# Java関係の操作

Ubuntu環境内にJDKとMavenをインストールする。
バージョンは以下とする。
- JDK：17
- Maven：任意

```bash
# 全体更新
sudo apt update -y

# 個別インストール
sudo apt install -y maven
sudo apt install -y openjdk-17-jdk
sudo update-alternatives --config java

# バージョン確認
maven -version
java -version
```