# Echoの環境構築

## プロジェクト環境構築

```bash
# プロジェクトディレクトリの作成
mkdir -p projects
cd projects

# Goモジュールの初期化
go mod init projects

# Echoのインストール
go get github.com/labstack/echo/v4
```

## サンプルサーバーの作成

```go
package main

import (
    "net/http"
    "github.com/labstack/echo/v4"
)

func main() {
    e := echo.New()

    // ルートハンドラー
    e.GET("/", func(c echo.Context) error {
        return c.String(http.StatusOK, "Hello, Echo!")
    })

    // サーバーの開始
    e.Logger.Fatal(e.Start(":8080"))
}
```

## サーバーの起動

```bash
go run main.go
```

## URL

https://echo.labstack.com/