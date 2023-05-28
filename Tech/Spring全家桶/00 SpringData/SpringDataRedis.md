

# 简介

![[Pasted image 20230314170358.png]]

```ad-summary
title:difference
与 *Jdeis* 不同, *Jedis* 是把所有操作都写在 *Jedis* 类里面,代码长达 **2500** 多行
而 *RedisTemplate* 就把操作像 *Redis* 一样按照类型分
```

![[Pasted image 20230314170927.png]]

# 操作

## 1. 引依赖

![[Pasted image 20230314172655.png]]

## 2. 写配置

![[Pasted image 20230314172722.png]]

## 3. 4. 省略

![[Pasted image 20230314172914.png]]

# RedisTemplate

## 序列化器 

```ad-question
如果 RedisTemplate 没有指定泛型,就会调用JDK里的 ObjectOutPutStream 来把对象转成字节流

![[Pasted image 20230314174714.png]]

```

### 解决方案 1 : (自动序列化)

```java  
import org.springframework.context.annotation.Bean;  
import org.springframework.context.annotation.Configuration;  
import org.springframework.data.redis.connection.RedisConnectionFactory;  
import org.springframework.data.redis.core.RedisTemplate;  
import org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer;  
import org.springframework.data.redis.serializer.StringRedisSerializer;  
  
/**  
 * author  : wl * email   : vieper0714@outlook.com * date     : 2023/3/14 19:30 * desc     : 由于RedisTemplate解析器的问题导致我们的用Object泛型时,会序列化出意想不到的的key和value,  
 *编写这个class就是为了复写,@AutoWired 也就是说自动装配时RedisTemplate对象  
 */  
@Configuration  
public class RedisConfig {  
  
  
    /**  
     * 重写RedisTemplate对象  
     * @param connectionFactory RedisConnectionFactory实例  
     * @return 重写完的对象 redisTemplate  
     */    @Bean  
    public RedisTemplate<String,Object> redisTemplate(RedisConnectionFactory connectionFactory){  
  
        //创建RedisTemplate对象  
        RedisTemplate<String, Object> redisTemplate = new RedisTemplate<>();  
        //设置工厂  
        redisTemplate.setConnectionFactory(connectionFactory);  
        //new JSON解析器  
        GenericJackson2JsonRedisSerializer serializer = new GenericJackson2JsonRedisSerializer();  
        //设置如何解析  
        //key的解析  
        redisTemplate.setKeySerializer(StringRedisSerializer.UTF_8);  
        redisTemplate.setHashKeySerializer(StringRedisSerializer.UTF_8);  
        //value 的解析  
        redisTemplate.setValueSerializer(serializer);  
        redisTemplate.setHashValueSerializer(serializer);  
  
        return redisTemplate;  
    }  
  
  
}
```

结果如下 :

![[Pasted image 20230314200246.png]]

### 方案一带来的问题:"@class这个对业务没什么作用的对象占用太大"

![[Pasted image 20230314200618.png]]

### 方案二 : 

#### 思路

![[Pasted image 20230314201025.png]]

#### code
![[Pasted image 20230314201200.png]]

```java
private static final ObjectMapper mapper = new ObjectMapper();  
@Test  
void testRedisTemplateObject() throws JsonProcessingException {  
    User user = new User();  
    user.setId(1L);  
    user.setName(r.nextLong() + "");  
    user.setScore(r.nextDouble());  
    String json = mapper.writeValueAsString(user);  
    redisTemplate.opsForValue().set("wl:test:user:1",json);  
    String userString = redisTemplate.opsForValue().get("wl:test:user:1");  
    User user1 = mapper.readValue(userString, User.class);  
    System.out.println(user1);  
}
```

### 总结

![[Pasted image 20230314202655.png]]

# 实战篇

![[用户登录功能的实现|用户登录]]

## 4.3 商家查询的缓存 : 

## 缓存数据

![[Snipaste_2023-04-22_16-06-24.png]]


