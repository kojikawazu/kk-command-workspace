# WSLコマンド州

[一覧]
wsl --list --all
wsl --list --verbose

[既定を変える]
wsl -s NextLaravel

[start]
wsl -d NextLaravel

[stop]
wsl --terminate  Ubuntu

[ディストリビューション削除]
wsl --unregister NextLaravel

[エクスポート]
wsl --export Ubuntu C:\Users\[ユーザー名]\Desktop\ubuntu_temp.tar

[インポート]
wsl --import NextLaravel "C:\Users\[ユーザー名]\Desktop\folder\workspace\workspace(Docker)\NextLaravelContainer" C:\Users\[ユーザー名]\Desktop\ubuntu_temp.tar
