# コーディング規約(Django)

Djangoのコーディング規約は、効率的で保守が容易なコードを書くためのガイドラインを提供しています。主要なポイントを以下にまとめます。

## インポート

- インポートは明確に分類して、Pythonの標準ライブラリ、サードパーティライブラリ、Djangoのコンポーネント、ローカルのDjangoコンポーネントの順に並べます。
- 各セクション内では、import module 文を from module import object の前に配置し、アルファベット順に並べます。

## コーディングスタイル

- 変数、関数、メソッド名にはスネークケースを使用し、クラス名にはキャメルケースを使用します。
- ブール値をテストする際は、assertTrue() や assertFalse() の代わりに assertIs(..., True/False) を使用して、実際のブール値を確認します。

## テンプレートスタイル

- Djangoテンプレートでは、{% extends %} タグをファイルの最初の非コメント行に配置します。
変数を表示する際は、{{ と }} の間に正確に1つのスペースを入れます。

## モデルスタイル

- モデルフィールド名は全て小文字を使用し、単語の間にはアンダースコアを使用します。
- class Meta クラスはフィールド定義の後に配置し、フィールドとクラス定義の間には空行を入れます。

これらのガイドラインに従うことで、Djangoアプリケーションの保守性と効率が向上します。より詳細な情報は、Djangoの公式ドキュメントとDjango Best Practicesから確認できます​ (Django Project)​​ (Django Best Practices)​​ (Django Best Practices)​。

## URL

https://docs.djangoproject.com/en/dev/internals/contributing/writing-code/coding-style/