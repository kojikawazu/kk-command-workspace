# Visitor（ビジター）パターン

Visitorパターン（ビジターパターン）は、オブジェクト構造の要素に対して実行される操作をカプセル化するデザインパターンです。このパターンを使用することで、構造に追加せずに新しい操作を簡単に定義できるようになります。つまり、オブジェクトの構造を変えずに、後から新しい機能を追加することが可能です。

## 適用場面

- 複雑なオブジェクト構造に対する操作の多様化：
  - オブジェクトの構成要素に対して多くの異なるかつ互換性のある操作が頻繁に追加される場合。
- オブジェクト構造から処理を分離したい場合：
  - オブジェクトのクラスを変更せずに新しい操作を簡単に追加したい場合。
- 異なるクラスのオブジェクト群に対する操作の集約：
  - 様々な種類のオブジェクトに対して、一貫したインターフェースで操作を行いたい場合。

## メリット

- 拡張性：
  - 新しい操作をオブジェクト構造に追加することができるので、システムの柔軟性が向上します。
- 関心の分離：
  - データ構造と操作を分離することができ、それぞれ独立して変更や拡張が可能です。
- 再利用性の向上：
  - 既存のオブジェクト構造に対して新しい訪問者を簡単に追加できるため、異なる種類の操作を再利用しやすくなります。

## デメリット

- 複雑性の増加：
  - 新しいビジターを追加するたびに、全ての要素クラスに対する訪問操作を定義する必要があり、システム全体が複雑になりがちです。
- 設計の困難さ：
  - オブジェクト構造とビジターの両方がうまく設計されていないと、パターンの実装が困難になることがあります。
- 追加のオーバーヘッド：
  - ビジターパターンの使用には追加の実行時間やメモリ使用量のコストが伴います。特に、オブジェクト構造が大きく、訪問者が頻繁に変更される場合、このオーバーヘッドは無視できない可能性があります。

Visitorパターンは、システムの構造内で多くの異なるタイプのオブジェクトが存在し、これらのオブジェクトに対して多くの異なる操作が行われるような場合に特に有効です。特に、コンポジットパターンと組み合わせて使うことが一般的です。

## サンプルコード

```java
// 訪問者インターフェース
interface ComputerPartVisitor {
    void visit(Computer computer);
    void visit(Mouse mouse);
    void visit(Keyboard keyboard);
    void visit(Monitor monitor);
}

// 訪問可能な要素インターフェース
interface ComputerPart {
    void accept(ComputerPartVisitor visitor);
}

// 具体的な訪問可能な要素クラス
class Computer implements ComputerPart {
    ComputerPart[] parts;

    public Computer(){
        parts = new ComputerPart[] {new Mouse(), new Keyboard(), new Monitor()};
    }

    public void accept(ComputerPartVisitor computerPartVisitor) {
        for (int i = 0; i < parts.length; i++) {
            parts[i].accept(computerPartVisitor);
        }
        computerPartVisitor.visit(this);
    }
}

class Mouse implements ComputerPart {
    public void accept(ComputerPartVisitor computerPartVisitor) {
        computerPartVisitor.visit(this);
    }
}

class Keyboard implements ComputerPart {
    public void accept(ComputerPartVisitor computerPartVisitor) {
        computerPartVisitor.visit(this);
    }
}

class Monitor implements ComputerPart {
    public void accept(ComputerPartVisitor computerPartVisitor) {
        computerPartVisitor.visit(this);
    }
}

// 具体的な訪問者
class ComputerPartDisplayVisitor implements ComputerPartVisitor {
    public void visit(Computer computer) {
        System.out.println("Displaying Computer.");
    }

    public void visit(Mouse mouse) {
        System.out.println("Displaying Mouse.");
    }

    public void visit(Keyboard keyboard) {
        System.out.println("Displaying Keyboard.");
    }

    public void visit(Monitor monitor) {
        System.out.println("Displaying Monitor.");
    }
}

// クライアントクラス
public class VisitorDemo {
    public static void main(String[] args) {
        ComputerPart computer = new Computer();
        computer.accept(new ComputerPartDisplayVisitor());
    }
}
```

```typescript
// 訪問者インターフェース
interface ComputerPartVisitor {
    visitComputer(computer: Computer): void;
    visitMouse(mouse: Mouse): void;
    visitKeyboard(keyboard: Keyboard): void;
    visitMonitor(monitor: Monitor): void;
}

// 訪問可能な要素インターフェース
interface ComputerPart {
    accept(visitor: ComputerPartVisitor): void;
}

// 具体的な訪問可能な要素クラス
class Computer implements ComputerPart {
    parts: ComputerPart[];

    constructor() {
        this.parts = [new Mouse(), new Keyboard(), new Monitor()];
    }

    accept(visitor: ComputerPartVisitor): void {
        this.parts.forEach(part => part.accept(visitor));
        visitor.visitComputer(this);
    }
}

class Mouse implements ComputerPart {
    accept(visitor: ComputerPartVisitor): void {
        visitor.visitMouse(this);
    }
}

class Keyboard implements ComputerPart {
    accept(visitor: ComputerPartVisitor): void {
        visitor.visitKeyboard(this);
    }
}

class Monitor implements ComputerPart {
    accept(visitor: ComputerPartVisitor): void {
        visitor.visitMonitor(this);
    }
}

// 具体的な訪問者
class ComputerPartDisplayVisitor implements ComputerPartVisitor {
    visitComputer(computer: Computer): void {
        console.log("Displaying Computer.");
    }

    visitMouse(mouse: Mouse): void {
        console.log("Displaying Mouse.");
    }

    visitKeyboard(keyboard: Keyboard): void {
        console.log("Displaying Keyboard.");
    }

    visitMonitor(monitor: Monitor): void {
        console.log("Displaying Monitor.");
    }
}

// クライアントコード
const computer = new Computer();
computer.accept(new ComputerPartDisplayVisitor());
```