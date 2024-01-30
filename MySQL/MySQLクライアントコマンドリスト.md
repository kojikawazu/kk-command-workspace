# MySQLコマンドリスト
---

## MySQLクライアントのインストール(Amazon Linux 2023の場合)

```bash
# 全体更新
sudo dnf upgrade -y
# MySQLのリポジトリをインストール(Amazon Linux 2023は以下となる)
sudo dnf -y localinstall  https://dev.mysql.com/get/mysql80-community-release-el9-1.noarch.rpm
# MySQLクライアントのインストール
sudo dnf -y install mysql mysql-community-client
```