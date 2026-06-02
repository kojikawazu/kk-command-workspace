# コマンドワークスペース

技術ナレッジ・調査メモ・コーディング規約を蓄積するワークスペース。

下記の索引は `scripts/gen-index.sh` で自動生成しています。
ドキュメントを追加・削除した際は `bash scripts/gen-index.sh` を実行して索引を再生成してください。
<!-- AUTO-INDEX:START -->

## AI

生成 AI・LLM・関連ツール・開発環境に関するナレッジ。

### Claude

- [Claude Desktop + MCP環境構築手順書](./AI/Claude/claude-mcp.md)

### GenAI

- [生成AI](./AI/GenAI/ai.md)
- [Dify](./AI/GenAI/dify.md)

### Ollama

- [Ollama + Claude Code セットアップガイド (macOS)](./AI/Ollama/ollama-to-claude-code.md)
- [Ollama セットアップガイド (macOS)](./AI/Ollama/ollama.md)

### OpenAI

- [OpenAI](./AI/OpenAI/openai.md)

## Architecture

ソフトウェア設計・アーキテクチャ・デザインパターン・設計原則に関するナレッジ。

### Design

- [設計](./Architecture/Design/design-main.md)
- [仕様変更](./Architecture/Design/md/change-specification.md)
- [クリーンアーキテクチャについて](./Architecture/Design/md/clean-architecture.md)
- [CQRS（Command Query Responsibility Segregation）](./Architecture/Design/md/cqrs.md)
- [DDD設計について](./Architecture/Design/md/ddd.md)
- [イベント駆動アーキテクチャについて](./Architecture/Design/md/event-driven-architecture.md)
- [ヘキサゴナルアーキテクチャ（別名「ポートとアダプターアーキテクチャ」）](./Architecture/Design/md/hexagonal-architecture.md)
- [レイヤードアーキテクチャーについて](./Architecture/Design/md/layered-architecture.md)
- [マイクロサービスアーキテクチャについて](./Architecture/Design/md/micro-server-architecture.md)
- [オニオンアーキテクチャ](./Architecture/Design/md/onion-architecture.md)
- [パイプライン処理](./Architecture/Design/md/pipeline-processing.md)
- [要件定義](./Architecture/Design/md/requirements-definition.md)
- [レジリエントパターン](./Architecture/Design/md/resilient-pattern.md)
- [サーガパターン](./Architecture/Design/md/saga-pattern.md)
- [サーバーレスアーキテクチャについて](./Architecture/Design/md/serverless-architecture.md)
- [スペースベースアーキテクチャについて](./Architecture/Design/md/space-based-architecture.md)
- [基本設計](./Architecture/Design/md/standard-design.md)

### DesignPattern

- [Singleton（シングルトン）](./Architecture/DesignPattern/01.create/01-singleton.md)
- [Factory Method（ファクトリーメソッド）](./Architecture/DesignPattern/01.create/02-factory-method.md)
- [Abstract Factory（抽象ファクトリ）](./Architecture/DesignPattern/01.create/03-abstract-method.md)
- [ビルダー（Builder）パターン](./Architecture/DesignPattern/01.create/04-builder.md)
- [プロトタイプ（Prototype）パターン](./Architecture/DesignPattern/01.create/05-prototype.md)
- [Adapter（アダプタ）パターン](./Architecture/DesignPattern/02.structure/06-adapter.md)
- [コンポジット（Composite）パターン](./Architecture/DesignPattern/02.structure/07-composite.md)
- [Proxy（プロキシ）パターン](./Architecture/DesignPattern/02.structure/08-proxy.md)
- [Flyweight（フライウェイト）パターン](./Architecture/DesignPattern/02.structure/09-flyweight.md)
- [ファサード（Facade）パターン](./Architecture/DesignPattern/02.structure/10-facade.md)
- [Bridge（ブリッジ）パターン](./Architecture/DesignPattern/02.structure/11-bridge.md)
- [Decorator（デコレータ）パターン](./Architecture/DesignPattern/02.structure/12-decorator.md)
- [Observer（オブザーバー）パターン](./Architecture/DesignPattern/03.behavioral/13-observer.md)
- [Strategy（ストラテジー）パターン](./Architecture/DesignPattern/03.behavioral/14-strategy.md)
- [Command（コマンド）パターン](./Architecture/DesignPattern/03.behavioral/15-command.md)
- [State（ステート）パターン](./Architecture/DesignPattern/03.behavioral/16-state.md)
- [Visitor（ビジター）パターン](./Architecture/DesignPattern/03.behavioral/17-visitor.md)
- [Mediatorパターン（メディエーターパターン）](./Architecture/DesignPattern/03.behavioral/18-mediator.md)
- [Iteratorパターン（イテレータパターン）](./Architecture/DesignPattern/03.behavioral/19-iterator.md)
- [Memento（メメント）パターン](./Architecture/DesignPattern/03.behavioral/20-memento.md)
- [Template Method（テンプレートメソッド）パターン](./Architecture/DesignPattern/03.behavioral/21-template-method.md)
- [Chain of Responsibility（チェーンオブレスポンシビリティ）パターン](./Architecture/DesignPattern/03.behavioral/22-chain-of-responsibility.md)
- [デザインパターン](./Architecture/DesignPattern/design-pattern.md)

### Other

- [Webバックエンド開発でよく使われるアルゴリズム・デザインパターン・データ構造](./Architecture/Other/other-pattern.md)

### SOLID

- [SOLID原則](./Architecture/SOLID/solid.md)

## Cloud-Infra

クラウド・IaC・OS/実行環境などインフラ全般に関するナレッジ。

