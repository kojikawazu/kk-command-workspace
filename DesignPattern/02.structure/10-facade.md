# ファサード（Facade）パターン

ファサード（Facade）パターンは、複雑なシステムを一つの統一されたインターフェースを通じてアクセス可能にするデザインパターンです。このパターンを使用することで、サブシステムの利用が容易になり、サブシステムの複雑さをクライアントから隠蔽できます。

# 適用場面

- 複雑なサブシステムを簡単に使用したい場合：
  - サブシステムに多数のインターフェースがあり、それぞれが異なる機能を提供している場合、ファサードを介してこれらを統一的かつ簡単に扱えるようにします。
- システムの分離とクライアントコードの依存度を下げたい場合：
  - システムの特定の部分に変更があっても、ファサードを通じて他のコードに影響を与えないようにします。
- レイヤードアーキテクチャの場合：
  - 異なる層間で通信するためのクリアなAPIを提供し、層間の結合を緩和します。

## メリット

- 使いやすさ：
  - ファサードは複雑なサブシステムの背後にある多くのオペレーションを隠し、クライアントに対してシンプルなインターフェースを提供します。
- 結合度の低減：
  - ファサードはクライアントと複雑なサブシステム間の結合を減らすことで、システムの独立性を高める効果があります。
- コードの整理：
  - ファサードを利用することで、システムのどの部分がどの機能を担当しているかが明確になり、システム全体の管理が容易になります。

## デメリット

- ファサード自体がシステムのボトルネックになる可能性：
  - すべてのクライアントリクエストがファサードを通過するため、その設計がシステムのパフォーマンスに大きな影響を及ぼす可能性があります。
- 過度な単純化：
  - ファサードが提供する操作が限られているため、より特殊な操作や最適化が必要な場合にファサードだけでは対応できないことがあります。
- 不適切な使用：
  - ファサードを通じてのみサブシステムにアクセス可能な場合、ファサードが大きく複雑になりすぎてしまうことがあります。

ファサードパターンは、複雑なシステムを簡単に利用するための優れた手段を提供しますが、その設計と適用はシステムのニーズに合わせて慎重に行う必要があります。

## サンプルコード

```java
// サブシステムクラス
class CPU {
    public void freeze() {
        System.out.println("CPU freeze");
    }
    public void jump(long position) {
        System.out.println("CPU jump to " + position);
    }
    public void execute() {
        System.out.println("CPU execute");
    }
}

class Memory {
    public void load(long position, byte[] data) {
        System.out.println("Memory load from " + position);
    }
}

class HardDrive {
    public byte[] read(long lba, int size) {
        System.out.println("Reading from hard drive");
        return new byte[]{1, 2, 3};
    }
}

// ファサード
class Computer {
    private CPU cpu;
    private Memory memory;
    private HardDrive hardDrive;

    public Computer() {
        this.cpu = new CPU();
        this.memory = new Memory();
        this.hardDrive = new HardDrive();
    }

    public void startComputer() {
        cpu.freeze();
        memory.load(0, hardDrive.read(0, 10));
        cpu.jump(0);
        cpu.execute();
    }
}

// クライアントコード
public class FacadePatternDemo {
    public static void main(String[] args) {
        Computer computer = new Computer();
        computer.startComputer();
    }
}
```

```typescript
// サブシステムクラス
class CPU {
    freeze(): void {
        console.log("CPU freeze");
    }
    jump(position: number): void {
        console.log("CPU jump to " + position);
    }
    execute(): void {
        console.log("CPU execute");
    }
}

class Memory {
    load(position: number, data: number[]): void {
        console.log("Memory load from " + position);
    }
}

class HardDrive {
    read(lba: number, size: number): number[] {
        console.log("Reading from hard drive");
        return [1, 2, 3];
    }
}

// ファサード
class Computer {
    private cpu: CPU;
    private memory: Memory;
    private hardDrive: HardDrive;

    constructor() {
        this.cpu = new CPU();
        this.memory = new Memory();
        this.hardDrive = new HardDrive();
    }

    startComputer(): void {
        this.cpu.freeze();
        this.memory.load(0, this.hardDrive.read(0, 10));
        this.cpu.jump(0);
        this.cpu.execute();
    }
}

// クライアントコード
const computer = new Computer();
computer.startComputer();
```