# Enterprise Workflow

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**Languages**: [中文](README.md) | [English](README_EN.md) | [日本語](README_JA.md)

A Claude Code plugin for enterprise development collaboration - Integrated Product, Development, Testing, and Review System

---

## Overview

Enterprise Workflow is a complete Claude Code plugin featuring a 7-phase development process:

```
[1] Planning → [2] Breakdown & Enhancement → [3] Development → [4] Testing → [5] Review → [6] Confirmation → [7] Enhancement & Fix
```

### Core Features

- **Scheduled Process Monitoring**: Automatic checks every 2 minutes with intervention
- **Automatic Completion**: Monitoring ends automatically when tasks complete
- **Dynamic Model Allocation**: Automatically selects models based on task complexity (opus/sonnet/haiku)
- **Parallel Task Detection**: Automatically identifies tasks that can run in parallel
- **Intelligent Process Simplification**: Simple tasks skip unnecessary phases
- **Multi-language Support**: Supports 10+ programming languages + WebSearch for dynamic learning
- **Enterprise Terminology**: Standard product-development-testing-review terminology

---

## Organization Structure

```
                    ┌──────────────┐
                    │Project Manager│
                    │ (Coordination)│
                    │  model: opus │
                    └──────┬───────┘
                           │
                           ▼
                ┌─────────────────┐
                │Task Breakdown   │
                │+ Business Analyst│
                │ haiku + sonnet  │
                └────────┬────────┘
                           │
            ┌──────────────┼──────────────┐
            │              │              │
            ▼              ▼              ▼
      ┌──────────┐  ┌──────────┐  ┌──────────┐
      │Architect │  │ Developer│  │   ...    │
      │(Tech)    │  │(Core)    │  │          │
      │  opus    │  │  sonnet  │  │          │
      └────┬─────┘  └────┬─────┘  └──────────┘
           │             │
           └──────┬──────┘
                  │
                  ▼
           ┌──────────┐
           │   QA     │
           │ Engineer │
           │  haiku   │
           └────┬─────┘
                │
                ▼
           ┌──────────┐
           │  Code    │
           │ Reviewer │
           │  opus    │
           └────┬─────┘
                │
                ▼
           ┌──────────┐
           │  User    │
           │ Confirm  │
           └──────────┘
```

---

## Departments and Model Assignment

| Department | Role | Responsibility | Phase | Model |
|------------|------|----------------|:-----:|:-----:|
| Project Manager | Coordination | Overall coordination | [1] | **opus** |
| Task Breakdown | Analysis | Requirement atomization | [2] | **haiku** |
| Business Analyst | Analysis | Solution enhancement | [2][7] | sonnet |
| Developer | Core Dev | Feature development | [3] | sonnet |
| Architect | Tech Lead | Architecture design | [3] | **opus** |
| QA Engineer | Quality | Testing & validation | [4] | **haiku** |
| Code Reviewer | Quality | Code review | [5] | **opus** |
| Process Monitor | Progress | Process monitoring | - | sonnet |

---

## Process Monitoring (V1.2)

### Activation

When a task starts, process monitoring is automatically activated:

```
CronCreate(cron: "*/2 * * * *", prompt: "/saints-workflow:monitor", recurring: true)
```

### Scheduled Checks

Every 2 minutes, the monitor automatically checks progress:

| Detection | Trigger | Intervention |
|-----------|---------|--------------|
| Stalled | No progress > 5 min | Push notification |
| Loop | Repeated > 3 times | Break the cycle |
| Confusion | Hesitated > 2 times | Guidance |

### Completion

When tasks complete, monitoring automatically ends:

```
CronDelete(job_id: {token})
```

---

## Installation

### Method 1: Local Plugin Installation (Recommended)

Install directly to the local cache directory without marketplace configuration.

**Step 1: Clone to local cache**

```bash
# Clone (Enterprise terminology version)
mkdir -p ~/.claude/plugins/cache/local/saints-workflow
git clone -b feature/enterprise-version git@github.com:asdshuaishuai/saints-workflow.git \
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
    "url": "git@github.com:asdshuaishuai/saints-workflow.git",
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
# Clone (Enterprise terminology version)
git clone -b feature/enterprise-version git@github.com:asdshuaishuai/saints-workflow.git
claude --plugin-dir ./saints-workflow
```

---

## Usage

### Full Workflow

```
/saints-workflow:workflow Implement user login feature
```

### Individual Commands

| Command | Function | Example |
|---------|----------|---------|
| `/saints-workflow:workflow` | Full workflow | `/saints-workflow:workflow Implement login` |
| `/saints-workflow:pm` | Planning only | `/saints-workflow:pm Analyze requirements` |
| `/saints-workflow:breakdown` | Task breakdown | `/saints-workflow:breakdown Break down module` |
| `/saints-workflow:analyst` | Analysis | `/saints-workflow:analyst Context collection` |
| `/saints-workflow:dev` | Development | `/saints-workflow:dev Implement feature` |
| `/saints-workflow:architect` | Architecture | `/saints-workflow:architect Design system` |
| `/saints-workflow:qa` | Testing | `/saints-workflow:qa` |
| `/saints-workflow:reviewer` | Code review | `/saints-workflow:reviewer` |
| `/saints-workflow:monitor` | Monitor check | `/saints-workflow:monitor` |

---

## Directory Structure

```
saints-workflow/
├── .claude-plugin/
│   └── plugin.json          # Plugin manifest
│
├── commands/                 # Slash Commands
│   ├── workflow.md          # Main entry
│   ├── pm.md                # Planning
│   ├── breakdown.md         # Breakdown
│   ├── analyst.md           # Analysis
│   ├── dev.md               # Development
│   ├── architect.md         # Architecture
│   ├── qa.md                # Testing
│   └── reviewer.md          # Review
│
├── agents/                   # Custom Agents
│   ├── pm.md                # Project Manager
│   ├── breakdown.md         # Task Breakdown
│   ├── analyst.md           # Business Analyst
│   ├── dev.md               # Developer
│   ├── architect.md         # Architect
│   ├── qa.md                # QA Engineer
│   ├── reviewer.md          # Code Reviewer
│   └── monitor.md           # Process Monitor
│
├── skills/                   # Skills
│   ├── workflow/
│   ├── monitor/
│   └── context/
│
├── README.md
├── README_EN.md
├── README_JA.md
└── LICENSE
```

---

## Changelog

### v1.2.3 (2026-03-20)

- **Refactor**: Enterprise terminology version
- **Docs**: Standard product-development-testing-review descriptions
- **Repo**: Migrated to GitHub

### v1.2.2 (2026-03-19)

- **Docs**: Added English and Japanese translations
- **Docs**: Added language switching links

### v1.2.1 (2026-03-19)

- **Docs**: Improved installation instructions with detailed local setup steps
- **Docs**: Added current environment configuration examples
- **Docs**: Added marketplace configuration instructions

### v1.2.0 (2026-03-19)

- **Added**: 3-minute process monitoring (CronCreate)
- **Added**: Automatic monitoring withdrawal on task completion
- **Added**: Enterprise terminology descriptions
- **Improved**: More automated workflow

### v1.1.0 (2026-03-17)

- **Added**: Team collaboration mode (L3 parallel execution)
- **Added**: Progress feedback at each phase
- **Added**: Frontend testing support (Vite, TypeScript)
- **Improved**: Model allocation strategy
- **Improved**: Context collection enhancement

### v1.0.0 (2026-03-13)

- Initial release
- 8 specialized Agents
- 9 Slash Commands
- Dynamic model allocation (L1/L2/L3)
- Multi-language support

---

## License

[MIT License](LICENSE)
