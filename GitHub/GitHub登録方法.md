# WSL上でのGitHubの登録方法

Ubuntuの場合、Ubuntuの環境下で実施すること

```bash
# 鍵を生成する
ssh-keygen -t ed25519 -C "[GitHubに登録したメールアドレス]" -f ~/.ssh/[鍵名]

# ssh-agent起動確認
eval "$(ssh-agent -s)"
# ssh-agentに登録
ssh-add ~/.ssh/[秘密鍵]

# GitHub情報の登録
git config --global user.name=[GitHubのユーザー名]
```

## 2. GitHubに公開鍵を登録
 
1. GitHubを起動
2. ユーザーへ移動
3. Settingsへ移動
4. 「SSH and GPG keys」へ移動
5. SSH keys欄の「New SSH key」ボタンを押下する
6. 公開鍵の中身を張り付けて登録する

## ssh接続確認

```bash
ssh -T git@github.com
```

## 3. 最後にコミット

```bash
git init
git add .
git commit -m "初回コミット"
git push origin main
```