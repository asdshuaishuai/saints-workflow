# 圣人工作流 (Saints Workflow)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

基于洪荒神话的 Claude Code 插件 - 智能开发协作系统

---

## 概述

圣人工作流是一个完整的 Claude Code 插件，包含 7 个阶段的开发工作流程：

```
[1] 规划 → [2] 拆分增强 → [3] 开发 → [4] 测试 → [5] 审查 → [6] 确认 → [7] 增强修复
```

### 核心特性

- **动态模型分配**: 根据任务复杂度自动选择模型 (opus/sonnet/haiku)
- **并行任务识别**: 自动识别可并行执行的任务
- **智能流程简化**: 简单任务自动跳过不必要阶段
- **多语言支持**: 支持 10+ 编程语言 + WebSearch 动态学习
- **编辑钩子**: 自动保护关键文件、备份配置、语法验证

---

## 圣人体系

```
                    ┌──────────────┐
                    │   太清天尊    │
                    │   (主控)     │
                    │  model: opus │
                    └──────┬───────┘
                           │
                           ▼
                ┌─────────────────┐
                │ 太极 (原子化)    │
                │ + 伏羲 (增强)    │
                │ haiku + sonnet  │
                └────────┬────────┘
                           │
            ┌──────────────┼──────────────┐
            │              │              │
            ▼              ▼              ▼
      ┌──────────┐  ┌──────────┐  ┌──────────┐
      │ 灵宝天尊  │  │ 元始天尊  │  │   ...    │
      │ (架构)   │  │ (开发)   │  │          │
      │  opus    │  │  sonnet  │  │          │
      └────┬─────┘  └────┬─────┘  └──────────┘
           │             │
           └──────┬──────┘
                  │
                  ▼
           ┌──────────┐
           │  女娲    │
           │ (测试)   │
           │  haiku   │
           └────┬─────┘
                │
                ▼
           ┌──────────┐
           │  菩提    │
           │ (审查)   │
           │  opus    │
           └────┬─────┘
                │
                ▼
           ┌──────────┐
           │ 用户确认  │
           └──────────┘
```

---

## 圣人列表与模型分配

| 圣人 | 角色 | 阶段 | 模型 |
|------|------|:----:|:----:|
| 太清天尊 | 主控协调 | [1] | **opus** |
| 太极 | 需求原子化 | [2] | **haiku** |
| 伏羲 | 方案增强 | [2][7] | sonnet |
| 元始天尊 | 功能开发 | [3] | sonnet |
| 灵宝天尊 | 架构设计 | [3] | **opus** |
| 女娲 | 测试验证 | [4] | **haiku** |
| 菩提 | 代码审查 | [5] | **opus** |
| 天道 | 流程监管 | - | sonnet |

---

## 动态复杂度评估

```yaml
L1-简单任务:
  特征: 单文件、小bug、配置修改
  流程: 直接开发 → 测试 → 完成
  跳过: 太极原子化、伏羲增强
  模型: haiku 为主

L2-中等任务:
  特征: 多文件(2-5)、功能开发
  流程: 完整流程
  模型: 混合使用

L3-复杂任务:
  特征: 架构变更、核心重构、跨模块
  流程: 完整流程 + 灵宝天尊架构设计
  模型: 关键角色使用 opus
```

---

## 安装

### 方法1: 通过市场安装（推荐）

```bash
# 在 Claude Code 中运行
/plugin install https://gitee.com/skyRules/saints-workflow.git
```

### 方法2: 手动安装

```bash
# 克隆到 Claude Code 插件缓存目录
git clone https://gitee.com/skyRules/saints-workflow.git \
  ~/.claude/plugins/cache/local/saints-workflow/1.0.0
```

然后在 `~/.claude/plugins/installed_plugins.json` 中添加：

```json
{
  "plugins": {
    "saints-workflow@local": [
      {
        "scope": "user",
        "installPath": "/home/你的用户名/.claude/plugins/cache/local/saints-workflow/1.0.0",
        "version": "1.0.0"
      }
    ]
  }
}
```

