# 已知问题

## 2026-03-13: 本地插件加载失败

### 问题描述
插件在 `installed_plugins.json` 中正确注册，但 `/plugin` 命令显示：
```
Plugin 'saints-workflow' not found in marketplace 'local'
```

### 已尝试的修复
1. 修复 agent 文件命名（去掉 `-agent` 后缀）
2. 修复 Task() 调用中的 agent 名称引用
3. 在 `settings.json` 的 `enabledPlugins` 中添加 `saints-workflow@local: true`
4. 创建 `~/.claude/plugins/marketplaces/local/.claude-plugin/marketplace.json`
5. 创建符号链接到 marketplace plugins 目录

### 当前状态
- `/reload-plugins` 显示: `1 error during load`
- 需要运行 `/doctor` 查看具体错误信息

### 待调查
- [ ] 运行 `/doctor` 检查加载错误详情
- [ ] 检查 hooks 配置是否有问题
- [ ] 检查 skills 目录格式是否正确
- [ ] 对比官方插件的完整目录结构

### 相关文件
- `~/.claude/settings.json` - 全局配置
- `~/.claude/plugins/installed_plugins.json` - 插件注册
- `~/.claude/plugins/marketplaces/local/` - 本地 marketplace
- `~/.claude/plugins/cache/local/saints-workflow/1.0.0/` - 插件缓存
