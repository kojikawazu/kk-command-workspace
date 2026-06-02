#  Singleton（シングルトン）

Singleton パターンは、特定のクラスのインスタンスがプログラム全体で一つしか存在しないことを保証するデザインパターンです。このパターンは、グローバルな状態を管理する際や、リソースに対する一元的なアクセスポイントが必要な場合に有効です。

## Singleton パターンの適用時

- グローバルな設定やリソース共有:
  - アプリケーション全体で一つの設定ファイルやデータベースの接続を共有する場合など。
- コストの高いオブジェクトの生成を避ける:
  - オブジェクトの生成が資源を大量に消費する場合、そのインスタンスを一つに制限することで効率化。
- 一貫した状態の保持:
  - 複数のインスタンスが生成されると状態の不整合が起こる可能性があるオブジェクト。

## Singleton パターンのメリット

- リソースの節約:
  - インスタンスが一つだけなので、メモリ使用量が減少します。
- アクセス制御:
  - インスタンスへのアクセスが制御され、グローバルに使用できるようになります。
- データ共有の簡素化:
  - 全コンポーネントが同じインスタンスを参照するため、データの共有が容易になります。

## Singleton パターンのデメリット

- グローバル状態の濫用:
  - グローバルな状態はデバッグやテストを困難にし、システムの複雑さを増す可能性があります。
- 柔軟性の欠如:
  - Singleton パターンはオブジェクト指向設計の原則に反することがあり、特に依存性の注入のような技術と組み合わせると問題が発生することがあります。
- スレッドセーフの問題:
  - 多スレッド環境での適切な同期処理が求められ、実装が複雑になることがあります。

Singleton パターンは、これらの利点と欠点を理解し、適用する場面を慎重に選ぶ必要があります。特に、グローバルな状態を持つことの副作用や影響を十分に評価することが重要です。システムの設計段階でこのパターンの使用が本当に必要かどうかを見極めることが求められます。

## サンプルコード一覧

```java
/**
 * シングルトンクラス 
 */
public class Singleton {
    // private static 変数としてインスタンスを保持
    private static Singleton instance = new Singleton();

    // コンストラクタを private にして外部からのインスタンス化を防ぐ
    private Singleton() {}

    // インスタンスへのアクセスを提供する public static メソッド
    public static Singleton getInstance() {
        return instance;
    }

    public void showMessage() {
        System.out.println("シングルトンクラスです");
    }
}

// 使用例
public class Main {
    public static void main(String[] args) {
        Singleton singleton = Singleton.getInstance();
        singleton.showMessage();
    }
}
```

```typescript
/**
 * シングルトンクラス 
 */
class Singleton {
    // private static 変数としてインスタンスを保持
    private static instance: Singleton = new Singleton();

    // コンストラクタを private にして外部からのインスタンス化を防ぐ
    private constructor() {}

    // インスタンスへのアクセスを提供する public static メソッド
    public static getInstance(): Singleton {
        return Singleton.instance;
    }

    public showMessage(): void {
        console.log("シングルトンクラスです");
    }
}

// 使用例
const singleton = Singleton.getInstance();
singleton.showMessage();
```