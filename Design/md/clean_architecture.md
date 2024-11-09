# クリーンアーキテクチャについて

ソフトウェアの保守性や拡張性を高めるためのアーキテクチャ設計方法の一つで、特に「依存性の方向」を意識して設計することが特徴です。この設計では、ビジネスロジックと外部の要素を分離し、アプリケーションのコア部分を守りつつ柔軟性を維持します。

## クリーンアーキテクチャの基本概念

クリーンアーキテクチャの中心的な考えは、アプリケーションを「コアのビジネスロジック」と「外部の依存部分」に分け、依存関係が「内側から外側」に向かうようにすることです。つまり、ビジネスロジックはインターフェースを通じて外部に依存させ、逆に外部の層からコアに直接依存させないようにします。

## クリーンアーキテクチャの構成要素（円状の構造）

クリーンアーキテクチャは、以下のような層で構成されており、内側から外側へと展開されます。

## エンティティ（Entities）

ビジネスルールを表現するもので、業務で定義されるデータやそのデータに関わるロジックを持ちます。
DDDでいうエンティティや値オブジェクトが含まれ、アプリケーションのあらゆる場所で使用されます。

## ユースケース（Use Cases）

アプリケーション固有のビジネスロジックを定義し、特定のユーザー操作やシステム操作に基づいたロジックを管理します。
例えば、「注文の作成」や「支払の処理」といったアクションがユースケースに該当します。

## インターフェースアダプタ（Interface Adapters）

ユースケース層やエンティティ層と外部との橋渡しを行い、データの変換や外部依存の抽象化を担当します。
APIコントローラーやDBリポジトリのインターフェースがここに配置され、特定のUIやDBとの接続部分を管理します。

## フレームワークとドライバ（Frameworks & Drivers）

最も外側の層で、Webフレームワーク、データベース、UIなどの具体的な実装部分です。
アプリケーションが動作する環境であり、ビジネスロジックやユースケース層に影響を及ぼさないように設計します。

## 依存性の方向

クリーンアーキテクチャの原則として、依存性の方向は内側から外側に向かうべきです。つまり、外側の層は内側の層に依存することができますが、内側の層は外側の層に依存しません。この仕組みにより、フレームワークやデータベースの変更が直接ビジネスロジックに影響を及ぼさないように設計されています。

## クリーンアーキテクチャのディレクトリ構成例

以下はGo言語でのディレクトリ構成例です。基本的なクリーンアーキテクチャの原則に従って、それぞれの役割に応じたディレクトリを配置しています。

```csharp
project-root/
├── cmd/
│   └── app/                     # アプリケーションのエントリーポイント
│       └── main.go
├── internal/
│   ├── entities/                # エンティティ層（ビジネスルールを表現）
│   │   └── order.go
│   ├── usecases/                # ユースケース層（アプリケーション固有のビジネスロジック）
│   │   └── order_usecase.go
│   ├── interfaces/              # インターフェースアダプタ層
│   │   ├── controllers/         # コントローラー（プレゼンテーションロジック）
│   │   │   └── order_controller.go
│   │   └── repository/          # リポジトリのインターフェース
│   │       └── order_repository.go
│   ├── infrastructure/          # フレームワークとドライバ層
│   │   ├── db/                  # DB接続（外部依存）
│   │   │   └── order_repository.go
│   │   └── server/              # サーバの設定（Webフレームワークなど）
│   │       └── server.go
└── pkg/                         # 共通ライブラリやユーティリティ
    └── utils.go
```

## クリーンアーキテクチャのメリット

- **保守性の向上**：ビジネスロジックが外部依存から隔離され、変更がしやすくなります。
- **テストの容易さ**：ビジネスロジックと外部システムが分離されているため、モックなどを使用したテストが容易になります。
- **再利用性の向上**：フレームワークやデータベースなどの詳細に依存しないため、他のプロジェクトや環境にも移植しやすくなります。

## コード例

### 1. エンティティ層 (internal/entities/order.go)

エンティティ層では、ビジネスルールを表現するために、注文（Order）のエンティティを定義します。

```go:internal/entities/order.go
package entities

import (
    "time"
    "github.com/google/uuid"
)

type Order struct {
    ID        uuid.UUID
    UserID    uuid.UUID
    Total     float64
    Status    string
    CreatedAt time.Time
    UpdatedAt time.Time
}

// NewOrder は注文の初期化を行います。
func NewOrder(userID uuid.UUID, total float64) *Order {
    return &Order{
        ID:        uuid.New(),
        UserID:    userID,
        Total:     total,
        Status:    "Pending",
        CreatedAt: time.Now(),
        UpdatedAt: time.Now(),
    }
}
```

## 2. ユースケース層 (internal/usecases/order_usecase.go)

ユースケース層では、アプリケーション固有のビジネスロジックを表現します。注文を新規作成するロジックや注文を完了させるロジックを実装します。

