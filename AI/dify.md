# Dify

## ローカルでDify動かす

### インストール

```bash
# Difyをcloneしてくる
git clone https://github.com/langgenius/dify.git

# Docker ComposeでDifyを起動
cd dify/docker
docker compose up -d

# 初期設定
# ブラウザで以下アドレスにアクセスし、初期設定を行います。
http://localhost
```

### Pythonの実行環境の調整

```bash
# インターネットへアクセスできるようにする
docker exec -it docker-sandbox-1 /bin/bash
echo "nameserver 8.8.8.8" > /etc/resolv.conf
exit
# Dockerコンテナの再接続
docker network connect bridge docker-sandbox-1
docker exec -it docker-sandbox-1 /bin/bash

# Pythonの依存関係を解消する
docker exec -it docker-sandbox-1 /bin/bash
find / -name "python-requirements.txt"
cat /dependencies/python-requirements.txt
echo "[依存関係]" >> /dependencies/python-requirements.txt
pip install -r /dependencies/python-requirements.txt
pip install --upgrade pip
pip install [パッケージ]
```

# URL

https://zenn.dev/tsuzukia/articles/ba7c90c38e3c2e#0.-dify%E3%82%92%E3%83%AD%E3%83%BC%E3%82%AB%E3%83%AB%E3%81%A7%E5%BB%BA%E3%81%A6%E3%82%8B

https://note.com/ai_tarou/n/n4899f0058fe5