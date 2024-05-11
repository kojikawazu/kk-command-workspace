# Proxy（プロキシ）パターン

プロキシ（Proxy）パターンは、オブジェクトへのアクセスを制御するためのデザインパターンです。このパターンを使用すると、クライアントが直接対象のオブジェクトを扱う代わりに、プロキシオブジェクトを介して対象オブジェクトへのアクセスを管理することができます。プロキシは対象オブジェクトの代理として機能し、アクセス制御、遅延初期化、ネットワーク接続、ロギングなど、さまざまな目的で使用されます。

## 適用場面

- リモートオブジェクトへのアクセス：
  - リモートマシンに存在するオブジェクトに対して、ローカル表現を提供する場合に使用します。これにより、ネットワークの詳細を抽象化しながらリモートオブジェクトとの通信が可能になります。
- リソースの重いオブジェクトの遅延初期化：
  - インスタンスの作成が重いオブジェクトに対して、実際に必要になるまでその生成を遅らせることができます。
- アクセス制御：
  - セキュリティ要件に基づいて、特定のオブジェクトへのアクセスを制限する場合に利用します。プロキシは権限チェックを行い、条件に応じて操作の実行を許可または拒否します。
- ロギングと監査：
  - オブジェクトへの操作をロギングし、システムの挙動を監視するために使用します。これにより、デバッグやシステムの透明性が向上します。

## メリット

- セキュリティ強化：
  - アクセスを制御することで、不正アクセスや意図しない操作からシステムを保護することができます。

- リソースの効率的な利用：オブジェクトの生成を遅らせることで、リソースを必要な時にのみ使用するため、システムリソースを節約できます。
  - システムの拡張性の向上：プロキシを介してオブジェクトとのやり取りを行うことで、システムの他の部分を変更することなく、新しいプロキシ機能を追加または変更できます。

## デメリット

- 実装の複雑化：
  - プロキシクラスを設計し管理する必要があり、システムの全体的な複雑性が増加する場合があります。
- パフォーマンスの低下：
  - プロキシの導入により、オブジェクトへのアクセスに追加のステップが生じるため、レスポンスタイムが長くなる可能性があります。
- 透過性の欠如：
  - プロキシを通じてのみオブジェクトにアクセスできる場合、システムの透過性が損なわれることがあります。

プロキシパターンは、特定のオブジェクトへのアクセスを効果的に制御し、システムのセキュリティとリソース管理を向上させる強力なツールですが、その導入には追加の設計考慮とコストが必要です。

## サンプルコード

```java
interface Image {
    void display();
}

// 実際の画像をロードするクラス
class RealImage implements Image {
    private String fileName;

    public RealImage(String fileName) {
        this.fileName = fileName;
        loadFromDisk(fileName);
    }

    private void loadFromDisk(String fileName) {
        System.out.println("Loading " + fileName);
    }

    @Override
    public void display() {
        System.out.println("Displaying " + fileName);
    }
}

// プロキシクラス
class ProxyImage implements Image {
    private RealImage realImage;
    private String fileName;

    public ProxyImage(String fileName) {
        this.fileName = fileName;
    }

    @Override
    public void display() {
        if (realImage == null) {
            realImage = new RealImage(fileName);
        }
        realImage.display();
    }
}

// クライアントクラス
public class ProxyPatternDemo {
    public static void main(String[] args) {
        Image image = new ProxyImage("test_image.jpg");
        // 画像はまだロードされていない
        image.display(); // 最初の呼び出しでロード
        image.display(); // 既にロードされているので、すぐに表示
    }
}
```

```typescript
interface Image {
    display(): void;
}

// 実際の画像をロードするクラス
class RealImage implements Image {
    private fileName: string;

    constructor(fileName: string) {
        this.fileName = fileName;
        this.loadFromDisk(fileName);
    }

    private loadFromDisk(fileName: string): void {
        console.log("Loading " + fileName);
    }

    display(): void {
        console.log("Displaying " + fileName);
    }
}

// プロキシクラス
class ProxyImage implements Image {
    private realImage: RealImage | null = null;
    private fileName: string;

    constructor(fileName: string) {
        this.fileName = fileName;
    }

    display(): void {
        if (this.realImage === null) {
            this.realImage = new RealImage(this.fileName);
        }
        this.realImage.display();
    }
}

// クライアントコード
const image: Image = new ProxyImage("test_image.jpg");
image.display(); // 最初の呼び出しでロード
image.display(); // 既にロードされているので、すぐに表示
```

