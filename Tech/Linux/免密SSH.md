
```bash
cat ~/.ssh/id_rsa.pub | ssh jacklove@107.172.99.132 "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
```


cat ~/.ssh/id_rsa.pub | ssh jacklove@101.33.250.187 "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"