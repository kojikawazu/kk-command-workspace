# Factory Method（ファクトリーメソッド）

Factory Method パターンは、オブジェクトの作成に関する責任をサブクラスに移譲することで、クライアントコードが具体的なクラスに依存することなくインスタンスを生成できるようにするデザインパターンです。このパターンは特に、フレームワークやライブラリがさまざまなインスタンス型をサポートする必要がある場合に有用です。

## Factory Method パターンの適用場面

- 生成するオブジェクトのクラスが実行時に決定される場合:
  - システムがどのクラスをインスタンス化するかを実行時まで知らない場合。
- クラスがそのサブクラスのオブジェクトを生成する場合:
  - ライブラリやフレームワークが拡張性を提供し、ユーザーが自分のサブクラスを実装してオブジェクトを生成できるようにする場合。
- クラスのライブラリを使用するクライアントアプリケーションが、実装されたクラスではなくインタフェースや抽象クラスに依存する場合:
  - クライアントが具体的な実装を知ることなく、オブジェクトを生成できるようにする。

## Factory Method パターンのメリット

- 柔軟性と再利用性が向上:
  - 新しいクラスをシステムに容易に追加し、既存のコードに影響を与えることなく新しいオブジェクトを生成できます。
- サブクラス化の自由度:
  - 生成する具体的なオブジェクトのクラスをクライアントから隠蔽し、サブクラスを通じて新しいオブジェクトタイプを導入することができます。
- 単一責任の原則:
  - オブジェクトの作成と使用を分離することで、コードの管理が容易になります。
- Factory Method パターンのデメリット
  - クラスの数が増える:
各種類のオブジェクト生成に一つのファクトリクラスが必要になり得るため、システムの複雑さが増す可能性があります。
- 設計が複雑になる:
 -  新しいオブジェクトタイプを導入する際に、新しいファクトリクラスが必要になる場合があり、設計が複雑になりがちです。
- コードの理解とメンテナンスが難しくなる可能性:
  - ファクトリメソッドを多用すると、コードベース全体で何が起こっているのかを把握しにくくなることがあります。

Factory Method パターンは、オブジェクトの作成をクライアントコードから分離し、より柔軟で拡張性の高いソフトウェアを設計する際に非常に役立ちますが、設計の複雑性が増す点には注意が必要です。適切な場面で慎重に使用することが推奨されます。


```java
abstract class Document {
    public abstract void displayInfo();
}

class PdfDocument extends Document {
    @Override
    public void displayInfo() {
        System.out.println("This is a PDF document.");
    }
}

class WordDocument extends Document {
    @Override
    public void displayInfo() {
        System.out.println("This is a Word document.");
    }
}

abstract class DocumentCreator {
    public abstract Document createDocument();

    public Document getDocument() {
        Document doc = createDocument();
        doc.displayInfo();
        return doc;
    }
}

class PdfCreator extends DocumentCreator {
    @Override
    public Document createDocument() {
        return new PdfDocument();
    }
}

class WordCreator extends DocumentCreator {
    @Override
    public Document createDocument() {
        return new WordDocument();
    }
}

public class Main {
    public static void main(String[] args) {
        DocumentCreator creator = new PdfCreator();
        Document doc = creator.getDocument();
        creator = new WordCreator();
        doc = creator.getDocument();
    }
}
```

```typescript
interface Logger {
    log(message: string): void;
}

class ConsoleLogger implements Logger {
    log(message: string): void {
        console.log(`ConsoleLogger: ${message}`);
    }
}

class FileLogger implements Logger {
    log(message: string): void {
        console.log(`FileLogger: ${message} (Assume it's logged to a file)`);
    }
}

abstract class LoggerFactory {
    public abstract createLogger(): Logger;

    public getLogger(): Logger {
        const logger = this.createLogger();
        return logger;
    }
}

class ConsoleLoggerFactory extends LoggerFactory {
    public createLogger(): Logger {
        return new ConsoleLogger();
    }
}

class FileLoggerFactory extends LoggerFactory {
    public createLogger(): Logger {
        return new FileLogger();
    }
}

const loggerFactory: LoggerFactory = new ConsoleLoggerFactory();
const logger: Logger = loggerFactory.getLogger();
logger.log("This is a test log entry.");
```