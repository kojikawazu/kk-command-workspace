# Docker環境のインストールマニュアル

## Dockerのインストール

```bash
# 既存のDockerバージョンの削除
sudo apt-get remove docker docker-engine docker.io containerd runc

# Dockerリポジトリの設定
sudo apt-get -y update
sudo apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Dockerのインストール
sudo apt-get -y update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io

# Docker確認
docker version
```

## Docker Composeのインストール

```bash
# Docker Composeのダウンロード
sudo curl -L "https://github.com/docker/compose/releases/download/v2.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# 実行権限の付与
sudo chmod +x /usr/local/bin/docker-compose

# Docker Composeのバージョン確認
docker-compose --version
```

## Docker Desktop for windowsと同期

1. Docker Desktopを起動
2. 右上の歯車(設定アイコン)をクリック
3. Resources -> WSL integration へ移動
4. Enable ～ のチェックボックスにチェックする
5. 必要なLinux分にチェックを入れる
6. Apply & restartボタンを押下する
