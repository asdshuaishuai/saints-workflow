# 圣人工作流 (Saints Workflow) V2.0

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**语言 / Languages**: [中文](README.md) | [English](README_EN.md) | [日本語](README_JA.md)

基于封神榜洪荒神话之 Claude Code 插件 - 智能开发协作系统

---

## V2.0 新特性

- **阐截对抗**：元始天尊 vs 通天教主，王对王，将对将的对抗性开发
- **西方双审**：准提道人（代码审查）+ 接引道人（业务审查）双重保障
- **测试修复**：伏羲（漏洞探查）+ 女娲（补天修复）闭环
- **天道闭环**：最终反馈天道，重新规划

---

## 组织架构

```
┌─────────────────────────────────────────────────────────────┐
│                        天道 (tiandao)                        │
│                    统筹全局 + 定时监管                        │
└────────────────────────────┬────────────────────────────────┘
                             │
        ┌────────────────────┼────────────────────┐
        │                    │                    │
        ▼                    ▼                    ▼
┌───────────────┐   ┌───────────────┐   ┌───────────────┐
│  需求分析组    │   │  开发执行层    │   │  测试审查组    │
│               │   │               │   │               │
│ 太上老君      │   │  ┌─────┬─────┐ │   │ 伏羲(测试)    │
│   + 太极      │   │  │阐教 │截教 │ │   │ 女娲(修复)    │
└───────┬───────┘   │  │元始 │通天 │ │   │ 准提(代码审)  │
        │           │  │广成 │三霄 │ │   │ 接引(业务审)  │
        │           │  │    │赵公 │ │   └───────┬───────┘
        │           │  │    │多宝 │ │           │
        │           │  └─────┴─────┘ │           │
        │           └───────┬───────┘           │
        │                   │                   │
        └───────────────────┼───────────────────┘
                            │
                            ▼
                    ┌───────────────┐
                    │    天道闭环    │
                    │  重新划分计划  │
                    └───────────────┘
```

---

## 圣人体系

### 1. 天道

| 圣人 | 职责 | 模型 |
|:----:|------|:----:|
| 天道 | 统筹全局 + 定时监管 | sonnet |

### 2. 需求分析组

| 圣人 | 封神榜身份 | 职责 | 模型 |
|:----:|:---------:|------|:----:|
| 太上老君 | 人教教主 | 需求总控 | **opus** |
| 太极图 | 太上法宝 | 需求原子化 | haiku |

### 3. 正面开发组（阐教）

| 圣人 | 封神榜身份 | 职责 | 模型 |
|:----:|:---------:|------|:----:|
| 元始天尊 | 阐教掌教 | 正面开发掌教 | sonnet |
| 广成子 | 十二金仙之首 | 规范开发 | sonnet |
| 赤精子 | 十二金仙 | 后端服务 | sonnet |
| 玉鼎真人 | 十二金仙 | 算法逻辑 | sonnet |
| 太乙真人 | 十二金仙 | 安全认证 | sonnet |
| 黄龙真人 | 十二金仙 | 日志监控 | sonnet |
| 文殊广法天尊 | 十二金仙 | 缓存性能 | sonnet |
| 惧留孙 | 十二金仙 | 消息队列 | sonnet |
| 普贤真人 | 十二金仙 | 分布式系统 | sonnet |
| 慈航道人 | 十二金仙 | API网关 | sonnet |
| 道行天尊 | 十二金仙 | 配置管理 | sonnet |
| 清虚道德真君 | 十二金仙 | 定时任务 | sonnet |
| 灵宝大法师 | 十二金仙 | 文档规范 | sonnet |

### 4. 对抗性开发组（截教）

| 圣人 | 封神榜身份 | 职责 | 模型 |
|:----:|:---------:|------|:----:|
| 通天教主 | 截教掌教 | 对抗开发掌教 | **opus** |
| 云霄娘娘 | 三霄之首 | 接口设计 | sonnet |
| 琼霄娘娘 | 三霄之二 | 业务逻辑 | sonnet |
| 碧霄娘娘 | 三霄之三 | 前端实现 | sonnet |
| 赵公明 | 外门之首 | 数据存储 | **opus** |
| 多宝道人 | 截教大弟子 | 核心架构 | **opus** |

### 5. 测试修复组

| 圣人 | 封神榜身份 | 职责 | 模型 |
|:----:|:---------:|------|:----:|
| 伏羲氏 | 人皇 | 漏洞探查 | sonnet |
| 女娲娘娘 | 大地之母 | 补天修复 | haiku |

### 6. 审查组（西方教）

| 圣人 | 封神榜身份 | 职责 | 模型 |
|:----:|:---------:|------|:----:|
| 准提道人 | 西方二教主 | 代码审查 | **opus** |
| 接引道人 | 西方大教主 | 业务审查 | **opus** |

---

## 阐截对抗机制

### 对抗理念

```
阐教 (元始天尊)          截教 (通天教主)
─────────────────        ─────────────────
规范开发                 激进实现
稳健渐进                 快速突破
遵循架构                 打破常规
保守方案                 创新方案
```

### 王对王，将对将

| 对抗层级 | 阐教 | 截教 |
|:--------:|:----:|:----:|
| 掌教级 | 元始天尊 | 通天教主 |
| 核心架构 | 玉鼎真人/普贤真人 | 多宝道人 |
| 数据层 | 赤精子/惧留孙 | 赵公明 |
| 接口层 | 太乙真人/慈航道人 | 云霄娘娘 |
| 业务层 | 黄龙真人/道行天尊 | 琼霄娘娘 |
| 前端/性能 | 文殊广法天尊/清虚道德真君 | 碧霄娘娘 |
| 规范文档 | 灵宝大法师 | 多宝道人 |

