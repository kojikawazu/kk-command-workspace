# Ollama セットアップガイド (macOS)

ローカルのオープンモデルでLLMを動かすための手順です。

## 前提条件

- macOS Sonoma (v14) 以降
- Apple Silicon (M1/M2/M3/M4) または Intel Mac
- RAM: 最低8GB（16GB以上推奨）
- ストレージ: モデルによって数GB〜数十GB必要

## 1. Ollamaのインストール

### Homebrew（推奨）

```bash
brew install ollama
```

### インストール確認

```bash
ollama --version
```

## 2. モデルのダウンロード

Claude Code用の推奨モデルをダウンロードします。

```bash
# 推奨モデル（いずれかを選択）
ollama pull qwen3-coder      # コーディング特化
ollama pull glm-4.7          # 汎用
ollama pull gpt-oss:20b      # 中規模
ollama pull gpt-oss:120b     # 大規模（要スペック）
```

### モデル管理コマンド

```bash
# ダウンロード済みモデル一覧
ollama list

# モデルの削除
ollama rm 
```

## 3. 動作確認

```bash
# サーバー確認
curl http://localhost:11434

# チャットテスト
ollama run qwen3-coder  "Hello"
```

## 参考リンク

- [Ollama公式サイト](https://ollama.com)