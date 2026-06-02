# Iteratorパターン（イテレータパターン）

Iteratorパターン（イテレータパターン）は、コレクション（集合体）内の要素に順番にアクセスする方法を提供するデザインパターンです。このパターンを使用すると、コレクションの内部表現を公開することなく、その要素を一つずつ処理することができます。

## 適用場面

- 異なるデータ構造を扱う場合：
  - 異なる種類のコレクション（例えば、配列、リスト、ツリーなど）に対して、統一されたインターフェースで要素にアクセスしたい場合。
- コレクションの実装を隠蔽したい場合：
  - コレクションの具体的な実装に依存せずに、要素にアクセスする方法が必要な場合。
- コレクションの走査を複数の方法で提供したい場合：
  - 異なる走査方法（前から後ろ、後ろから前など）を提供したい場合。

## メリット

- 抽象化の促進：
  - コレクションの内部構造に依存せずに要素を走査できるため、コレクションの種類が変更されてもクライアントコードを変更する必要がありません。
- 再利用性の向上：
  - 同じ走査プロセスを異なる種類のコレクションに対して再利用できます。
- 複数の走査を同時に行うことが可能：
  - 一つのコレクションに対して、複数のイテレータを同時に活用することができます。

## デメリット

- オーバーヘッドの増加：
  - イテレータオブジェクトを生成し、管理するための追加のコストが発生します。
- 複雑性の増加：
  - シンプルな走査であれば、イテレータを使用せず直接コレクションにアクセスする方が簡単な場合があります。
- 同期の問題：
  - 複数のイテレータが同じコレクションを同時に走査する場合、同期を保つ必要があるかもしれません。

Iteratorパターンは、コレクションの走査を一元管理し、その操作をクリーンに保ちたい場合に特に有効です。これにより、コレクションの操作と走査ロジックが分離され、より整理されたコードを実現することができます。

## サンプルコード

```java
import java.util.ArrayList;
import java.util.List;

// イテレータインターフェース
interface Iterator<T> {
    boolean hasNext();
    T next();
}

// 集合体インターフェース
interface Aggregate {
    Iterator<Book> iterator();
}

// 具体的な集合体
class BookShelf implements Aggregate {
    private List<Book> books;

    public BookShelf() {
        this.books = new ArrayList<>();
    }

    public void addBook(Book book) {
        books.add(book);
    }

    @Override
    public Iterator<Book> iterator() {
        return new BookShelfIterator(this);
    }

    public int getSize() {
        return books.size();
    }

    public Book getBookAt(int index) {
        return books.get(index);
    }
}

// 具体的なイテレータ
class BookShelfIterator implements Iterator<Book> {
    private BookShelf bookShelf;
    private int index;

    public BookShelfIterator(BookShelf bookShelf) {
        this.bookShelf = bookShelf;
        this.index = 0;
    }

    @Override
    public boolean hasNext() {
        return index < bookShelf.getSize();
    }

    @Override
    public Book next() {
        Book book = bookShelf.getBookAt(index);
        index++;
        return book;
    }
}

// 要素（本）
class Book {
    private String name;

    public Book(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}

// デモクラス
public class IteratorDemo {
    public static void main(String[] args) {
        BookShelf bookShelf = new BookShelf();
        bookShelf.addBook(new Book("Design Patterns"));
        bookShelf.addBook(new Book("Effective Java"));
        bookShelf.addBook(new Book("Clean Code"));

        Iterator<Book> iterator = bookShelf.iterator();
        while (iterator.hasNext()) {
            Book book = iterator.next();
            System.out.println(book.getName());
        }
    }
}
```

```typescript
// イテレータインターフェース
interface Iterator<T> {
    hasNext(): boolean;
    next(): T;
}

// 集合体インターフェース
interface Aggregate {
    iterator(): Iterator<Book>;
}

// 具体的な集合体
class BookShelf implements Aggregate {
    private books: Book[] = [];

    addBook(book: Book): void {
        this.books.push(book);
    }

    getLength(): number {
        return this.books.length;
    }

    getBookAt(index: number): Book {
        return this.books[index];
    }

    iterator(): Iterator<Book> {
        return new BookShelfIterator(this);
    }
}

// 具体的なイテレータ
class BookShelfIterator implements Iterator<Book> {
    private bookShelf: BookShelf;
    private index: number = 0;

    constructor(bookShelf: BookShelf) {
        this.bookShelf = bookShelf;
    }

    hasNext(): boolean {
        return this.index < this.bookShelf.getLength();
    }

    next(): Book {
        const book = this.bookShelf.getBookAt(this.index);
        this.index++;
        return book;
    }
}

// 要素（本）
class Book {
    constructor(private name: string) {}

    getName(): string {
        return this.name;
    }
}

// デモコード
const bookShelf = new BookShelf();
bookShelf.addBook(new Book("Design Patterns"));
bookShelf.addBook(new Book("Effective TypeScript"));
bookShelf.addBook(new Book("Clean Code"));

const iterator = bookShelf.iterator();
while (iterator.hasNext()) {
    const book = iterator.next();
    console.log(book.getName());
}
```