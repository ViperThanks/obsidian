
# 组成

![[Pasted image 20230304192243.png]]

# 类型

![[Pasted image 20230304192745.png]]

# 通信协议与体系结构

## 传输方式

![[Pasted image 20230304193249.png]]

```ad-note
title: 理解
半双工 : 对讲机
全双工 : 日常网络通信 -> 打电话

```

![[Pasted image 20230304194858.png]]


```ad-note
单播: 我和你聊天

多播 : 我和几个聊天

广播 : 我和 所有人聊天

**数据交换**

电路交换 : 直接占用所有的线路

报文交换 : 如图

分组交换 : 先分组 再 合并

```

![[Pasted image 20230304195450.png]]
```ad-note
网络协议三要素 : 语法语义和时序

```


# 网络层


![[Pasted image 20230304190603.png]]

# 子网划分

![[Pasted image 20230303183739.png]]

计算机 特殊地址 
![[Pasted image 20230304164707.png]]
# *TCP/IP*

## 三次握手

![[Pasted image 20230303185303.png]]

```ad-note
title: 见解
客户端先发送 都一个 *SYN包* 开始 SYN = 1, seq = x

服务器接收后 回发一个 *SYN-ACK包* SYN = 1 , ACK = 1,seq = y,ack = x + 1



```

## 四次挥手

![[Pasted image 20230303190742.png]]

![[Pasted image 20230304212341.png]]