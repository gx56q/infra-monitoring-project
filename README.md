# API

## Локальный запуск

```bash
docker compose up -d
docker compose ps
curl http://localhost:80
./check_api.sh http://localhost:80
./analyze_logs.sh
```

## Запуск на сервере

Укажите свой логин и адрес сервера вместо `user@server.example`.

```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/monitoring
ssh-copy-id -i ~/.ssh/monitoring.pub user@server.example
git archive --format=tar.gz -o ../project.tar.gz HEAD
scp -i ~/.ssh/monitoring ../project.tar.gz user@server.example:~/
ssh -i ~/.ssh/monitoring user@server.example
```

На сервере распакуйте архив и запустите контейнеры.

```bash
mkdir -p ~/project
tar -xzf ~/project.tar.gz -C ~/project
cd ~/project
docker compose up -d
curl http://localhost:80
```
