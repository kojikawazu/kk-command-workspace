# レイヤードアーキテクチャーについて

アプリケーションを「層（レイヤー）」に分け、それぞれの層が明確な責務を持つように設計するアーキテクチャのスタイルです。これにより、各層が独立して動作し、互いに疎結合な関係を保ちながらアプリケーション全体を構成できます。

## レイヤードアーキテクチャの基本構成

レイヤードアーキテクチャは一般的に以下の4つの層で構成されます。

- プレゼンテーション層（Presentation Layer）
  - 役割：ユーザーとのやり取り（入力と出力）を担当する層です。ユーザーが送信したリクエストを処理し、適切なレスポンスを返す役割を持ちます。
  - 主な実装：Webアプリケーションではコントローラーやビューが含まれ、APIの場合はエンドポイントがこの層に該当します。

- アプリケーション層（Application Layer）
  - 役割：ビジネスロジックの調整やユースケースの管理を担当する層です。プレゼンテーション層からのリクエストを受けて、ビジネス層やデータ層を連携させ、全体の操作の流れを制御します。
  - 主な実装：サービスクラスが含まれることが多く、各ユースケースに対応するロジックがここに集まります。ビジネスルールを直接持つことは少なく、ビジネス層を呼び出して操作を行います。

- ビジネス層（Business Logic Layer / Domain Layer）
  - 役割：ビジネスロジックやドメインルールを実際に持つ層で、アプリケーションにおける中核的なロジックを定義します。
  - 主な実装：ドメインモデル、エンティティ、ビジネスルールを持つサービスクラスなどが含まれます。データ層に直接依存しない構成にすることが望ましいです。

- データ層（Data Layer / Infrastructure Layer）
  - 役割：データの永続化を担当する層で、データベースや外部API、ファイルシステムといったデータストレージに関する操作を行います。
  - 主な実装：リポジトリやデータアクセスオブジェクト（DAO）など、データのCRUD（Create, Read, Update, Delete）操作を担当するクラスが含まれます。

## レイヤードアーキテクチャの依存関係

- 依存の流れ：各層は基本的に「上位層から下位層」に依存します。
  - たとえば、プレゼンテーション層はアプリケーション層に依存し、アプリケーション層はビジネス層に依存します。
  - この順序により、ビジネス層やデータ層がプレゼンテーション層に依存しない構成が実現され、ビジネスロジックやデータの変更が上位層に影響を与えないように設計されています。

- 独立性の確保：ビジネスロジックやデータの処理は一箇所に集約されており、プレゼンテーション層やアプリケーション層の変更による影響を受けにくいのが特徴です。

## レイヤードアーキテクチャのメリット

- 保守性の向上：
  - 各層が独立しているため、特定の層を変更しても他の層に影響を与えにくくなります。

- 再利用性の向上：
  - データアクセスやビジネスロジックが一箇所に集約されるため、他のアプリケーションでも再利用しやすくなります。

- テストの容易さ：
  - 層ごとにテストを行えるため、単体テストや統合テストがしやすく、システム全体の品質を確保しやすい構造です。

## レイヤードアーキテクチャのデメリット

- パフォーマンスの低下：
  - 層ごとに依存が発生するため、複数の層を通過する処理でオーバーヘッドが生じ、パフォーマンスが低下する可能性があります。

- 柔軟性の不足：
  - 層ごとに依存関係が固定化されるため、大規模な変更が必要な場合、依存関係の見直しが難しくなることがあります。

- 冗長な実装：
  - 単純な処理であっても各層に責任を分散するため、単純なアプリケーションには少し冗長に感じることがあります。

## ディレクトリ構成

```csharp
project-root/
├── cmd/
│   └── app/
│       └── main.go               # アプリケーションのエントリーポイント
├── internal/
│   ├── presentation/             # プレゼンテーション層
│   │   └── controller/
│   │       └── order_controller.go
│   ├── application/              # アプリケーション層
│   │   └── service/
│   │       └── order_service.go
│   ├── domain/                   # ドメイン層（ビジネスロジック）
│   │   ├── model/
│   │   │   └── order.go
│   │   └── repository/
│   │       └── order_repository.go
│   └── infrastructure/           # データ層（インフラストラクチャ層）
│       └── db/
│           └── order_repository_impl.go
└── pkg/                          # 共通ライブラリやユーティリティ
    └── utils.go
```

# 1. プレゼンテーション層：order_controller.go

ユーザーからのリクエストを受け取り、アプリケーション層（サービス）に処理を依頼し、レスポンスを返します。

