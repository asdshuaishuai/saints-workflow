# 聖人ワークフロー (Saints Workflow)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**言語**: [中文](README.md) | [English](README_EN.md) | [日本語](README_JA.md)

中国神話「封神演義」に基づくClaude Codeプラグイン - インテリジェント開発協力システム

---

## 概要

聖人ワークフローは、7フェーズの開発プロセスを特徴とする完全なClaude Codeプラグインです：

```
[1] 計画 → [2] 分解・強化 → [3] 開発 → [4] テスト → [5] レビュー → [6] 確認 → [7] 強化・修正
```

### 主な機能

- **天道による監視**: 3分ごとに自動介入し、逸脱を修正
- **自動完了**: タスク完了時、天道監視を自動終了
- **動的モデル割り当て**: タスク複雑度に応じてモデルを自動選択 (opus/sonnet/haiku)
- **並列タスク検出**: 並列実行可能なタスクを自動識別
- **インテリジェントプロセス簡素化**: 単純なタスクは不要なフェーズをスキップ
- **多言語サポート**: 10以上のプログラミング言語 + WebSearchによる動的学習
- **神話的対話**: 封神演義スタイルの会話

---

## 聖人システム (封神演義の設定)

```
                    ┌──────────────┐
                    │  太清天尊    │
                    │  (老子)      │
                    │  model: opus │
                    └──────┬───────┘
                           │
                           ▼
                ┌─────────────────┐
                │ 太極図 (法宝)   │
                │ + 伏羲 (人皇)   │
                │ haiku + sonnet  │
                └────────┬────────┘
                           │
            ┌──────────────┼──────────────┐
            │              │              │
            ▼              ▼              ▼
      ┌──────────┐  ┌──────────┐  ┌──────────┐
      │通天教主   │  │元始天尊   │  │   ...    │
      │ (截教)   │  │ (闡教)   │  │          │
      │  opus    │  │  sonnet  │  │          │
      └────┬─────┘  └────┬─────┘  └──────────┘
           │             │
           └──────┬──────┘
                  │
                  ▼
           ┌──────────┐
           │  女媧    │
           │ (補天)   │
           │  haiku   │
           └────┬─────┘
                │
                ▼
           ┌──────────┐
           │ 準提道人  │
           │ (西方教)  │
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

## 聖人一覧とモデル割り当て

| 聖人 | 封神演義の身分 | 役割 | フェーズ | モデル |
|------|---------------|------|:--------:|:------:|
| 太清天尊 | 老子/道徳天尊 | 調整 | [1] | **opus** |
| 太極図 | 太清法宝 | 原子分解 | [2] | **haiku** |
| 伏羲氏 | 人皇/三皇の首 | 強化 | [2][7] | sonnet |
| 元始天尊 | 闡教教主 | 開発 | [3] | sonnet |
| 通天教主 | 截教教主 | アーキテクチャ | [3] | **opus** |
| 女媧娘娘 | 大地の母 | テスト | [4] | **haiku** |
| 準提道人 | 西方教聖人 | コードレビュー | [5] | **opus** |
| 天道 | 形なし | 監視 | - | sonnet |

---

## 天道による監視 (V1.2)

### 起動

タスク開始時、天道監視が自動的に起動します：

```
CronCreate(cron: "*/3 * * * *", prompt: "/saints-workflow:tiandao", recurring: true)
```

### 介入

3分ごとに天道が降臨し、聖人たちを監視します：

| 検出項目 | トリガー | 介入 |
|----------|----------|------|
| 怠惰 | 5分以上停滞 | 雷による督促 |
| ループ | 3回以上繰り返し | サイクルを断つ |
| 混乱 | 2回以上躊躇 | 天音による導き |

### 完了

タスク完了時、天道は自動的に退場します：

```
CronDelete(job_id: {トークン})
```

---

## インストール

### 方法1: ローカルプラグインインストール（推奨）

マーケットプレースを設定せず、ローカルキャッシュディレクトリに直接インストールします。

**ステップ1: ローカルキャッシュにクローン**

```bash
mkdir -p ~/.claude/plugins/cache/local/saints-workflow
git clone https://github.com/asdshuaishuai/saints-workflow.git \
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
    "url": "https://github.com/asdshuaishuai/saints-workflow.git",
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
git clone https://github.com/asdshuaishuai/saints-workflow.git
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
| `/saints-workflow:saints` | フルワークフロー | `/saints-workflow:saints ログイン法宝を錬成` |
| `/saints-workflow:taiqing` | 計画のみ | `/saints-workflow:taiqing 卦象推演` |
| `/saints-workflow:taig` | 原子分解 | `/saints-workflow:taig 混沌を解体` |
| `/saints-workflow:fuxi` | 強化 | `/saints-workflow:fuxi 八卦演算` |
| `/saints-workflow:yuanshi` | 開発 | `/saints-workflow:yuanshi 開天闢地` |
| `/saints-workflow:lingbao` | アーキテクチャ | `/saints-workflow:lingbao 万仙布陣` |
| `/saints-workflow:nva` | テスト | `/saints-workflow:nva` |
| `/saints-workflow:puti` | コードレビュー | `/saints-workflow:puti` |
| `/saints-workflow:tiandao` | 天道降臨 | `/saints-workflow:tiandao` |

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
│   ├── fuxi.md              # 強化
│   ├── yuanshi.md           # 開発
│   ├── lingbao.md           # アーキテクチャ
│   ├── nva.md               # テスト
│   └── puti.md              # レビュー
│
├── agents/                   # カスタムエージェント
│   ├── taiqing.md           # 調整者 (老子)
│   ├── taig.md              # 原子化 (太極図)
│   ├── fuxi.md              # 強化者 (伏羲)
│   ├── yuanshi.md           # 開発者 (元始天尊)
│   ├── lingbao.md           # 設計者 (通天教主)
│   ├── nva.md               # テスター (女媧)
│   ├── puti.md              # レビューアー (準提道人)
│   └── tiandao.md           # 監視者 (天道)
│
├── skills/                   # スキル
│   ├── saints/
│   └── tiandao/
│
├── README.md
├── README_EN.md
├── README_JA.md
└── LICENSE
```

---

## 更新履歴

### v1.2.1 (2026-03-19)

- **ドキュメント**: インストール手順を詳細に改善
- **ドキュメント**: 現在の環境設定例を追加
- **ドキュメント**: マーケットプレース設定方法を追加
- **ドキュメント**: 英語・日本語翻訳を追加

### v1.2.0 (2026-03-19)

- **追加**: 3分間隔の天道監視 (CronCreate)
- **追加**: タスク完了時の天道自動退場
- **追加**: 神話的対話の強化
- **改善**: 全聖人の古風な話し方
- **改善**: より自動化されたワークフロー

### v1.1.0 (2026-03-17)

- **追加**: チーム協力モード (L3 並列実行)
- **追加**: 各フェーズでの進捗フィードバック
- **追加**: フロントエンドテストサポート (Vite, TypeScript)
- **改善**: モデル割り当て戦略
- **改善**: 八卦コンテキスト収集

### v1.0.0 (2026-03-13)

- 初期リリース
- 8つの専門エージェント
- 9つのスラッシュコマンド
- 動的モデル割り当て (L1/L2/L3)
- 多言語サポート

---

## ライセンス

[MIT License](LICENSE)