# Template Method（テンプレートメソッド）パターン

Template Methodパターン（テンプレートメソッドパターン）は、操作の骨組みを定義し、その一部をサブクラスで実装させることで、アルゴリズムの構造を変えずに特定のステップを再定義できるデザインパターンです。このパターンは、基本的なプロセスのステップを定義しつつ、その詳細をサブクラスに委ねることを可能にします。

## 適用場面

- アルゴリズムの骨組みを一度定義し、その一部を異なる振る舞いで実装したい場合：
  - 複数のクラスで共通のプロセスがあり、プロセスの一部の振る舞いだけが異なる場合に適しています。
- コードの重複を避ける場合：
  - 似たようなアルゴリズムが複数存在するが、いくつかのステップの実装が異なる場合、共通の部分をスーパークラスに集約し、異なる部分だけをサブクラスでオーバーライドして実装することで、コードの重複を避けることができます。
- 制御の中央集約を図る場合：
  - アルゴリズムの特定のポイントでの振る舞いを制御し、その実行順序をスーパークラスで厳格に管理したい場合に適しています。

## メリット

- コードの再利用性：
  - 共通のコードをスーパークラスに一度書くことで、サブクラス間でコードの再利用が可能となります。
- 拡張が容易：
  - 新しい具体的な振る舞いを持つクラスを追加する場合、既存のクラスを変更することなく、必要なメソッドだけをオーバーライドすることができます。
- 制御の一元化：
  - アルゴリズムの骨組みを一箇所に保ち、サブクラスがその枠組みを変更することなく、特定のステップだけをカスタマイズできます。

## デメリット

- 柔軟性の制限：
  - テンプレートメソッドが定義するフローに強く依存するため、フロー自体を変更することが困難になることがあります。
- デバッグと理解の難しさ：
  - アルゴリズムの流れが複数のクラスに分散されているため、デバッグやコードの理解が難しくなることがあります。
- サブクラスの設計制約：
  - スーパークラスのメソッドによって実行の枠組みが強制されるため、サブクラスはその枠内でのみ機能を提供できるという設計制約を受けます。

テンプレートメソッドパターンは、アルゴリズムのスケルトンを定義し、その一部をサブクラスでカスタマイズすることが頻繁に必要とされるアプリケーションに特に適しています。このパターンによって、アプリケーション全体の一貫性を保ちながら、柔軟性を持たせることができます。

## サンプルコード

```java
// 抽象クラスでテンプレートメソッドを定義
abstract class Game {
    abstract void initialize();
    abstract void startPlay();
    abstract void endPlay();

    // テンプレートメソッド
    public final void play() {
        initialize();
        startPlay();
        endPlay();
    }
}

// 具体的なクラスでテンプレートメソッドの各ステップを実装
class Football extends Game {
    @Override
    void initialize() {
        System.out.println("Football Game Initialized! Start playing.");
    }

    @Override
    void startPlay() {
        System.out.println("Football Game Started. Enjoy the game!");
    }

    @Override
    void endPlay() {
        System.out.println("Football Game Finished!");
    }
}

// デモクラス
public class TemplateMethodDemo {
    public static void main(String[] args) {
        Game game = new Football();
        game.play();
    }
}
```

```typescript
// 抽象クラスでテンプレートメソッドを定義
abstract class Game {
    abstract initialize(): void;
    abstract startPlay(): void;
    abstract endPlay(): void;

    // テンプレートメソッド
    public play(): void {
        this.initialize();
        this.startPlay();
        this.endPlay();
    }
}

// 具体的なクラスでテンプレートメソッドの各ステップを実装
class Football extends Game {
    initialize(): void {
        console.log("Football Game Initialized! Start playing.");
    }

    startPlay(): void {
        console.log("Football Game Started. Enjoy the game!");
    }

    endPlay(): void {
        console.log("Football Game Finished!");
    }
}

// デモコード
const game: Game = new Football();
game.play();
```
