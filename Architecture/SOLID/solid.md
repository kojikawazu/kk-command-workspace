# SOLID原則

## SOLID原則とは？

SOLID原則とは、ソフトウェアを柔軟に、メンテナンス性を高く設計するための5つの原則。

1. SRP: 単一責任の原則
2. OCP: 開放閉鎖の原則
3. LSP: リスコフの原則
4. ISP: インタフェースの原則
5. DIP: 依存性逆転の原則

## SRP (Single Responsibility Principle)

- モジュールを変更する理由はたったひとつだけであるべきである。

::::details badcode
```javascript:badcode
import React, { useEffect, useState } from "react";
import axios from "axios";

type TodoType = {
  id: number;
  userId: number;
  title: string;
  completed: boolean;
};

export const TodoList = () => {
  const [data, setData] = useState<TodoType[]>([]);
  const [isFetching, setIsFetching] = useState(true);

  useEffect(() => {
    axios
      .get<TodoType[]>("https://jsonplaceholder.typicode.com/todos")
      .then((res) => {
        setData(res.data);
      })
      .catch((e) => {
        console.log(e);
      })
      .finally(() => {
        setIsFetching(false);
      });
  }, []);

  if (isFetching) {
    return <p>...loading</p>;
  }

  return (
    <ul>
      {data.map((todo) => {
        return (
          <li>
            <span>{todo.id}</span>
            <span>{todo.title}</span>
          </li>
        );
      })}
    </ul>
  );
};
```
::::

TodoListコンポーネントではTodoをフェッチしてきて、フェッチしたデータを元に描画しています。
こういったコンポーネントはプロジェクトに関わっているとたまに見るかもしれませんが、以下の理由でSRPに違反しています。

- フェッチ処理とTODOの描画という2つの責務を同じコンポーネントの中で行っている

例えば、fetch 部分で指定しているエンドポイントが変更されたとすると、TodoListコンポーネントの中身を変更しないといけません。また、タイトルのスタイルを変更したい場合も、このコンポーネントを変更する必要があります。

React ではカスタム hooks を使って、hooks のフェッチ部分とコンポーネントの描画を分離することができるので、カスタム hooks でフェッチ部分を切り出してあげます。

::::details goodcode
```javascript:goodcode
import React, { useEffect, useState } from "react";
import axios from "axios";

type TodoType = {
  id: number;
  userId: number;
  title: string;
  completed: boolean;
};

export const useFetchTodo = () => {
  const [data, setData] = useState<TodoType[]>([]);
  const [isFetching, setIsFetching] = useState(true);

  useEffect(() => {
    axios
      .get<TodoType[]>("https://jsonplaceholder.typicode.com/todos")
      .then((res) => {
        setData(res.data);
      })
      .catch((e) => {
        console.log(e);
      })
      .finally(() => {
        setIsFetching(false);
      });
  }, []);

  return {
    todo: data,
    isFetching,
  };
};

export const TodoList = () => {
  const { todo, isFetching } = useFetchTodo();

  if (isFetching) {
    return <p>...loading</p>;
  }

  return (
    <ul>
      {todo.map((todo) => {
        return (
          <li>
            <span>{todo.id}</span>
            <span>{todo.title}</span>
          </li>
        );
      })}
    </ul>
  );
};
```
::::

こうすることで、フェッチする処理をコンポーネント側が知る必要はなくなり、インターフェースを知っているだけでよくなりました。例えば、フェッチの中でエラーハンドリング処理を追加したいケースが出てきても、コンポーネント側を変更せずにuseFetchTodoの中を変更するだけで収まるようになります。

このように SRP をコンポーネント設計に当てはめることで、適切な責務分離によるテスタビリティの向上や次に解説する開放閉鎖の原則に繋がります。

## OCP (Open Closed Principle)

OCP とは、「コンポーネントや関数の拡張に対しては開いて、変更に対しては閉じているべき」という原則になります。

::::details badcode
```javascript:badcode
import React, { VFC } from "react";

type Props = {
  title: string;
  type: "default" | "withLinkButton" | "withNormalButton";
  href?: string;
  buttonText?: string;
  onClick?: () => void;
};

export const Title: VFC<Props> = ({
  title,
  type,
  href,
  buttonText,
  onClick,
}) => {
  return (
    <div style={{ display: "flex", justifyContent: "space-between" }}>
      <h1>{title}</h1>
      {type === "withLinkButton" && (
        <button onClick={onClick}>
          <a href={href}>{buttonText}</a>
        </button>
      )}
      {type === "withNormalButton" && (
        <button onClick={onClick}>{buttonText}</button>
      )}
    </div>
  );
};
```
::::

props としてタイトル名を表示するtitle、タイトルの横にどんなボタンを置くかを決めるtypeなどを受け取ります。そして現状のユースケースとしては、ボタンを表示しないケース、タイトルの横にリンクのボタンを表示するケース、普通のボタンを表示するケースの 3 つがあります。

