# プロトタイプ（Prototype）パターン

プロトタイプ（Prototype）パターンは、既存のオブジェクトをプロトタイプとして利用し、クローン（複製）を作成することで新しいオブジェクトを生成するデザインパターンです。これにより、複雑なオブジェクトを初めから構築するコストや時間を節約し、動的にオブジェクトを拡張・変更できる柔軟性を提供します。

## 適用場面

- 複製が可能で効率的な初期化が必要な場合：
  - 新しいインスタンスの作成に時間がかかるか、資源を多く消費する場合に、プロトタイプパターンは既存のインスタンスを複製することでコストを削減します。
- ランタイムに新しいオブジェクトの型を柔軟に指定したい場合：
  - プロトタイプパターンを使用すると、具体的なクラスに依存せずにインスタンスを生成できるため、システムがよりダイナミックで拡張性のある設計になります。
- クラス階層の代わりにクローニングを使用したい場合：
  - 複数の派生クラスが存在する場合、それらをプロトタイプとして保持し、必要に応じて複製することで、複雑なクラス階層を回避できます。

## メリット

- 抽象的なコード: 
  - 具体的なクラスに依存することなくオブジェクトを生成することができるため、コードがより抽象的で再利用しやすくなります。
- パフォーマンスの向上:
  - オブジェクトの初期化が重たい場合、既存のオブジェクトを複製する方が新規作成するよりもパフォーマンスが向上します。
- 動的なシステムの構築: システム実行中に新しいオブジェクトの型を指定できるため、動的なシステムの構築が可能になります。

## デメリット

- クローニングの複雑さ:
  - オブジェクトが内部状態や参照を多く持つ場合、深いコピーを行うロジックが複雑になることがあります。
- クローニングされたオブジェクトの管理:
  - クローンが生成された後、その状態の追跡や管理が難しくなることがあります。
- 不適切な使用:
  - すべての設計問題にプロトタイプパターンが適切なわけではなく、不適切な場面で使用するとコードの理解や保守が困難になることがあります。

プロトタイプパターンは、オブジェクトの作成に関連するコストが高い場合や、オブジェクトの種類を実行時に柔軟に変更したい場合に特に有効ですが、その実装にはオブジェクトの深いコピーを適切に管理する必要があります。

## サンプルコード

```java
public class Document implements Cloneable {
    private String title;
    private String content;

    public Document(String title, String content) {
        this.title = title;
        this.content = content;
    }

    // ゲッターとセッター
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Override
    public Document clone() {
        try {
            return (Document) super.clone();
        } catch (CloneNotSupportedException e) {
            throw new AssertionError(); // Can never happen
        }
    }

    @Override
    public String toString() {
        return "Document{" +
                "title='" + title + '\'' +
                ", content='" + content + '\'' +
                '}';
    }

    public static void main(String[] args) {
        Document original = new Document("Original", "This is the original document.");
        Document clone = original.clone();
        clone.setTitle("Clone");
        clone.setContent("This is the cloned document.");

        System.out.println(original);
        System.out.println(clone);
    }
}
```

```typescript
class Document {
    private title: string;
    private content: string;

    constructor(title: string, content: string) {
        this.title = title;
        this.content = content;
    }

    // ゲッターとセッター
    setTitle(title: string): void {
        this.title = title;
    }

    setContent(content: string): void {
        this.content = content;
    }

    clone(): Document {
        return new Document(this.title, this.content);
    }

    toString(): string {
        return `Document{title='${this.title}', content='${this.content}'}`;
    }
}

const original = new Document("Original", "This is the original document.");
const clone = original.clone();
clone.setTitle("Clone");
clone.setContent("This is the cloned document.");

console.log(original.toString());
console.log(clone.toString());
```