### AWS

- [AWS関連のコマンドリスト](./Cloud-Infra/AWS/aws-cli-commands.md)

### Ansible

- [Ansible](./Cloud-Infra/Ansible/ansible.md)
- [設置場所](./Cloud-Infra/Ansible/custom/manual.md)

### ConoHa

- [ConoHa](./Cloud-Infra/ConoHa/conoha.md)

### Firebase

- [Firebase](./Cloud-Infra/Firebase/firebase.md)

### GoogleCloud

- [TerraformによるGoogle Cloud Runへのデプロイ](./Cloud-Infra/GoogleCloud/cloud-run.md)

### IaC

- [Terraform を用いた AWS IaC のベストプラクティスと代表的なアーキテクチャ](./Cloud-Infra/IaC/iac-doc.md)

### Selenium

- [Selenium構築方法](./Cloud-Infra/Selenium/selenium-setup.md)

### Terraform

- [Packerのインストールマニュアル](./Cloud-Infra/Terraform/packer-install.md)
- [Terraformのインストールマニュアル](./Cloud-Infra/Terraform/terraform-install.md)

### WSL

- [Docker環境のインストールマニュアル](./Cloud-Infra/WSL/docker-install.md)
- [Java関係の操作](./Cloud-Infra/WSL/java-operations.md)
- [WSLコマンド集](./Cloud-Infra/WSL/wsl-commands.md)

### Windows

- [Active Directory](./Cloud-Infra/Windows/active-directory.md)

## CodingRule

- [コーディング規約(Java)](./CodingRule/01-java-rule.md)
- [コーディング規約(Spring)](./CodingRule/02-spring-rule.md)
- [コーディング規約(Python)](./CodingRule/03-python-rule.md)
- [コーディング規約(Django)](./CodingRule/04-django-rule.md)
- [コーディング規約(JavaScript)](./CodingRule/05-javascript-rule.md)
- [コーディング規約(Next.js)](./CodingRule/06-nextjs-rule.md)
- [コーディング規約(React)](./CodingRule/07-react-rule.md)
- [コーディング規約(PHP)](./CodingRule/08-php-rule.md)
- [コーディング規約(Laravel)](./CodingRule/09-laravel-rule.md)
- [コーディング規約(Ruby)](./CodingRule/10-ruby-rule.md)
- [コーディング規約(Rails)](./CodingRule/11-rails-rule.md)
- [コーディング規約(TypeScript)](./CodingRule/12-typescript-rule.md)
- [コーディング規約(ShellScript)](./CodingRule/13-shell-script-rule.md)
- [コーディング規約メモ](./CodingRule/99-rule-memo.md)

## Database

データベース・ORM・BaaS などデータ層に関するナレッジ。

### MySQL

- [MySQLコマンドリスト](./Database/MySQL/mysql-client-commands.md)

### Prisma

- [Prisma導入](./Database/Prisma/prisma.md)

### Supabase

- [RLS](./Database/Supabase/rls.md)
- [トランザクション](./Database/Supabase/transaction.md)

## Frameworks

Web アプリケーションフレームワーク・ライブラリ・クエリ層に関するナレッジ。

### GraphQL

- [GraphQL](./Frameworks/GraphQL/graphql.md)

### Laravel

- [Laravelコマンドリスト](./Frameworks/Laravel/laravel-commands.md)

### NestJS

- [NestJS](./Frameworks/NestJS/nestjs.md)

### Nextjs

- [Next.js 関連リンク・セットアップ](./Frameworks/Nextjs/site.md)

### Vuejs

- [Vue.js](./Frameworks/Vuejs/vuejs.md)

## Languages

プログラミング言語そのものの仕様・機能・環境構築に関するナレッジ。

### Go

- [Go言語（GoLang）の詳細調査](./Languages/Go/go-doc.md)
- [GoLangのマニュアル](./Languages/Go/go-main.md)
- [Go言語の注意点まとめ](./Languages/Go/md/go-caution.md)
- [Echoの環境構築](./Languages/Go/md/go-echo.md)
- [マニュアルメモ](./Languages/Go/md/go-other.md)
- [Goの環境構築](./Languages/Go/md/go.md)

### Java

- [Java 8からJava 22までの主な新機能と改善点まとめ](./Languages/Java/java-version-doc.md)
- [参考URL](./Languages/Java/java.md)

### Kotlin

- [Kotlinを用いたWebアプリケーション開発の特徴](./Languages/Kotlin/kotlin-doc.md)

### PHP

- [PHPとLaravelの概要レポート](./Languages/PHP/php-doc.md)

### Python

- [Python（パイソン）の概要と最新情報](./Languages/Python/py-doc.md)

### Ruby

- [Ruby](./Languages/Ruby/install.md)

### Rust

- [Rustの環境構築](./Languages/Rust/rust.md)

### TypeScript

- [TypeScriptの概要と活用に関する詳細解説](./Languages/TypeScript/typescript-doc.md)

## Process

開発プロセス・プロジェクトマネジメント・コラボレーションに関するナレッジ。

### Agile

- [アジャイル開発](./Process/Agile/agile01.md)
- [アジャイル開発(実践)](./Process/Agile/agile02.md)

### GitHub

- [GitHubの組織使用](./Process/GitHub/github-organization.md)
- [WSL上でのGitHubの登録方法](./Process/GitHub/github-registration.md)

### PMBOK

- [PMBOK](./Process/PMBOK/pmbok.md)

## URL

- [参考サイト一覧](./URL/reference-sites.md)

<!-- AUTO-INDEX:END -->
