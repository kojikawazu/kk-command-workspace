---
description: ドキュメント更新・設計書管理ルール
globs: 
---

# ドキュメント

- **ドキュメント更新**: 作業が完了したら、ルートドキュメント（CLAUDE.md / readme.md）の更新が必要かどうか確認し、必要であれば更新する。
- **設計書の管理**: タスクごとに設計書を新規作成しない。既存の仕様書ドキュメントに追記・更新する。

## ディレクトリ構造の規約

ドキュメントは **2 階層**（親グループ / カテゴリ）で配置する。

| 親グループ | 対象 |
|-----------|------|
| `Languages/` | プログラミング言語（Java, Go, Python 等） |
| `Frameworks/` | Web フレームワーク・ライブラリ（Next.js, Laravel, GraphQL 等） |
| `Database/` | DB・ORM・BaaS（MySQL, Prisma, Supabase） |
| `Cloud-Infra/` | クラウド・IaC・OS/実行環境（AWS, Terraform, WSL 等） |
| `Architecture/` | 設計・アーキテクチャ・パターン（Design, DesignPattern, SOLID, Other） |
| `AI/` | 生成 AI・LLM・関連ツール（Claude, OpenAI, Ollama, GenAI） |
| `Process/` | 開発プロセス・PM（Agile, PMBOK, GitHub） |
| `CodingRule/` `URL/` | 単独トップ（親グループに属さない） |

- **新規カテゴリの追加**: 適切な親グループ配下にディレクトリを作る。どの親にも属さない場合のみ単独トップとする。
- **親グループ README**: 各親グループ直下に `README.md` を置く。先頭の本文 1 行が索引のカテゴリ説明として自動転記される。
- **ファイル名**: kebab-case に統一する。
- **H1 必須**: 各 `.md` の先頭行は `# 見出し`。索引のリンクラベルに使われる（無いとファイル名や本文中のコメントを誤って拾う）。
- **索引**: `readme.md` の索引は `bash scripts/gen-index.sh` で自動生成。手編集しない。
