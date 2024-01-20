# WSLコマンド州

## 一覧

```bash
wsl --list --all
wsl --list --verbose
```

## 既定を変える

```bash
wsl -s NextLaravel
```

## start

```bash
wsl -d NextLaravel
```

## stop

```bash
wsl --terminate  Ubuntu
```

## ディストリビューション削除

```bash
wsl --unregister NextLaravel
```

## エクスポート

```bash
wsl --export Ubuntu C:\Users\[ユーザー名]\Desktop\ubuntu_temp.tar
```

## インポート

```bash
wsl --import NextLaravel "C:\Users\[ユーザー名]\Desktop\folder\workspace\workspace(Docker)\NextLaravelContainer" C:\Users\[ユーザー名]\Desktop\ubuntu_temp.tar
```
