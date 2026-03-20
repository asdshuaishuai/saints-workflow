# 企业工作流 (Enterprise Workflow)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**语言 / Languages**: [中文](README.md) | [English](README_EN.md) | [日本語](README_JA.md)

基于 Claude Code 的企业级开发协作插件 - 产研测审一体化智能协作系统

---

## 概述

企业工作流是一个完整的 Claude Code 插件，包含七阶段开发流程：

```
[1] 规划 → [2] 拆分增强 → [3] 开发 → [4] 测试 → [5] 审查 → [6] 确认 → [7] 增强修复
```

### 核心特性

- **定时流程监管**：每两分钟自动检查进度，异常干预
- **任务完成退场**：任务完成后自动解除监管
- **动态模型分配**：根据任务复杂度自动选择模型 (opus/sonnet/haiku)
- **并行任务识别**：自动识别可并行执行的任务
- **智能流程简化**：简单任务自动跳过不必要阶段
- **多语言支持**：支持十数种编程语言 + WebSearch 动态学习
- **企业化术语**：标准企业产研测审术语

---

## 组织架构

```
                    ┌──────────────┐
                    │   项目经理    │
                    │ (流程控制)    │
                    │  model: opus │
                    └──────┬───────┘
                           │
                           ▼
                ┌─────────────────┐
                │ 任务拆分引擎     │
                │ + 需求分析师     │
                │ haiku + sonnet  │
                └────────┬────────┘
                           │
            ┌──────────────┼──────────────┐
            │              │              │
            ▼              ▼              ▼
      ┌──────────┐  ┌──────────┐  ┌──────────┐
      │ 架构师    │  │开发工程师 │  │   ...    │
      │(技术架构) │  │(核心开发) │  │          │
      │  opus    │  │  sonnet  │  │          │
      └────┬─────┘  └────┬─────┘  └──────────┘
           │             │
           └──────┬──────┘
                  │
                  ▼
           ┌──────────┐
           │测试工程师 │
           │(质量保证) │
           │  haiku   │
           └────┬─────┘
                │
                ▼
           ┌──────────┐
           │代码审查   │
           │(质量把关) │
           │  opus    │
           └────┬─────┘
                │
                ▼
           ┌──────────┐
           │ 用户确认  │
           └──────────┘
```

---

## 部门职能与模型分配

| 部门 | 角色 | 职责 | 阶段 | 模型 |
|------|------|------|:----:|:----:|
| 项目经理 | 流程控制 | 统筹协调 | [1] | **opus** |
| 任务拆分 | 需求分析 | 需求原子化 | [2] | **haiku** |
| 需求分析 | 业务分析 | 方案增强 | [2][7] | sonnet |
| 开发工程师 | 核心开发 | 功能开发 | [3] | sonnet |
| 架构师 | 技术架构 | 架构设计 | [3] | **opus** |
| 测试工程师 | 质量保证 | 测试验证 | [4] | **haiku** |
| 代码审查 | 质量把关 | 代码审查 | [5] | **opus** |
| 流程监管 | 进度监控 | 流程监管 | - | sonnet |

---

## 流程监管 (V1.2 新增)

### 开启监管

任务开始时，自动开启流程监管：

```
CronCreate(cron: "*/2 * * * *", prompt: "/saints-workflow:tiandao", recurring: true)
```

### 定时检查

每两分钟，监管器自动检查进度：

| 检测项 | 触发条件 | 干预措施 |
|--------|---------|---------|
| 进度停滞 | 停滞 > 5分钟 | 推进提醒 |
| 重复循环 | 重复 > 3次 | 断开循环 |
| 方向迷茫 | 犹豫 > 2次 | 指引方向 |

### 任务完成

任务完成后，监管器自动退出：

```
CronDelete(job_id: {监管令牌})
```

---

## 安装

### 方法一：本地插件安装（当前环境使用）

此方法无需配置市场，直接将插件安装到本地缓存目录。

**步骤 1：克隆插件到本地缓存**

```bash
# 创建目录并克隆 (企业术语版本)
mkdir -p ~/.claude/plugins/cache/local/saints-workflow
git clone -b feature/enterprise-version git@github.com:asdshuaishuai/saints-workflow.git \
  ~/.claude/plugins/cache/local/saints-workflow/1.2.0
```

**步骤 2：注册插件**

编辑 `~/.claude/plugins/installed_plugins.json`，在 `plugins` 对象中添加：

```json
{
  "version": 2,
  "plugins": {
    "saints-workflow@saints-workflow-local": [
      {
        "scope": "user",
        "installPath": "/home/你的用户名/.claude/plugins/cache/local/saints-workflow/1.2.0",
        "version": "1.2.0",
        "installedAt": "2026-03-19T00:00:00.000Z",
        "lastUpdated": "2026-03-19T00:00:00.000Z"
      }
    ]
  }
}
```

**步骤 3：启用插件**

编辑 `~/.claude/settings.json`，添加到 `enabledPlugins`：

```json
{
  "enabledPlugins": {
    "saints-workflow@saints-workflow-local": true
  }
}
```

**步骤 4：重启 Claude Code**

```bash
# 重新启动 Claude Code 即可使用
claude
```

### 方法二：通过市场安装

**步骤 1：配置插件市场**

编辑 `~/.claude/plugins/marketplaces.json`（如不存在则创建）：

