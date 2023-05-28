

# 第一章

![[Snipaste_2023-04-19_19-09-22.png]]

## 1.1 什么是Internet 

### 节点()
```ad-note
title:节点
节点分为 
1. **主机节点** : 主机节点就是一般的主机 比如 机顶盒,电脑,接入网络的电视 及其的应用程序
2. **数据交换节点** : 数据交换节点指的是 数据链路层的 *交换机* ,网络层 的 *路由器* ,以及更高层的 *负载均衡设备* 
```

### 边 通信链路

```ad-note
title:边
边是由 **数据链路层** 组成的一条条链路叫做边 

由接入的节点又分为两类 
1. 接入网链路, 主机连接到互联网的链路
2. 主干网(*backbone*) 路由器中间的链路
```

### 协议(*protocol*)

```ad-note
title:protocol
**协议** : 指是 对等层 的 实体 运行中的模块进行通信时所要遵守的 **规则的集合** 

集合包括 *语法* *语义* *时序*
```

![[Snipaste_2023-04-12_17-38-33.png]]

```ad-summary
title:基本概念
*meida* 介质也就是说 网线 光纤 电缆  位于第0层

*media* 在物理层之下,主要是把数字信号到物理信号

网络模型中每一层: 

**应用层** *message*消息

**运输层** *segment*段

**网络层** *packet*包

**数据链路层** PDU --*frame* 帧 
 
**物理层** *Bit* 比特



```



## 网络结构


### 简单概述 :

### 边缘与核心与接入网

![[Pasted image 20230226170315.png]]

![[Pasted image 20230226164159.png]]

![[Snipaste_2023-04-13_17-03-10 1.png]]


## 1.2 网络边缘(network edge) 面向连接 服务

![[Pasted image 20230226174149.png]]



## 1.3 网络核心

#### 电路交换

![[Snipaste_2023-04-17_18-35-32.png]]
![[Snipaste_2023-04-17_18-54-41.png]]
![[Snipaste_2023-04-17_18-57-24.png]]

##### FDM & TDM
![[Snipaste_2023-04-17_20-08-47.png]]

##### 计算题

![[Snipaste_2023-04-17_20-27-34.png]]

![[Snipaste_2023-04-17_20-36-51.png]]

#### 分组交换
![[Snipaste_2023-04-17_20-58-14.png]]

![[Snipaste_2023-04-17_21-04-55.png]]

![[Snipaste_2023-04-17_21-10-07.png]]

## 网络的分类

![[Snipaste_2023-04-18_14-56-58.png]]

#### 虚电路(virtual circuit)的工作原理

![[Snipaste_2023-04-18_14-58-15.png]]

#### 数据报(datagram)的工作原理

![[Snipaste_2023-04-18_15-00-09.png]]

## 1.4 接入网(access)和物理媒体(physical media)

### modem(猫🐱)

![[Snipaste_2023-04-18_15-22-19.png]]

![[Snipaste_2023-04-18_15-32-27.png]]

### 物理媒体(physical media)

![[Snipaste_2023-04-18_15-45-59.png]]

![[Snipaste_2023-04-18_15-49-27.png]]

![[Snipaste_2023-04-18_15-54-36.png]]

## 1.5 Internet 结构与 ISP

### *ISP* (Internet Service Providers) 网络服务提供者

![[Snipaste_2023-04-18_17-03-21.png]]


![[Snipaste_2023-04-18_18-44-34.png]]

```ad-note
title: ICP ISP IXP
ICP :  ISP (*Internet Server Provider*) 

ICP :  ICP (*Internet Content Provider*)  

IXP :  IXP (*Internet Exchange Point*) 

```

### Internet 结构

![[Snipaste_2023-04-20_16-31-19.png]]

### ISP (*Internet Server Provider*) 之间的连接

![[Snipaste_2023-04-20_16-36-21.png]]

##  1.6 分组延时 , 丢失和吞吐量

![[Snipaste_2023-04-20_20-58-44.png]]

### 四种分组延迟

![[Snipaste_2023-04-20_21-00-53.png]]

![[Snipaste_2023-04-20_21-04-00.png]]

#### 节点延时的总结
![[Snipaste_2023-04-20_21-15-27.png]]

![[Snipaste_2023-04-20_21-23-57.png]]

###  TraceRoute 路由跟踪命令 windows 

```shell
Tracert [TargetIpAddress]
```

![[Snipaste_2023-04-22_15-49-38.png]]

![[Snipaste_2023-04-22_15-43-23.png]]

![[Snipaste_2023-04-22_15-43-53.png]]

![[Snipaste_2023-04-22_15-44-25.png]]

### 分组丢失

![[Snipaste_2023-04-22_15-56-21.png]]

### 吞吐量

## 1.7 协议 ( *protocol* )



## TCP (*Transmission Control Protocol*) 

### TCP三次握手

![[计算机网络(CN) -- 快速学习#*TCP/IP*]]