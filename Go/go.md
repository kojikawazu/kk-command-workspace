# Goの環境構築

## インストール

```bash
wget https://go.dev/dl/go1.23.1.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.23.1.linux-amd64.tar.gz
```

## 実行パス設定

```bash:~/.bashrc
export PATH=$PATH:/usr/local/go/bin
```

## バージョン確認

```bash
go version
```

## URL

https://go.dev/

https://go.dev/dl/