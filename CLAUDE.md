# コマンドワークスペース

技術ナレッジ・調査メモ・コーディング規約を蓄積するドキュメントワークスペース。資料のインデックスは `readme.md` を参照。

## ディレクトリ構造

ドキュメントは **2 階層**（親グループ / カテゴリ）で配置します。親グループは `Languages/` `Frameworks/` `Database/` `Cloud-Infra/` `Architecture/` `AI/` `Process/`、および単独トップの `CodingRule/` `URL/`。各親グループ直下には概要を記した `README.md` を置きます。詳細な配置規約は `.claude/rules/documentation.md` を参照。

## 索引の維持

`readme.md` の索引は `scripts/gen-index.sh` で自動生成しています（親グループ `##` / カテゴリ `###` の 2 レベル。親 README の先頭行をカテゴリ説明として転記）。ドキュメントを追加・削除・移動したら `bash scripts/gen-index.sh` を実行して索引を再生成してください（索引部分は手編集しない）。

## Rules

明示的な指示がなくても、`.claude/rules/` 内のルールを常に守ってください。

| ファイル | スコープ | 内容 |
|---------|---------|------|
| shortcuts.md | 全体 | 指示ショートカット（PR出して、PR承認しました 等） |
| workflow.md | 全体 | 開発フロー（ブランチ運用） |
| documentation.md | 全体 | ドキュメント更新ルール |
| git.md | 全体 | GitHub Flow・ブランチ命名・push 禁止物 |
