# Mediatorパターン（メディエーターパターン）

Mediatorパターン（メディエーターパターン）は、オブジェクト間の複雑な通信を単純化するために使用されるデザインパターンです。このパターンでは、メディエーターと呼ばれる中央の制御点を通じて、オブジェクト間の直接的な通信を避け、代わりにメディエーターが相互作用を管理します。これにより、オブジェクト間の結合を緩和し、各オブジェクトの再利用性を向上させることができます。

## 適用場面

- 多くのオブジェクト間で複雑な通信が必要な場合：
  - システムに多数のコンポーネントやオブジェクトがあり、これらが密接に相互作用する必要がある場合、メディエーターを導入することで通信の複雑さを管理できます。
- オブジェクト間の結合を低減したい場合：
  - オブジェクトが互いに独立して操作できるようにし、直接的な依存関係を減らしたい場合に有効です。
- システムの再設計が困難な場合：
  - 既存のシステムにおいて、オブジェクト間の結合が高く、新しい機能の追加や既存機能の修正が困難な場合に、メディエーターを導入して問題を解決できます。

## メリット

- 結合の緩和：
  - コンポーネントやオブジェクト間の結合が緩和されるため、システムの各部分がより独立して動作でき、変更や再利用が容易になります。
- 再利用性の向上：
  - 各オブジェクトがメディエーターを介してのみ他のオブジェクトと通信するため、オブジェクト自体は再利用しやすくなります。
- 集中管理：
  - オブジェクト間の相互作用が一箇所に集中して管理されるため、システム全体の動作を一元管理しやすくなります。

## デメリット

- メディエーターの肥大化：
  - システムの複雑性がメディエーター内に集中することがあり、メディエーター自体が非常に複雑になる可能性があります。
- パフォーマンス問題：
  - すべての通信がメディエーターを介して行われるため、メディエーターがボトルネックとなり、システムのパフォーマンスに影響を及ぼす可能性があります。
- 依存性のシフト：
  - 結合の緩和は達成されますが、多くのコンポーネントがメディエーターに強く依存する形になるため、メディエーターの変更が困難になることがあります。

メディエーターパターンは、システムの複雑さを効果的に管理し、各コンポーネントの独立性を保ちつつ、柔軟かつ効率的に設計する際に特に有効です。

## サンプルコード

```java
// メディエータインターフェース
interface ChatMediator {
    void sendMessage(String msg, User user);
    void addUser(User user);
}

// 具体的なメディエータ
class ChatRoom implements ChatMediator {
    private List<User> users;

    public ChatRoom() {
        this.users = new ArrayList<>();
    }

    @Override
    public void addUser(User user) {
        this.users.add(user);
    }

    @Override
    public void sendMessage(String msg, User user) {
        for (User u : users) {
            // メッセージ送信者以外にメッセージを送信
            if (u != user) {
                u.receive(msg);
            }
        }
    }
}

// 抽象ユーザークラス
abstract class User {
    protected ChatMediator mediator;
    protected String name;

    public User(ChatMediator med, String name) {
        this.mediator = med;
        this.name = name;
    }

    public abstract void send(String msg);
    public abstract void receive(String msg);
}

// 具体的なユーザー
class ConcreteUser extends User {
    public ConcreteUser(ChatMediator med, String name) {
        super(med, name);
    }

    @Override
    public void send(String msg) {
        System.out.println(this.name + ": Sending Message = " + msg);
        mediator.sendMessage(msg, this);
    }

    @Override
    public void receive(String msg) {
        System.out.println(this.name + ": Received Message = " + msg);
    }
}

// デモクラス
public class MediatorDemo {
    public static void main(String[] args) {
        ChatMediator mediator = new ChatRoom();
        User user1 = new ConcreteUser(mediator, "John");
        User user2 = new ConcreteUser(mediator, "Doe");
        User user3 = new ConcreteUser(mediator, "Smith");
        User user4 = new ConcreteUser(mediator, "Alice");

        mediator.addUser(user1);
        mediator.addUser(user2);
        mediator.addUser(user3);
        mediator.addUser(user4);

        user1.send("Hi All");
    }
}
```

```typescript
// メディエータインターフェース
interface ChatMediator {
    sendMessage(msg: string, user: User): void;
    addUser(user: User): void;
}

// 具体的なメディエータ
class ChatRoom implements ChatMediator {
    private users: User[] = [];

    addUser(user: User): void {
        this.users.push(user);
    }

    sendMessage(msg: string, user: User): void {
        this.users.forEach(u => {
            if (u !== user) {
                u.receive(msg);
            }
        });
    }
}

// ユーザークラス
abstract class User {
    protected mediator: ChatMediator;
    protected name: string;

    constructor(mediator: ChatMediator, name: string) {
        this.mediator = mediator;
        this.name = name;
    }

    abstract send(msg: string): void;
    abstract receive(msg: string): void;
}

// 具体的なユーザー
class ConcreteUser extends User {
    constructor(mediator: ChatMediator, name: string) {
        super(mediator, name);
    }

    send(msg: string): void {
        console.log(`${this.name}: Sending Message = ${msg}`);
        this.mediator.sendMessage(msg, this);
    }

    receive(msg: string): void {
        console.log(`${this.name}: Received Message = ${msg}`);
    }
}

// デモコード
const mediator = new ChatRoom();
const user1 = new ConcreteUser(mediator, "John");
const user2 = new ConcreteUser(mediator, "Doe");
const user3 = new ConcreteUser(mediator, "Smith");
const user4 = new ConcreteUser(mediator, "Alice");

mediator.addUser(user1);
mediator.addUser(user2);
mediator.addUser(user3);
mediator.addUser(user4);

user1.send("Hi All");
```

