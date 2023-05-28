
# Bash command 

```bash
docker run -d --name my-redis 2 -p 6667:6379 -v /home/ubuntu/docker-config/redis/redis.conf:/usr/local/etc/redis/redis.conf redis:5.0.14 redis-server /usr/local/etc/redis/redis.conf
```

# Redis.conf 

```txt
# Redis 配置文件示例

# 监听的 IP 地址和端口
bind 0.0.0.0
port 6379

# 设置密码
requirepass X9y*GGgViyRUYxzy7zkHVK6

# 客户端超时时间（单位：秒）
timeout 300

# 数据库数量
databases 16

# 持久化选项
save 900 1
save 300 10
save 60 10000



# 内存策略
maxmemory 2GB
maxmemory-policy allkeys-lru

# 其他配置选项...



```