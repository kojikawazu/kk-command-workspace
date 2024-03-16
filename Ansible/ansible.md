# Ansible

## 構築方法

```bash
# ansibleのインストール
sudo yum install -y ansible
# ansibleのバージョン確認
ansible --version
```

## 秘密鍵

```bash
# 鍵の生成
ssh-keygen -t ed25519 -C "[GitHubに登録したメールアドレス]" -f ~/.ssh/[鍵名]

# master(Ansibleインストール)側の設定
# 秘密鍵を書き込み
vi ec2-key.pem
# 秘密鍵の設定
chmod 400 ec2-key.pem
# ssh-agent起動
ssh-agent bash
# ssh-agentに秘密鍵を登録
ssh-add ~/.ssh/[秘密鍵]
```

## インベントリファイル

```:inventory.txt
[ホストグループ名]
[ホスト名1] ansible_host=[PC1のIPアドレス] ansible_connection=ssh ansible_user=[sshログインユーザー]
[ホスト名2] ansible_host=[PC2のIPアドレス] ansible_connection=ssh ansible_user=[sshログインユーザー]
```

## Playbook実行

```bash
# Playbook実行
# install_nginx.yaml(Playbook設定ファイル)で実行
ansible-playbook -i inventory.txt install_nginx.yaml -v
```

# URL

https://docs.ansible.com/ansible/2.9/modules/list_of_commands_modules.html

https://docs.ansible.com/ansible/2.9/modules/service_module.html#service-module
