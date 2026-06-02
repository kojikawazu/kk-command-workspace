# Ollama + Claude Code セットアップガイド (macOS)

ローカルのオープンモデルでClaude Codeを動かすための手順です。

## 前提条件

- ollama.md を元にOllama構築済み。

## 1. Claude Codeとの連携

### 方法A: クイックセットアップ（推奨）

```bash
ollama launch claude
```

設定のみ行う場合：

```bash
ollama launch claude --config
```

### 方法B: 手動セットアップ

#### 環境変数の設定

```bash
export ANTHROPIC_AUTH_TOKEN=ollama
export ANTHROPIC_API_KEY=""
export ANTHROPIC_BASE_URL=http://localhost:11434
```

#### Claude Codeの実行

```bash
claude --model qwen3-coder
```

#### ワンライナーで実行

```bash
ANTHROPIC_AUTH_TOKEN=ollama ANTHROPIC_BASE_URL=http://localhost:11434 ANTHROPIC_API_KEY="" claude --model qwen3-coder
```

### シェル設定に追加（永続化）

`~/.zshrc` または `~/.bashrc` に以下を追加：

```bash
# Ollama + Claude Code 設定
export ANTHROPIC_AUTH_TOKEN=ollama
export ANTHROPIC_API_KEY=""
export ANTHROPIC_BASE_URL=http://localhost:11434
alias claude-local='claude --model qwen3-coder'
```

設定を反映：

```bash
source ~/.zshrc
```

## 4. 動作確認

```bash
# Ollamaサーバーが起動しているか確認
curl http://localhost:11434

# モデルで直接チャット
ollama run qwen3-coder

# Claude Codeで起動
claude --model qwen3-coder
```

## トラブルシューティング

### Ollamaサーバーが起動していない

```bash
ollama serve
```

### コンテキスト長の調整

Claude Codeは大きなコンテキストウィンドウ（最低64kトークン）が必要です。

```bash
# Modelfileでコンテキスト長を指定
ollama create mymodel -f - <<EOF
FROM qwen3-coder
PARAMETER num_ctx 65536
EOF

claude --model mymodel
```

### ポートの変更

デフォルトポート（11434）を変更する場合：

```bash
OLLAMA_HOST=0.0.0.0:8080 ollama serve
export ANTHROPIC_BASE_URL=http://localhost:8080
```

## 参考リンク

- [Ollama + Claude Code ドキュメント](https://docs.ollama.com/integrations/claude-code)
- [Ollamaモデルライブラリ](https://ollama.com/library)
- [コンテキスト長の設定](https://docs.ollama.com/context-length)