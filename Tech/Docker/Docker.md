# 更新和升级包

```bash
sudo apt update && sudo apt upgrade
```


# 在 Linux 安装 
1.  更新和升级包
![[Docker#更新和升级包]]

2. 安装 Docker 相关的软件包，包括依赖项：
```bash
sudo apt install docker.io
```
3. 启动 Docker 服务：
 ```bash
sudo systemctl start docker
```
4. 将当前用户添加到 `docker` 用户组中，以便无需使用 `sudo` 来运行 Docker 命令：
```bash
sudo usermod -aG docker $USER
```
