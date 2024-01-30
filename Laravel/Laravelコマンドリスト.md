# Laravelコマンドリスト

## Composerのインストール

```bash
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer; \
chmod +x /usr/local/bin/composer
```

## Laravelのインストール

```bash
# プロジェクトの立ち上げ
composer create-project --prefer-dist laravel/laravel server
cd server
# Breezeのインストール
composer require laravel/breeze --dev
php artisan breeze:install api
```

## 依存関係のインストール

```bash
composer install
```

## サーバーの起動

```bash
php artisan serve --host=0.0.0.0 --port=8000
```

## DBマイグレーション

```bash
# UUIDインストール(IDをわかりにくするパッケージ)
composer require goldspecdigital/laravel-eloquent-uuid:^10.0
# マイグレーションファイルの作成
php artisan make:migration create_reviews_table
# マイグレーション実施
php artisan migrate
# マイグレーションのロールバック
php artisan migrate:rollback

# Seederの作成
php artisan make:seeder ReviewsTableSeeder
php artisan db:seed
```

## キャッシュの削除

```bash
# キャッシュの削除
php artisan cache:clear
# キャッシュの再生成
php artisan config:cache
```

## Controllerの作成

```bash
# Controllerの作成
sail php artisan make:controller RecipeController --resource
```

## Modelの作成

```bash
# Modelの作成
sail php artisan make:model Recipe
sail php artisan make:model Review
sail php artisan make:model Category
sail php artisan make:model Ingredient
sail php artisan make:model Step
```

## パンくずリスト

```bash
# パンくずリスト用パッケージのインストール
sail composer require diglactic/laravel-breadcrumbs
# パンくずリスト作成
sail php artisan vendor:publish --tag=breadcrumbs-config
```