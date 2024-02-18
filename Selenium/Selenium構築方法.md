# Selenium構築方法
---

## 構築方法

```bash
sudo apt update

# 必要なモジュールのインストール
sudo apt install python3-pip unzip zip libnss3
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install -f

# seleniumのインストール
sudo pip3 install selenium
# seleniumの確認
pip3 show selenium

# Linux版chromeのインストール
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install -f

# chrome driverのダウンロード
wget https://chromedriver.storage.googleapis.com/121.0.6167.184/chromedriver_linux64.zip
unzip chromedriver-linux64.zip
cd chromedriver-linux64
sudo mv chromedriver /usr/local/bin/
# コマンド確認
which chromedriver

# chromium-browserのインストール
sudo apt-get install chromium-browser

# レポートモジュールのインストール
sudo pip3 install unittest-xml-reporting
```

## 参考URL
---

https://googlechromelabs.github.io/chrome-for-testing/#stable

https://tutorialsninja.com/demo/