# Chain of Responsibility（チェーンオブレスポンシビリティ）パターン

Chain of Responsibilityパターン（チェーンオブレスポンシビリティパターン）は、複数のオブジェクトを連鎖させ、その連鎖を通じてリクエストを処理する方法を提供するデザインパターンです。リクエストを受けたオブジェクトが処理できない場合、それを連鎖の次のオブジェクトに転送し、適切なハンドラが見つかるまでこれを繰り返します。

## 適用場面

- 複数のオブジェクトがリクエストを処理できる場合：
  - リクエストを処理するための候補が複数存在し、そのうちのどれか一つがリクエストを処理する責任を持つべき場合に適しています。
- 処理の透過性を確保したい場合：
  - リクエストの送信者がリクエストを処理する具体的なオブジェクトを知らずに済むようにしたい場合に使用します。
- 処理のダイナミックな追加・削除が必要な場合：
  - 処理の流れを動的に変更したい場合（例えば、ランタイムで処理の責任を担うオブジェクトを追加または削除する場合）に適しています。

## メリット

- 低結合性：
  - オブジェクト間の結合度が低く、各オブジェクトはリクエストを処理する責任を次のオブジェクトに委譲することが可能です。
- 拡張性の向上：
  - 新しいハンドラをチェーンに簡単に追加できるため、システムを柔軟に拡張できます。
- 動的な変更が容易：
  - 実行時にチェーンの構造を変更できるため、処理の優先順位や担当を動的に変更することができます。

## デメリット

- 処理の保証が難しい：
  - リクエストが適切なハンドラによって処理されるかどうかの保証が常にあるわけではなく、チェーンを通過しても処理されない場合があります。
- パフォーマンス問題：
  - リクエストがチェーンの各ハンドラを通過する必要があるため、処理に時間がかかる可能性があります。
- デバッグと保守の複雑化：
  - チェーンが長くなると、どのハンドラがリクエストを処理しているかを追跡しにくくなる可能性があります。

Chain of Responsibilityパターンは、処理を柔軟に管理したい場合や複数のオブジェクトがリクエストを処理する可能性がある場合に特に有効です。これにより、システムの一部が変更または拡張されても他の部分に影響を与えることなく、容易に対応することが可能になります。

## サンプルコード

```java
// ハンドラーの抽象クラス
abstract class Logger {
    public static int INFO = 1;
    public static int DEBUG = 2;
    public static int ERROR = 3;

    protected int level;
    // 次の要素の参照
    protected Logger nextLogger;

    public void setNextLogger(Logger nextLogger) {
        this.nextLogger = nextLogger;
    }

    public void logMessage(int level, String message) {
        if (this.level <= level) {
            write(message);
        }
        if (nextLogger != null) {
            nextLogger.logMessage(level, message);
        }
    }

    abstract protected void write(String message);
}

// 具体的なハンドラー
class ConsoleLogger extends Logger {
    public ConsoleLogger(int level) {
        this.level = level;
    }

    protected void write(String message) {
        System.out.println("Standard Console::Logger: " + message);
    }
}

class ErrorLogger extends Logger {
    public ErrorLogger(int level) {
        this.level = level;
    }

    protected void write(String message) {
        System.out.println("Error Console::Logger: " + message);
    }
}

class FileLogger extends Logger {
    public FileLogger(int level) {
        this.level = level;
    }

    protected void write(String message) {
        System.out.println("File::Logger: " + message);
    }
}

// デモクラス
public class ChainPatternDemo {
    private static Logger getChainOfLoggers() {
        Logger errorLogger = new ErrorLogger(Logger.ERROR);
        Logger fileLogger = new FileLogger(Logger.DEBUG);
        Logger consoleLogger = new ConsoleLogger(Logger.INFO);

        errorLogger.setNextLogger(fileLogger);
        fileLogger.setNextLogger(consoleLogger);

        return errorLogger;
    }

    public static void main(String[] args) {
        Logger loggerChain = getChainOfLoggers();

        loggerChain.logMessage(Logger.INFO, "This is an information.");
        loggerChain.logMessage(Logger.DEBUG, "This is a debug level information.");
        loggerChain.logMessage(Logger.ERROR, "This is an error information.");
    }
}
```

```typescript
// ハンドラーの抽象クラス
abstract class Logger {
    static INFO: number = 1;
    static DEBUG: number = 2;
    static ERROR: number = 3;

    protected level: number;
    // 次の要素の参照
    protected nextLogger: Logger;

    setNextLogger(nextLogger: Logger): void {
        this.nextLogger = nextLogger;
    }

    logMessage(level: number, message: string): void {
        if (this.level <= level) {
            this.write(message);
        }
        if (this.nextLogger != null) {
            this.nextLogger.logMessage(level, message);
        }
    }

    abstract write(message: string): void;
}

// 具体的なハンドラー
class ConsoleLogger extends Logger {
    constructor(level: number) {
        super();
        this.level = level;
    }

    write(message: string): void {
        console.log("Standard Console::Logger: " + message);
    }
}

class ErrorLogger extends Logger {
    constructor(level: number) {
        super();
        this.level = level;
    }

    write(message: string): void {
        console.log("Error Console::Logger: " + message);
    }
}

class FileLogger extends Logger {
    constructor(level: number) {
        super();
        this.level = level;
    }

    write(message: string): void {
        console.log("File::Logger: " + message);
    }
}

// デモコード
function getChainOfLoggers(): Logger {
    let errorLogger = new ErrorLogger(Logger.ERROR);
    let fileLogger = new FileLogger(Logger.DEBUG);
    let consoleLogger = new ConsoleLogger(Logger.INFO);

    errorLogger.setNextLogger(fileLogger);
    fileLogger.setNextLogger(consoleLogger);

    return errorLogger;
}

let loggerChain = getChainOfLoggers();

loggerChain.logMessage(Logger.INFO, "This is an information.");
loggerChain.logMessage(Logger.DEBUG, "This is a debug level information.");
loggerChain.logMessage(Logger.ERROR, "This is an error information.");
```

