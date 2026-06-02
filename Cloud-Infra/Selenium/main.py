from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import time

# サービスの初期化
options = webdriver.ChromeOptions()
options.add_experimental_option('excludeSwitches', ['enable-logging'])
options.add_argument("--no-sandbox")

# chrome driverの初期化
driver = webdriver.Chrome(options=options)

# Google Chromeへアクセス
driver.get('https://www.google.com/')

# 検索タグが取得するまで待機
WebDriverWait(driver, 5).until(
    # 検索タグを取得
    EC.presence_of_element_located((By.NAME, "q"))
)
# 検索タグを取得
input_element = driver.find_element(By.NAME, "q")
# Seleniumと入力し、Enterを押下する
input_element.send_keys("Selenium" + Keys.ENTER)

# Seleniumが設定されるまで待つ
WebDriverWait(driver, 5).until(
    # Seleniumを取得
    EC.presence_of_element_located((By.PARTIAL_LINK_TEXT, "Selenium"))
)
# Seleniumと該当するリンクを取得
link = driver.find_element(By.PARTIAL_LINK_TEXT, "Selenium")
# リンクをクリックする
link.click()

# 10秒待つ
time.sleep(10)
# 閉じる
driver.quit()