```go:internal/usecases/order_usecase.go
package usecases

import (
    "example.com/project/internal/entities"
    "example.com/project/internal/interfaces/repository"
    "github.com/google/uuid"
)

type OrderUsecase struct {
    orderRepo repository.OrderRepository
}

// NewOrderUsecase はOrderUsecaseを初期化します
func NewOrderUsecase(orderRepo repository.OrderRepository) *OrderUsecase {
    return &OrderUsecase{orderRepo: orderRepo}
}

// CreateOrder は新しい注文を作成します
func (uc *OrderUsecase) CreateOrder(userID uuid.UUID, total float64) (*entities.Order, error) {
    order := entities.NewOrder(userID, total)
    if err := uc.orderRepo.Save(order); err != nil {
        return nil, err
    }
    return order, nil
}

// CompleteOrder は注文の完了ステータスを更新します
func (uc *OrderUsecase) CompleteOrder(orderID uuid.UUID) error {
    order, err := uc.orderRepo.FindByID(orderID)
    if err != nil {
        return err
    }
    order.Status = "Completed"
    order.UpdatedAt = time.Now()
    return uc.orderRepo.Save(order)
}
```

## 3. インターフェースアダプタ層 (internal/interfaces/repository/order_repository.go)

インターフェースアダプタ層では、ユースケース層とインフラストラクチャ層の橋渡しを行います。リポジトリのインターフェースを定義し、後でDBの具体実装と接続します。

```go:internal/interfaces/repository/order_repository.go
package repository

import (
    "example.com/project/internal/entities"
    "github.com/google/uuid"
)

type OrderRepository interface {
    Save(order *entities.Order) error
    FindByID(id uuid.UUID) (*entities.Order, error)
}
```

## 4. フレームワークとドライバ層（インフラストラクチャ層） (internal/infrastructure/db/order_repository.go)

インフラストラクチャ層では、データベース接続などの具体的な実装を行います。以下は、OrderRepository の実装例です。

```go:internal/infrastructure/db/order_repository.go
package db

import (
    "database/sql"
    "example.com/project/internal/entities"
    "example.com/project/internal/interfaces/repository"
    "github.com/google/uuid"
)

type OrderRepositoryImpl struct {
    db *sql.DB
}

func NewOrderRepositoryImpl(db *sql.DB) repository.OrderRepository {
    return &OrderRepositoryImpl{db: db}
}

// Save は注文をデータベースに保存します
func (r *OrderRepositoryImpl) Save(order *entities.Order) error {
    _, err := r.db.Exec("INSERT INTO orders (id, user_id, total, status, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?)",
        order.ID, order.UserID, order.Total, order.Status, order.CreatedAt, order.UpdatedAt)
    return err
}

// FindByID は指定されたIDの注文を検索して返します
func (r *OrderRepositoryImpl) FindByID(id uuid.UUID) (*entities.Order, error) {
    row := r.db.QueryRow("SELECT id, user_id, total, status, created_at, updated_at FROM orders WHERE id = ?", id)
    order := &entities.Order{}
    err := row.Scan(&order.ID, &order.UserID, &order.Total, &order.Status, &order.CreatedAt, &order.UpdatedAt)
    if err != nil {
        return nil, err
    }
    return order, nil
}
```

## 5. コントローラー (internal/interfaces/controllers/order_controller.go)

コントローラーはインターフェースアダプタ層の一部であり、HTTPリクエストを受け取ってユースケースを実行し、レスポンスを返す役割を持ちます。

```go:internal/interfaces/controllers/order_controller.go
package controllers

import (
    "net/http"
    "example.com/project/internal/usecases"
    "github.com/gin-gonic/gin"
    "github.com/google/uuid"
)

type OrderController struct {
    orderUsecase *usecases.OrderUsecase
}

func NewOrderController(orderUsecase *usecases.OrderUsecase) *OrderController {
    return &OrderController{orderUsecase: orderUsecase}
}

// CreateOrderHandler は注文の作成リクエストを処理します
func (c *OrderController) CreateOrderHandler(ctx *gin.Context) {
    var request struct {
        UserID uuid.UUID `json:"user_id"`
        Total  float64   `json:"total"`
    }
    if err := ctx.ShouldBindJSON(&request); err != nil {
        ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
        return
    }
    
    order, err := c.orderUsecase.CreateOrder(request.UserID, request.Total)
    if err != nil {
        ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
        return
    }

    ctx.JSON(http.StatusCreated, order)
}
```

## 6. エントリーポイント (cmd/app/main.go)

最後に、エントリーポイントとしてmain.goでアプリケーションを起動し、依存関係を注入します。

```go:cmd/app/main.go
package main

import (
    "database/sql"
    "log"
    "example.com/project/internal/infrastructure/db"
    "example.com/project/internal/interfaces/controllers"
    "example.com/project/internal/usecases"
    "github.com/gin-gonic/gin"
    _ "github.com/mattn/go-sqlite3"
)

func main() {
    // DB接続設定（例としてSQLiteを使用）
    database, err := sql.Open("sqlite3", "./orders.db")
    if err != nil {
        log.Fatal(err)
    }
    defer database.Close()

    // 依存関係の初期化
    orderRepo := db.NewOrderRepositoryImpl(database)
    orderUsecase := usecases.NewOrderUsecase(orderRepo)
    orderController := controllers.NewOrderController(orderUsecase)

    // ルータ設定
    router := gin.Default()
    router.POST("/orders", orderController.CreateOrderHandler)

    // サーバ起動
    router.Run(":8080")
}
```