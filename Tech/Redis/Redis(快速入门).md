## 启动

![[redis的启动指南(Reides start guide for windows)|redis启动指南]]

## redis.conf

* 开可以开后台,开密码
* 关只允许ip自己,端口开发6379
* 默认低版本没有密码(连接不填密码即可)

## 通用命令

![](https://cdn.nlark.com/yuque/0/2022/png/28869531/1666776905811-e04c4079-e067-46be-8a33-e4bf21f0c294.png)

## 五种基本类型

![](https://cdn.nlark.com/yuque/0/2022/png/28869531/1666701585776-7446b4f6-0a13-40dd-aaab-0df31ed3775f.png)

## String基本操作

![](https://cdn.nlark.com/yuque/0/2022/png/28869531/1666701941884-b663d958-3840-4f0c-ab2d-c417477ad341.png)

## Hash基本操作

![](https://cdn.nlark.com/yuque/0/2022/png/28869531/1666702360522-831189e1-36ba-4b7e-964e-9a4df9767570.png)

### 实操

![](https://cdn.nlark.com/yuque/0/2022/png/28869531/1666775164810-7f94d5ce-d6a4-49b7-84ef-b2365e1fd50a.png)

## 列表基本操作

![](https://cdn.nlark.com/yuque/0/2022/png/28869531/1666775528413-fa4236f4-8827-42a4-8fbf-86edef004913.png)

## Set集合操作

![](https://cdn.nlark.com/yuque/0/2022/png/28869531/1666776056703-aa808834-e761-44ba-bc61-cd663b1b7649.png)

## 有序集合

![](https://cdn.nlark.com/yuque/0/2022/png/28869531/1666776586099-4ec7e7d5-bc3f-485a-95d1-c3f5b63c6c3e.png)

## Java操作redis(pom导入启动)

![](https://cdn.nlark.com/yuque/0/2022/png/28869531/1666890416800-da08c1c3-cc4a-46b9-84ca-c6b8699d5ddd.png)

![](https://cdn.nlark.com/yuque/0/2022/png/28869531/1666890455288-e945f98e-1387-4303-899c-e99fc6298e5d.png)

# Spring Cache

![](https://cdn.nlark.com/yuque/0/2022/png/28869531/1667382369015-15abc5ed-b3fc-47e4-a3f2-c11313878351.png)

### 加入缓存 cachePut

#### 业务save/add

![](https://cdn.nlark.com/yuque/0/2022/png/28869531/1667391972569-018e06ee-6b71-494f-9f86-6c42db297e73.png)

    @CachePut(value = "userName" , key = "#user.id")
    @PostMapping
    public User save(User user){
        userService.save(user);
        return user;
    }

### 删除缓存cacheEvict

#### 业务delete

![](https://cdn.nlark.com/yuque/0/2022/png/28869531/1667459622403-d147b313-8df8-41f0-afc9-81a8d92ea3cb.png)

```java
    @CacheEvict(value = "userName", key = "#id")
    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id){
        userService.removeById(id);
    }
```

#### 业务update()

![](https://cdn.nlark.com/yuque/0/2022/png/28869531/1667460896977-1f54768d-171a-445a-9be9-4330ec7ab0ed.png)

allentries = true: 删除所有缓存

### 获取缓存(Cacheable)

![](https://cdn.nlark.com/yuque/0/2022/png/28869531/1667469381610-4eb506db-111c-4b84-8eb5-02b484d37a10.png)