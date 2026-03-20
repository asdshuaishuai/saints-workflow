# エンタープライズワークフロー (Enterprise Workflow)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**言語**: [中文](README.md) | [English](README_EN.md) | [日本語](README_JA.md)

Claude Code向けエンタープライズ開発協力プラグイン - 製品・開発・テスト・レビュー統合システム

---

## 概要

エンタープライズワークフローは、7フェーズの開発プロセスを特徴とする完全なClaude Codeプラグインです：

```
[1] 計画 → [2] 分解・強化 → [3] 開発 → [4] テスト → [5] レビュー → [6] 確認 → [7] 強化・修正
```

### 主な機能

- **定時プロセス監視**: 2分ごとに自動チェック、異常時は介入
- **自動完了**: タスク完了時、監視を自動終了
- **動的モデル割り当て**: タスク複雑度に応じてモデルを自動選択 (opus/sonnet/haiku)
- **並列タスク検出**: 並列実行可能なタスクを自動識別
- **インテリジェントプロセス簡素化**: 単純なタスクは不要なフェーズをスキップ
- **多言語サポート**: 10以上のプログラミング言語 + WebSearchによる動的学習
- **エンタープライズ用語**: 標準的な製品・開発・テスト・レビュー用語

---

## 組織構造

```
                    ┌──────────────┐
                    │ プロジェクト  │
                    │  マネージャー │
                    │  model: opus │
                    └──────┬───────┘
                           │
                           ▼
                ┌─────────────────┐
                │ タスク分解     │
                │+ ビジネスアナリスト│
                │ haiku + sonnet  │
                └────────┬────────┘
                           │
            ┌──────────────┼──────────────┐
            │              │              │
            ▼              ▼              ▼
      ┌──────────┐  ┌──────────┐  ┌──────────┐
      │アーキテクト│  │ 開発者   │  │   ...    │
      │(技術)     │  │(コア)    │  │          │
      │  opus    │  │  sonnet  │  │          │
      └────┬─────┘  └────┬─────┘  └──────────┘
           │             │
           └──────┬──────┘
                  │
                  ▼
           ┌──────────┐
           │   QA     │
           │ エンジニア│
           │  haiku   │
           └────┬─────┘
                │
                ▼
           ┌──────────┐
           │  コード   │
           │ レビューアー│
           │  opus    │
           └────┬─────┘
                │
                ▼
           ┌──────────┐
           │ ユーザー  │
           │  確認    │
           └──────────┘
```

---

## 部門とモデル割り当て

| 部門 | 役割 | 責任 | フェーズ | モデル |
|------|------|------|:--------:|:------:|
| プロジェクトマネージャー | 調整 | 全体調整 | [1] | **opus** |
| タスク分解 | 分析 | 要件の原子化 | [2] | **haiku** |
| ビジネスアナリスト | 分析 | ソリューション強化 | [2][7] | sonnet |
| 開発者 | コア開発 | 機能開発 | [3] | sonnet |
| アーキテクト | 技術リード | アーキテクチャ設計 | [3] | **opus** |
| QAエンジニア | 品質 | テスト・検証 | [4] | **haiku** |
| コードレビューアー | 品質 | コードレビュー | [5] | **opus** |
| プロセス監視 | 進捗 | プロセス監視 | - | sonnet |

---

## プロセス監視 (V1.2)

### 起動

タスク開始時、プロセス監視が自動的に起動します：

```
CronCreate(cron: "*/2 * * * *", prompt: "/saints-workflow:tiandao", recurring: true)
```

### 定時チェック

2分ごとに監視が自動的に進捗をチェックします：

| 検出項目 | トリガー | 介入 |
|----------|----------|------|
| 停滞 | 5分以上進捗なし | プッシュ通知 |
| ループ | 3回以上繰り返し | サイクルを断つ |
| 混乱 | 2回以上躊躇 | ガイダンス |

### 完了

タスク完了時、監視は自動的に終了します：

```
CronDelete(job_id: {トークン})
```

---

## インストール

### 方法1: ローカルプラグインインストール（推奨）

マーケットプレースを設定せず、ローカルキャッシュディレクトリに直接インストールします。

**ステップ1: ローカルキャッシュにクローン**

```bash
# エンタープライズ用語バージョンをクローン
mkdir -p ~/.claude/plugins/cache/local/saints-workflow
git clone -b feature/enterprise-version git@github.com:asdshuaishuai/saints-workflow.git \
  ~/.claude/plugins/cache/local/saints-workflow/1.2.0
```

**ステップ2: プラグインを登録**

`~/.claude/plugins/installed_plugins.json` を編集：

```json
{
  "version": 2,
  "plugins": {
    "saints-workflow@saints-workflow-local": [
      {
        "scope": "user",
        "installPath": "/home/あなたのユーザー名/.claude/plugins/cache/local/saints-workflow/1.2.0",
        "version": "1.2.0",
        "installedAt": "2026-03-19T00:00:00.000Z",
        "lastUpdated": "2026-03-19T00:00:00.000Z"
      }
    ]
  }
}
```

