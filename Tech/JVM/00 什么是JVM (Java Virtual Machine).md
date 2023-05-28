
**英文只是单纯地练习英语** :) *smile* 


[可参考的文章](https://ziyang.moe/article/jvm2.html) ^97ad52

# JVM介绍
![[Pasted image 20221224165115.png]]

## JVM(*Java Virtual Machine*) JRE(*Java Runtime Environment*) JDK(*Java Development Kit*)的关系

![[Pasted image 20221224165021.png]]

# 01程序计数器
![[Pasted image 20221225200734.png]]

* **作用** : 记住下一条jvm指令的执行地址

* **具体实现** : 是使用 计算机硬件 -> **寄存器**(_Register_) 来实现的


![[Pasted image 20221225201802.png]]

* **特点** :
	* **私有性** : Cpu在执行 线程时 cpu的调度器会给予线程一个时间片,如果该线程在时间片内没有结束,那他的程序计数器会**暂存**他下一条指令的内存,直到cpu再给予他新的时间片,所以程序计数器具有**私有性**
	* **安全性** : 不会出现内存溢出(JVM规定的)



# 02虚拟机 栈(*Stack*)
```ad-note
title:虚拟机参数
option : -Xss8m 
```

## 定义 : 

![[Pasted image 20221226154235.png]]

```ad-info
title:定义
虚拟机栈 : **线程**运行所需要的内存空间

栈帧 : **方法**运行所需要的内存

```

```ad-abstract
title:例子 : 主线程调用   方法1 -> 栈帧1 , 方法2 -> 栈帧2 ,方法3 -> 栈帧3时栈的情况

![[eSearch-2022-12-26-15-36-42-39.gif]]
```

```ad-note
title:见解
一个线程运行，计算机会分配一个空间(栈*stack*)，这段空间由多个栈帧构成，每个栈帧对应一个对象方法
```

```ad-question
title:问题
**1.垃圾回收是否涉及栈内存 ? ** 

不会,虚拟机栈(*VMStack*)调用完方法就直接弹出就行了,Garbage Collection(*GC*)只是清理堆(*heap*)内存

**2.栈内存分配越大越好吗？**

不会,栈内存分配越大,只会让方法内调用变多   e.g.: 递归深度 , 但计算机总内存不变,线程数 = 总内存 / 单个栈内存,线程数会变少

**3.方法内的局部变量是否线程安全?**

如果该局部变量引用的对象并且跳出了方法影响的范围,需要考虑

```

```ad-caution
title:栈内存溢出一般来说有两种情况

1. 栈帧太大了,一般很少遇到这种情况,但是有人说把比较大的数据(公司数据库的一个*table*表那种)放入一个*map*里就会,因为栈帧大小与其局部变量有关
2. 栈帧太多了,栈帧太多一般是因为无限递归
```



占用了cpu过多的时间片

# 线程运行的诊断

* *CPU*占用过高 : 

```ad-info
title:
虚拟机(Linux)角度:
* 用 *top* 定位对应进程
* *ps H -eo pid,tid,%cpu | grep* 对应**进程id** (定位对应**线程**)
* *jstack* 对应**进程id**
	* 根据**线程id**找到有问题的线程, 进一步定位到源码
```
* 长时间没有结果:

```ad-info
title:
考虑 *jstack* 对应进程看看有没有死锁(*DeadLock*)
```

# 03本地方法栈(*Native Method Stack*) (简单的概念)

* **作用** : 为本地(_Native_)方法提供内存空间

* **例子** :  ![[Pasted image 20230120113140.png]] **java.lang.System** 下的 *native* 方法



# 04 堆(*Heap*)

```ad-note
title:虚拟机参数
option : -Xmx8m 修改堆空间为8m
```

# 堆内存诊断工具 : *jmap*  *jconsole* *jps* *jvisualvm*

ad-note
title:jconsole
![[Pasted image 20230104165845.png]]



# 05方法区

```ad-note
title:定义
**官方定义:**
![[Pasted image 20230104172015.png]]
包含运行时常量池,类的字段,类的方法数据,方法和构造器的代码,还包含特殊方法
```

![[Pasted image 20230104172308.png]]
## 方法区(Metaspace)内存溢出代码

通过大量(*10000个*)加载类来实现
![[Pasted image 20230104173722.png]]

# 二进制字节码(*.class*文件):

* 类基本属性
* [[00 什么是JVM (Java Virtual Machine)#^23ae0c|常量池]]
* 类的方法定义
* 虚拟机指令


# 常量池

^23ae0c

```ad-info
title:常量池的作用(个人见解)
常量池，就是一张表，虚拟机指令根据这张常量表找到要执行的类名、方法名、参数类型、字面量等信息,让java虚拟机在运行时通过符号像查字典一样一一翻译
```

```ad-info
title:运行时常量池
运行时常量池，常量池是*.class文件中的，当该类被加载，它的常量池信息就会放入运行时常量池，并
把里面的符号地址变为真实地址

```

## StringTable:

![[Pasted image 20230104210232.png]]

### 特性:
* 常量池中的字符串仅是符号，第一次用到时才变为对象
* 利用串池的机制，来避免重复创建字符串对象
* 字符串变量拼接的原理是String Builder（1.8）
* 字符串常量拼接的原理是编译期优化
* 可以使用intern方法，主动将串池中还没有的字符串对象放入串池


### 面试题 ():
![[Pasted image 20230104203601.png]]

### StringTable位置
![[Pasted image 20230104211052.png]]

### StringTable会被垃圾会收

### StringTable性能优化

#### 基于HashTable特性的优化
```ad-tip
title:通过提高table中桶的数量来减少hash冲突从而加快速度
		-XX:StringTableSize=1009

```

![[Pasted image 20230105150901.png]]

# 6.直接内存

```ad-note
title:普通IO和NIO的区别
**普通阻塞IO**
![[Pasted image 20230105153037.png]]

**NIO**
![[Pasted image 20230105153136.png]]

```

## 特点
* 常见于NIO操作时，用于数据缓冲区
* 分配回收成本较高，但读写性能高
* 不受JVM内存回收管理

## 直接内存溢出代码
```java
public class Demo1 {  
    static final int _100M = 1024 * 1024 * 100;  
  
    public static void main(String[] args) {  
        int i = 0;  
        //让byteBuffer一直被引用
        ArrayList<ByteBuffer> list = new ArrayList<>();  
        try {  
            while (true) {  
	            // 使用 ByteBuffer 类 去 分配 allocate 直接内存 direct 
	            // 并 使用 局部变量 byteBuffer 去 指向 该对象
                ByteBuffer byteBuffer = ByteBuffer.allocateDirect(_100M);  
                list.add(byteBuffer);  
                i++;  
            }  
        } finally {  
	        //输出次数
            System.out.println(i);  
        }  
    }  
}
```


## 分配和回收直接内存的原理
![[Pasted image 20230105163552.png]]

```ad-important
title:
**直接内存的释放是通过java底层的 *unsafe* 对象来实现的 ,  而非 *GC* ,底层运用的是虚引用对象*Cleaner* ** 
```

# 7.垃圾回收
## 对象存活判断
* ### **引用计数法**:
	* *Reference Counting*
	* 对象中添加引用计数器，被引用是加一，引用失效时减一，计数器为零即可回收 
	* 原理简单，效率高 
	* 例外情况太多，无法处理循环引用


### 可达分析算法
```ad-important
title:重要概念**GCRoots**
GCRoots对象包括：虚拟机栈中的局部变量表引用的对象，方法区中类静态属性引用和常量引用对象，本地方法栈中的引用的对象
```



# 8. 四大引用

建议看大佬的文章 [[00 什么是JVM (Java Virtual Machine)#^97ad52|大佬的文章]]
## 软引用(SoftReference)

....

# 9. 垃圾回收算法

## 传统算法
* ### **标记-清除算法**(*Mark Sweep)![[Pasted image 20230114164833.png]]
	* **优点** : **速度快**,清除只需要标记 *垃圾* 的起始及终止地址即可
	* **缺点** : **会产生内存碎片**一旦遇到需要连续空间的对象 (*数组* 等) 空间没有整理,看似有内存,实际上缺塞不进去

* ### **标记-整理算法**(*Mark Compact)![[Pasted image 20230114165659.png]]
	* **优点** : 使内存更加紧凑 (**没有内存碎片**)
	* **缺点** : 整理**速度慢**,里面牵扯到了对象的地址变换 (*个人见解 : 假如 局部变量a -> 0x009 -> 对象a 现在 0x009变成了0x003改变了 对原本的的代码改动变大* )

* ### **复制算法**(*Copy*)![[Pasted image 20230114171101.png]]
	* **优点** :  **没有内存碎片**
	* **缺点** : 需要**占用双倍的内存空间**


## *JVM*分代回收算法

```ad-tip
title:弹幕看到的
**每次minorGC后，eden和from对象都清除干净了**
```

* ### **标记-复制算法** (*Mark Copy*)![[Pasted image 20230114201124.png]]
	* 将**新生代**分为一块较大的 *Eden* 空间和两块较小的 *Survivor* 空间
	* 每次分配只使用 *Eden* 和其中一块 *Survivor* 
	* 当发生垃圾回收时，将 *Eden* 和 *Survivor* 中仍然存活的对象一次性复制到另外一块*Survivor*空间，接着直接清理掉 *Eden* 和已使用的 *Survivor* 
	* **Hotspot**默认的 *Eden* 和 *Survivor* 比例为 **8 : 1**  
	* 当 *Survivor* 空间不足以容纳 *Minor GC* 后的存活对象，则需要其他内存区域进行分配担保（*Handle Promotion*），这些对象将通过分配担保机制直接进入**老年代**


# *GC* 分析

```ad-note
title:## demo的*jvm*机参数
-Xms20M -Xmx20M -Xmn10M -XX:+UseSerialGC -XX:+PrintGCDetails -verbose:gc
```

```ad-important
title:## 提示
 一个线程里如果OOM了,并不会导致整个java进程结束
```
