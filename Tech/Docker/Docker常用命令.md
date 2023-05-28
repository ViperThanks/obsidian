
# 查看运行中的容器: 

```shell
sudo docker ps -a
```

# 停止容器:

```shell
sudo docker stop <container-id>
```

# 删除容器 : 

```shell
sudo docker rm <container-id>
```

# 列出镜像: 

```shell
sudo docker images 
```

# 删除镜像:

```shell
sudo docker rmi <image-id>
```

# 安装 Docker:

```shell
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

# 运行 Hello World 实例

```shell
sudo docker run hello-world
```

# 创建一个 Dockerfile 文件:

```shell
vim dockerfile 
```

# 构建镜像

```shell
sudo docker build -t myapp .
```

# 运行容器
```shell
sudo docker run -p 8080:8080 -v /usr/app/log:/usr/app/log myapp
```

