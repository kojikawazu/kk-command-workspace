# Flyweight（フライウェイト）パターン

フライウェイト（Flyweight）パターンは、多数の細かいオブジェクトが存在する場合にメモリ使用量を削減することを目的としたデザインパターンです。このパターンは、オブジェクトの共通の状態を共有し、個々のオブジェクトごとに異なる状態を持たせることで、効率的にリソースを管理します。

## 適用場面

- 多数の類似オブジェクトが存在する場合：
  - オブジェクト間で共有可能なデータ（不変の状態）が多く、個別に持たせる必要があるデータ（変更可能な状態）が少ない場合に適しています。
- アプリケーションのパフォーマンス改善が必要な場合：
  - メモリ使用量の削減やオブジェクト生成コストの軽減が求められる状況で有効です。
- システム内の多くのオブジェクトが重複している場合：
  - 文字処理やグラフィックのレンダリングなど、同じ属性を共有するオブジェクトが大量に生成される場合に役立ちます。

## メリット

- メモリ効率の向上：
  - 共有可能なデータを再利用することで、オブジェクトのインスタンスが消費するメモリ量を大幅に削減できます。
- パフォーマンスの向上：
  - オブジェクトの生成が少なくなるため、初期化にかかるコストが減少し、アプリケーションの全体的なパフォーマンスが向上します。
- システムのスケーラビリティの向上：
  - リソースの節約により、より大規模な問題に対応できるようになります。

## デメリット

- 複雑性の増加：
  - フライウェイトオブジェクトの管理には、追加のロジックが必要となり、システムの設計が複雑になる可能性があります。
- 実装の難易度：
  - 共有状態と非共有状態を適切に管理する必要があり、実装が難しくなることがあります。
- 実行時のオーバーヘッド：
  - オブジェクトの状態を外部から管理する必要があるため、実行時のオーバーヘッドが増えることがあります。

フライウェイトパターンは、リソースの制約がある環境や、大量の類似オブジェクトを効率的に管理する必要があるシナリオに特に適しています。しかし、その適用は、システムの要件と予想されるベネフィットを慎重に評価した上で行うべきです。

## サンプルコード

```java
import java.util.HashMap;
import java.util.Map;

// フライウェイトクラス
class Font {
    private final String color;  // Immutable
    private final int size;      // Immutable

    public Font(String color, int size) {
        this.color = color;
        this.size = size;
    }

    @Override
    public String toString() {
        return "Font{" +
               "color='" + color + '\'' +
               ", size=" + size +
               '}';
    }
}

// ファクトリクラス
class FontFactory {
    private static final Map<String, Font> fonts = new HashMap<>();

    public static Font getFont(String key) {
        Font font = fonts.get(key);
        if (font == null) {
            String[] parts = key.split(":");
            font = new Font(parts[0], Integer.parseInt(parts[1]));
            fonts.put(key, font);
        }
        return font;
    }
}

// クライアントコード
public class FlyweightPatternDemo {
    public static void main(String[] args) {
        Font font1 = FontFactory.getFont("Red:12");
        Font font2 = FontFactory.getFont("Red:12");
        Font font3 = FontFactory.getFont("Blue:12");

        System.out.println(font1);
        System.out.println(font2);
        System.out.println(font3);

        System.out.println("Checking if font1 and font2 are the same object: " + (font1 == font2));
        System.out.println("Checking if font1 and font3 are the same object: " + (font1 == font3));
    }
}
```

```typescript
// フライウェイトクラス
class Font {
    constructor(private color: string, private size: number) {}

    public toString(): string {
        return `Font{color='${this.color}', size=${this.size}}`;
    }
}

// ファクトリクラス
class FontFactory {
    private static fonts: Map<string, Font> = new Map();

    public static getFont(key: string): Font {
        let font = this.fonts.get(key);
        if (!font) {
            const [color, size] = key.split(':');
            font = new Font(color, parseInt(size));
            this.fonts.set(key, font);
        }
        return font;
    }
}

// クライアントコード
const font1 = FontFactory.getFont("Red:12");
const font2 = FontFactory.getFont("Red:12");
const font3 = FontFactory.getFont("Blue:12");

console.log(font1.toString());
console.log(font2.toString());
console.log(font3.toString());

console.log(`Checking if font1 and font2 are the same object: ${font1 === font2}`);
console.log(`Checking if font1 and font3 are the same object: ${font1 !== font3}`);
```