**ステップ3: プラグインを有効化**

`~/.claude/settings.json` を編集：

```json
{
  "enabledPlugins": {
    "saints-workflow@saints-workflow-local": true
  }
}
```

**ステップ4: Claude Codeを再起動**

```bash
claude
```

### 方法2: マーケットプレースからインストール

**ステップ1: マーケットプレースを設定**

`~/.claude/plugins/marketplaces.json` を編集：

```json
[
  {
    "name": "saints-market",
    "url": "git@github.com:asdshuaishuai/saints-workflow.git",
    "type": "git"
  }
]
```

**ステップ2: インストール**

```bash
/plugin install saints-workflow
```

### 方法3: 開発テスト用

```bash
# エンタープライズ用語バージョンをクローン
git clone -b feature/enterprise-version git@github.com:asdshuaishuai/saints-workflow.git
claude --plugin-dir ./saints-workflow
```

---

## 使用方法

### フルワークフロー

```
/saints-workflow:saints ユーザーログイン機能を実装
```

### 個別コマンド

| コマンド | 機能 | 例 |
|----------|------|-----|
| `/saints-workflow:saints` | フルワークフロー | `/saints-workflow:saints ログイン実装` |
| `/saints-workflow:taiqing` | 計画のみ | `/saints-workflow:taiqing 要件分析` |
| `/saints-workflow:taig` | タスク分解 | `/saints-workflow:taig モジュール分解` |
| `/saints-workflow:fuxi` | 分析 | `/saints-workflow:fuxi コンテキスト収集` |
| `/saints-workflow:yuanshi` | 開発 | `/saints-workflow:yuanshi 機能実装` |
| `/saints-workflow:lingbao` | アーキテクチャ | `/saints-workflow:lingbao システム設計` |
| `/saints-workflow:nva` | テスト | `/saints-workflow:nva` |
| `/saints-workflow:puti` | コードレビュー | `/saints-workflow:puti` |
| `/saints-workflow:tiandao` | 監視チェック | `/saints-workflow:tiandao` |

---

## ディレクトリ構成

```
saints-workflow/
├── .claude-plugin/
│   └── plugin.json          # プラグインマニフェスト
│
├── commands/                 # スラッシュコマンド
│   ├── saints.md            # メインエントリ
│   ├── taiqing.md           # 計画
│   ├── taig.md              # 分解
│   ├── fuxi.md              # 分析
│   ├── yuanshi.md           # 開発
│   ├── lingbao.md           # アーキテクチャ
│   ├── nva.md               # テスト
│   └── puti.md              # レビュー
│
├── agents/                   # カスタムエージェント
│   ├── taiqing.md           # プロジェクトマネージャー
│   ├── taig.md              # タスク分解
│   ├── fuxi.md              # ビジネスアナリスト
│   ├── yuanshi.md           # 開発者
│   ├── lingbao.md           # アーキテクト
│   ├── nva.md               # QAエンジニア
│   ├── puti.md              # コードレビューアー
│   └── tiandao.md           # プロセス監視
│
├── skills/                   # スキル
│   ├── saints/
│   ├── tiandao/
│   └── bagua/
│
├── README.md
├── README_EN.md
├── README_JA.md
└── LICENSE
```

---

## 更新履歴

### v1.2.3 (2026-03-20)

- **リファクタリング**: エンタープライズ用語バージョン
- **ドキュメント**: 標準的な製品・開発・テスト・レビュー記述
- **リポジトリ**: GitHubに移行

### v1.2.2 (2026-03-19)

- **ドキュメント**: 英語・日本語翻訳を追加
- **ドキュメント**: 言語切り替えリンクを追加

### v1.2.1 (2026-03-19)

- **ドキュメント**: インストール手順を詳細に改善
- **ドキュメント**: 現在の環境設定例を追加
- **ドキュメント**: マーケットプレース設定方法を追加

### v1.2.0 (2026-03-19)

- **追加**: 3分間隔のプロセス監視 (CronCreate)
- **追加**: タスク完了時の監視自動終了
- **追加**: エンタープライズ用語記述
- **改善**: より自動化されたワークフロー

### v1.1.0 (2026-03-17)

- **追加**: チーム協力モード (L3 並列実行)
- **追加**: 各フェーズでの進捗フィードバック
- **追加**: フロントエンドテストサポート (Vite, TypeScript)
- **改善**: モデル割り当て戦略
- **改善**: コンテキスト収集強化

### v1.0.0 (2026-03-13)

- 初期リリース
- 8つの専門エージェント
- 9つのスラッシュコマンド
- 動的モデル割り当て (L1/L2/L3)
- 多言語サポート

---

## ライセンス

[MIT License](LICENSE)
