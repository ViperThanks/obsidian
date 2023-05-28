
# 前言 

```ad-note
title: 课程介绍
基于 [视频链接](https://www.bilibili.com/video/BV1cr4y1671t) 黑马学习的Redis课程,在写完Boot项目 瑞吉外卖 以及 在 深入学习 [[00 SpringBoot|SpringBoot]] 过程中学习的 

```

```ad-summary
title: 官网
大部分命令都可以在官网上搜到,官网罗列了命令的集合

-> [document](https://redis.io/commands/)

```

# redis 的缓存更新策略

![[Snipaste_2023-04-22_17-00-47.png]]

## 主动更新策略

![[Snipaste_2023-04-22_17-04-37.png]]

### Cache aside pattern 

![[Snipaste_2023-04-22_17-09-46.png]]

### 总结   
![[Snipaste_2023-04-22_17-18-04.png]]

# 一般业务最佳实践

![[Snipaste_2023-04-27_18-33-16.png]]

# 基础篇

## redis数据结构介绍

![[Pasted image 20230310212453.png]]

## 通用命令 -> *generic*

![[Pasted image 20230311161715.png]]

## String int float 命令 -> *String*

![[Pasted image 20230313143554.png]]

## Key的结构 

![[Pasted image 20230313144116.png]]

![[Pasted image 20230313145711.png]]

## 小结

![[Pasted image 20230313150402.png]]

## Hash -> *HashMap*


![[Pasted image 20230313150721.png]]

![[Pasted image 20230313150803.png]]

## List -> *LinkedList*

![[Pasted image 20230313152742.png]]

## Set -> *HashSet*

![[Pasted image 20230313203002.png]]

![[Pasted image 20230313211052.png]]

## SortedSet -> *TreeSet*

![[Pasted image 20230314133618.png]]

![[Pasted image 20230314133742.png]]

## GEO (*Gps*)  

![[Snipaste_2023-05-24_16-11-42.png]]

## BitMap 

![[Snipaste_2023-05-25_18-11-47.png]]

## HyperLogLog 

![[Snipaste_2023-05-27_17-48-55.png]]

![[Snipaste_2023-05-27_17-49-58.png]]


# Java客户端 -> SpringDataRedis

![[Pasted image 20230314170148.png]]

# 缓存

## 缓存击穿 
![[SpringDataRedis#缓存击穿]] 


## 缓存雪崩
![[SpringDataRedis#缓存雪崩]] 



## 缓存穿透

![[SpringDataRedis#缓存穿透]] 


# 单节点的带来的问题

![[Snipaste_2023-05-27_19-53-59.png]]

## Redis 的持久化

### RDB

![[Snipaste_2023-05-27_19-58-26.png]]

配置文件设置如下

![[Redis.conf#RDB]]

#### 原理

![[Snipaste_2023-05-27_20-27-33.png]]

#### 总结
![[Snipaste_2023-05-27_20-29-41.png]]

### AOF

![[Snipaste_2023-05-27_20-32-57.png]]

#### Bgrewritedaof (background rewrited AOF)

![[Snipaste_2023-05-27_21-26-00.png]]

![[Redis.conf#AOF]]

### 总结

![[Snipaste_2023-05-27_21-32-09.png]]