```json
[
  {
    "name": "saints-market",
    "url": "git@github.com:asdshuaishuai/saints-workflow.git",
    "type": "git"
  }
]
```

**步骤 2：安装插件**

```bash
# 在 Claude Code 中运行
/plugin install saints-workflow
```

### 方法三：使用 --plugin-dir 测试（开发调试用）

```bash
# 克隆仓库 (企业术语版本)
git clone -b feature/enterprise-version git@github.com:asdshuaishuai/saints-workflow.git

# 使用指定插件目录启动
claude --plugin-dir ./saints-workflow
```

---

## 当前环境配置示例

以下是本机环境的实际配置，供参考：

**目录结构：**

```
~/.claude/
├── plugins/
│   ├── cache/
│   │   └── local/
│   │       └── saints-workflow/
│   │           └── 1.2.0/          # 插件代码
│   │               ├── .claude-plugin/
│   │               │   └── plugin.json
│   │               ├── agents/
│   │               ├── commands/
│   │               ├── skills/
│   │               └── hooks/
│   └── installed_plugins.json      # 插件注册
└── settings.json                   # 启用配置
```

**installed_plugins.json 片段：**

```json
{
  "version": 2,
  "plugins": {
    "saints-workflow@saints-workflow-local": [
      {
        "scope": "user",
        "installPath": "/home/kelthas/.claude/plugins/cache/local/saints-workflow/1.2.0",
        "version": "1.2.0",
        "installedAt": "2026-03-19T00:00:00.000Z",
        "lastUpdated": "2026-03-19T00:00:00.000Z"
      }
    ]
  }
}
```

**settings.json 片段：**

```json
{
  "enabledPlugins": {
    "saints-workflow@saints-workflow-local": true
  }
}
```

---

## 使用方法

### 完整工作流

```
/saints-workflow:saints 实现用户登录功能
```

### 单独调用

| 命令 | 功能 | 示例 |
|------|------|------|
| `/saints-workflow:saints` | 完整工作流 | `/saints-workflow:saints 实现登录功能` |
| `/saints-workflow:taiqing` | 仅规划 | `/saints-workflow:taiqing 需求分析` |
| `/saints-workflow:taig` | 任务拆分 | `/saints-workflow:taig 拆分需求` |
| `/saints-workflow:fuxi` | 需求分析 | `/saints-workflow:fuxi 上下文收集` |
| `/saints-workflow:yuanshi` | 功能开发 | `/saints-workflow:yuanshi 功能实现` |
| `/saints-workflow:lingbao` | 架构设计 | `/saints-workflow:lingbao 架构设计` |
| `/saints-workflow:nva` | 测试验证 | `/saints-workflow:nva` |
| `/saints-workflow:puti` | 代码审查 | `/saints-workflow:puti` |
| `/saints-workflow:tiandao` | 监管检查 | `/saints-workflow:tiandao` |

---

## 目录结构

```
saints-workflow/
├── .claude-plugin/
│   └── plugin.json          # 插件清单
│
├── commands/                 # Slash Commands
│   ├── saints.md            # 主入口
│   ├── taiqing.md           # 规划
│   ├── taig.md              # 拆分
│   ├── fuxi.md              # 增强
│   ├── yuanshi.md           # 开发
│   ├── lingbao.md           # 架构
│   ├── nva.md               # 测试
│   └── puti.md              # 审查
│
├── agents/                   # 自定义 Agents
│   ├── taiqing.md           # 项目经理
│   ├── taig.md              # 任务拆分
│   ├── fuxi.md              # 需求分析
│   ├── yuanshi.md           # 开发工程师
│   ├── lingbao.md           # 架构师
│   ├── nva.md               # 测试工程师
│   ├── puti.md              # 代码审查
│   └── tiandao.md           # 流程监管
│
├── skills/                   # 技能定义
│   ├── saints/SKILL.md      # 工作流技能
│   ├── tiandao/SKILL.md     # 监管技能
│   └── bagua/SKILL.md       # 上下文分析
│
├── README.md
└── LICENSE
```

---

## 更新日志

### v1.2.3 (2026-03-20)

- **重构**：企业化术语版本
- **文档**：标准产研测审一体化描述
- **仓库**：迁移至 GitHub

### v1.2.2 (2026-03-19)

- **文档**：新增英文版 README_EN.md
- **文档**：新增日文版 README_JA.md
- **文档**：主 README 添加语言切换链接

### v1.2.1 (2026-03-19)

- **文档**：完善安装配置说明，添加本地安装详细步骤
- **文档**：添加当前环境配置示例
- **文档**：添加 market 配置方式说明

### v1.2.0 (2026-03-19)

- **新增**：定时流程监管 (CronCreate)
- **新增**：任务完成自动解除监管 (CronDelete)
- **新增**：企业化术语描述
- **优化**：流程更加自动化

### v1.1.0 (2026-03-17)

- **新增**：Team 协作模式 (L3 复杂任务并行执行)
- **新增**：进度反馈 (每阶段输出状态)
- **新增**：前端测试支持 (Vite, TypeScript)
- **优化**：模型分配策略细化
- **优化**：上下文收集增强

### v1.0.0 (2026-03-13)

- 初始版本发布
- 8 个专业化 Agent
- 9 个 Slash Commands
- 动态模型分配 (L1/L2/L3)
- 多语言支持

---

## 许可证

[MIT License](LICENSE)
