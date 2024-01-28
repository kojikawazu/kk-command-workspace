# Terraformのインストールマニュアル

Ubuntu環境上で以下コマンドを実行する

```bash
# リポジトリのGPGキーを追加
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
# HashiCorpのリポジトリを追加
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
# パッケージリストの更新
sudo apt-get update
# Packerのインストール
sudo apt-get install packer
# インストールの確認
packer -version
```