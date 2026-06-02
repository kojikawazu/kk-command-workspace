# CQRS（Command Query Responsibility Segregation）

## CQRSの概要

システムの**読み取り（Query）と書き込み（Command）**の責任を分離するアーキテクチャパターンです。この設計は、特に大規模システムや、読み取りと書き込みの要件が大きく異なるケースで効果を発揮します。

## CQRSの基本概念

- コマンド（Command）：
  - データに変更を加える操作（作成、更新、削除）を意味します。書き込み専用のモデルを通じて処理され、データストアの更新を行います。

- クエリ（Query）：
  - データを取得する操作を意味します。クエリは読み取り専用のモデルを通じて行われ、データを提供しますが、データストアを変更することはありません。

- 読み取りモデルと書き込みモデルの分離：
  - CQRSでは、読み取りと書き込みのモデルを分離するため、各モデルはそれぞれの目的に最適化された設計が可能です。たとえば、読み取りモデルはデータ検索や表示に特化し、書き込みモデルはデータの一貫性を重視した構造とすることができます。

## CQRSのメリット

- パフォーマンスの向上：読み取り専用のモデルは高速化が容易で、キャッシュの利用やインデックスの最適化が可能です。

- スケーラビリティの向上：読み取りと書き込みを異なるサーバーで分散させることで、読み取り負荷が多い場合には読み取り専用のデータベースをスケールアウトできます。

- 複雑なドメインロジックへの対応：コマンドとクエリを分離することで、各操作に特化したビジネスロジックを構築しやすくなり、コードの可読性や保守性が向上します。

## CQRSのデメリット

- 設計と実装の複雑さ：読み取りと書き込みが分かれるため、データの整合性や同期の管理が複雑になります。

- データの一貫性：読み取り専用のデータベースがある場合、書き込みデータベースとの間でリアルタイムの同期が難しくなり、最終的な一貫性を保つ設計が求められます。

## CQRSの適用が有効な状況

- 読み取りと書き込みの負荷が大きく異なるケース：SNSやECサイトなど、アクセス頻度が高いデータの読み取り処理を高速化したい場合。

- パフォーマンスの最適化が必要なケース：レポートや分析システムで、読み取りに特化した構造にしたい場合。

- データ整合性よりも可用性を優先するケース：例えば、キャッシュや分散データベースを用いるアーキテクチャで、ある程度の最終一貫性が許容される場合。

## ディレクトリ構成

```csharp
order-service/
├── cmd/
│   └── main.go                       # エントリーポイント
├── internal/
│   ├── command/
│   │   └── handler/                  # 書き込み用のハンドラ
│   │       └── create_order.go
│   ├── query/
│   │   └── handler/                  # 読み取り用のハンドラ
│   │       └── get_order.go
│   ├── domain/
│   │   └── model/                    # ドメインモデル
│   │       └── order.go
│   └── repository/
│       └── order_repository.go       # リポジトリ
└── go.mod
```

## 書き込み操作（注文作成）のコマンドハンドラ

```go:internal/command/handler/create_order.go
package handler

import (
    "order-service/internal/domain/model"
    "order-service/internal/repository"
    "github.com/google/uuid"
)

type CreateOrderHandler struct {
    repo repository.OrderRepository
}

func NewCreateOrderHandler(repo repository.OrderRepository) *CreateOrderHandler {
    return &CreateOrderHandler{repo: repo}
}

func (h *CreateOrderHandler) Handle(userID uuid.UUID, items []model.OrderItem) (*model.Order, error) {
    order := model.NewOrder(userID, items)
    err := h.repo.Save(order)
    if err != nil {
        return nil, err
    }
    return order, nil
}
```

## 読み取り操作（注文情報の取得）のクエリハンドラ


```go:internal/query/handler/get_order.go
package handler

import (
    "order-service/internal/domain/model"
    "order-service/internal/repository"
    "github.com/google/uuid"
)

type GetOrderHandler struct {
    repo repository.OrderRepository
}

func NewGetOrderHandler(repo repository.OrderRepository) *GetOrderHandler {
    return &GetOrderHandler{repo: repo}
}

func (h *GetOrderHandler) Handle(orderID uuid.UUID) (*model.Order, error) {
    return h.repo.FindByID(orderID)
}
```