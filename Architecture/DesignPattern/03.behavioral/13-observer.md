# Observer（オブザーバー）パターン

Observerパターン（観察者パターン）は、オブジェクト間での状態変化の通知を効率よく行いたい場合に適用されるデザインパターンです。特に、あるオブジェクト（サブジェクト）の状態の変更を、依存する一連のオブジェクト（オブザーバー）がそれぞれ自動的に更新する必要がある場合に利用されます。

## 適用場面

- 分散イベントハンドリングシステム：
  - イベントの発生源となるオブジェクトから複数のリスナー（オブザーバー）へ通知を送る必要がある場合。
- ユーザーインターフェース：
  - ユーザーインターフェイスコンポーネントがアプリケーションの状態変更に基づいて更新を行う場合（例えば、MVCアーキテクチャのモデルとビュー間）。
- 非同期通信プロセス：
  - あるオブジェクトの状態が変わった際に、それに依存する他のプロセスやオブジェクトに通知する必要がある場合。
メリット
- 疎結合性：
  - サブジェクトはオブザーバーの具体的なクラスを知る必要がなく、インターフェースを通じてのみ相互作用するため、コンポーネント間の結合度が低くなります。
- 動的なサブスクリプション：
  - オブザーバーはいつでもサブジェクトに登録したり解除したりすることができるため、実行時に柔軟に関係を変更することが可能です。
- スケーラビリティ：
  - 新しいオブザーバータイプの追加が容易であり、システムの変更に対して柔軟に対応できます。

## デメリット

- メモリオーバーヘッド：
  - 多数のオブザーバーが存在する場合、各オブザーバーを管理するためのオーバーヘッドが増加する可能性があります。
- 更新の難しさ：
  - サブジェクトの状態が頻繁に変わる場合、オブザーバーへの通知が連鎖的に多くの処理を引き起こし、パフォーマンスの問題を生じる可能性があります。
- 通知の順序問題：
  - オブザーバーへの通知順序が重要な場合、特定の順序で通知を管理するのが難しいことがあります。

Observerパターンは、これらの特徴を考慮し、適切な場面での適用が推奨されます。

## サンプルコード

```java
import java.util.ArrayList;
import java.util.List;

// オブザーバーインターフェース
interface Observer {
    void update(String message);
}

// サブジェクトインターフェース
interface Subject {
    void registerObserver(Observer o);
    void removeObserver(Observer o);
    void notifyObservers();
}

// 具体的なサブジェクト
class NewsAgency implements Subject {
    private List<Observer> observers = new ArrayList<>();
    private String news;

    public void setNews(String news) {
        this.news = news;
        notifyObservers();
    }

    @Override
    public void registerObserver(Observer o) {
        observers.add(o);
    }

    @Override
    public void removeObserver(Observer o) {
        observers.remove(o);
    }

    @Override
    public void notifyObservers() {
        for (Observer observer : observers) {
            observer.update(news);
        }
    }
}

// 具体的なオブザーバー
class NewsChannel implements Observer {
    private String news;

    @Override
    public void update(String news) {
        this.news = news;
        System.out.println("NewsChannel updated with news: " + news);
    }
}

public class Main {
    public static void main(String[] args) {
        NewsAgency newsAgency = new NewsAgency();
        NewsChannel newsChannel = new NewsChannel();

        newsAgency.registerObserver(newsChannel);
        newsAgency.setNews("Breaking News: Java makes a comeback!");
    }
}
```

```typescript
interface Observer {
    update(message: string): void;
}

interface Subject {
    registerObserver(observer: Observer): void;
    removeObserver(observer: Observer): void;
    notifyObservers(): void;
}

class NewsAgency implements Subject {
    private observers: Observer[] = [];
    private news: string = "";

    public setNews(news: string) {
        this.news = news;
        this.notifyObservers();
    }

    public registerObserver(observer: Observer) {
        this.observers.push(observer);
    }

    public removeObserver(observer: Observer) {
        const index = this.observers.indexOf(observer);
        if (index > -1) {
            this.observers.splice(index, 1);
        }
    }

    public notifyObservers() {
        this.observers.forEach(observer => observer.update(this.news));
    }
}

class NewsChannel implements Observer {
    private news: string = "";

    public update(news: string) {
        this.news = news;
        console.log(`NewsChannel updated with news: ${news}`);
    }
}

// Usage
const newsAgency = new NewsAgency();
const newsChannel = new NewsChannel();

newsAgency.registerObserver(newsChannel);
newsAgency.setNews("Breaking News: TypeScript is awesome!");
```