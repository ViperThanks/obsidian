
# 修改默认前缀 以及 id 分配算法

![[Pasted image 20230218201850.png]]


# 开运行日志

![[Pasted image 20230218202408.png]]

# 分页拦截器(page interceptor)

## 基于 *MyBatisPlusInterceptor* 类的 *addInnerInterceptor* 成员方法

```java
@Configuration  
public class MPConfig {  
  
  
    @Bean  
    public MybatisPlusInterceptor mybatisPlusInterceptor(){  
        MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();  
        interceptor.addInnerInterceptor(new PaginationInnerInterceptor());  
        return interceptor;  
    }  
}
```

![[Pasted image 20230219151633.png]]