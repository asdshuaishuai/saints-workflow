# Saints Workflow (V3.1)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**Languages**: [中文](README.md) | [English](README_EN.md) | [日本語](README_JA.md)

> *Chaos begins, heaven and earth are dark. Primordial saints show their divine powers.*

A Claude Code plugin based on Chinese mythology "Investiture of the Gods" (Fengshen Bang) - Intelligent Development Collaboration System

---

## V3.1 · Lingtai Fangcun (Current)

- **Self-Reflection**: Introduced self-reflection mechanism to ensure output quality before delivery.
- **Dynamic Routing**: Automatically match the most suitable saint based on task complexity.
- **Context Enhancement**: Optimized long context management for precise causal tracking.
- **Architecture Optimization**: Deeply adapted to Claude 3.5/4 features for better performance.

## V3.0 · Great Primordial Era

- **Great Formations**: 5 major formations (Liangyi, Wanxian, Zhuxian, etc.) for different stages.
- **Innate Treasures**: Development tools transformed into powerful artifacts (Hunyuan Jindou, etc.).
- **Investiture Lists**: Merit, Reincarnation, and Karma lists for comprehensive tracking.
- **Four Saints Deliberation**: Collaborative decision-making for critical architectural choices.
- **Heavenly Dao Judgment**: Final decision in case of deadlock.

---

## Overview

Saints Workflow is a complete Claude Code plugin featuring a multi-phase development process:

```
[1] Planning → [2] Breakdown → [3] Development → [4] Testing → [5] Review → [6] Confirmation → [7] Enhancement
```

### Core Features

- **Heavenly Dao Monitoring**: Automatic intervention every 3 minutes to correct deviations
- **Automatic Completion**: Heavenly Dao monitoring ends automatically when tasks complete
- **Dynamic Model Allocation**: Automatically selects models based on task complexity (opus/sonnet/haiku)
- **Parallel Task Detection**: Automatically identifies tasks that can run in parallel
- **Intelligent Process Simplification**: Simple tasks skip unnecessary phases
- **Multi-language Support**: Supports 10+ programming languages + WebSearch for dynamic learning
- **Mythological Dialogue**: Conversations styled after Fengshen Bang mythology

---

## Saints System (Fengshen Bang Lore)

```
                    ┌──────────────┐
                    │ Taiqing Sage │
                    │   (Laozi)    │
                    │  model: opus │
                    └──────┬───────┘
                           │
                           ▼
                ┌─────────────────┐
                │ Taiji Diagram   │
                    │ + Fuxi      │
                │ haiku + sonnet  │
                └────────┬────────┘
                           │
            ┌──────────────┼──────────────┐
            │              │              │
            ▼              ▼              ▼
      ┌──────────┐  ┌──────────┐  ┌──────────┐
      │ Tongtian │  │ Yuanshi  │  │   ...    │
      │  (Jie)   │  │  (Chan)  │  │          │
      │  opus    │  │  sonnet  │  │          │
      └────┬─────┘  └────┬─────┘  └──────────┘
           │             │
           └──────┬──────┘
                  │
                  ▼
           ┌──────────┐
           │  Nuwa    │
           │ (Mending)│
           │  haiku   │
           └────┬─────┘
                │
                ▼
           ┌──────────┐
           │  Zhunti  │
           │ (Western)│
           │  opus    │
           └────┬─────┘
                │
                ▼
           ┌──────────┐
           │  User    │
           │Confirm   │
           └──────────┘
```

---

## Saints and Model Assignment

| Saint | Identity | Role | Phase | Model |
|-------|----------|------|:-----:|:-----:|
| Taiqing Sage | Laozi/Daoist Sage | Coordination | [1] | **opus** |
| Taiji Diagram | Taiqing Artifact | Atomic Breakdown | [2] | **haiku** |
| Fuxi | Human Emperor | Enhancement | [2][7] | sonnet |
| Yuanshi Tianzun | Chan Leader | Development | [3] | sonnet |
| Tongtian Jiaozhu | Jie Leader | Architecture | [3] | **opus** |
| Nuwa | Mother Earth | Testing | [4] | **haiku** |
| Zhunti | Western Sage | Code Review | [5] | **opus** |
| Heavenly Dao | Formless | Monitoring | - | sonnet |

---

## Heavenly Dao Monitoring (V1.2)

### Activation

When a task starts, Heavenly Dao monitoring is automatically activated:

```
CronCreate(cron: "*/3 * * * *", prompt: "/saints-workflow:tiandao", recurring: true)
```

### Interventions

Every 3 minutes, Heavenly Dao descends to monitor the saints:

| Detection | Trigger | Intervention |
|-----------|---------|--------------|
| Idleness | Stalled > 5 min | Thunder催促 |
| Loop | Repeated > 3 times | Break the cycle |
| Confusion | Hesitated > 2 times | Divine guidance |

### Completion

When tasks complete, Heavenly Dao automatically withdraws:

```
CronDelete(job_id: {token})
```

---

## Installation

### Method 1: Local Plugin Installation (Recommended)

Install directly to the local cache directory without marketplace configuration.

**Step 1: Clone to local cache**

```bash
mkdir -p ~/.claude/plugins/cache/local/saints-workflow
git clone https://github.com/asdshuaishuai/saints-workflow.git \
  ~/.claude/plugins/cache/local/saints-workflow/1.2.0
```

**Step 2: Register the plugin**

Edit `~/.claude/plugins/installed_plugins.json`:

