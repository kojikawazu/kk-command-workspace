# AWS関連のコマンドリスト
---

## AWS CLIのインストール
---

```bash
# インストール
sudo apt update
sudo apt install awscli

# バージョンの確認
aws --version
```

## ECRにDockerfileをプッシュする方法
---

### ステップ 1: ECRリポジトリの作成

もしまだECRリポジトリを作成していない場合、AWS管理コンソールから、またはAWS CLIを使用して作成できます。

```bash
aws ecr create-repository --repository-name your-repo-name --region your-region
```

- your-repo-nameをリポジトリの名前に置き換えてください。
- your-regionをAWSリージョン（例: us-west-2）に置き換えてください。

### ステップ 2: 認証トークンの取得

DockerクライアントがECRにアクセスできるように、認証トークンを取得してDockerにログインします。

```bash
aws ecr get-login-password --region your-region | docker login --username AWS --password-stdin your-account-id.dkr.ecr.your-region.amazonaws.com
```

- your-regionをリポジトリが存在するリージョンに置き換えてください。
- your-account-idをあなたのAWSアカウントIDに置き換えてください。

### ステップ 3: Dockerイメージのビルド

Dockerfileが存在するディレクトリで以下のコマンドを実行して、ローカルにDockerイメージをビルドします。

```bash
docker build -t your-repo-name .
```

- your-repo-nameはステップ1で作成したECRリポジトリの名前です。

### ステップ 4: Dockerイメージにタグを付ける
ビルドしたイメージにECRリポジトリ用のタグを付けます。

```bash
docker tag your-repo-name:latest your-account-id.dkr.ecr.your-region.amazonaws.com/your-repo-name:latest
```

- latestは使用するタグですが、適宜変更可能です。

### ステップ 5: DockerイメージをECRにプッシュ

タグ付けしたイメージをECRにプッシュします。

```bash
docker push your-account-id.dkr.ecr.your-region.amazonaws.com/your-repo-name:latest
```

## AWS-CLIでECSクラスタ停止中の理由解析方法

クラスタ内の停止中タスク一覧を表示する。

```bash
aws ecs list-tasks --cluster cluster-name --desired-status STOPPED --region region-name
```

停止中の理由を表示する。

```bash
aws ecs list-tasks --cluster cluster-name --tasks arn-name --region region-name
```

## Session Managerプラグインのインストール

AWS Systems Manager Session Managerは、AWSリソースへのセキュアな接続を提供するサービスです。ECS Execを使用するためには、このSession Managerプラグインがローカル環境にインストールされている必要があります。

以下のステップに従って、Session Managerプラグインをインストールしてください。

```bash
# sessing manager pluginのインストール
curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb"
sudo dpkg -i session-manager-plugin.deb
# インストール後の確認
session-manager-plugin

# ECS Execが有効か確認する
aws ecs describe-services --cluster your-cluster-name --services your-service-name | grep enableExecuteCommand
# ECS Execを有効にする
aws ecs update-service --cluster your-cluster-name --service your-service-name --enable-execute-command

# この後タスクの再起動も実施する
```

## CSRF対策の不具合

ドメインの異なるサーバーがユーザー認証すると、Laravel(バックエンド)側がエラーとなる。
バックエンド側からcsrf-tokenが送られてこない。

CORS対策以外にもCSRF不具合対策が必要となった。
.env、もしくはAWS側の環境変数に以下を設定する。

```bash
SANCTUM_STATEFUL_DOMAINS=[Web側のドメイン],[API側のドメイン]
```

## 参考URL

https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/stopped-task-errors.html

https://zenn.dev/funayamateppei/articles/ee64daaaff6ccf#laravel%E3%81%AEbreeze%E3%82%92%E4%BD%BF%E7%94%A8%E3%81%97%E3%81%9Fspa%E8%AA%8D%E8%A8%BC%E3%82%92%E3%81%97%E3%82%88%E3%81%86%E3%81%A8%E3%81%97%E3%81%9F