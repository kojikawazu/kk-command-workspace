# Ruby

## Rubyの構築

## 依存関係のインストール

まず、必要な依存関係をインストールします。これには、ビルドツールやライブラリが含まれます。

```bash
sudo apt-get update
sudo apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev ruby-dev sqlite3 libsqlite3-dev
```

### ruby-buildのインストール

ruby-buildは、GitHubから最新バージョンをクローンしてローカルにインストールすることができます。以下のコマンドで行います。

```bash
git clone https://github.com/rbenv/ruby-build.git
PREFIX=/usr/local sudo ./ruby-build/install.sh

gem install sqlite3
```

### 利用可能なRubyバージョンの確認

アップデートしたruby-buildを使って、利用可能なRubyのバージョンを確認します。

```bash
rbenv install -l
```

### Rubyのバージョンをインストール

必要なバージョンがリストにあれば、次のコマンドでインストールできます。

```bash
rbenv install 3.0.2
```

### rbenvを使ってバージョンを設定

インストール後、使いたいRubyのバージョンを設定します。

```bash
rbenv global 3.0.2
```

### 環境を再構築

変更を適用するために、rbenvを再初期化します。

```bash
rbenv rehash
```

### Rubyのバージョンを確認

```bash
ruby -v
gem -v
```

## Rubyの主な特徴

- オブジェクト指向
- シンプルな文法
- 強力な標準ライブラリ
- 国際標準

## RubyとRuby on Rails

- Ruby
  - プログラミング言語 
- Ruby on Rails
  - Rubyで書かれたWebアプリケーションフレームワーク
  - Web開発における共通した作業に伴う労力を軽減
  - Webアプリケーションを少ないコード量で開発


## RubyGems(gem)

- 幅広いライブラリがgemという形式が公開
- よく使う機能などがgemで公開されており、利用することで開発工数が削減できる

## 採用事例

- クックパッド
- freee
- GitHub
- Arbnb
- Square

## Railsのインストール

```bash
sudo gem install rails -v 7.0.0 -N

rails -v
```

## Railsの基本理念

設定より規約
- Convention over Configuration, CoC

同じことを繰り返さない
- Don't Repeat Yourself, DRY

MVCアーキテクチャ

## ERB

Embedded Rubyの略
htmlの中に、rubyのプログラムを埋め込むことができる。
テンプレートエンジンの一種

## プロジェクトの作成

```bash
rails _7.0.0_ new hello
```

## サーバー起動

```bash
rails s
```

## コントローラーの作成

```bash
rails g controller users index
```

## モデルの作成

```bash
rails g model User name:string age:integer
```

## マイグレーション

```bash
rails db:create
rails db:migrate
```

## データベース構造の確認

```bash
rails dbconsole
```

## データベースの操作

```bash
rails console
```

## 規約

(例)
app/views/users/index.html.erb

(ルール)
app/views/コントローラー名/アクション名.html.erb

# URL

### 環境を再構築