props の type にwithTooltipという型を追加して、type === 'withTooltipの場合はツールチップを表示するように修正しました。

このように、このコンポーネントは拡張を続ける中で常に変更にさらされることになります。常に変更にさらされると、開発者はあるユースケースの追加により、他のユースケースに不具合が出ていないかを確認する必要が出来てきます。この確認作業は拡張の回数と比例して増加していき、開発スピードは徐々に低下していくことが予想されます。

なので、OCP の原則に従って、リファクタリングをしていきたいと思います。
様々なリファクタリングの仕方がありますが、今回は React のデザインパターンである Composition Components パターンを使ってリファクタリングします。

::::details badcode
```javascript:badcode
import { VFC, FC } from "react";

type TitleProps = {
  title: string;
};

export const Title: FC<TitleProps> = ({ title, children }) => {
  return (
    <div style={{ display: "flex", justifyContent: "space-between" }}>
      <h1>{title}</h1>
      {children}
    </div>
  );
};

type TitleWithLinkProps = {
  title: string;
  href: string;
  buttonText: string;
};

export const TitleWithLink: VFC<TitleWithLinkProps> = ({
  title,
  href,
  buttonText,
}) => {
  return (
    <Title title={title}>
      <button>
        <a href={href}>{buttonText}</a>
      </button>
    </Title>
  );
};

type TitleWithButtonProps = {
  title: string;
  buttonText: string;
  onClick: () => void;
};

export const TitleWithButtonProps: VFC<TitleWithButtonProps> = ({
  title,
  buttonText,
  onClick,
}) => {
  return (
    <Title title={title}>
      <button onClick={onClick}>{buttonText}</button>
    </Title>
  );
};
```
::::

## LSP (Liskov Substitution Principle)

親クラスが持つメソッドやオブジェクトは、サブクラスで使用しても同じ挙動をしなければいけないというものです。親で定義した仕様を、サブクラスでオーバラーライドして挙動を変えてしまうと、意図しないバグを生むことになります。

例えばAnimalクラスと、そのサブクラスであるDogクラスとCatクラスがあるとして、以下の様なコードは LSP に違反していると言えます。

::::details badcode
```javascript:badcode
export class Animal {
  swim(distance: number) {
    console.log(`${distance}mまで泳いだよ！`);
  }
}

export class Dog extends Animal {
  swim(distance: number) {
    console.log(`${distance}mまで泳いだよ！`);
  }
}

export class Cat extends Animal {
  swim() {
    new Error("猫なので泳げないよ！");
  }
}
```
::::

親クラスである Animal で swim 関数を定義しており、サブクラスである Dog と Cat はその関数をオーバーライドしています。しかし、Catクラスは swim をオーバーライドして独自の処理を加えており、CatクラスはAnimalクラスと置き換えることはできないので、LSP に違反していると言えます。

React では hooks を使用した関数型コンポーネントが主軸となっており、上記のようなクラスベースの処理を書くことは少なくなっているのが現状です。なので、こちらの原則は React だけしか触らない人にとって頭に入れておくだけでもいいかもしれません。

## ISP (Interface Segregation Principle)

インターフェース分離の原則とは、インターフェースを使用するクラスやオブジェクトは、不要なインターフェースの使用を強制されるべきではないという原則です。

React で言い換えると、コンポーネントで定義されるインターフェース（TypeScriptで定義されるpropsの型定義）は、そのコンポーネントで使用する用途に限定されるべきであると言えます。

::::details badcode
```javascript:badcode
import React, { VFC } from "react";

type PostType = {
  title: string;
  author: {
    name: string;
    age: number;
  };
  createdAt: Date;
};

export const Post = ({ post }: { post: PostType }) => {
  return (
    <div>
      <PostTitle post={post} />
      <span>author: {post.author.name}</span>
      <PostDate post={post} />
    </div>
  );
};

type Props = {
  post: PostType;
};

export const PostTitle: VFC<Props> = ({ post }) => {
  return <h1>{post.title}</h1>;
};

type DateProps = {
  post: PostType;
};

export const PostDate: VFC<DateProps> = ({ post }) => {
  return <time>{post.createdAt}</time>; // サンプルということで...
};
```
::::

Postコンポーネントは投稿を描画するコンポーネントで、子コンポーネントにタイトルを表示するPostTitleコンポーネントと投稿日を表すPostDateコンポーネントを呼び出しています。

一見普通のコンポーネントに見えますが、こちらのコードは ISP に違反しているコードだと言えます。

PostTitleコンポーネントはコンポーネントのインターフェースとしてpost: PostTypeを定義していますが、このコンポーネントで使用するのはpostオブジェクトの中のnameプロパティのみです。

つまり、PostTitleコンポーネントはnameというインターフェースにのみ依存していればいいものの、post: PostTypeというインターフェースに依存しているために、不必要な依存まで増やしていることになっています。

