# Firebase

https://firebase.google.com/?authuser=1&hl=ja

## Hostingへデプロイ

FirebaseのHostingサービスを利用する。

```bash
# Firebase Hosting を使用してサイトをホストするには、Firebase CLI（コマンドライン ツール）が必要です。
# 次の npm コマンドを実行して、CLI をインストールするか、最新バージョンの CLI に更新します。

npm install -g firebase-tools
```

```bash
# プロジェクトの初期化
# ターミナル ウィンドウを開き、ウェブアプリのルート ディレクトリに移動するか、ルート ディレクトリを作成します

# Google へのログイン
firebase login
# プロジェクトの開始
# このコマンドはアプリのルート ディレクトリから実行してください。
firebase init
```

```bash
# Firebase Hosting へのデプロイ

# 準備ができたらウェブアプリをデプロイしてください
# 静的ファイル（HTML、CSS、JS など）をアプリのデプロイ ディレクトリ（デフォルトは「public」）に配置します。続いて、アプリのルート ディレクトリから次のコマンドを実行します。
firebase deploy
```
