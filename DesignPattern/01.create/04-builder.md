# ビルダー（Builder）パターン

ビルダー（Builder）パターンは、複雑なオブジェクトの構築プロセスをステップバイステップで行い、同じ構築プロセスで異なる表現形式のオブジェクトを生成できるようにするデザインパターンです。これにより、オブジェクトの内部表現をクライアントから隠蔽し、構築プロセスを再利用して異なるオブジェクトを生成することが可能になります。

## 適用場面

- 複雑なオブジェクトの作成プロセスが固定されているが、その組成は異なる場合:
  - オブジェクトの構築が複数のステップで行われ、各ステップで様々な表現が可能な場合に適しています。例えば、異なるタイプのドキュメントを生成するエディタや、異なる種類の車を組み立てる自動車工場など。
- オブジェクトの構成要素が多岐にわたる場合:
  - オブジェクトが多数のコンポーネントやオプションで構成されていて、それらがさまざまな組み合わせでオブジェクトを形成する場合に有効です。
- オブジェクトの生成に一貫性が求められる場合:
  - 構築プロセスを一つの場所にカプセル化することで、異なるオブジェクトでも同じ構築プロセスを保証することができます。

## メリット

- 構築プロセスの詳細隔離:
  - クライアントは構築プロセスの詳細を知る必要がなく、ビルダーのインターフェースを通じてオブジェクトを生成できます。
- 再利用性と拡張性:
  - ビルダークラスを拡張して新しいビルダーを容易に追加することができるため、同じ構築プロセスで異なるオブジェクトを生成することが可能です。
- オブジェクト表現の変更容易性:
  - オブジェクトの具体的な内部表現を変更するには、新しいビルダーを実装するだけで良いので、既存のクライアントコードを変更する必要がありません。
- より良い制御:
  - 構築プロセスがステップごとに進むため、最終的なオブジェクトがステップに応じて段階的に構築されます。これにより、より精密な制御が可能になります。

## デメリット

- 設計の複雑性:
  - ビルダーパターンを導入することで、システムに多くの新しいクラスやインターフェースが追加されることがあり、設計が複雑になることがあります。
- オーバーヘッドの増加:
  - 単純なオブジェクトの生成にビルダーパターンを使用すると、不必要なオーバーヘッドが発生する可能性があります。オブジェクトの構築が非常にシンプルな場合は、他のパターンや直接的な方法が適切かもしれません。
- コードの維持管理:
  - ビルダーとそれを使用するクライアントコードの両方を維持する必要があります。ビルダーのインターフェースが変更された場合、それを使用するすべてのクライアントコードも更新する必要が出てきます。

ビルダーパターンは、構築プロセスの柔軟性を重視し、オブジェクトの内部構造から構築プロセスを隔離したい場合に特に有効です。

## サンプルコード

