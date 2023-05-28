
# Maven

## parent
![[Pasted image 20230215153102.png]]

![[Pasted image 20230215153354.png]]

![[Pasted image 20230215154220.png]]

## starter

![[Pasted image 20230215162947.png]]

![[Pasted image 20230215163014.png]]

## 引导类

![[Pasted image 20230215163602.png]]

## 辅助功能 

````ad-note
title: Maven排除依赖

~~~xml
<exclusions>
	<exclusion>
		GAV
	</exclusion>
</exclusions>
~~~
````


![[Pasted image 20230215172610.png]]

### 内置服务器原理

![[Pasted image 20230215173255.png]]

![[Pasted image 20230215173522.png]]


# SpringBoot入门

## 基本配置

![[Pasted image 20230216152658.png]]

![[Pasted image 20230216152752.png]]

## 配置文件优先级

![[Pasted image 20230216153751.png]]

## YAML

![[YAML]]

### 从YAML读取数据

#### 单个数据
![[Pasted image 20230216164602.png]]

#### 自定义对象封装 **主要** 

![[Pasted image 20230216170857.png]]

##### 作用
![[Pasted image 20230216171156.png]]
##### 总结
![[Pasted image 20230216171255.png]]

## springboot 整合 第三方技术

### junit

![[Pasted image 20230216173304.png]]
![[Pasted image 20230216173327.png]]

### Mybatis

 ```ad-note
title: 创建工程时
选 *MySQL framework* + *MySQL driver*

```


![[Pasted image 20230218173027.png]]

#### 配置
![[Pasted image 20230218173045.png]]

### *Mybatis Plus*(MP)

和MyBatis一样,但需要手工单独添加坐标

### Druid (DataSource)

#### 第一种

![[Pasted image 20230218194119.png]]

#### 第二种 

![[Pasted image 20230218194154.png]]

## 小案例(SSMP)

### 数据层(Dao层)


![[Pasted image 20230218201735.png]]

#### MyBatis Plus 配置

![[MyBatisPlus配置]]

### Controller层

#### 基于SpringMVC的全局异常处理器

![[00 SpringMVC]]

#### 总结

![[Pasted image 20230224175031.png]]

### 前端 

#### 分页功能

![[Pasted image 20230224181622.png]]

##### 分页功能引起的 删除 bug

![[Pasted image 20230224195751.png]]


# 运维开发篇

## 有脏数据

```ad-caution
title: 注意
springboot project 打包(**package**) 成 *jar包* 的时候 由于 maven 的 package 生命周期前面有 *test* 所有会把测试数据都打包进去,避免这种情况的方法 


-> **在 idea 中 skip 掉 test 这个生命周期即可**

```

## 启动失败bug

![[Pasted image 20230225182901.png]]

```ad-note
title: 原因
没有导 maven 的 plugin

```

### 本质问题

![[Pasted image 20230225184625.png]]

```ad-note
**Start-Class** :

**Main-Class** : 

后面没有标明jar包的启动器,导致jar包无法加载主清单属性

```

## 临时变量

### terminal
![[Pasted image 20230228111341.png]]

`java -jar target.jar --server.port=8080`

### IDE

![[Pasted image 20230228171655.png]]

## 配置文件级别

![[Pasted image 20230228173021.png]]

```ad-note
title: 级别
**config** 包下的永远比 **同级** 高

在 **jar包** 的比在 **源码** 的 高

```

```ad-question
title: 思考
*properties* > *yml* 

```

## 多环境开发
### 多环境配置

![[Pasted image 20230228174745.png]]

![[Pasted image 20230228175126.png]]


### 多配置文件
![[Pasted image 20230228175532.png]]

### 分组管理

![[Pasted image 20230228180919.png]]

![[Pasted image 20230228181603.png]]

## 日志级别

![[Pasted image 20230228200258.png]]


![[Pasted image 20230228201538.png]]

## 日志文件(持久化)

![[Pasted image 20230301125534.png]]


# 开发实用篇

## 热部署

### 手工

![[Pasted image 20230301132941.png]]

![[Pasted image 20230301133002.png]]

### 自动


![[Pasted image 20230301142851.png]]

![[Pasted image 20230301142940.png]]

### 热部署范围配置

#### 默认
![[Pasted image 20230301143945.png]]


#### 自定义
![[Pasted image 20230301143909.png]]

### 禁用热部署

![[Pasted image 20230301145205.png]]


## 配置高级

### @ConfigurationProperties(prefix = '')

![[Pasted image 20230301154521.png]]

### @EnableConfigurationProperties

![[Pasted image 20230301155027.png]]

#### 小结

关于@Configuration的上面红色报错

![[日常bug#@ConfigurationProperties]]

### 宽松绑定机制

![[Pasted image 20230301161223.png]]

![[Pasted image 20230301161543.png]]

### 常用计量单位

![[JavaSE#常用计量单位]]

### 对Bean进行数字校验

![[Pasted image 20230301164652.png]]

![[Pasted image 20230301164718.png]]

![[Pasted image 20230301164746.png]]

### 加载测试专用属性 ->  (@SpringBootTest)

#### 属性级别 

![[Pasted image 20230301193601.png]]

#### Bean对象级别

![[Pasted image 20230301194315.png]]

### web测试环境 -> (in @SpringBootTest)

![[Pasted image 20230301195406.png]]

### 虚拟请求测试

![[Pasted image 20230301200253.png]]

![[Pasted image 20230301201740.png]]


### 数据层测试事务回滚 -> (@Transactional)

![[Pasted image 20230302152321.png]]

### 测试用例数据

![[Pasted image 20230302161525.png]]