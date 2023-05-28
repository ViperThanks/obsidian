
# 简单的 *Linux* 指令

## 防火墙(firewalld) 

1.  防火墙的开启、关闭、禁用命令  
    **设置开机启用/禁用防火墙：**      `systemctl enable/disable firewalld.service`  
    **启动/关闭防火墙：**             `systemctl start/stop firewalld`  
    **检查防火墙状态：**              `systemctl status firewalld`
2.  使用firewall-cmd配置端口  
    **查看防火墙状态：**      `firewall-cmd --state`  
    **重新加载配置：**        `firewall-cmd --reload`  
    **查看开放的端口：**      `firewall-cmd --list-ports`  
    **开启防火墙端口：**      `firewall-cmd --zone=public --add-port=9200/tcp --permanent`  
    命令含义：  
    *–zone*              作用域  
    *–add-port=9200/tcp* 添加端口，格式为：端口/通讯协议  
    *–permanent*         永久生效，没有此参数重启后失效  
    注意：添加端口后，必须用命令`firewall-cmd --reload`重新加载一遍才会生效  
    关闭防火墙端口：`firewall-cmd --zone=public --remove-port=9200/tcp --permanent`



## 后台运行

```shell
nohup java -jar {target.jar} > log.log 2>&1 &
``` 
