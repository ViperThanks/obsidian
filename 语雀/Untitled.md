
## Java 操作 redis(pom 导入启动)

![](https://cdn.nlark.com/yuque/0/2022/png/28869531/1666890416800-da08c1c3-cc4a-46b9-84ca-c6b8699d5ddd.png)

![](https://cdn.nlark.com/yuque/0/2022/png/28869531/1666890455288-e945f98e-1387-4303-899c-e99fc6298e5d.png)

# Spring Cache

![](https://cdn.nlark.com/yuque/0/2022/png/28869531/1667382369015-15abc5ed-b3fc-47e4-a3f2-c11313878351.png)

### 加入缓存 cachePut

#### 业务save/add

![](https://cdn.nlark.com/yuque/0/2022/png/28869531/1667391972569-018e06ee-6b71-494f-9f86-6c42db297e73.png)

```java

    @CachePut(value = "userName" , key = "#user.id")
    @PostMapping
    public User save(User user){
        userService.save(user);
        return user;
    }
```

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