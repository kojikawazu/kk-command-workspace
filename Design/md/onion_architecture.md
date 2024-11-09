# オニオンアーキテクチャ

## オニオンアーキテクチャの概要

ドメインロジックの純粋性と依存関係の制御を重視する設計パターンです。このアーキテクチャは、ビジネスロジックを外部から独立させることで、より柔軟でテスタブルなシステムを構築できるようにします。特に複雑なビジネスルールやドメインロジックが中心のシステムで有効です。

## オニオンアーキテクチャの特徴

- 依存関係の方向：
  - 依存関係は常に内側（コア層）から外側（インフラ層）に向けられます。
  - これにより、ビジネスロジックが外部の実装に依存せずに設計できます。

- レイヤー構造：
  - オニオンアーキテクチャは、同心円状の層構造を持ちます。中心に行くほどシステムのコア部分（ドメインロジック）となり、外側に向かってUIやデータベースなどのインフラ層が配置されます。
  - コア層：ドメインエンティティやドメインサービスが含まれるビジネスロジックの中心。
  - アプリケーション層：コア層を利用して具体的なビジネスケースを実現する層。
  - インフラ層：データベースや外部API、ファイルシステムなどの実際のインフラストラクチャーが含まれ、システムの外部と接続する層。

- テスタビリティ：
  - ビジネスロジックが独立しているため、UIやデータベースに依存せずにテストができ、柔軟で変更に強い設計が可能になります。

## オニオンアーキテクチャのレイヤー構造

以下のように同心円状に層が並びます：

- 中心（ドメイン層）：エンティティ、値オブジェクト、ドメインサービスが含まれるビジネスロジックの核心。ここは他の層に依存しません。

- アプリケーション層：ドメイン層の機能を利用して、ユースケースやアプリケーションのビジネスルールを実装します。

- インフラ層：データベースや外部システムの接続が含まれ、アプリケーション層からの依存を受けるだけで、逆の依存はありません。

## オニオンアーキテクチャのメリット

- 依存性の逆転：ビジネスロジックが外部のインフラに依存せず、テストや変更がしやすくなります。

- テスタビリティ：ドメインやアプリケーション層が独立しているため、ユニットテストが容易になります。

- 柔軟性と保守性：外部の変更に影響を受けにくく、長期的な運用や保守に強い設計です。

## デメリット

- 複雑さ：小規模なアプリケーションには複雑すぎる場合があり、学習コストも高くなります。

- 過剰設計のリスク：すべてのシステムに適用すると、シンプルにできる部分まで複雑化する可能性があるため、適用範囲を検討する必要があります。

## ディレクトリ構成例

```csharp
project-root/
├── cmd/                        # アプリケーションのエントリーポイント
│   └── main.go                 # エントリーポイント
├── internal/
│   ├── domain/                 # ドメイン層（コア層）
│   │   ├── entity/             # エンティティ（例：User、Orderなど）
│   │   └── service/            # ドメインサービス
│   │       └── user_service.go # ビジネスロジックの中心
│   ├── application/            # アプリケーション層（ユースケース層）
│   │   └── user_usecase.go     # アプリケーションロジック
│   ├── infrastructure/         # インフラ層
│   │   ├── repository/         # データベース接続やリポジトリ
│   │   │   └── user_repository.go
│   │   └── external/           # 外部APIとの接続
│   └── interfaces/             # UIやAPIのインターフェース層
│       └── api/
│           └── user_handler.go # APIハンドラ
└── go.mod                      # モジュールファイル（Goの場合）
```

## サンプルコード

### 1. ドメイン層のエンティティ

```go:internal/domain/entity/user.go
package entity

type User struct {
    ID    int
    Name  string
    Email string
}
```

### 2. ドメインサービス

```go:internal/domain/service/user_service.go
package service

import "project/internal/domain/entity"

type UserService struct{}

func (s *UserService) IsValidUser(user entity.User) bool {
    return user.Email != ""
}
```

### 3. アプリケーション層（ユースケース）

```go:internal/application/user_usecase.go
package application

import (
    "project/internal/domain/entity"
    "project/internal/domain/service"
    "project/internal/infrastructure/repository"
)

type UserUseCase struct {
    userRepo   repository.UserRepository
    userService service.UserService
}

func (uc *UserUseCase) RegisterUser(user entity.User) error {
    if !uc.userService.IsValidUser(user) {
        return errors.New("invalid user")
    }
    return uc.userRepo.Save(user)
}
```

### 4. インフラ層（リポジトリ）

```go:internal/infrastructure/repository/user_repository.go
package repository

import "project/internal/domain/entity"

type UserRepository interface {
    Save(user entity.User) error
}

type UserRepositoryImpl struct {
    // DB connection details here
}

func (repo *UserRepositoryImpl) Save(user entity.User) error {
    // DB save logic here
    return nil
}
```

### 5. インターフェース層（APIハンドラ）

```go:internal/interfaces/api/user_handler.go
package api

import (
    "net/http"
    "project/internal/application"
    "project/internal/domain/entity"
    "github.com/gin-gonic/gin"
)

type UserHandler struct {
    userUseCase application.UserUseCase
}

func (h *UserHandler) RegisterUser(c *gin.Context) {
    var user entity.User
    if err := c.BindJSON(&user); err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
        return
    }
    err := h.userUseCase.RegisterUser(user)
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
        return
    }
    c.JSON(http.StatusOK, gin.H{"status": "user registered"})
}
```