post: PostTypeに依存してしまうと、例えば PostTypeが以下のような型に変更された場合、PostTitleコンポーネントとPostDateコンポーネントにまで変更が及んでしまうことになります。（nameだけに依存していれば、修正される箇所はPostコンポーネントだけに終止します。）

::::details goodcode
```javascript:goodcode
import React, { VFC } from "react";

type PostType = {
  title: string;
  author: {
    name: string;
    age: number;
  };
  createdAt: Date;
};

export const Post = ({ post }: { post: PostType }) => {
  return (
    <div>
      <PostTitle title={post.title} />
      <span>author: {post.author.name}</span>
      <PostDate date={post.createdAt} />
    </div>
  );
};

type Props = {
  title: string;
};

export const PostTitle: VFC<Props> = ({ title }) => {
  return <h1>{title}</h1>;
};

type DateProps = {
  date: Date
};

export const PostDate: VFC<DateProps> = ({ date }) => {
  return <time>{date}</time>;
};
```
::::

## DIP (Dependency Inversion Principle)

DIP は日本語で依存性逆転の原則と言います。
所謂、import などを使って外部のモジュールに依存する場合は、具象ではなく抽象に対して依存するべきであるという意味で、SOLID 原則の中で個人的には一番重要な原則であると思っています。

なぜなら、抽象に依存することで変更に強いアプリケーションを構築できるからであり、逆に具象に依存したアプリケーションは変更に弱く、すぐに破綻してしまいます。

例えば、あなたが所属するチームがフェッチライブラリであるswrを採用したとして、以下のようなコードを実装しました。

::::details badcode
```javascript:badcode
import useSWR from 'swr'

const fetcher = async (url) => {
  const res = await fetch(url)
  return res.json()
}

export const Todo = () => {
  const { data } = useSWR('https://jsonplaceholder.typicode.com/todos', fetcher)

  if (!data) return <p>loading....</p>
  
  return (
    <ul>
    {data.map((todo) => {
      return (
        <li>
          <span>{todo.id}</span>
          <span>{todo.title}</span>
        </li>
      );
    })}
  </ul>
  )
}
```
::::

上記のコードはいくつかの問題点を抱えています。

- Todoコンポーネント内でフェッチ処理を行っておりSRPに違反している
- 具体的な実装であるswrにTodoコンポーネントが依存している

今回TodoコンポーネントではuseSWRを実行して、todosのデータをフェッチしており、当然Todoコンポーネント以外のコンポーネントもuseSWRを直接実行してフェッチしています。

例えば、swrの同列ライブラリであるreact-queryがバージョンアップして、swrより優れた機能をリリースしたとします。あなたはreact-queryにこのアプリケーションも移行したいと考えたときに、果たしてその移行は簡単に行えるでしょうか？ 移行を行うためには以下の問題が発生します。

- 様々なコンポーネントでswrに直接依存しているので、各コンポーネントでreact-queryに置き換える変更を加えないといけない
- エラーの返し方がそれぞれのコンポーネントで異なる場合、errorを参照している実装箇所も修正が必要になる

今回の問題として、Todoコンポーネントが直接swrの実装に依存していることが１つの問題点であり、DIPを使って依存の方向性をインターフェースに向けるように修正します。

::::details goodcode
```javascript:useFetch.ts
import useSWR from 'swr'

interface IUseFetch<T> {
  key: string
  fetcher: () => Promise<T>
}

interface IResponse<T> {
  data: T | undefined,
  error: string | undefined
  isValidating: boolean
}

export const useFetch = <T>({ key, fetcher }: IUseFetch<T>): IResponse<T> => {
  const { data, error, isValidating } = useSWR<T, string>(key, fetcher)

  return {
    data,
    error,
    isValidating
  }
}
```

```javascript:Todo.tsx
import { useFetch } from './useFetch'

type ResponseType = {
  id: number
  title: string
}

const fetcher = async (): Promise<ResponseType[]> => {
  const url = 'https://jsonplaceholder.typicode.com/todos'
  const res = await fetch(url)
  return res.json()
}

export const Todo = () => {
  const { data } = useFetch<ResponseType[]>({ key: '/todos', fetcher })

  if (!data) return <p>loading....</p>
  
  return (
    <ul>
    {data.map((todo) => {
      return (
        <li>
          <span>{todo.id}</span>
          <span>{todo.title}</span>
        </li>
      );
    })}
  </ul>
  )
}
```
::::

上記のコードでは、useFetch関数というswrをラップする関数を定義して、それをTodoコンポーネントで読み込んでいます。

useFetchではインターフェースとして引数で受け取る値と返却される値を定義しており、Todoコンポーネントでの依存はswr自身から、そのインターフェースに逆転しました。

## URL

https://zenn.dev/koki_tech/articles/361bb8f2278764
