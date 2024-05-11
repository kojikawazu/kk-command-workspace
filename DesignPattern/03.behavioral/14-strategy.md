# Strategy（ストラテジー）パターン

Strategyパターン（ストラテジーパターン）は、アルゴリズムの家族を定義し、それらを動的に切り替え可能にすることで、アルゴリズムの使用をクライアントから独立させるデザインパターンです。これにより、アルゴリズムの具体的な実装がクライアントに影響を与えることなく変更や拡張が可能になります。

## 適用場面

- 異なるアルゴリズムのオプションがある場合：
  - アルゴリズムを実行時に選択できるようにしたい場合、例えばソートや検索などのアルゴリズムを異なるシナリオで使い分けたい場合に適しています。
- ビジネスルールが頻繁に変更される場合：
  - ビジネスルールが異なるアルゴリズムとして表現される場合、これらのルールが変更されたときに新しいクラスを追加するだけで対応できます。
- アルゴリズムによる影響を最小化したい場合：
  - 複数のアルゴリズムが存在し、それらがアプリケーションの他の部分に影響を与えないようにしたい場合に適しています。

## メリット

- アルゴリズムの交換可能性：
  - アルゴリズムの具体的な実装を簡単に交換できるため、異なる戦略を試すことが容易です。
- 拡張性：
  - 新しいアルゴリズム（戦略）を追加する際に、既存のコードを変更せずに新たなクラスを追加するだけで対応可能です。
- 疎結合：
  - 戦略を使用するクラス（コンテキスト）は、具体的なアルゴリズムの実装から独立しているため、コンポーネント間の結合が低く保たれます。

## デメリット

- クラスの増加：
  - 異なる戦略を実装するために多くのクラスが必要になる場合があります。これはアプリケーションの複雑性を増加させる可能性があります。
- オーバーヘッド：
  - 戦略パターンを使うことで、動的にアルゴリズムを切り替えるためのオーバーヘッドが発生することがあります。特に、アルゴリズムの切り替えが頻繁に行われる場合、パフォーマンスに影響を与える可能性があります。
- クライアントの負担増：
  - クライアントが戦略を意識する必要があり、適切な戦略を選択するための責任がクライアントに移されます。

これらの点を考慮し、アルゴリズムの柔軟性を高め、メンテナンスを容易にするために、特定のシナリオでストラテジーパターンを適用すると良いでしょう。

## サンプルコード

```java
interface PaymentStrategy {
    void pay(int amount);
}

class CreditCardStrategy implements PaymentStrategy {
    private String name;
    private String cardNumber;

    public CreditCardStrategy(String name, String cardNumber) {
        this.name = name;
        this.cardNumber = cardNumber;
    }

    @Override
    public void pay(int amount) {
        System.out.println(amount + " paid with credit/debit card.");
    }
}

class PaypalStrategy implements PaymentStrategy {
    private String emailId;

    public PaypalStrategy(String email) {
        this.emailId = email;
    }

    @Override
    public void pay(int amount) {
        System.out.println(amount + " paid using Paypal.");
    }
}

class ShoppingCart {
    private PaymentStrategy paymentStrategy;

    public void setPaymentStrategy(PaymentStrategy strategy) {
        this.paymentStrategy = strategy;
    }

    public void checkout(int amount) {
        paymentStrategy.pay(amount);
    }
}

public class StrategyPatternDemo {
    public static void main(String[] args) {
        ShoppingCart cart = new ShoppingCart();
        cart.setPaymentStrategy(new CreditCardStrategy("John Doe", "1234567890123456"));
        cart.checkout(100);

        cart.setPaymentStrategy(new PaypalStrategy("john@example.com"));
        cart.checkout(200);
    }
}
```

```typescript
interface PaymentStrategy {
    pay(amount: number): void;
}

class CreditCardStrategy implements PaymentStrategy {
    private name: string;
    private cardNumber: string;

    constructor(name: string, cardNumber: string) {
        this.name = name;
        this.cardNumber = cardNumber;
    }

    pay(amount: number): void {
        console.log(`${amount} paid with credit/debit card.`);
    }
}

class PaypalStrategy implements PaymentStrategy {
    private emailId: string;

    constructor(emailId: string) {
        this.emailId = emailId;
    }

    pay(amount: number): void {
        console.log(`${amount} paid using Paypal.`);
    }
}

class ShoppingCart {
    private paymentStrategy: PaymentStrategy;

    setPaymentStrategy(strategy: PaymentStrategy): void {
        this.paymentStrategy = strategy;
    }

    checkout(amount: number): void {
        this.paymentStrategy.pay(amount);
    }
}

// Usage
const cart = new ShoppingCart();
cart.setPaymentStrategy(new CreditCardStrategy("John Doe", "1234567890123456"));
cart.checkout(100);

cart.setPaymentStrategy(new PaypalStrategy("john@example.com"));
cart.checkout(200);
```