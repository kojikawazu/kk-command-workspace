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

# ファイルパス -> 説明文（先頭の非見出し・非空・非コメント段落 1 行）
desc() {
  awk '
    /^[[:space:]]*$/   { next }   # 空行
    /^#/               { next }   # 見出し
    /^<!--/            { next }   # HTML コメント
    /^---[[:space:]]*$/{ next }   # frontmatter 区切り
    { sub(/^[[:space:]]+/, ""); sub(/[[:space:]]+$/, ""); print; exit }
  ' "$1" 2>/dev/null
}

# ディレクトリ配下の md を列挙（README.md 除く）。$2="self" なら直下のみ、それ以外は再帰
list_files() {
  local dir="$1" depth=""
  [ "${2:-}" = "self" ] && depth="-maxdepth 1"
  find "$dir" $depth -type f -name '*.md' ! -name 'README.md' \
    | LC_ALL=C sort | while IFS= read -r f; do
    printf -- '- [%s](./%s)\n' "$(label "$f")" "$f"
  done
}

# 配下に（README.md 以外の）md があれば真
has_md() {
  find "$1" -type f -name '*.md' ! -name 'README.md' -print -quit 2>/dev/null | grep -q .
}

# 索引本体を生成（2 レベル: 親 ## / 子 ###）
gen() {
  printf '%s\n\n' "$START"
  for dir in */; do
    dir="${dir%/}"
    case " $EXCLUDE " in *" $dir "*) continue ;; esac
    has_md "$dir" || continue
    printf '## %s\n\n' "$dir"

    # 親カテゴリの説明文（README.md の先頭段落）
    if [ -f "$dir/README.md" ]; then
      d="$(desc "$dir/README.md")"
      [ -n "$d" ] && printf '%s\n\n' "$d"
    fi

    # 親ディレクトリ直下のファイル（単独トップ: CodingRule / URL 等）
    direct="$(list_files "$dir" self)"
    [ -n "$direct" ] && printf '%s\n\n' "$direct"

    # 子カテゴリ（サブディレクトリ）を再帰列挙
    find "$dir" -mindepth 1 -maxdepth 1 -type d | LC_ALL=C sort | while IFS= read -r sub; do
      has_md "$sub" || continue
      printf '### %s\n\n' "$(basename "$sub")"
      list_files "$sub"
      printf '\n'
    done
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
