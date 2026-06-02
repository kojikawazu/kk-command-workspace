# Decorator（デコレータ）パターン

デコレータ（Decorator）パターンは、オブジェクトに動的に新しい責務を追加することを目的としたデザインパターンです。このパターンを利用することで、サブクラス化の代わりにオブジェクトに機能を追加することができ、実行時にオブジェクトの振る舞いを拡張または変更することが可能になります。

## 適用場面

- オブジェクトに追加的な責務を柔軟に付与したい場合:
  - 新しいサブクラスを作成することなく、オブジェクトに新しい機能を追加したい場合に適しています。
- サブクラスの数を減らしたい場合:
  - 機能の組み合わせによって必要となるサブクラスの数が指数関数的に増加することを避けたい場合に有用です。
- 機能の追加を実行時に行いたい場合:
  - コンパイル時ではなく、実行時にオブジェクトの機能を拡張したい場合に利用されます。

## メリット

- 拡張性:
  - オブジェクトに新しい責務を動的に追加することが可能であり、既存のコードを変更することなく機能を拡張できます。
- サブクラスの削減:
  - 多機能なオブジェクトを扱う場合、サブクラスの数を大幅に削減できるため、システムの複雑さを抑えられます。
- 再利用性の向上:
  - デコレータを組み合わせることで、広範なシナリオで再利用可能なコンポーネントを作成できます。

## デメリット

- 小さなオブジェクトが多くなる:
  - デコレータパターンを使用すると、多数の小さなオブジェクトが生成され、システムが理解しにくくなることがあります。
- デバッグの難易度が増す:
  - デコレータの層が深くなると、エラーの追跡やデバッグが難しくなることがあります。
- 設計の複雑化:
  - 適切なデコレータの選定や使用には、システムの設計に対する深い理解が必要であり、設計の複雑化を招くことがあります。

デコレータパターンは、オブジェクト指向設計において非常に強力なツールですが、その適用はシステムの要件と利点・欠点を慎重に評価した上で行うべきです。デコレータは、特に動的な機能追加が頻繁に求められる場合や、多機能なオブジェクトを効率的に管理したい場合に有効です。

## サンプルコード

```java
// コンポーネントインターフェース
interface Beverage {
    double cost();
    String getDescription();
}

// 具体的なコンポーネント
class Coffee implements Beverage {
    public double cost() {
        return 1.99;
    }

    public String getDescription() {
        return "Coffee";
    }
}

// デコレータの抽象クラス
abstract class BeverageDecorator implements Beverage {
    protected Beverage beverage;

    public BeverageDecorator(Beverage beverage) {
        this.beverage = beverage;
    }

    public abstract String getDescription();
}

// 具体的なデコレータ
class Milk extends BeverageDecorator {
    public Milk(Beverage beverage) {
        super(beverage);
    }

    public double cost() {
        return beverage.cost() + 0.50;
    }

    public String getDescription() {
        return beverage.getDescription() + ", Milk";
    }
}

class Sugar extends BeverageDecorator {
    public Sugar(Beverage beverage) {
        super(beverage);
    }

    public double cost() {
        return beverage.cost() + 0.20;
    }

    public String getDescription() {
        return beverage.getDescription() + ", Sugar";
    }
}

// クライアントコード
public class DecoratorPatternDemo {
    public static void main(String[] args) {
        Beverage beverage = new Coffee();
        System.out.println(beverage.getDescription() + " $" + beverage.cost());

        Beverage milkCoffee = new Milk(beverage);
        System.out.println(milkCoffee.getDescription() + " $" + milkCoffee.cost());

        Beverage sugarMilkCoffee = new Sugar(milkCoffee);
        System.out.println(sugarMilkCoffee.getDescription() + " $" + sugarMilkCoffee.cost());
    }
}
```

```typescript
// コンポーネントインターフェース
interface Beverage {
    cost(): number;
    getDescription(): string;
}

// 具体的なコンポーネント
class Coffee implements Beverage {
    cost(): number {
        return 1.99;
    }

    getDescription(): string {
        return "Coffee";
    }
}

// デコレータの抽象クラス
abstract class BeverageDecorator implements Beverage {
    protected beverage: Beverage;

    constructor(beverage: Beverage) {
        this.beverage = beverage;
    }

    abstract getDescription(): string;

    cost(): number {
        return this.beverage.cost(); // Default implementation
    }
}

// 具体的なデコレータ
class Milk extends BeverageDecorator {
    constructor(beverage: Beverage) {
        super(beverage);
    }

    cost(): number {
        return this.beverage.cost() + 0.50;
    }

    getDescription(): string {
        return this.beverage.getDescription() + ", Milk";
    }
}

class Sugar extends BeverageDecorator {
    constructor(beverage: Beverage) {
        super(beverage);
    }

    cost(): number {
        return this.beverage.cost() + 0.20;
    }

    getDescription(): string {
        return this.beverage.getDescription() + ", Sugar";
    }
}

// クライアントコード
const beverage = new Coffee();
console.log(`${beverage.getDescription()} $${beverage.cost()}`);

const milkCoffee = new Milk(beverage);
console.log(`${milkCoffee.getDescription()} $${milkCoffee.cost()}`);

const sugarMilkCoffee = new Sugar(milkCoffee);
console.log(`${sugarMilkCoffee.getDescription()} $${sugarMilkCoffee.cost()}`);
```