```go:internal/presentation/controller/order_controller.go
package controller

import (
    "net/http"
    "example.com/project/internal/application/service"
    "github.com/gin-gonic/gin"
    "github.com/google/uuid"
)

type OrderController struct {
    orderService *service.OrderService
}

func NewOrderController(orderService *service.OrderService) *OrderController {
    return &OrderController{orderService: orderService}
}

// CreateOrderHandler は新しい注文の作成リクエストを処理します
func (c *OrderController) CreateOrderHandler(ctx *gin.Context) {
    var request struct {
        UserID uuid.UUID `json:"user_id"`
        Total  float64   `json:"total"`
    }
    if err := ctx.ShouldBindJSON(&request); err != nil {
        ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
        return
    }

    order, err := c.orderService.CreateOrder(request.UserID, request.Total)
    if err != nil {
        ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
        return
    }

    ctx.JSON(http.StatusCreated, order)
}
```

## 2. アプリケーション層：order_service.go

ユースケースごとのビジネスロジックを実装し、リポジトリとドメインモデルを利用してビジネスルールを実行します。

```go:internal/application/service/order_service.go
package service

import (
    "example.com/project/internal/domain/model"
    "example.com/project/internal/domain/repository"
    "github.com/google/uuid"
)

type OrderService struct {
    orderRepo repository.OrderRepository
}

func NewOrderService(orderRepo repository.OrderRepository) *OrderService {
    return &OrderService{orderRepo: orderRepo}
}

// CreateOrder は新しい注文を作成します
func (s *OrderService) CreateOrder(userID uuid.UUID, total float64) (*model.Order, error) {
    order := model.NewOrder(userID, total)
    if err := s.orderRepo.Save(order); err != nil {
        return nil, err
    }
    return order, nil
}
```

## 3. ドメイン層（ビジネスロジック層）order.go

ビジネスルールに基づいたデータ構造やメソッドを定義します。

```go:internal/domain/model/order.go
package model

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

// NewOrder はOrderのコンストラクタ
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

リポジトリインターフェース：order_repository.go
ビジネスロジック層でのリポジトリインターフェースを定義します。

```go:internal/domain/repository/order_repository.go
package repository

import (
    "example.com/project/internal/domain/model"
    "github.com/google/uuid"
)

type OrderRepository interface {
    Save(order *model.Order) error
    FindByID(id uuid.UUID) (*model.Order, error)
}
```

## 4. データ層（インフラストラクチャ層）：order_repository_impl.go

データベースとのやり取りを実装します。リポジトリインターフェースを実装してデータベースの詳細を隠します。

```go:internal/infrastructure/db/order_repository_impl.go
package db

import (
    "database/sql"
    "example.com/project/internal/domain/model"
    "example.com/project/internal/domain/repository"
    "github.com/google/uuid"
)

type OrderRepositoryImpl struct {
    db *sql.DB
}

func NewOrderRepositoryImpl(db *sql.DB) repository.OrderRepository {
    return &OrderRepositoryImpl{db: db}
}

// Save は注文をデータベースに保存します
func (r *OrderRepositoryImpl) Save(order *model.Order) error {
    _, err := r.db.Exec("INSERT INTO orders (id, user_id, total, status, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?)",
        order.ID, order.UserID, order.Total, order.Status, order.CreatedAt, order.UpdatedAt)
    return err
}

// FindByID は指定されたIDの注文を検索して返します
func (r *OrderRepositoryImpl) FindByID(id uuid.UUID) (*model.Order, error) {
    row := r.db.QueryRow("SELECT id, user_id, total, status, created_at, updated_at FROM orders WHERE id = ?", id)
    order := &model.Order{}
    err := row.Scan(&order.ID, &order.UserID, &order.Total, &order.Status, &order.CreatedAt, &order.UpdatedAt)
    if err != nil {
        return nil, err
    }
    return order, nil
}
```

## 5. エントリーポイント：main.go

依存関係の注入を行い、アプリケーションを起動します。

```go:cmd/app/main.go
package main

import (
    "database/sql"
    "log"
    "example.com/project/internal/infrastructure/db"
    "example.com/project/internal/application/service"
    "example.com/project/internal/presentation/controller"
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
    orderService := service.NewOrderService(orderRepo)
    orderController := controller.NewOrderController(orderService)

    // ルータ設定
    router := gin.Default()
    router.POST("/orders", orderController.CreateOrderHandler)

    // サーバ起動
    router.Run(":8080")
}
```