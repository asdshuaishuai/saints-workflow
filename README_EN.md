# Saints Workflow

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**Languages**: [中文](README.md) | [English](README_EN.md) | [日本語](README_JA.md)

> *In the beginning, chaos. In chaos lies infinite potential. Ten thousand saints show their divine powers.*

A multi-role Claude Agent collaboration system based on Chinese mythology "Investiture of the Gods" (Fengshen Bang) — mapping software development stages to specialized divine roles working in harmony.

---

## Project Highlights

A **creative multi-role Agent system** with distinctive features:

- **20+ Professional Agents** - Complete role hierarchy from requirements analysis to code review
- **5 Core Skills** - Bagua Context Collection, Divine Formations, Investiture Lists, Innate Treasures, Complete Workflow
- **Chan vs Jie Opposition** - Dual-track evaluation with orthodox implementation (Chan) vs innovative proposals (Jie)
- **Western Dual Review** - Code review (Zhunti) + business review (Jieyin) for comprehensive quality assurance
- **Dynamic Task Routing** - Automatically schedules optimal agents based on task complexity

---

## Core Concepts

### Workflow Architecture

```
[1] Requirements    [2] Atomic          [3] Opposing        [4] Testing &
    Analysis           Breakdown          Development        Verification
    ↓                  ↓                  ↓                  ↓
 Taishang         Taiji           Chan vs Jie         Fuxi & Nuwa
    ↓                  ↓                  ↓                  ↓
┌──────────────────────────────────────────────────────┐
│          Western Dual Review (Code + Business)       │
│          Zhunti + Jieyin                            │
└──────────────────────────────────────────────────────┘
```

### Divine Role Distribution

| Group | Saint | Role | Model | Description |
|:-----:|:-----:|------|:----:|-------------|
| Requirements | Taishang | Requirement Control | **opus** | Complexity assessment, requirement understanding |
| Requirements | Taiji | Atomic Breakdown | **haiku** | Decompose requirements into atomic tasks |
| Chan | Yuanshi Tianzun | Orthodox Development | sonnet | Standard, compliant implementation |
| Chan | Guangchengzi et al. | Module Implementation | sonnet | Division of labor among disciples |
| Jie | Tongtian Jiaozhu | Opposition Proposals | **opus** | Innovative alternative solutions |
| Jie | Yunxiao/Qiongxiao/Bixiao | Interface/Business/Frontend | sonnet | Treasure collaboration |
| Jie | Duobao | Core Architecture | **opus** | Complex module breakthrough |
| Testing | Fuxi | Flaw Detection | sonnet | 8-dimensional test design |
| Testing | Nuwa | Defect Repair | haiku | Problem fixing |
| Western | Zhunti | Code Review | **opus** | Code quality, security, performance |
| Western | Jieyin | Business Review | **opus** | Business logic, process verification |

---

## Project Structure

```
.
├── agents/              # 20+ Divine Agent definitions
│   ├── taishang.md      # Taishang Laojun - Requirements analysis & control
│   ├── taig.md          # Taiji - Atomic decomposition
│   ├── yuanshi.md       # Yuanshi Tianzun - Chan orthodox development
│   ├── tongtian.md      # Tongtian Jiaozhu - Jie opposition proposals
│   ├── duobao.md        # Duobao Daoren - Complex modules & architecture
│   ├── puti.md          # Zhunti Daoren - Code review
│   ├── fuxi.md          # Fuxi - Eight trigrams test design
│   ├── wenshu.md        # Wenshu - Cache performance optimization
│   ├── randing.md       # Randing Daoren - Investiture record keeping
│   └── ...              # 15+ other divine roles
│
├── commands/            # Command entry points
│   ├── saints.md        # Complete workflow entry
│   ├── bagua.md         # Eight Trigrams skill
│   └── ...              # Other commands
│
├── skills/              # 5 Core Skills
│   ├── saints/          # Complete Workflow
│   │   └── SKILL.md
│   ├── bagua/           # Eight Trigrams - 8D context collection
│   │   └── SKILL.md
│   ├── zhenfa/          # Divine Formation Demonstration - 5 major formations
│   │   └── SKILL.md
│   ├── fengshen/        # Investiture List - three-tiered task recording
│   │   └── SKILL.md
│   └── fabao/           # Innate Treasures - tool capability mapping
│       └── SKILL.md
│
└── README.md            # Project documentation
```

---

## Usage Guide

### Complete Workflow

```bash
/saints-workflow:saints Implement user login feature
```

Automatically executes:
1. **Taishang** analyzes requirements
2. **Taiji** decomposes into atomic tasks
3. **Chan** proposes orthodox solution, **Jie** proposes innovative alternative
4. **Fuxi** performs 8D flaw detection
5. **Nuwa** fixes found issues
6. **Zhunti** reviews code, **Jieyin** reviews business logic
7. **Heavenly Dao** confirms completion

### Quick Start

```bash
# Use Eight Trigrams to understand project
/bagua

# Try complete workflow
/saints-workflow:saints Develop payment feature
```

---

## Architecture

- **20+ Professional Agents** - Each with clear roles and tools
- **5 Core Skills** - Supporting complete workflow
- **3-Tier Model System**: opus (complex) > sonnet (standard) > haiku (simple)
- **Opposition Mode** - Chan (orthodox) vs Jie (innovative) dual-track design

---

## License

[MIT License](LICENSE)

> *The Way begets one, one begets two, two beget three, three beget ten thousand things.*
