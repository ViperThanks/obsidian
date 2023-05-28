# 整体架构

![[Pasted image 20230123173740.png]]

# *MySql*体系结构图

![[Pasted image 20230203173847.png]]

![[Pasted image 20230203173940.png]]

# *MySql -- InnoDB* 逻辑储存结构

![[MySql#逻辑存储结构]]



# 基础篇

## SQL语句

### SQL分类
![[Pasted image 20230123175150.png]]


#### DDL

```ad-MyNote
title:*DDL*
**数据库的DDL** : 

![[Pasted image 20230123182101.png]]



**表的DDL** :

1. **查询**
![[Pasted image 20230123205449.png]]
2. **修改**
![[Pasted image 20230123220213.png]]
---![[Pasted image 20230123220429.png]]
3. **删除**![[Pasted image 20230123221252.png]]




```

#### 总结
![[Pasted image 20230123221411.png]]

#### DML
就是简单的 *update insert delete* sql语句

#### DQL 

```ad-MyNote
title:DQL
*DQL*语法
![[Pasted image 20230124171403.png]]
```

![[Pasted image 20230124183630.png]]

Limit
![[Pasted image 20230124201548.png]]

执行顺序
![[Pasted image 20230124203256.png]]

#### DCL
![[Pasted image 20230124204146.png]]

![[Pasted image 20230124204329.png]]

## 函数

### 字符串函数

![[Pasted image 20230124205522.png]]




### 数值函数

![[Pasted image 20230124211002.png]]



### 日期函数

![[Pasted image 20230124214517.png]]


### 流程函数

![[Pasted image 20230124215330.png]]

```mysql
select  
    name,  
    case work_address when '北京' then '一线城市' when '上海' then '一线城市' 
    else '二线城市' end as 城市级别,  
    IF(age >= 10, 'old man', 'young man')  
from emp;
```

## 约束

### 一般约束
![[Pasted image 20230124221206.png]]

### 外键约束

* **concept**![[Pasted image 20230124222825.png]]


*  **语法**![[Pasted image 20230124223636.png]]
```mysql
alter table emp add constraint fk_emp_dept_id foreign key (dept_id) references dept(id);
```

## 多表查询

### 多表关系

![[Pasted image 20230126184356.png]]

* #### 一对多 ![[Pasted image 20230126184614.png]]
* #### 多对多![[Pasted image 20230126184848.png]]
* #### 一对一![[Pasted image 20230126201907.png]]

### 概述

![[Pasted image 20230126203606.png]]

### 分类

![[Pasted image 20230126204510.png]]

* #### 内连接![[Pasted image 20230126205542.png]]
* #### 外链接![[Pasted image 20230127153941.png]] 
* #### 自链接![[Pasted image 20230127154918.png]]
* #### 联合查询(*Union Union all*)![[Pasted image 20230127161149.png]]
* #### 子查询![[Pasted image 20230127161338.png]]
	* 标量子查询![[Pasted image 20230127162357.png]]
	* 列子查询![[Pasted image 20230127163948.png]]
	* 行子查询![[Pasted image 20230127165131.png]]
	* 表子查询 :   一般用于别名


## 事务

![[Pasted image 20230129193417.png]]

### 语法 : 
![[Pasted image 20230129200651.png]]

### 四大特性

![[Pasted image 20230129211628.png]]

### 并发事务引发的问题

![[Pasted image 20230129213250.png]]

### 事务隔离级别:

![[Pasted image 20230203155642.png]]

### 总结

![[Pasted image 20230203164736.png]]

# 进阶篇

## 存储引擎 (**作用于表**)

![[Pasted image 20230203174246.png]]

### 显示储存引擎(*storage engine*)

```mysql
show engines
```


### InnoDB 

#### 特点:

![[Pasted image 20230204155434.png]]

#### 逻辑结构 : 

![[Pasted image 20230204160155.png]]
```ad-note
**见解** : 图书馆->书架->书本->书页->一行字->一个字
```

### MyISAM

![[Pasted image 20230204160446.png]]

### Memory

![[Pasted image 20230204160656.png]]

### 三个储存引擎特点 : 

![[Pasted image 20230204160818.png]]

### 储存引擎的选择

![[Pasted image 20230204161202.png]]

交替 : 
大部分情况还是 *InnoDb* 
*MyISAM* -> *MangoDB*
*Memory* -> *Redis*

## 索引

### 概述

![[Pasted image 20230204170948.png]]

### 优缺点

![[Pasted image 20230204171143.png]]

### 索引结构

![[Pasted image 20230204171413.png]]

#### 二叉树

![[Pasted image 20230205150640.png]]

#### B-Tree

![[Pasted image 20230205152053.png]]

#### B+Tree

![[Pasted image 20230205152946.png]]

#### MySql B+Tree

![[Pasted image 20230205153144.png]]

#### Hash索引
![[Pasted image 20230205153633.png]]

#### 总结 

![[Pasted image 20230205154105.png]]

```ad-question
title: 为什么Mysql使用B+树?
*answer* : 因为 *二叉树* 相对于 *b-tree* 而言的层级太高 所有搜索效率就低 , 由于 页(*page*) 的最大限度大小是 16kb 而 *b-tree* 无论是 **叶子节点** 还是 **非叶子节点** 都保存数据 , 在数据量相同的情况下 *B+Tree* 的层级会比 *b-tree* 小

```

### 索引分类

![[Pasted image 20230205155852.png]]

#### 聚集索引 和 二级索引(非聚集)
![[Pasted image 20230205160123.png]]

![[Pasted image 20230205160324.png]]

```ad-note
title: 举例 

~~~ mysql
select * from user where name = 'kkk' 
~~~
![[Pasted image 20230205162523.png]]

```

### 索引语法

![[Pasted image 20230205164442.png]]

#### practice

![[Pasted image 20230206152321.png]]

### SQL 性能分析

* SQL 执行频率![[Pasted image 20230206152933.png]]
* SQL 慢查询日志![[Pasted image 20230206161242.png]]
* profile详情![[Pasted image 20230206162046.png]]
* explain执行计划![[Pasted image 20230206163252.png]]![[Pasted image 20230206164652.png]]![[Pasted image 20230206164847.png]]

### 索引使用法则(联合索引)

#### 概述 : 

![[Pasted image 20230208155703.png]]

![[Pasted image 20230208160457.png]]

#### 索引失效情况

![[Pasted image 20230208160753.png]]

还有字符串不加单引号

![[Pasted image 20230208161137.png]]


![[Pasted image 20230208161556.png]]

![[Pasted image 20230208162805.png]]

#### SQL提示

![[Pasted image 20230208164030.png]]

#### 覆盖索引

![[Pasted image 20230208170103.png]]

```ad-info
title: 解释 : 为什么 select * 比较慢?
因为
`select * from tb_xxx where UnPrimaryKey = Target`
一般除非把 整张表的字段都做索引,否则一定会涉及到 回表查询 性能比较低 

```

![[Pasted image 20230208204615.png]]

##### 面试题

![[Pasted image 20230208205024.png]]

#### 前缀索引

![[Pasted image 20230208205732.png]]

##### 流程:
![[Pasted image 20230208220453.png]]

### 单列索引和联合索引

单列索引 当 用多个条件时 只会使用单个索引 会造成回表查询的现象
![[Pasted image 20230208220823.png]]

#### 单列情况
![[Pasted image 20230208221306.png]]

#### 多列情况
![[Pasted image 20230208221520.png]]

### 索引设计原则

![[Pasted image 20230208221935.png]]

### 索引总结:

![[Pasted image 20230209152203.png]]
![[Pasted image 20230209152631.png]]

## SQL 优化 

### 插入数据 (*insert*)

* **少量数据**![[Pasted image 20230209153120.png]]
* **大量数据**![[Pasted image 20230209153421.png]]

### 主键优化(*Primary*)

#### 页分裂:

* 顺序插入![[Pasted image 20230209154505.png]]
* 乱序插入  ![[Pasted image 20230209154756.png]]
```ad-note
title: 乱序插入说明
在应该插入 **数据的页(a)** 分裂 *50%的数据* 到 刚申请的**新的数据页(c)** 然后再把数据放到**新的数据页(c)** 中,再把 **a** 指向 **下一个页(b)** 的指针指向 **c** , **c**的指针再指向 **b**

```

#### 页合并

![[Pasted image 20230209155630.png]]

#### 设计原则

![[Pasted image 20230209160039.png]]

```ad-note
title: Answer
1. 因为 二级索引叶子节点挂载的就是 **主键** , 如果主键长度大
2. 因为 不顺序插入会照常 **页分裂**
3. 长度大 , 乱序 
4. 要重新整理数据结构

```

### Order By 优化

![[Pasted image 20230209161234.png]]

![[Pasted image 20230209161410.png]]

![[Pasted image 20230209161006.png]]

#### 总结
![[Pasted image 20230209161708.png]]

### Group By 优化

![[Pasted image 20230209163339.png]]

### Limit 优化

![[Pasted image 20230209163911.png]]

### Update 优化 ( 行级锁 )

![[Pasted image 20230209165123.png]]

### 总结 : 
 ![[Pasted image 20230209165336.png]]

## 视图

### 语法

![[Pasted image 20230209170058.png]]

### 识图的检查选项

![[Pasted image 20230209172814.png]]

## 储存过程

 ### 概述 : 

像 JAVA 中 的 方法

![[Pasted image 20230210142806.png]]

![[Pasted image 20230210143050.png]]

### 语法 : 

![[Pasted image 20230210143533.png]]

![[Pasted image 20230210144318.png]]

### 变量 :

#### 系统变量:

![[Pasted image 20230210145618.png]]

#### 用户定义变量
![[Pasted image 20230210145834.png]]

![[Pasted image 20230210150235.png]]

#### 局部变量

![[Pasted image 20230210150707.png]]

![[Pasted image 20230210150720.png]]

### IF 语句 : 

![[Pasted image 20230210152736.png]]


### 参数

![[Pasted image 20230210153027.png]]

![[Pasted image 20230210154415.png]]

### Case

![[Pasted image 20230210154521.png]]

![[Pasted image 20230210155427.png]]

### while

![[Pasted image 20230210155541.png]]

### repeat

![[Pasted image 20230210155800.png]]

### loop

![[Pasted image 20230210160145.png]]

![[Pasted image 20230210160240.png]]

### 游标

![[Pasted image 20230210161413.png]]

![[Pasted image 20230210162441.png]]


### Handler (like *JAVA* Exception)

![[Pasted image 20230210162806.png]]

### 储存函数

![[Pasted image 20230210163047.png]]

## 触发器

### 概述 : 

![[Pasted image 20230210163911.png]]

### 语法 : 
![[Pasted image 20230210170211.png]]

![[Pasted image 20230210172257.png]]

## 视图  存储过程 触发器总结

![[Pasted image 20230210172543.png]]

## 锁

### 概述 :

![[Pasted image 20230212200146.png]]

### 锁的分类

![[Pasted image 20230212200218.png]]

### 全局锁

![[Pasted image 20230212200705.png]]

#### 未加全局锁的情况

![[Pasted image 20230212200729.png]]

#### 加了全局锁的情况

![[Pasted image 20230212201042.png]]

#### 全局锁的特点
![[Pasted image 20230212202054.png]]

### 表级锁

![[Pasted image 20230212202240.png]]

#### 1. 表锁

![[Pasted image 20230212202528.png]]

#####  表读锁

![[Pasted image 20230212202517.png]]

![[Pasted image 20230212202837.png]]

##### 表写锁

![[Pasted image 20230212203033.png]]

##### 总结 : 
![[Pasted image 20230212203222.png]]

##### 元数据锁(*meta data lock*)

![[Pasted image 20230212204529.png]]

##### 意向锁

![[Pasted image 20230212204843.png]]

![[Pasted image 20230212204854.png]]

没有意向锁之前 , 如果我在并发条件下 update (*DML*) ,innodb会把涉及到的行都锁住, 然后 另一个进程 想对整张表加锁,而我 不知道哪行锁住了,就要遍历整张表才知道有没有 行锁


![[Pasted image 20230212210200.png]]
![[Pasted image 20230212210214.png]]

###### 意向共享(*IS*)

![[Pasted image 20230212212101.png]]

###### 意向排他(*IX*)

![[Pasted image 20230212220659.png]]

### 行级锁

#### 介绍 

![[Pasted image 20230212221736.png]]

#### 行锁 : 

![[Pasted image 20230212222107.png]]

![[Pasted image 20230212222252.png]]

##### 测试 : 

![[Pasted image 20230212223513.png]]

1. ![[Pasted image 20230212222829.png]]

2. ![[Pasted image 20230212223333.png]]![[Pasted image 20230212223454.png]]


#### 间隙锁 / 邻键锁

![[Pasted image 20230212224210.png]]

1. 间隙(*GAP*)锁![[Pasted image 20230212224059.png]]
2. ![[Pasted image 20230212225037.png]]
3. ![[Pasted image 20230212225354.png]]

## 锁总结

![[Pasted image 20230212230026.png]]

表锁 : 读锁 写锁
元数据锁 : 解决ddl 和 dml 冲突的
意向 : 解决行锁和表锁冲突

## InnoDB存储引擎

### 逻辑存储结构
![[Pasted image 20230209154227.png]]

![[Pasted image 20230213163139.png]]

### 架构图

#### 内存架构

##### buffer pool 缓冲池

![[Pasted image 20230213164205.png]]

##### change buffer

![[Pasted image 20230213164554.png]]

##### adaptive hash index
![[Pasted image 20230213164812.png]]

##### log buffer
![[Pasted image 20230213165018.png]]

### 事务原理

![[Pasted image 20230213171028.png]]

### 事务的底层实现

![[Pasted image 20230213171243.png]]

#### Redolog 和 持久性
![[Pasted image 20230213171731.png]]

```ad-note
title: 过程
当用户一大堆(*DML*)语句的事务提交到 *mysql* 时, *mysql* 会先从 *Buffer Pool* 中找,如果没有就去磁盘中找,并把他放到 *buffer pool* 中.此时,修改完的 *page* 就变成了 脏页(*dirty page*) ,需要过一段时间再 *flush* 回磁盘中, 但如果再 *flush* 过程中出错....

```

#### redolog

```ad-note
title: 解决

1. *redolog* 在事务提交的过程就将日志刷到磁盘中，如果事务提交失败，那么日志刷新失败也就无所谓了

2. 在持久化到磁盘之前先做个备份，一旦持久化出错就用备份的意思
3. 为什么不直接把脏数据直接提交呢?因为 **大量** *DML* 会操作很多数据库,如果每次提交都把*dirty page* **flush** 到 *hard disk* 里 会照成大量的IO,影响性能
4. *redolog*日志是追加到磁盘上的,效率高,而且如果没有发生错误,*redolog*就会循环更替
```


![[Pasted image 20230213172741.png]]

#### undolog 和 原子性 和 MVCC

![[Pasted image 20230213173427.png]]
![[Pasted image 20230213175316.png]]

```ad-tip
title: Note
因为你当前事务*select*的是事务开启时的数据，而其他事务执行update和delete操作后数据变化，要读取改变前的数据还需读取undolog日志

```

### MVCC

#### 基本概念

![[Pasted image 20230213174256.png]]

#### 三个隐藏字段

![[Pasted image 20230213174557.png]]

#### undolog 版本链

![[Pasted image 20230213180033.png]]

#### readview

![[Pasted image 20230213180351.png]]

![[Pasted image 20230213182812.png]]

##### 实例
###### RC情况下
![[Pasted image 20230213183846.png]]

![[Pasted image 20230213183916.png]]

###### RR(repeatable reader)

![[Pasted image 20230213195241.png]]

### InnoDB总结

![[Pasted image 20230213200024.png]]

## 系统数据库

![[Pasted image 20230214161945.png]]

## 常用工具

![[Pasted image 20230214162501.png]]