```java
// ピザクラス
class Pizza {
    private String dough;
    private String sauce;
    private String topping;

    public void setDough(String dough) {
        this.dough = dough;
    }

    public void setSauce(String sauce) {
        this.sauce = sauce;
    }

    public void setTopping(String topping) {
        this.topping = topping;
    }

    @Override
    public String toString() {
        return "Pizza{" +
               "dough='" + dough + '\'' +
               ", sauce='" + sauce + '\'' +
               ", topping='" + topping + '\'' +
               '}';
    }
}

// 抽象ビルダー
abstract class PizzaBuilder {
    protected Pizza pizza;

    public void createNewPizzaProduct() {
        pizza = new Pizza();
    }

    public Pizza getPizza() {
        return pizza;
    }

    public abstract void buildDough();
    public abstract void buildSauce();
    public abstract void buildTopping();
}

// 具体的なビルダー（ハワイアンピザ）
class HawaiianPizzaBuilder extends PizzaBuilder {
    public void buildDough() {
        pizza.setDough("cross");
    }

    public void buildSauce() {
        pizza.setSauce("mild");
    }

    public void buildTopping() {
        pizza.setTopping("ham+pineapple");
    }
}

// 具体的なビルダー（スパイシーピザ）
class SpicyPizzaBuilder extends PizzaBuilder {
    public void buildDough() {
        pizza.setDough("pan baked");
    }

    public void buildSauce() {
        pizza.setSauce("hot");
    }

    public void buildTopping() {
        pizza.setTopping("pepperoni+salami");
    }
}

// ディレクター
class Cook {
    private PizzaBuilder pizzaBuilder;

    public void setPizzaBuilder(PizzaBuilder pb) {
        pizzaBuilder = pb;
    }

    public Pizza getPizza() {
        return pizzaBuilder.getPizza();
    }

    public void constructPizza() {
        pizzaBuilder.createNewPizzaProduct();
        pizzaBuilder.buildDough();
        pizzaBuilder.buildSauce();
        pizzaBuilder.buildTopping();
    }
}

// 実行クラス
public class BuilderExample {
    public static void main(String[] args) {
        Cook cook = new Cook();
        PizzaBuilder hawaiianPizzaBuilder = new HawaiianPizzaBuilder();
        PizzaBuilder spicyPizzaBuilder = new SpicyPizzaBuilder();

        cook.setPizzaBuilder(hawaiianPizzaBuilder);
        cook.constructPizza();
        Pizza pizza = cook.getPizza();
        System.out.println("Pizza built: " + pizza);

        cook.setPizzaBuilder(spicyPizzaBuilder);
        cook.constructPizza();
        pizza = cook.getPizza();
        System.out.println("Pizza built: " + pizza);
    }
}
```


```typescript
// ピザクラス
class Pizza {
    private dough: string;
    private sauce: string;
    private topping: string;

    setDough(dough: string): void {
        this.dough = dough;
    }

    setSauce(sauce: string): void {
        this.sauce = sauce;
    }

    setTopping(topping: string): void {
        this.topping = topping;
    }

    toString(): string {
        return `Pizza with dough: ${this.dough}, sauce: ${this.sauce}, topping: ${this.topping}`;
    }
}

// 抽象ビルダー
abstract class PizzaBuilder {
    protected pizza: Pizza;

    createNewPizzaProduct(): void {
        this.pizza = new Pizza();
    }

    getPizza(): Pizza {
        return this.pizza;
    }

    abstract buildDough(): void;
    abstract buildSauce(): void;
    abstract buildTopping(): void;
}

// 具体的なビルダー（ハワイアンピザ）
class HawaiianPizzaBuilder extends PizzaBuilder {
    buildDough(): void {
        this.pizza.setDough("cross");
    }

    buildSauce(): void {
        this.pizza.setSauce("mild");
    }

    buildTopping(): void {
        this.pizza.setTopping("ham+pineapple");
    }
}

// 具体的なビルダー（スパイシーピザ）
class SpicyPizzaBuilder extends PizzaBuilder {
    buildDough(): void {
        this.pizza.setDough("pan baked");
    }

    buildSauce(): void {
        this.pizza.setSauce("hot");
    }

    buildTopping(): void {
        this.pizza.setTopping("pepperoni+salami");
    }
}

// ディレクター
class Cook {
    private pizzaBuilder: PizzaBuilder;

    setPizzaBuilder(pb: PizzaBuilder): void {
        this.pizzaBuilder = pb;
    }

    getPizza(): Pizza {
        return this.pizzaBuilder.getPizza();
    }

    constructPizza(): void {
        this.pizzaBuilder.createNewPizzaProduct();
        this.pizzaBuilder.buildDough();
        this.pizzaBuilder.buildSauce();
        this.pizzaBuilder.buildTopping();
    }
}

// 実行
let cook = new Cook();
let hawaiianPizzaBuilder = new HawaiianPizzaBuilder();
let spicyPizzaBuilder = new SpicyPizzaBuilder();

cook.setPizzaBuilder(hawaiianPizzaBuilder);
cook.constructPizza();
let pizza = cook.getPizza();
console.log("Pizza built: " + pizza.toString());

cook.setPizzaBuilder(spicyPizzaBuilder);
cook.constructPizza();
pizza = cook.getPizza();
console.log("Pizza built: " + pizza.toString());

```
