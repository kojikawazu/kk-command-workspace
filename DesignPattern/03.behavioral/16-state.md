# State（ステート）パターン

Stateパターン（ステートパターン）は、オブジェクトの状態が変わるとその振る舞いが変わるようにするデザインパターンです。このパターンでは、状態を表すクラス群を導入し、状態に依存する振る舞いをこれらのクラスでカプセル化します。これにより、状態の変更がそのオブジェクトのクラスの実行時の振る舞いを変更することができます。

## 適用場面

- オブジェクトの状態に基づいて振る舞いが大きく変化する場合：
  - 例えば、文書の状態が「編集中」から「承認済み」に変わるとき、利用できる操作が大きく変わるような場合です。
- 状態の変遷が複雑で、オブジェクトの振る舞いを状態の変化に応じて維持する必要がある場合：
  - 状態遷移が多く、それに伴い振る舞いが変わる複雑なシステムで役立ちます。
- 条件分岐の複雑化の解消：
  - 複数のif-elseブロックやswitch文による条件分岐を減らし、より整理されたコードを実現したい場合に適しています。

## メリット

- 状態の管理の単純化：
  - 各状態を個別のクラスとして管理することで、状態に依存したコードの分散を避け、より綺麗で管理しやすいコードを実現できます。
- 拡張性の向上：
  - 新しい状態を追加する場合、既存のクラスを変更することなく、新しい状態クラスを追加するだけで対応可能です。
- 状態遷移の明確化：
  - 状態遷移が各ステートクラス内で明確に管理されるため、システムの動作が理解しやすくなります。

## デメリット

- クラスの増加：
  - 状態ごとにクラスを作成する必要があるため、システムの規模が大きくなるにつれて管理しなければならないクラスの数が増えます。
- 設計の複雑化：
  - 適切に設計するためには、システムの状態とそれに対応する振る舞いを正確に理解し、適切にクラスに落とし込む必要があります。
- オーバーヘッドの増加：
  - 状態遷移のロジックが複雑になる場合、それに伴うパフォーマンスのオーバーヘッドが発生することがあります。

Stateパターンは、オブジェクトの状態に応じて行動が大きく変わるようなシステムに適しており、特にユーザーインタフェースの制御やゲーム開発などで有効です。

## サンプルコード

```java
// ステートインターフェース
interface TrafficLightState {
    void change(TrafficLight trafficLight);
}

// 具体的なステート：赤信号
class RedState implements TrafficLightState {
    @Override
    public void change(TrafficLight trafficLight) {
        System.out.println("Red light - stop");
        trafficLight.setState(new GreenState());
    }
}

// 具体的なステート：緑信号
class GreenState implements TrafficLightState {
    @Override
    public void change(TrafficLight trafficLight) {
        System.out.println("Green light - go");
        trafficLight.setState(new YellowState());
    }
}

// 具体的なステート：黄信号
class YellowState implements TrafficLightState {
    @Override
    public void change(TrafficLight trafficLight) {
        System.out.println("Yellow light - caution");
        trafficLight.setState(new RedState());
    }
}

// コンテキストクラス
class TrafficLight {
    private TrafficLightState state;

    public TrafficLight(TrafficLightState state) {
        this.state = state;
    }

    public void setState(TrafficLightState state) {
        this.state = state;
    }

    public void change() {
        state.change(this);
    }
}

public class StatePatternDemo {
    public static void main(String[] args) {
        TrafficLight light = new TrafficLight(new RedState());
        light.change();  // Red light - stop
        light.change();  // Green light - go
        light.change();  // Yellow light - caution
    }
}
```

```typescript
// ステートインターフェース
interface TrafficLightState {
    change(trafficLight: TrafficLight): void;
}

// 具体的なステート：赤信号
class RedState implements TrafficLightState {
    change(trafficLight: TrafficLight): void {
        console.log("Red light - stop");
        trafficLight.setState(new GreenState());
    }
}

// 具体的なステート：緑信号
class GreenState implements TrafficLightState {
    change(trafficLight: TrafficLight): void {
        console.log("Green light - go");
        trafficLight.setState(new YellowState());
    }
}

// 具体的なステート：黄信号
class YellowState implements TrafficLightState {
    change(trafficLight: TrafficLight): void {
        console.log("Yellow light - caution");
        trafficLight.setState(new RedState());
    }
}

// コンテキストクラス
class TrafficLight {
    private state: TrafficLightState;

    constructor(state: TrafficLightState) {
        this.state = state;
    }

    setState(state: TrafficLightState): void {
        this.state = state;
    }

    change(): void {
        this.state.change(this);
    }
}

// 使用例
const light = new TrafficLight(new RedState());
light.change();  // Red light - stop
light.change();  // Green light - go
light.change();  // Yellow light - caution
```