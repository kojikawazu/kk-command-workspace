# ConoHa

# ConoHa

TODO

# サーバー側設定

## sshdの設定変更

以下ファイルを変更し、sshDの設定を変更する。
・ポート番号の変更。(なるべく22以外を使用する。)
・rootユーザーはログイン不可を推奨する。
・パスワードログインを拒否する。(鍵認証のみのログインにする。)

```bash
# /etc/ssh/sshd_config

Port 16
#PermitRootLogin yes
#PasswordAuthentication yes
```

sshdサービスの再起動を行う。
rootユーザー以外であれば、sudoを先頭に追加し、実行する。

```bash
systemctl restart sshd
systemctl status sshd
```

# ファイアーウォールの変更

ファイアーウォールのインバウンドルールの変更を行う。

```bash
# ［サーバ上のadminで］ファイアウォールの現状確認
sudo ufw status verbose
# ［サーバ上のadminで］ルールを番号で表示
sudo ufw status numbered
# ［サーバ上のadminで］既存ルールを削除
sudo ufw delete 2
sudo ufw delete 1
# ［サーバ上のadminで］12345/tcp を許可
sudo ufw allow 12345/tcp
# ［サーバ上のadminで］ファイアウォールのデフォルトをdenyに
sudo ufw default deny
# ［サーバ上のadminで］ファイアウォールの現状確認
sudo ufw status verbose
```

# ConoHa画面側の設定

1. セキュリティグループを作成する
2. サーバーにセキュリティグループをアタッチする。

※ 詳細はTODO