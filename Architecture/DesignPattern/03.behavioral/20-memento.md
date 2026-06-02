# Memento（メメント）パターン

Mementoパターン（メメントパターン）は、オブジェクトの状態を保存し、後でその状態を復元するためのデザインパターンです。このパターンは、オブジェクトのカプセル化を壊さずに、以前の状態に戻すことが可能な構造を提供します。

## 適用場面

- アンドゥ/リドゥ機能が必要な場合：
  - テキストエディタ、グラフィックデザインツール、ゲームなど、ユーザーが行った操作を元に戻したりやり直したりする機能が求められる場合。
- オブジェクトの状態のスナップショットが必要な場合：
  - オブジェクトの特定の時点での状態を保存し、システムの他の部分がそのスナップショットを参照する必要がある場合。
- トランザクションとロールバックが要求される場合：
  - データベース管理システムやビジネスプロセス管理で、操作を一連のトランザクションとして扱い、エラー発生時に前の安定した状態に戻す必要がある場合。

## メリット

- 状態の復元の容易さ：
  - オブジェクトの内部状態を外部に公開することなく、簡単に以前の状態に戻すことができます。
- カプセル化の保持：
  - Mementoオブジェクトはオブジェクトの内部状態に対する直接的なアクセスを提供せず、オブジェクトのカプセル化を侵害しません。
- 履歴管理の明確化：
  - 状態の変更履歴を明確に管理でき、必要に応じて任意の状態にアクセス可能です。

## デメリット

- リソース使用の増加：
  - 多くのメメントを保存する必要がある場合、メモリ消費が増大します。
- 複雑性の増加：
  - メメントを管理するための追加のクラスや機能が必要になるため、システムの設計が複雑になりがちです。
- パフォーマンス問題：
  - 特に大きなオブジェクトの状態を頻繁に保存する場合、システムのパフォーマンスに影響を与える可能性があります。

Mementoパターンは、オブジェクトの状態の復元が頻繁に必要とされるアプリケーションや、ユーザーによる操作のアンドゥ/リドゥ機能が重要なアプリケーションに特に有効です。これにより、システムのユーザビリティを向上させるとともに、データの整合性を保つことができます。

## サンプルコード

```java
// Mementoクラス
class TextMemento {
    private final String state;

    public TextMemento(String state) {
        this.state = state;
    }

    public String getState() {
        return state;
    }
}

// Originatorクラス
class TextEditor {
    private String content;

    public void setText(String text) {
        content = text;
    }

    public String getText() {
        return content;
    }

    public TextMemento saveToMemento() {
        return new TextMemento(content);
    }

    public void restoreFromMemento(TextMemento memento) {
        content = memento.getState();
    }
}

// Caretakerクラス
class Caretaker {
    private List<TextMemento> savedStates = new ArrayList<>();

    public void addMemento(TextMemento memento) {
        savedStates.add(memento);
    }

    public TextMemento getMemento(int index) {
        return savedStates.get(index);
    }
}

// デモクラス
public class MementoDemo {
    public static void main(String[] args) {
        TextEditor editor = new TextEditor();
        Caretaker caretaker = new Caretaker();

        editor.setText("Version 1");
        caretaker.addMemento(editor.saveToMemento());
        editor.setText("Version 2");
        caretaker.addMemento(editor.saveToMemento());

        editor.restoreFromMemento(caretaker.getMemento(0)); // Restore to Version 1
        System.out.println(editor.getText()); // Output: Version 1
    }
}
```

```typescript
// Mementoクラス
class TextMemento {
    constructor(private state: string) {}

    getState(): string {
        return this.state;
    }
}

// Originatorクラス
class TextEditor {
    private content: string;

    setText(text: string): void {
        this.content = text;
    }

    getText(): string {
        return this.content;
    }

    saveToMemento(): TextMemento {
        return new TextMemento(this.content);
    }

    restoreFromMemento(memento: TextMemento): void {
        this.content = memento.getState();
    }
}

// Caretakerクラス
class Caretaker {
    private savedStates: TextMemento[] = [];

    addMemento(memento: TextMemento): void {
        this.savedStates.push(memento);
    }

    getMemento(index: number): TextMemento {
        return this.savedStates[index];
    }
}

// デモコード
const editor = new TextEditor();
const caretaker = new Caretaker();

editor.setText("Version 1");
caretaker.addMemento(editor.saveToMemento());
editor.setText("Version 2");
caretaker.addMemento(editor.saveToMemento());

editor.restoreFromMemento(caretaker.getMemento(0)); // Restore to Version 1
console.log(editor.getText()); // Output: Version 1
```