```json
{
  "version": 2,
  "plugins": {
    "saints-workflow@saints-workflow-local": [
      {
        "scope": "user",
        "installPath": "/home/YOUR_USERNAME/.claude/plugins/cache/local/saints-workflow/1.2.0",
        "version": "1.2.0",
        "installedAt": "2026-03-19T00:00:00.000Z",
        "lastUpdated": "2026-03-19T00:00:00.000Z"
      }
    ]
  }
}
```

**Step 3: Enable the plugin**

Edit `~/.claude/settings.json`:

```json
{
  "enabledPlugins": {
    "saints-workflow@saints-workflow-local": true
  }
}
```

**Step 4: Restart Claude Code**

```bash
claude
```

### Method 2: Marketplace Installation

**Step 1: Configure marketplace**

Edit `~/.claude/plugins/marketplaces.json`:

```json
[
  {
    "name": "saints-market",
    "url": "https://github.com/asdshuaishuai/saints-workflow.git",
    "type": "git"
  }
]
```

**Step 2: Install**

```bash
/plugin install saints-workflow
```

### Method 3: Development Testing

```bash
git clone https://github.com/asdshuaishuai/saints-workflow.git
claude --plugin-dir ./saints-workflow
```

---

## Usage

### Full Workflow

```
/saints-workflow:saints Implement user login feature
```

### Individual Commands

| Command | Function | Example |
|---------|----------|---------|
| `/saints-workflow:saints` | Full workflow | `/saints-workflow:saints Create login artifact` |
| `/saints-workflow:taiqing` | Planning only | `/saints-workflow:taiqing Analyze requirements` |
| `/saints-workflow:taig` | Atomic breakdown | `/saints-workflow:taig Break down module` |
| `/saints-workflow:fuxi` | Enhancement | `/saints-workflow:fuxi Enhance solution` |
| `/saints-workflow:yuanshi` | Development | `/saints-workflow:yuanshi Implement feature` |
| `/saints-workflow:lingbao` | Architecture | `/saints-workflow:lingbao Design system` |
| `/saints-workflow:nva` | Testing | `/saints-workflow:nva` |
| `/saints-workflow:puti` | Code review | `/saints-workflow:puti` |
| `/saints-workflow:tiandao` | Heavenly Dao | `/saints-workflow:tiandao` |

---

## Directory Structure

```
saints-workflow/
├── .claude-plugin/
│   └── plugin.json          # Plugin manifest
│
├── commands/                 # Slash Commands
│   ├── saints.md            # Main entry
│   ├── taiqing.md           # Planning
│   ├── taig.md              # Breakdown
│   ├── fuxi.md              # Enhancement
│   ├── yuanshi.md           # Development
│   ├── lingbao.md           # Architecture
│   ├── nva.md               # Testing
│   └── puti.md              # Review
│
├── agents/                   # Custom Agents
│   ├── taiqing.md           # Coordinator (Laozi)
│   ├── taig.md              # Atomic (Taiji)
│   ├── fuxi.md              # Enhancer (Fuxi)
│   ├── yuanshi.md           # Developer (Yuanshi)
│   ├── lingbao.md           # Architect (Tongtian)
│   ├── nva.md               # Tester (Nuwa)
│   ├── puti.md              # Reviewer (Zhunti)
│   └── tiandao.md           # Monitor (Heavenly Dao)
│
├── skills/                   # Skills
│   ├── saints/
│   └── tiandao/
│
├── README.md
├── README_EN.md
├── README_JA.md
└── LICENSE
```

---

## Changelog

### v3.1.0 · Lingtai Fangcun (2026-03-25)

- **Self-Reflection**: Logic consistency checks before output to improve code and solution quality.
- **Dynamic Routing**: Intelligent saint scheduling based on task intent recognition.
- **Context Enhancement**: Optimized RAG and long context handling to ensure complex logic is preserved.
- **Architecture Optimization**: Optimized Prompt strategies for professional development scenarios.

### v3.0.0 · Great Primordial Era (2026-03-20)

- **Great Formations**: 5 major formations rotating for different development stages.
- **Innate Treasures**: Development tools transformed into powerful artifacts.
- **Investiture Lists**: Merit, Reincarnation, and Karma lists for tracking.
- **Four Saints Deliberation**: Collaborative decision-making for critical tasks.
- **Heavenly Dao Judgment**: Final decision in case of deadlock.

### v1.2.1 (2026-03-19)

- **Docs**: Improved installation instructions with detailed local setup steps
- **Docs**: Added current environment configuration examples
- **Docs**: Added marketplace configuration instructions
- **Docs**: Added English and Japanese translations

### v1.2.0 (2026-03-19)

- **Added**: 3-minute Heavenly Dao monitoring (CronCreate)
- **Added**: Automatic Heavenly Dao withdrawal on task completion
- **Added**: Mythological dialogue enhancement
- **Improved**: All saints now speak in classical Chinese style
- **Improved**: More automated workflow

### v1.1.0 (2026-03-17)

- **Added**: Team collaboration mode (L3 parallel execution)
- **Added**: Progress feedback at each phase
- **Added**: Frontend testing support (Vite, TypeScript)
- **Improved**: Model allocation strategy
- **Improved**: Eight Trigrams context collection

### v1.0.0 (2026-03-13)

- Initial release
- 8 specialized Agents
- 9 Slash Commands
- Dynamic model allocation (L1/L2/L3)
- Multi-language support

---

## License

[MIT License](LICENSE)