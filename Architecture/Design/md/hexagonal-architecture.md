# ヘキサゴナルアーキテクチャ（別名「ポートとアダプターアーキテクチャ」）

## ヘキサゴナルアーキテクチャの概要

ヘキサゴナルアーキテクチャは、システムのコアロジック（ビジネスロジック）と外部の依存（データベースやAPIなど）を明確に分離することを目的としたアーキテクチャです。この設計では、ポートとアダプターという概念を使って、システムの内部と外部が疎結合になるように設計します。

- ポート：ビジネスロジックにアクセスするためのインターフェースを定義し、コアロジックが外部に依存せずに独立性を保つ役割を担います。

- アダプター：外部システムと接続するために必要な具体的な実装で、ポートに対応したインターフェースを実装し、依存関係を橋渡しします。

## ヘキサゴナルアーキテクチャの特徴

- 依存性の逆転
  - 外部の具体的な実装が、ビジネスロジックに依存する形を取ります（依存性逆転の原則）。
  - コアロジックは「ポート」のみを意識し、実際のデータアクセスやAPI呼び出しは「アダプター」に委ねられます。

- テスタブルな設計
  - ビジネスロジックが外部依存から切り離されるため、ユニットテストが容易になり、システムの変更に強い構造を持ちます。

- 拡張性と柔軟性
  - 新たなインターフェースや外部システムを追加する際に、アダプターを用意するだけで済むため、柔軟に拡張できます。

## ヘキサゴナルアーキテクチャの構成

ヘキサゴナルアーキテクチャは、システムを以下のように構成します。

- コア（ビジネスロジック）：ビジネスロジックを中心に据え、ドメインモデルやユースケースが含まれます。

- ポート：ビジネスロジックの入力・出力インターフェース。コアロジックがアクセスするための定義です。

- 入力ポート：外部からビジネスロジックを呼び出すためのインターフェース（例：アプリケーションのサービス層）。

- 出力ポート：ビジネスロジックが外部にデータを送る際に使用するインターフェース（例：リポジトリ）。

- アダプター：ポートのインターフェースを実装し、外部システム（データベース、API、UIなど）と接続します。

- 入力アダプター：外部からのリクエストを処理して入力ポートに渡します（例：APIハンドラやUI）。

- 出力アダプター：ビジネスロジックの結果を出力ポートから取得して外部に送信します（例：リポジトリやAPIクライアント）。

## ヘキサゴナルアーキテクチャのメリット

- 柔軟で拡張しやすい：外部依存をポートとアダプターで管理するため、新しいインターフェースやアダプターを追加するだけで拡張できます。

- 高いテスタビリティ：ビジネスロジックが外部依存から切り離されているため、テストが容易です。

- 疎結合の確保：アプリケーションの内部と外部が分離されており、依存関係がシンプルです。

## デメリット

- 初学者にとっての理解が難しい：ポートやアダプターの概念が新しく、学習コストが高い場合があります。

- 構造の複雑化：シンプルなシステムには不必要な場合があり、プロジェクト規模に応じて適用する必要があります。

## ディレクトリ構成

```csharp
project-root/
├── cmd/                          # エントリーポイント
│   └── main.go
├── internal/
│   ├── core/                     # ビジネスロジック層（ドメイン層）
│   │   ├── domain/               # ドメインモデル
│   │   ├── ports/                # ポート（インターフェース）
│   │   │   ├── input/            # 入力ポート（サービスインターフェース）
│   │   │   └── output/           # 出力ポート（リポジトリインターフェース）
│   │   └── services/             # ビジネスロジック
│   ├── adapters/                 # アダプター層
│   │   ├── input/                # 入力アダプター
│   │   │   └── api/              # REST APIハンドラ
│   │   └── output/               # 出力アダプター
│   │       └── persistence/      # データベース接続
└── go.mod
```

## サンプルコード

### 1. ドメインモデル（エンティティ）

```go:internal/core/domain/user.go
package domain

type User struct {
    ID    int
    Name  string
    Email string
}
```

### 2. ポート（インターフェース）

- 入力ポート（ビジネスロジックの操作）

```go:internal/core/ports/input/user_service.go
package input

import "project/internal/core/domain"

type UserService interface {
    RegisterUser(user domain.User) error
}
```

- 出力ポート（データアクセス）

```go:internal/core/ports/output/user_repository.go
package output

import "project/internal/core/domain"

type UserRepository interface {
    Save(user domain.User) error
}
```

### 3. コアサービス（ビジネスロジック）

```go:internal/core/services/user_service_impl.go
package services

import (
    "project/internal/core/domain"
    "project/internal/core/ports/output"
)

type UserServiceImpl struct {
    userRepo output.UserRepository
}

func NewUserService(userRepo output.UserRepository) *UserServiceImpl {
    return &UserServiceImpl{userRepo: userRepo}
}

func (s *UserServiceImpl) RegisterUser(user domain.User) error {
    // ここでバリデーションやビジネスルールを適用
    if user.Email == "" {
        return errors.New("email is required")
    }
    return s.userRepo.Save(user)
}
```

### 4. アダプター

- 入力アダプター（APIハンドラ）

```go:internal/adapters/input/api/user_handler.go
package api

import (
    "net/http"
    "project/internal/core/domain"
    "project/internal/core/ports/input"
    "github.com/gin-gonic/gin"
)

type UserHandler struct {
    userService input.UserService
}

func NewUserHandler(userService input.UserService) *UserHandler {
    return &UserHandler{userService: userService}
}

func (h *UserHandler) RegisterUser(c *gin.Context) {
    var user domain.User
    if err := c.BindJSON(&user); err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
        return
    }
    err := h.userService.RegisterUser(user)
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
        return
    }
    c.JSON(http.StatusOK, gin.H{"status": "user registered"})
}
```

- 出力アダプター（リポジトリ）

```go:internal/adapters/output/persistence/user_repository_impl.go
package persistence

import (
    "project/internal/core/domain"
)

type UserRepositoryImpl struct {
    // DB connection details here
}

func NewUserRepository() *UserRepositoryImpl {
    return &UserRepositoryImpl{}
}

func (repo *UserRepositoryImpl) Save(user domain.User) error {
    // 実際のDB操作をここで実装
    return nil
}
```