### 方法3: 使用 --plugin-dir 测试

```bash
# 克隆仓库
git clone https://gitee.com/skyRules/saints-workflow.git

# 使用 --plugin-dir 加载
claude --plugin-dir ./saints-workflow
```

---

## 使用方法

> **注意**: 插件命令需要使用命名空间前缀 `saints-workflow:`

### 完整工作流

```
/saints-workflow:saints 实现用户登录功能
```

### 单独调用

| 命令 | 功能 | 示例 |
|------|------|------|
| `/saints-workflow:saints` | 完整工作流 | `/saints-workflow:saints 实现用户登录` |
| `/saints-workflow:taiqing` | 仅规划 | `/saints-workflow:taiqing 分析API设计` |
| `/saints-workflow:taig` | 原子化拆分 | `/saints-workflow:taig 拆分登录模块` |
| `/saints-workflow:fuxi` | 方案增强 | `/saints-workflow:fuxi 增强需求` |
| `/saints-workflow:yuanshi` | 功能开发 | `/saints-workflow:yuanshi 修复登录bug` |
| `/saints-workflow:lingbao` | 架构设计 | `/saints-workflow:lingbao 重构认证模块` |
| `/saints-workflow:nva` | 测试验证 | `/saints-workflow:nva` |
| `/saints-workflow:puti` | 代码审查 | `/saints-workflow:puti` |
| `/saints-workflow:bagua` | 上下文收集 | `/saints-workflow:bagua 用户模块` |

### 重载插件

```
/reload-plugins
```

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
│   ├── puti.md              # 审查
│   └── bagua.md             # 上下文
│
├── agents/                   # 自定义 Agents
│   ├── taiqing.md     # 主控 (opus)
│   ├── taig.md        # 原子化 (haiku)
│   ├── fuxi.md        # 增强 (sonnet)
│   ├── yuanshi.md     # 开发 (sonnet)
│   ├── lingbao.md     # 架构 (opus)
│   ├── nva.md         # 测试 (haiku)
│   ├── puti.md        # 审查 (opus)
│   └── tiandao.md     # 监管 (sonnet)
│
├── skills/                   # Agent Skills
│   └── bagua/
│       └── SKILL.md         # 八卦上下文收集
│
├── hooks/                    # 事件钩子
│   ├── hooks.json           # 钩子配置
│   ├── pre-edit-check.sh    # 编辑前检查
│   └── post-edit-verify.sh  # 编辑后验证
│
├── README.md
└── LICENSE
```

---

## 钩子功能

### pre-edit-check.sh

- 保护关键依赖文件 (go.mod, package.json, Cargo.toml 等 15+ 种)
- 文件锁检测 (防止并发编辑冲突)
- 自动备份配置文件

### post-edit-verify.sh

- 多语言语法检查 (Go, TS, JS, Python, Rust, Java, Ruby, PHP 等 12+ 种)
- 变更历史记录
- 文件大小异常检测
- 测试文件关联提示
- 调试代码检测

---

## 多语言支持

| 组件 | 支持方式 |
|------|---------|
| 女娲 (测试) | 预设 10+ 语言 + WebSearch 动态学习 |
| 伏羲 (增强) | 预设 8+ 语言配置 + 通用模式 |
| 元始 (开发) | 预设 5+ 语言规范 + WebSearch 惯用法 |
| 灵宝 (架构) | 预设 5+ 语言结构 + WebSearch 最佳实践 |
| 菩提 (审查) | 预设 8+ 语言安全模式 + WebSearch 漏洞 |

---

## 开发与贡献

```bash
# 克隆仓库
git clone https://gitee.com/skyRules/saints-workflow.git

# 本地测试
claude --plugin-dir ./saints-workflow

# 查看可用命令
/help
```

---

## 许可证

[MIT License](LICENSE)

---

## 更新日志

### v1.0.0 (2026-03-13)

- 初始版本发布
- 8 个专业化 Agent
- 9 个 Slash Commands
- 动态模型分配 (L1/L2/L3)
- 多语言支持
- 编辑钩子
