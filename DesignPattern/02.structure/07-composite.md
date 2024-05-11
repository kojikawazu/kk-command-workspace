# コンポジット（Composite）パターン

コンポジット（Composite）パターンは、部分-全体の階層を表現するために使用されるデザインパターンです。このパターンを使用すると、個々のオブジェクトとオブジェクトの集合を、クライアントが同一の方法で操作できるようになります。コンポジットパターンは特に、一群のオブジェクトを単一のオブジェクトと同じように扱いたい場合に有効です。

## 適用場面

- 階層的な構造を持つオブジェクト群を管理する必要がある場合：
  - GUIコンポーネント、ファイルシステム、組織図など、部分と全体が階層関係にある構造を持つオブジェクトに適しています。
- 個々のオブジェクトとオブジェクトの集合を透過的に扱いたい場合：
  - クライアントが個々のオブジェクトとその集合を同じように扱えるようにすることで、プログラムの複雑さを減少させることができます。
- オブジェクトの追加や削除などの操作を一元化したい場合：
  - コンポジット構造内のオブジェクトに対する操作を一元管理することで、保守性や拡張性を向上させることが可能です。

## メリット

- クライアントの単純化：
  - クライアントは複合オブジェクトと単一オブジェクトを区別する必要がなく、同一のインターフェースを通じて操作を行うことができます。
- 柔軟な構造：
  - コンポジットパターンを使用することで、動的にオブジェクトの構造を変更することができます。オブジェクトの追加や削除が容易になります。
- 再帰的な構造の簡単化：
  - 再帰的なコンポーネントを持つシステムの管理が容易になり、それぞれのコンポーネントを同一の方法で扱うことができます。

## デメリット

- 設計の過剰一般化：
  - 全てのコンポーネントが同一のインターフェースを共有するため、特定のコンポーネントに特有の機能を持たせることが難しくなる場合があります。
- システムの過度な一般化：
  - すべてのコンポーネントを一律に扱うため、個々のコンポーネントの特性を無視することになり、パフォーマンスに影響を与えることがあります。
- 設計の複雑化：
  - コンポジットとリーフノードで異なる振る舞いを期待する場合、その区別を適切に管理することが設計上の挑戦となります。

コンポジットパターンは、階層的な構造を持つオブジェクト群を扱う場合に非常に有効ですが、その実装にはオブジェクトの一般化と設計の複雑性を考慮する必要があります。

## サンプルコード

```java
import java.util.ArrayList;
import java.util.List;

// コンポーネントインターフェース
interface Graphic {
    void draw();
}

// リーフコンポーネント
class Circle implements Graphic {
    public void draw() {
        System.out.println("Circle drawn.");
    }
}

class Rectangle implements Graphic {
    public void draw() {
        System.out.println("Rectangle drawn.");
    }
}

// コンポジットコンポーネント
class CompositeGraphic implements Graphic {
    private List<Graphic> children = new ArrayList<>();

    public void add(Graphic graphic) {
        children.add(graphic);
    }

    public void remove(Graphic graphic) {
        children.remove(graphic);
    }

    public void draw() {
        for (Graphic graphic : children) {
            graphic.draw();
        }
    }
}

// クライアントクラス
public class CompositePatternDemo {
    public static void main(String[] args) {
        CompositeGraphic graphic = new CompositeGraphic();
        graphic.add(new Circle());
        graphic.add(new Rectangle());

        CompositeGraphic subGraphic = new CompositeGraphic();
        subGraphic.add(new Circle());
        subGraphic.add(new Rectangle());

        graphic.add(subGraphic);

        graphic.draw();
    }
}
```

```typescript
interface Graphic {
    draw(): void;
}

// リーフコンポーネント
class Circle implements Graphic {
    draw(): void {
        console.log("Circle drawn.");
    }
}

class Rectangle implements Graphic {
    draw(): void {
        console.log("Rectangle drawn.");
    }
}

// コンポジットコンポーネント
class CompositeGraphic implements Graphic {
    private children: Graphic[] = [];

    add(graphic: Graphic): void {
        this.children.push(graphic);
    }

    remove(graphic: Graphic): void {
        const index = this.children.indexOf(graphic);
        if (index > -1) {
            this.children.splice(index, 1);
        }
    }

    draw(): void {
        this.children.forEach(graphic => graphic.draw());
    }
}

// クライアントコード
const graphic = new CompositeGraphic();
graphic.add(new Circle());
graphic.add(new Rectangle());

const subGraphic = new CompositeGraphic();
subGraphic.add(new Circle());
subGraphic.add(new Rectangle());

graphic.add(subGraphic);

graphic.draw();
```