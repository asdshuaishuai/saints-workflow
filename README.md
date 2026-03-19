# 圣人工作流 (Saints Workflow)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

基于封神榜洪荒神话之 Claude Code 插件 - 智能开发协作系统

---

## 概述

圣人工作流乃完整之 Claude Code 插件，含七阶段开发流程：

```
[1] 规划 → [2] 拆分增强 → [3] 开发 → [4] 测试 → [5] 审查 → [6] 确认 → [7] 增强修复
```

### 核心特性

- **天道定时监管**：每三刻自动降临，拨乱反正
- **功德圆满退场**：任务圆满后自动解除天道监管
- **动态模型分配**：依任务复杂度自动择模型 (opus/sonnet/haiku)
- **并行任务识别**：自动识别可并行执行之任务
- **智能流程简化**：简单任务自动跳过不必要阶段
- **多语言支持**：支持十数种编程语言 + WebSearch 动态学习
- **洪荒韵味对话**：封神榜洪荒神话风格对话

---

## 圣人体系 (封神榜设定)

```
                    ┌──────────────┐
                    │   太清天尊    │
                    │   (老子)     │
                    │  model: opus │
                    └──────┬───────┘
                           │
                           ▼
                ┌─────────────────┐
                │ 太极图 (法宝)    │
                │ + 伏羲 (人皇)    │
                │ haiku + sonnet  │
                └────────┬────────┘
                           │
            ┌──────────────┼──────────────┐
            │              │              │
            ▼              ▼              ▼
      ┌──────────┐  ┌──────────┐  ┌──────────┐
      │通天教主   │  │元始天尊   │  │   ...    │
      │ (截教)   │  │ (阐教)   │  │          │
      │  opus    │  │  sonnet  │  │          │
      └────┬─────┘  └────┬─────┘  └──────────┘
           │             │
           └──────┬──────┘
                  │
                  ▼
           ┌──────────┐
           │  女娲    │
           │ (补天)   │
           │  haiku   │
           └────┬─────┘
                │
                ▼
           ┌──────────┐
           │ 准提道人  │
           │ (西方教)  │
           │  opus    │
           └────┬─────┘
                │
                ▼
           ┌──────────┐
           │ 善信确认  │
           └──────────┘
```

---

## 圣人列表与模型分配

| 圣人 | 封神榜身份 | 职责 | 阶段 | 模型 |
|------|-----------|------|:----:|:----:|
| 太清天尊 | 老子/道德天尊 | 主控协调 | [1] | **opus** |
| 太极图 | 太清法宝 | 需求原子化 | [2] | **haiku** |
| 伏羲氏 | 人皇/三皇之首 | 方案增强 | [2][7] | sonnet |
| 元始天尊 | 阐教掌教 | 功能开发 | [3] | sonnet |
| 通天教主 | 截教掌教 | 架构设计 | [3] | **opus** |
| 女娲娘娘 | 大地之母 | 测试验证 | [4] | **haiku** |
| 准提道人 | 西方教圣人 | 代码审查 | [5] | **opus** |
| 天道 | 无形无相 | 流程监管 | - | sonnet |

---

## 天道定时监管 (V1.2 新增)

### 开启天道

任务开始时，自动开启天道法眼：

```
CronCreate(cron: "*/3 * * * *", prompt: "/saints-workflow:tiandao", recurring: true)
```

### 天道降临

每三刻，天道自动降临，监察诸圣：

| 检测项 | 触发条件 | 天罚 |
|--------|---------|------|
| 懈怠之罪 | 停滞 > 5分钟 | 雷罚催促 |
| 轮回之困 | 重复 > 3次 | 斩断轮回 |
| 迷途之惑 | 犹豫 > 2次 | 天音指路 |

### 功德圆满

任务圆满后，天道自动退场：

```
CronDelete(job_id: {天道令牌})
```

---

## 安装

### 方法一：本地插件安装（当前环境使用）

此方法无需配置市场，直接将插件安装到本地缓存目录。

**步骤 1：克隆插件到本地缓存**

```bash
# 创建目录并克隆
mkdir -p ~/.claude/plugins/cache/local/saints-workflow
git clone https://gitee.com/skyRules/saints-workflow.git \
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
    "url": "https://gitee.com/skyRules/saints-workflow.git",
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
# 克隆仓库
git clone https://gitee.com/skyRules/saints-workflow.git

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
| `/saints-workflow:saints` | 完整工作流 | `/saints-workflow:saints 炼制登录法宝` |
| `/saints-workflow:taiqing` | 仅规划 | `/saints-workflow:taiqing 卦象推演` |
| `/saints-workflow:taig` | 原子化拆分 | `/saints-workflow:taig 拆解混沌` |
| `/saints-workflow:fuxi` | 方案增强 | `/saints-workflow:fuxi 八卦演算` |
| `/saints-workflow:yuanshi` | 功能开发 | `/saints-workflow:yuanshi 开天辟地` |
| `/saints-workflow:lingbao` | 架构设计 | `/saints-workflow:lingbao 万仙布阵` |
| `/saints-workflow:nva` | 测试验证 | `/saints-workflow:nva` |
| `/saints-workflow:puti` | 代码审查 | `/saints-workflow:puti` |
| `/saints-workflow:tiandao` | 天道降临 | `/saints-workflow:tiandao` |

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
│   ├── taiqing.md           # 主控 (老子)
│   ├── taig.md              # 原子化 (太极图)
│   ├── fuxi.md              # 增强 (伏羲)
│   ├── yuanshi.md           # 开发 (元始天尊)
│   ├── lingbao.md           # 架构 (通天教主)
│   ├── nva.md               # 测试 (女娲)
│   ├── puti.md              # 审查 (准提道人)
│   └── tiandao.md           # 监管 (天道)
│
├── README.md
└── LICENSE
```

---

## 更新日志

### v1.2.1 (2026-03-19)

- **文档**：完善安装配置说明，添加本地安装详细步骤
- **文档**：添加当前环境配置示例
- **文档**：添加 market 配置方式说明

### v1.2.0 (2026-03-19)

- **新增**：天道三分钟定时监管 (CronCreate)
- **新增**：任务圆满自动解除天道 (CronDelete)
- **新增**：洪荒韵味对话增强 (封神榜设定)
- **优化**：诸圣对话尽皆文言
- **优化**：流程更加自动化

### v1.1.0 (2026-03-17)

- **新增**：Team 协作模式 (L3 复杂任务并行执行)
- **新增**：进度反馈 (每阶段输出状态)
- **新增**：前端测试支持 (Vite, TypeScript)
- **优化**：模型分配策略细化
- **优化**：八卦上下文收集增强

### v1.0.0 (2026-03-13)

- 初始版本发布
- 8 个专业化 Agent
- 9 个 Slash Commands
- 动态模型分配 (L1/L2/L3)
- 多语言支持

---

## 许可证

[MIT License](LICENSE)