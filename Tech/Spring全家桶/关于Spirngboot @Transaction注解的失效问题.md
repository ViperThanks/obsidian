
# 1. this 调用
方法里面
```java
// 通过 Spring 官方 API
IVoucherOrderService proxy = (IVoucherOrderService) (AopContext.currentProxy());  
return proxy.createVoucherOrder(voucherId, stock);  
```
dependency
```xml
<!--aspectJ-->  
<dependency>  
	<groupId>org.aspectj</groupId>  
	<artifactId>aspectjweaver</artifactId>  
</dependency>
```
application 
```java
@EnableAspectJAutoProxy(exposeProxy = true) // 开启AOP
```

```ad-note

上述代码就是基于 *Api* *AopContext*  的 **currentProxy** 类获取当前代理对象,再通过代理对象来代理
**@Transaction** 的内部方法
```

