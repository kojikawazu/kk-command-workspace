# NestJS

## nest.js導入

```bash
# インストール
npm i -g @nestjs/cli
# バージョン確認
nest -v
```

## NestJSの構築

```bash
# NestJSの生成
nest new backend

# NestJSの起動
cd backend
npm install
npm run start:dev
```

## モデルの作成

```bash
nest g module items
```

## コントローラーの作成

```bash
nest g controller items --no-spec
```

## サービスの作成

```bash
nest g service items --no-spec
```

## ORMの導入

```bash
npm i --save typeorm @nestjs/typeorm pg
```

## マイグレーション(アイテム)

```bash
# マイグレーションを実行
npm run typeorm:run-migrations
# 新しいマイグレーションを生成
npm run typeorm:generate-migration --name=マイグレーション名
# 空のマイグレーションを作成
npm run typeorm:create-migration --name=マイグレーション名
# 最後に適用されたマイグレーションをロールバック
npm run typeorm:revert-migration

docker network ls
docker network inspect [ネットワークIDまたは名前]
```

## 認証導入

```bash
# 認証導入
nest g module auth
npm i --save bcrypt
npm i --save-dev @types/bcrypt

# 認証コントローラー
nest g controller auth --no-spec
# 認証サービス
nest g service auth --no-spec
```

## マイグレーション(認証ユーザー)

```bash
# マイグレーションの生成
npm run typeorm:generate-migration --name=CreateUser
# マイグレーション実行
npm run typeorm:run-migrations
```

## JWTの導入

```bash
npm i --save @nestjs/jwt @nestjs/passport passport passport-jwt
npm i --save-dev @types/passport-jwt
```

## nest.jsの起動

```bash
npm run start:dev
```

## URL

### nestjs

https://nestjs.com/

### JWT

https://jwt.io/

### jest

https://jestjs.io/

### typeorm v0.3への移行による変更

https://zenn.dev/felipe/articles/typeorm_update

https://zenn.dev/fjsh/articles/nestjs-with-typeorm#%E3%83%90%E3%83%AA%E3%83%87%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E3%82%92%E8%A1%8C%E3%81%86

https://qiita.com/hrkmtsmt/items/70bf78d968880f14c619

https://docs.nestjs.com/techniques/database

https://orkhan.gitbook.io/typeorm/docs/migrations