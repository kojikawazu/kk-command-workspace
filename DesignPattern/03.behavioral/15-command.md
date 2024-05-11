# Command（コマンド）パターン

Commandパターン（コマンドパターン）は、要求自体をカプセル化することにより、要求を発行するオブジェクトと要求を実行するオブジェクトを分離するデザインパターンです。このパターンでは、要求に関連するすべて（実行するアクション、そのアクションのパラメータ）をオブジェクトとして扱います。これにより、操作の実行、キャンセル、キューイング、ログ記録、トランザクションなどを独立して行うことが可能になります。

## 適用場面

- 取り消し可能な操作：
  - コマンドパターンを使用すると、実行した操作を取り消す（Undo）機能を簡単に実装できます。
- 履歴ログの管理：
  - 実行された全コマンドの履歴を保持し、後でこれらのコマンドを再実行（Redo）やログ記録として使用できます。
- オペレーションのキューイングとスケジューリング：
  - コマンドオブジェクトをキューに入れ、異なるタイミングや異なるスレッドで実行することができます。
- 複雑なコマンドの組み合わせ：
  - 複数の単純なコマンドを組み合わせて、一つの複合コマンドを作成することが可能です。

## メリット

- 拡張性：新しいコマンドを追加する際に既存のクラスを変更する必要がなく、容易に拡張が可能です。
  - 分離と組織化：コマンドを発行する責任とコマンドを実行する責任を分離することで、システムをより整理された形で管理できます。
- 取り消しと再実行のサポート：
  - コマンドパターンは操作の取り消しや再実行を簡単に実装できるため、ユーザーインターフェイスが複雑なアプリケーションで有用です。

## デメリット

- 複雑性の増加：
  - 小さな操作であってもコマンドクラスを定義する必要があり、システムの複雑性が増します。
- オーバーヘッドの増加：
  - 各コマンドのために新しいクラスを作成する必要があり、多くの小さなオブジェクトが生成されることで、パフォーマンスに影響を与える可能性があります。
- リソースの使用量増加：
  - 履歴を保存するために多くのリソースを消費する場合があり、特に大規模なアプリケーションでは管理が難しくなることがあります。

Commandパターンは、これらの特徴を考慮して、特にユーザーインターフェイスの管理やトランザクションシステムなど、操作の柔軟性と管理を重視するシナリオで有効に機能します。

## サンプルコード

```java
// Commandインターフェース
interface Command {
    void execute();
}

// 具体的なコマンド
class LightOnCommand implements Command {
    private Light light;

    public LightOnCommand(Light light) {
        this.light = light;
    }

    @Override
    public void execute() {
        light.turnOn();
    }
}

class LightOffCommand implements Command {
    private Light light;

    public LightOffCommand(Light light) {
        this.light = light;
    }

    @Override
    public void execute() {
        light.turnOff();
    }
}

// レシーバ
class Light {
    public void turnOn() {
        System.out.println("The light is on");
    }

    public void turnOff() {
        System.out.println("The light is off");
    }
}

// インヴォーカー
class RemoteControl {
    private Command command;

    public void setCommand(Command command) {
        this.command = command;
    }

    public void pressButton() {
        command.execute();
    }
}

// クライアント
public class CommandPatternDemo {
    public static void main(String[] args) {
        Light light = new Light();
        Command lightsOn = new LightOnCommand(light);
        Command lightsOff = new LightOffCommand(light);

        RemoteControl control = new RemoteControl();
        control.setCommand(lightsOn);
        control.pressButton();
        control.setCommand(lightsOff);
        control.pressButton();
    }
}
```

```typescript
// Commandインターフェース
interface Command {
    execute(): void;
}

// 具体的なコマンド
class LightOnCommand implements Command {
    constructor(private light: Light) {}

    execute(): void {
        this.light.turnOn();
    }
}

class LightOffCommand implements Command {
    constructor(private light: Light) {}

    execute(): void {
        this.light.turnOff();
    }
}

// レシーバ
class Light {
    turnOn(): void {
        console.log("The light is on");
    }

    turnOff(): void {
        console.log("The light is off");
    }
}

// インヴォーカー
class RemoteControl {
    private command: Command;

    setCommand(command: Command): void {
        this.command = command;
    }

    pressButton(): void {
        this.command.execute();
    }
}

// クライアント
const light = new Light();
const lightsOn = new LightOnCommand(light);
const lightsOff = new LightOffCommand(light);

const control = new RemoteControl();
control.setCommand(lightsOn);
control.pressButton();
control.setCommand(lightsOff);
control.pressButton();
```