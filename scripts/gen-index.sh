#!/usr/bin/env bash
#
# gen-index.sh — readme.md の索引ブロックをディレクトリツリーから自動生成する。
#
# 使い方:
#   bash scripts/gen-index.sh        # リポジトリ内のどこから実行しても可
#
# 仕様:
#   - トップレベルディレクトリを走査し、配下の *.md を再帰収集して索引を生成。
#   - リンクラベルは各ファイルの先頭 H1（"# ...")。H1 が無ければファイル名。
#   - readme.md の <!-- AUTO-INDEX:START --> 〜 <!-- AUTO-INDEX:END --> の間だけ
#     差し替え、マーカー外の手書き部分（タイトル・前書き）は保持する。
#   - 冪等（再実行しても差分は出ない）。
#
set -euo pipefail

cd "$(cd "$(dirname "$0")/.." && pwd)"

README="readme.md"
START="<!-- AUTO-INDEX:START -->"
END="<!-- AUTO-INDEX:END -->"
EXCLUDE=".git .claude scripts private node_modules"

if [ ! -f "$README" ]; then
  echo "error: $README が見つかりません" >&2
  exit 1
fi
if ! grep -qF "$START" "$README" || ! grep -qF "$END" "$README"; then
  echo "error: $README にマーカー ($START / $END) がありません" >&2
  exit 1
fi

# ファイルパス -> 先頭 H1（無ければ basename）
label() {
  local h
  h="$(grep -m1 -E '^#[[:space:]]+' "$1" 2>/dev/null \
    | sed -E 's/^#[[:space:]]+//; s/[[:space:]]+$//')"
  if [ -n "$h" ]; then
    printf '%s' "$h"
  else
    basename "$1"
  fi
}

# 索引本体を生成
gen() {
  printf '%s\n\n' "$START"
  for dir in */; do
    dir="${dir%/}"
    case " $EXCLUDE " in *" $dir "*) continue ;; esac
    # md ファイルが無いディレクトリはスキップ
    find "$dir" -type f -name '*.md' -print -quit | grep -q . || continue
    printf '## %s\n\n' "$dir"
    find "$dir" -type f -name '*.md' | LC_ALL=C sort | while IFS= read -r f; do
      printf -- '- [%s](./%s)\n' "$(label "$f")" "$f"
    done
    printf '\n'
  done
  printf '%s\n' "$END"
}

# マーカー外（前書き / 後書き）を保持して索引部分のみ差し替え
head="$(awk -v s="$START" 'index($0,s){exit} {print}' "$README")"
tail="$(awk -v e="$END" 'f{print} index($0,e){f=1}' "$README")"

{
  printf '%s\n' "$head"
  gen
  [ -n "$tail" ] && printf '%s\n' "$tail"
} > "$README.tmp"
mv "$README.tmp" "$README"

echo "Updated $README index."
