# サーガパターン

## サーガパターンの概要

分散トランザクションを管理するための設計パターンです。分散システムやマイクロサービスアーキテクチャでは、各サービスが独立しているため、複数のサービスにまたがるトランザクション処理（例：注文作成、在庫の確認、支払い処理など）でのデータの整合性が課題になります。サーガパターンでは、各サービスがローカルトランザクションを完了させるたびに、他のサービスに通知してトランザクションを進行させることで、最終的なデータ整合性を保ちます。

## サーガパターンの種類

サーガパターンには、コレオグラフィーとオーケストレーションの2種類の実装方法があります。

- コレオグラフィー方式
  - 各サービスが独自に次のアクションをトリガーする方式。
  - 例：注文サービスが注文を作成すると、そのイベントを在庫サービスが受け取り、在庫を減らす処理を行います。在庫が処理完了したら、支払いサービスに通知する、といった流れです。
  - サービス間の直接的な連携によってトランザクションを進めるため、制御が簡単ですが、サービスの連携が複雑になると依存関係の管理が難しくなることがあります。

- オーケストレーション方式
  - 中央に「オーケストレーター」と呼ばれるサービスを配置し、トランザクション全体を管理する方式。
  - 例：オーケストレーターが注文の作成、在庫の引き当て、支払い処理などの順序を指示し、各ステップの完了や失敗を管理します。
  - 連携の順序やエラー時の回復処理が明確に定義できるため、複雑なトランザクションも整理しやすくなります。

## サーガパターンの流れ（例：ECサイトでの注文処理）

たとえば、注文処理のシナリオで、サーガパターンを利用した分散トランザクションは以下。

- 注文の作成：ユーザーが商品を注文すると、注文サービスが「注文作成」トランザクションを実行します。

- 在庫の引き当て：注文作成が完了したら、在庫サービスに在庫引き当てのトランザクションが開始されます。

- 支払いの実行：在庫引き当てが完了したら、支払いサービスに支払い処理が開始されます。

- 出荷準備：支払いが完了したら、出荷サービスで出荷準備が行われます。

万が一、どこかのステップで失敗した場合には、ロールバックのための代替アクションが発動します。たとえば、支払い処理が失敗した場合、在庫引き当てを取り消し、注文をキャンセルするといった処理を実行します。

## サーガパターンのメリット

- 分散トランザクションの管理：各サービスが独自にローカルトランザクションを管理するため、分散システムでもデータの整合性を保ちやすくなります。

- スケーラビリティ：トランザクションの一貫性が担保されつつも、各サービスが独立して動作するため、システムのスケーラビリティが確保されます。

- 柔軟性：オーケストレーション方式であれば、オーケストレーターが各ステップの順序や回復方法を一元的に管理するため、複雑なビジネスフローも管理が容易です。

## サーガパターンのデメリット

- 複雑なエラーハンドリング：ロールバックや代替アクションが必要となるため、エラーハンドリングの設計が複雑になります。

- タイミングの問題：コレオグラフィー方式の場合、各サービスが独立してイベントを処理するため、整合性を保つのが難しくなる場合があります。

- 依存関係の管理：サービス間の依存関係が増えると、設計や運用が難しくなることがあります。

## サンプル

### 1. サーガオーケストレーター

オーケストレーターは、各ステップのトランザクションを管理します。

```go:saga/saga_orchestrator.go
package saga

type Orchestrator struct {
    orderService     OrderService
    inventoryService InventoryService
    paymentService   PaymentService
    shipmentService  ShipmentService
}

func NewOrchestrator(order OrderService, inventory InventoryService, payment PaymentService, shipment ShipmentService) *Orchestrator {
    return &Orchestrator{
        orderService:     order,
        inventoryService: inventory,
        paymentService:   payment,
        shipmentService:  shipment,
    }
}

func (o *Orchestrator) ExecuteOrderSaga(orderID string) error {
    // 注文作成
    if err := o.orderService.CreateOrder(orderID); err != nil {
        return err
    }

    // 在庫引き当て
    if err := o.inventoryService.ReserveInventory(orderID); err != nil {
        o.orderService.CancelOrder(orderID) // ロールバック
        return err
    }

    // 支払い処理
    if err := o.paymentService.ProcessPayment(orderID); err != nil {
        o.inventoryService.ReleaseInventory(orderID) // ロールバック
        o.orderService.CancelOrder(orderID)
        return err
    }

    // 出荷準備
    if err := o.shipmentService.PrepareShipment(orderID); err != nil {
        o.paymentService.RefundPayment(orderID) // ロールバック
        o.inventoryService.ReleaseInventory(orderID)
        o.orderService.CancelOrder(orderID)
        return err
    }

    return nil
}
```

### 2. 各サービスの実装

以下は、オーケストレーターが利用するサービスのインターフェースと実装例です。

```go:services/order_service.go
package services

type OrderService interface {
    CreateOrder(orderID string) error
    CancelOrder(orderID string) error
}

type OrderServiceImpl struct {}

func (o *OrderServiceImpl) CreateOrder(orderID string) error {
    // 注文作成ロジック
    return nil
}

func (o *OrderServiceImpl) CancelOrder(orderID string) error {
    // 注文キャンセルロジック
    return nil
}
```

その他の InventoryService、PaymentService、ShipmentService も同様に、オーケストレーターに必要な操作をインターフェースとして提供します。