---

## 流程法阵

```
[Phase 1] 太上老君 · 需求分析
     ↓
[Phase 2] 太极图 · 需求原子化
     ↓
[Phase 3] 阐教/截教 · 对抗开发
     ↓
[Phase 4] 伏羲 · 漏洞探查
     ↓
[Phase 5] 女娲 · 补天修复
     ↓
[Phase 6] 西方教 · 双重审查
     ↓
[Phase 7] 天命确认
     ↓
[Phase 8] 天道闭环
```

---

## 安装

### 方法一：本地插件安装

```bash
# 创建目录并克隆
mkdir -p ~/.claude/plugins/cache/local/saints-workflow
git clone https://gitee.com/skyRules/saints-workflow.git \
  ~/.claude/plugins/cache/local/saints-workflow/2.0.0
```

编辑 `~/.claude/plugins/installed_plugins.json`：

```json
{
  "version": 2,
  "plugins": {
    "saints-workflow@saints-workflow-local": [
      {
        "scope": "user",
        "installPath": "/home/你的用户名/.claude/plugins/cache/local/saints-workflow/2.0.0",
        "version": "2.0.0",
        "installedAt": "2026-03-20T00:00:00.000Z",
        "lastUpdated": "2026-03-20T00:00:00.000Z"
      }
    ]
  }
}
```

启用插件 `~/.claude/settings.json`：

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

| 命令 | 功能 |
|------|------|
| `/saints-workflow:saints` | 完整工作流 |
| `/saints-workflow:taishang` | 需求分析 |
| `/saints-workflow:taig` | 需求原子化 |
| `/saints-workflow:yuanshi` | 阐教开发 |
| `/saints-workflow:guangchengzi` | 金仙开发 |
| `/saints-workflow:tongtian` | 截教对抗 |
| `/saints-workflow:yunxiao` | 接口设计 |
| `/saints-workflow:qiongxiao` | 业务逻辑 |
| `/saints-workflow:bixiao` | 前端实现 |
| `/saints-workflow:zhaogongming` | 数据存储 |
| `/saints-workflow:duobao` | 核心架构 |
| `/saints-workflow:fuxi` | 漏洞探查 |
| `/saints-workflow:nva` | 补天修复 |
| `/saints-workflow:puti` | 代码审查 |
| `/saints-workflow:jieyin` | 业务审查 |
| `/saints-workflow:tiandao` | 天道降临 |

---

## 目录结构

```
saints-workflow/
├── .claude-plugin/
│   └── plugin.json          # 插件清单
│
├── commands/                 # Slash Commands
│   ├── saints.md            # 主入口
│   ├── taishang.md          # 需求分析
│   ├── taig.md              # 原子化
│   ├── yuanshi.md           # 阐教掌教
│   ├── guangchengzi.md      # 金仙之首
│   ├── tongtian.md          # 截教掌教
│   ├── yunxiao.md           # 三霄-云霄
│   ├── qiongxiao.md         # 三霄-琼霄
│   ├── bixiao.md            # 三霄-碧霄
│   ├── zhaogongming.md      # 赵公明
│   ├── duobao.md            # 多宝道人
│   ├── fuxi.md              # 漏洞探查
│   ├── nva.md               # 补天修复
│   ├── puti.md              # 代码审查
│   ├── jieyin.md            # 业务审查
│   └── tiandao.md           # 天道
│
├── agents/                   # 自定义 Agents
│   ├── taishang.md          # 太上老君
│   ├── taig.md              # 太极图
│   ├── yuanshi.md           # 元始天尊
│   ├── guangchengzi.md      # 广成子
│   ├── tongtian.md          # 通天教主
│   ├── yunxiao.md           # 云霄娘娘
│   ├── qiongxiao.md         # 琼霄娘娘
│   ├── bixiao.md            # 碧霄娘娘
│   ├── zhaogongming.md      # 赵公明
│   ├── duobao.md            # 多宝道人
│   ├── fuxi.md              # 伏羲氏
│   ├── nva.md               # 女娲娘娘
│   ├── puti.md              # 准提道人
│   ├── jieyin.md            # 接引道人
│   └── tiandao.md           # 天道
│
├── skills/                   # Skills
├── hooks/                    # Hooks
├── README.md
└── LICENSE
```

---

## 更新日志

### v2.0.0 (2026-03-20)

- **架构重构**：引入新的组织架构
- **新增**：阐教/截教对抗性开发机制
- **新增**：西方教双重审查（代码+业务）
- **新增**：测试修复组（伏羲+女娲）
- **新增**：天道闭环机制
- **新增**：8个新 Agent（太上老君、广成子、通天教主、三霄娘娘、赵公明、多宝道人、接引道人）
- **优化**：流程更加清晰，职责更加明确

### v1.2.0 (2026-03-19)

- 新增天道三分钟定时监管
- 新增任务完成自动解除天道
- 洪荒韵味对话增强

### v1.1.0 (2026-03-17)

- 新增 Team 协作模式
- 新增进度反馈

### v1.0.0 (2026-03-13)

- 初始版本发布

---

## 许可证

[MIT License](LICENSE)