## Redis 的缓存更新策略
![[Redis(深入学习)#redis 的缓存更新策略]] 

## 缓存穿透


![[Snipaste_2023-04-22_18-16-37.png]]

![[Snipaste_2023-04-22_18-25-57.png]]  

### 缓存穿透总结

![[Snipaste_2023-04-22_18-37-41.png]]



## 缓存雪崩

![[Snipaste_2023-04-23_19-07-02.png]]

* 多级缓存 -> 在 *Nginx* 服务器和 *Redis* 以及 JVM (*Java Virtual Machine*) 本地缓存来实现多级缓存


## 缓存击穿

![[Snipaste_2023-04-23_19-20-54.png]]

### 逻辑过期和互斥锁


![[Snipaste_2023-04-23_19-27-24.png]]

![[Snipaste_2023-04-23_19-29-57.png]]

#### 互斥锁的实现

```ad-note
title: 互斥锁🔒的实现
基于 redis 的 *setnx* 语句来实现,因为 **sync** 是单机锁🔒 ,并且增加有效期 *expired* 来避免死锁
```

 流程图 : 
![[Snipaste_2023-04-24_17-31-45.png]]

```java
/**  
* 通过id获取商铺信息,并加锁.避免缓存击穿  
* @param id 商铺id  
* @return 商铺信息,如果为null,则表示该商铺不存在  
*/  
private Shop getByIdWithMutex(Long id) {  
	String key = RedisConstants.CACHE_SHOP_KEY + id;  
	Shop shop = null;  
	String lockKey = RedisConstants.LOCK_SHOP_KEY + id;  
	do {  
		// 从缓存中获取数据  
		String shopJson = stringRedisTemplate.opsForValue().get(key);  
		// 缓存中有数据  
		if (StrUtil.isNotBlank(shopJson)) {  
			return JSONUtil.toBean(shopJson, Shop.class);  
		}  
  
		try {  
			if (tryLock(lockKey)) {  
			// 从数据库中获取数据  
			shop = getById(id);  
			Thread.sleep(200);  
			stringRedisTemplate.opsForValue().set(  
				key,  
				JSONUtil.toJsonStr(shop),  
				RedisConstants.CACHE_SHOP_TTL,  
				TimeUnit.MINUTES  
			);  
			unlock(lockKey);  
			break;  
			} else {  
				Thread.sleep(50L);  
			}  
		} catch (InterruptedException e) {  
			throw new RuntimeException(e);  
		}  
	} while (!peekLock(lockKey));  
	//数据不存在  
	//把null值放入redis中避免缓存穿透  
	if (Objects.isNull(shop)) {  
		stringRedisTemplate.opsForValue().set(  
			key,  
			"",  
			RedisConstants.CACHE_NULL_TTL,  
			TimeUnit.MINUTES  
		);  
	}  
	return shop;  
}
```


#### 逻辑缓存的实现

流程图 : 

![[Snipaste_2023-04-24_17-30-56.png]]

```java
private static final ExecutorService CACHE_REBUILD_EXECUTOR =     Executors.newFixedThreadPool(10);  
  
private Shop getByIdWithLogicalExpire(Long id) {  
	String redisDataKey = RedisConstants.CACHE_SHOP_KEY + id;  
	String redisDataJson = stringRedisTemplate.opsForValue().get(redisDataKey);  
	if (StrUtil.isBlank(redisDataJson)) {  
		return null;  
	}  
	//判断缓存是否过期  
	RedisData redisData = JSONUtil.toBean(redisDataJson, RedisData.class);  
	Shop shop = JSONUtil.toBean((JSONObject) redisData.getData(), Shop.class);  
	LocalDateTime logicalExpire = redisData.getExpireTime();  
	if (LocalDateTime.now().isAfter(logicalExpire)) {  
		String lockKey = RedisConstants.LOCK_SHOP_KEY + id;  
		if (tryLock(lockKey)) {  
			//rebuild after double check  
			if (LocalDateTime.now().isAfter  
				(JSONUtil.toBean(stringRedisTemplate.opsForValue().get(redisDataKey), RedisData.class).getExpireTime())) 
				{  
					callHelper(id, 20L);  
				}  
		}  
	}  
	return shop;  
}  
  
private void callHelper(Long id, Long expireTime) {  
	CACHE_REBUILD_EXECUTOR.submit(() ->  
	{  
		try {  
			savaShop2Redis(id, expireTime);  
		} catch (Exception e) {  
			throw new RuntimeException(e);  
		} finally {  
			unlock(RedisConstants.LOCK_SHOP_KEY + id);  
		}  
	});  
}

public void savaShop2Redis(Long id, Long expireTime) throws InterruptedException {  
	Shop shop = getById(id);  
	Thread.sleep(200L);  
	RedisData redisData = new RedisData();  
	redisData.setData(shop);  
	redisData.setExpireTime(LocalDateTime.now().plusSeconds(expireTime));  
	stringRedisTemplate.opsForValue().set(RedisConstants.CACHE_SHOP_KEY + id,  JSONUtil.toJsonStr(redisData));  
  
}
```


## 缓存工具封装


## 4.4 秒杀

### 全局唯一 ID 生成器

![[Snipaste_2023-04-27_18-54-10.png]]

#### 基于 Redis 实现的全局 ID 生成器
![[Snipaste_2023-04-27_18-58-06.png]] 

### 超卖问题

![[Snipaste_2023-05-05_11-46-53 1.png]]

#### 乐观锁 : 

##### 版本号法 : 

![[Snipaste_2023-05-05_11-52-09.png]]

##### CAS 

对应 SQL : 
*"update  tb_target set stock = stock - 1 where .... 业务需求 " + stock = 刚刚获得的 stock*
![[Snipaste_2023-05-05_11-57-35.png]]

#### 超卖问题总结

![[Snipaste_2023-05-05_14-00-36.png]]

### 一人一单

![[Snipaste_2023-05-05_17-14-19.png]]

### 分布式锁

![[Snipaste_2023-05-05_17-21-11.png]]

![[Snipaste_2023-05-05_17-23-56.png]]

#### 基于 redis 的分布式锁
 

![[Snipaste_2023-05-08_17-35-12.png]]

### 秒杀优化

![[Snipaste_2023-05-20_14-45-11.png]]

![[Snipaste_2023-05-20_14-54-52.png]]

#### 具体步骤

![[Snipaste_2023-05-20_18-20-05.png]]

![[Snipaste_2023-05-20_20-24-14.png]]

### 基于消息队列进行优化

![[Message Queue(MQ)#MQ 解决异步秒杀问题]]

### redis 实现消息队列

#### list 实现的消息队列
![[Snipaste_2023-05-20_20-50-43.png]]

##### 总结 
![[Snipaste_2023-05-21_16-18-57.png]]


#### redis 的 PubSub 实现

![[Snipaste_2023-05-21_16-25-01.png]]

*Psubscribe* 的通配符 
![[Snipaste_2023-05-21_16-23-32.png]]

##### 总结

![[Snipaste_2023-05-21_16-28-53.png]]

#### 基于 Stream 的

##### 介绍 : 

![[Snipaste_2023-05-21_16-34-55.png]]

![[Snipaste_2023-05-21_16-40-02.png]]

##### 实践 
![[Snipaste_2023-05-21_16-40-53.png]]

![[Snipaste_2023-05-21_16-43-28.png]]


##### 消费者组

![[Snipaste_2023-05-21_16-46-45.png]]

![[Snipaste_2023-05-21_16-49-07.png]]

![[Snipaste_2023-05-21_16-53-22.png]]

伪代码

![[Snipaste_2023-05-21_17-06-53.png]]


## 达人探店基于(sorted set , set)

### 点赞, 基于 set

```ad-note
title: 思路
只需要创建 blog:liked: + blog.id set 把 liked 的User对象的id都装到 , set 里面 就行了
```

### Top 5 类微信朋友圈的点赞排行榜 order by TimeStamp

```ad-note
title: 思路
把点赞系统的set 改成 sorted set即可 ,对应 stringRedisTemplate.opsForZSet 
```


## 消息推送 

###  基于 (Zset | SortedSet 的 rangebyscorewithscore)

![[Snipaste_2023-05-23_17-22-07.png]]

### 两种常见模式

![[Snipaste_2023-05-23_17-24-37.png]]

![[Snipaste_2023-05-23_17-26-36.png]]

### Timeline 的实现方案

![[Snipaste_2023-05-23_17-28-19.png]]

##### 推拉模式

![[Snipaste_2023-05-23_17-33-20.png]]

```ad-note
title: 思路 
普通人 直接推送

大V : 如果是活跃粉,推送.如果是 僵尸或者普通粉丝,在他要的时候才拉取 

```

![[Snipaste_2023-05-23_17-37-35 1.png]]

#### 具体实现

![[Snipaste_2023-05-23_18-08-47.png]]


![[Snipaste_2023-05-23_18-16-49.png]]

![[Snipaste_2023-05-23_18-18-27.png]]

## 附近商铺 (基于 Reids - GEO)

![[Redis(深入学习)#GEO (*Gps*)]]

## 用户签到 (*BitMap*)


# 高级篇