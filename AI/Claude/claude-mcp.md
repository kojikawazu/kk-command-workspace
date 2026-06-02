# Claude Desktop + MCP環境構築手順書

## 前提条件

- Node.jsがインストール済み
- GitHubアカウントを保有
- Windowsの場合の手順書となる

## 1. GitHubパーソナルアクセストークンの作成

- 1. GitHubにログイン
- 2. 右上のプロフィールアイコン → Settings
- 3. 左メニュー最下部の「Developer settings」
- 4. 左メニュー「Personal access tokens」→「Tokens (classic)」
- 5. 「Generate new token」→「Generate new token (classic)」
- 6. Note: 任意の名前（例：Claude MCP）
- 7. 有効期限: 任意
- 8. スコープ選択:
  - repo（全て）
  - read:org
- 9. 「Generate token」をクリック
- 10. 表示されたトークンを保存（この画面を閉じると二度と表示されません）

## 2. MCPサーバーのインストール

- Git Bashを起動し、グローバルインストールします。

```bash
npm install -g @modelcontextprotocol/server-github
```

## 3. Claude Desktopのセットアップ

## 3-1.  インストール

- [Claude.ai](https://claude.ai/download)からインストーラをダウンロード
- インストーラを実行してClaude Desktopをインストール

## 3-2. 開発者モードの有効化

- 1. Claude Desktopを起動
- 2. 左上メニュー → Help → Enable Developer Mode
- 3. ダイアログで「Enable」をクリック

## 3-3. MCP設定

- 1. 左上メニュー → File → Settings
- 2. Developer → Edit Config
- 3. 以下の設定を入力：

```json:
{
  "mcpServers": {
    "github": {
      "command": "node",
      "args": [
        "C:\\Users\\[ユーザー名]\\AppData\\Roaming\\npm\\node_modules\\@modelcontextprotocol\\server-github\\dist\\index.js"
      ],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "[トークン]",
        "GITHUB_USERNAME": "[GitHubのアカウント名]"
      }
    }
  }
}
```

設定値の説明：

- ユーザー名: Windowsのユーザー名
- トークン: GitHubの個人アクセストークン（リポジトリアクセス権限必要）
- GitHubのアカウント名: GitHubのユーザー名

## 3.4 動作確認

- Claude Desktopを再起動
- 左上メニュー → Developer → Open MCP Log Fileにて、MCP起動したことを確認

# URL

- [Model Context Protocol (MCP) を試してみる (Windows)](https://zenn.dev/acntechjp/articles/483747f8e89ad8)

- [Windows環境でClaude Desktop + GitHub MCP Serverを使ってサンプルリポジトリを作成する方法](https://qiita.com/Maki-HamarukiLab/items/146304ad523bf1effab3)
