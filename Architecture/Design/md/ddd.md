# DDD設計について

DDD（ドメイン駆動設計）は、特に複雑なビジネスロジックを中心に構築するソフトウェアの設計方法です。

**ドメイン例：注文管理システム**

このシステムでは、ユーザーが商品を注文し、注文の詳細（注文アイテム、支払情報など）を管理する流れを想定します。

## 1. プロジェクト全体のディレクトリ構成

```csharp
project-root/
├── cmd/
│   └── app/              # アプリケーションのエントリーポイント（main.go など）
│       └── main.go
├── internal/
│   ├── domain/           # ドメイン層（ビジネスロジックの中心部分）
│   │   ├── order/
│   │   │   ├── order.go  # エンティティと値オブジェクト
│   │   │   ├── item.go   # サブエンティティや値オブジェクト
│   │   │   └── service.go# ドメインサービス
│   │   ├── repository/
│   │   │   └── order_repository.go # リポジトリのインターフェース
│   │   └── factory/
│   │       └── order_factory.go    # ファクトリー
│   ├── application/      # アプリケーション層（ユースケース）
│   │   └── order_service.go
│   ├── infrastructure/   # インフラストラクチャ層（DBや外部システムとの接続）
│   │   ├── persistence/
│   │   │   └── order_repository.go # DB接続の具体的なリポジトリ実装
│   │   └── config/       # 設定ファイル管理
│   │       └── config.go
│   └── interfaces/       # インターフェース層（APIやUI）
│       └── api/
│           ├── handler/
│           │   └── order_handler.go # HTTPハンドラ
│           └── middleware/
│               └── auth_middleware.go # 認証ミドルウェア
└── pkg/                  # 共有ライブラリやユーティリティ
    └── utils.go
```

## 2. エンティティ：Order（注文）とOrderItem（注文アイテム）

Order はエンティティであり、アグリゲートルートになります。OrderItem は Order 内のサブエンティティです。

```go:Order.go
package domain

import (
    "time"
    "github.com/google/uuid"
)

type Order struct {
    ID         uuid.UUID
    UserID     uuid.UUID
    Items      []OrderItem
    Status     string
    CreatedAt  time.Time
    UpdatedAt  time.Time
}

// NewOrder はOrderファクトリーメソッドで、Orderを初期化します
func NewOrder(userID uuid.UUID, items []OrderItem) *Order {
    return &Order{
        ID:        uuid.New(),
        UserID:    userID,
        Items:     items,
        Status:    "Pending",
        CreatedAt: time.Now(),
        UpdatedAt: time.Now(),
    }
}

func (o *Order) AddItem(item OrderItem) {
    o.Items = append(o.Items, item)
}

type OrderItem struct {
    ID          uuid.UUID
    ProductID   uuid.UUID
    Quantity    int
    UnitPrice   float64
}

// NewOrderItem は OrderItem のファクトリーメソッドです
func NewOrderItem(productID uuid.UUID, quantity int, unitPrice float64) OrderItem {
    return OrderItem{
        ID:        uuid.New(),
        ProductID: productID,
        Quantity:  quantity,
        UnitPrice: unitPrice,
    }
}
```

## 3. リポジトリ：OrderRepository

リポジトリは、データベースとのインターフェースを提供し、アグリゲート（ここでは Order）の保存や取得を管理します。

```go:OrderRepository.go
package repository

import (
    "example.com/project/domain"
    "github.com/google/uuid"
)

type OrderRepository interface {
    Save(order *domain.Order) error
    FindByID(id uuid.UUID) (*domain.Order, error)
    FindByUserID(userID uuid.UUID) ([]domain.Order, error)
}
```

## 4. ドメインサービス：OrderService

ドメインサービスは、エンティティや値オブジェクトに属さないビジネスロジックを提供します。たとえば、「割引計算」を行うサービスや、「在庫確認」を行うサービスが該当します。

```go:OrderService.go
package service

import (
    "errors"
    "example.com/project/domain"
    "example.com/project/repository"
)

type OrderService struct {
    orderRepo repository.OrderRepository
}

func NewOrderService(orderRepo repository.OrderRepository) *OrderService {
    return &OrderService{orderRepo: orderRepo}
}

// PlaceOrder は注文を行うビジネスロジックを実装
func (s *OrderService) PlaceOrder(order *domain.Order) error {
    if len(order.Items) == 0 {
        return errors.New("注文にアイテムが含まれていません")
    }
    // ビジネスロジック（例：在庫確認など）
    return s.orderRepo.Save(order)
}
```

## 5. ファクトリー：OrderFactory

ファクトリーは、複雑なエンティティやアグリゲートの生成を行います。以下では OrderFactory を使って Order を生成しています。

```go:OrderFactory.go
package factory

import (
    "example.com/project/domain"
    "github.com/google/uuid"
)

type OrderFactory struct{}

func NewOrderFactory() *OrderFactory {
    return &OrderFactory{}
}

// CreateOrder は新しい Order を作成するためのメソッド
func (f *OrderFactory) CreateOrder(userID uuid.UUID, items []domain.OrderItem) *domain.Order {
    return domain.NewOrder(userID, items)
}
```

## 6. 使用例：注文を作成して保存

```go:main.go
package main

import (
    "fmt"
    "example.com/project/domain"
    "example.com/project/factory"
    "example.com/project/service"
    "github.com/google/uuid"
)

func main() {
    // Order Factoryの生成
    orderFactory := factory.NewOrderFactory()

    // 注文アイテムの作成
    item1 := domain.NewOrderItem(uuid.New(), 2, 100.0)
    item2 := domain.NewOrderItem(uuid.New(), 1, 50.0)
    items := []domain.OrderItem{item1, item2}

    // 注文の作成
    order := orderFactory.CreateOrder(uuid.New(), items)

    // Order Service の初期化（リポジトリはモックなどを使用）
    orderService := service.NewOrderService(nil) // 本来リポジトリを渡します

    // 注文の保存
    err := orderService.PlaceOrder(order)
    if err != nil {
        fmt.Println("エラー:", err)
    } else {
        fmt.Println("注文が保存されました:", order)
    }
}
```