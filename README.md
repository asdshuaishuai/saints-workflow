# 圣人工作流 (Saints Workflow) V3.1

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**语言 / Languages**: [中文](README.md) | [English](README_EN.md) | [日本語](README_JA.md)

> *混沌初开，天地玄黄。洪荒众圣，各显神通。*

基于洪荒封神演义之 Claude Code 插件 —— 智能开发协作系统

---

## V3.1 · 灵台方寸 (当前版本)

- **圣人自省**：引入自我反思机制，输出前先经"灵台"自省，确保法旨无误
- **乾坤挪移**：动态路由任务，根据因果复杂度自动匹配最适圣人，法力不虚耗
- **掌中乾坤**：上下文增强管理，精准捕捉长程因果，万法不离其宗
- **法力进阶**：深度适配底层模型特性，响应更迅捷，断事更精准

## V3.0 · 洪荒新纪

- **大阵演武**：两仪微尘阵、万仙阵、诛仙阵、九曲黄河阵、十绝阵，五大神阵轮转
- **先天灵宝**：混元金斗、金蛟剪、定海珠、诛仙四剑，开发利器化法宝
- **封神天榜**：功德榜、轮回榜、因果榜，三榜定乾坤
- **四圣合议**：太上、元始、准提、接引，四圣破阵决大事
- **天道裁决**：僵持不下时，天道降法旨，一锤定音

## V2.0 · 阐截争锋

- **阐截对抗**：元始坐镇昆仑，通天坐镇碧游，王对王，将对将
- **西方二圣**：准提执代码之镜，接引执业务之尺，双重把关
- **人皇补天**：伏羲演八卦探幽，女娲炼五石补阙
- **天道轮回**：终归天道，重定乾坤

---

## 概述

圣人工作流是一个完整的 Claude Code 插件，具备多阶段开发流程：

```
[1] 规划 → [2] 分解 → [3] 开发 → [4] 测试 → [5] 审查 → [6] 确认 → [7] 增强
```

### 核心功能

- **天道监控**：每3分钟自动干预纠正偏差
- **自动完成**：任务完成时天道监控自动结束
- **动态模型分配**：根据任务复杂度自动选择模型 (opus/sonnet/haiku)
- **并行任务检测**：自动识别可并行执行的任务
- **智能流程简化**：简单任务跳过不必要的阶段
- **多语言支持**：支持10+编程语言 + WebSearch 动态学习
- **神话对话**：封神演义风格的对话

---

## 圣人系统 (封神演义设定)

```
                    ┌──────────────┐
                    │ 太清圣人     │
                    │   (老子)     │
                    │  model: opus │
                    └──────┬───────┘
                           │
                           ▼
                ┌─────────────────┐
                │   太极图       │
                    │ + 伏羲      │
                │ haiku + sonnet  │
                └────────┬────────┘
                           │
            ┌──────────────┼──────────────┐
            │              │              │
            ▼              ▼              ▼
      ┌──────────┐  ┌──────────┐  ┌──────────┐
      │   通天   │  │   元始   │  │   ...    │
      │  (截教)  │  │  (阐教)  │  │          │
      │  opus    │  │  sonnet  │  │          │
      └────┬─────┘  └────┬─────┘  └──────────┘
           │             │
           └──────┬──────┘
                  │
                  ▼
           ┌──────────┐
           │   女娲   │
           │ (补天)   │
           │  haiku   │
           └────┬─────┘
                │
                ▼
           ┌──────────┐
           │   准提   │
           │ (西方)   │
           │  opus    │
           └────┬─────┘
                │
                ▼
           ┌──────────┐
           │   用户   │
           │ 确认     │
           └──────────┘
```

---

## 圣人与模型分配

| 圣人 | 身份 | 角色 | 阶段 | 模型 |
|-------|----------|------|:-----:|:-----:|
| 太清圣人 | 老子/道教圣人 | 协调 | [1] | **opus** |
| 太极图 | 太清法宝 | 原子分解 | [2] | **haiku** |
| 伏羲 | 人皇 | 增强 | [2][7] | sonnet |
| 元始天尊 | 阐教领袖 | 开发 | [3] | sonnet |
| 通天教主 | 截教领袖 | 架构 | [3] | **opus** |
| 女娲 | 大地之母 | 测试 | [4] | **haiku** |
| 准提 | 西方圣人 | 代码审查 | [5] | **opus** |
| 天道 | 无形 | 监控 | - | sonnet |

---

## 天道监控 (V1.2)

### 激活

任务开始时，天道监控自动激活：

```
CronCreate(cron: "*/3 * * * *", prompt: "/saints-workflow:tiandao", recurring: true)
```

### 干预

每3分钟，天道降临监控众圣：

| 检测 | 触发 | 干预 |
|-----------|---------|--------------|
| 闲置 | 停滞 > 5分钟 | 雷霆催促 |
| 循环 | 重复 > 3次 | 打破循环 |
| 困惑 | 犹豫 > 2次 | 神圣指引 |

### 完成

任务完成时，天道自动撤退：

```
CronDelete(job_id: {token})
```

---

## 安装

### 方法1：本地插件安装 (推荐)

直接安装到本地缓存目录，无需市场配置。

**步骤1：克隆到本地缓存**

```bash
mkdir -p ~/.claude/plugins/cache/local/saints-workflow
git clone https://github.com/asdshuaishuai/saints-workflow.git \
  ~/.claude/plugins/cache/local/saints-workflow/1.2.0
```

**步骤2：注册插件**

编辑 `~/.claude/plugins/installed_plugins.json`：

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

**步骤3：启用插件**

编辑 `~/.claude/settings.json`：

```json
{
  "enabledPlugins": {
    "saints-workflow@saints-workflow-local": true
  }
}
```

**步骤4：重启 Claude Code**

```bash
claude
```

### 方法2：市场安装

**步骤1：配置市场**

编辑 `~/.claude/plugins/marketplaces.json`：

```json
[
  {
    "name": "saints-market",
    "url": "https://github.com/asdshuaishuai/saints-workflow.git",
    "type": "git"
  }
]
```

**步骤2：安装**

```bash
/plugin install saints-workflow
```

### 方法3：开发测试

```bash
git clone https://github.com/asdshuaishuai/saints-workflow.git
claude --plugin-dir ./saints-workflow
```

---

## 使用方法

### 完整工作流

```
/saints-workflow:saints 实现用户登录功能
```

### 单个命令

| 命令 | 功能 | 示例 |
|------|------|------|
| `/saints-workflow:saints` | 完整工作流 | `/saints-workflow:saints 创建登录组件` |
| `/saints-workflow:taiqing` | 仅规划 | `/saints-workflow:taiqing 分析需求` |
| `/saints-workflow:taig` | 原子分解 | `/saints-workflow:taig 分解模块` |
| `/saints-workflow:fuxi` | 增强 | `/saints-workflow:fuxi 优化方案` |
| `/saints-workflow:yuanshi` | 开发 | `/saints-workflow:yuanshi 实现功能` |
| `/saints-workflow:lingbao` | 架构 | `/saints-workflow:lingbao 设计系统` |
| `/saints-workflow:nva` | 测试 | `/saints-workflow:nva` |
| `/saints-workflow:puti` | 代码审查 | `/saints-workflow:puti` |
| `/saints-workflow:tiandao` | 天道 | `/saints-workflow:tiandao` |

---

## 更新日志

### v3.1.0 · 灵台方寸 (2026-03-25)

- **圣人自省**：输出前进行逻辑一致性检查，提升代码和解决方案质量
- **乾坤挪移**：基于任务意图识别的智能圣人调度
- **掌中乾坤**：优化RAG和长上下文处理，确保复杂逻辑得以保留
- **法力进阶**：针对专业开发场景优化Prompt策略

### v3.0.0 · 洪荒新纪 (2026-03-20)

- **大阵演武**：五大神阵轮转，适应不同开发阶段
- **先天灵宝**：开发工具化作强大法宝
- **封神天榜**：功德、轮回、因果榜全面追踪
- **四圣合议**：关键任务的协同决策
- **天道裁决**：僵持时的最终裁决

### v1.2.1 (2026-03-19)

- 天道监控系统完善
- 动态模型分配优化
- 并行任务检测增强

### v1.2.0 (2026-03-18)

- 引入天道监控机制
- 每3分钟自动干预纠正偏差
- 任务完成自动结束监控

### v1.1.0 (2026-03-17)

- 众圣协同，共襄盛举

### v1.0.0 (2026-03-13)

- 混沌初开，圣人出世

---

## 许可证

[MIT License](LICENSE)

---

> *封神榜上留名，功德千秋万代。*
> *阐截争锋未已，天道轮回不止。*
