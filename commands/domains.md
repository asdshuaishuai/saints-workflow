---
description: 院子管理 · 维护与查询区域划分
---

# 院子管理 · 区域划分与协调

> 百万教阶，各得其所。院子分明，协作有序。

## 天命

**「$ARGUMENTS」**

## 执行

```
Task(yuanshi, prompt: "【元始听令】院子管理: $ARGUMENTS
当前任务类型可能包括：
- list-domains: 列出所有院子及其负责人
- get-domain [domain_id]: 查询特定院子信息
- assign-atoms [task_id]: 为原子分配院子
- check-dependency [domain1] [domain2]: 检查院子间依赖关系
- validate-coupling [task_id]: 检查原子的跨院子耦合情况
- report-coverage: 生成院子覆盖率报告

请根据命令类型，查询 data/domains.json 中的配置，提供准确的信息。")
```

---

## 支持的子命令

### list-domains
列出所有院子及其基本信息

**输出示例**:
```
身份认证 (auth)
  负责人: @auth-owner
  技术栈: backend, oauth, jwt
  发布周期: week
  
支付结算 (payment)
  负责人: @payment-owner
  技术栈: backend, rpc, lua
  发布周期: sprint
  依赖: auth, db, mq
  
...
```

### get-domain [domain_id]
获取特定院子的详细信息

**示例**: `@yuanshi get-domain auth`

**输出**: 院子的完整配置、可复用组件、联系人等

### assign-atoms [task_id]
根据原子属性智能分配院子

**工作流程**:
1. 读取 `data/atoms_{task_id}.json` 或 `docs/reviews/{task_id}/atoms.json`
2. 按技术栈匹配分配院子
3. 检查跨域依赖，标记为耦合原子
4. 输出分配方案与风险评估

### check-dependency [domain1] [domain2]
检查两个院子间的依赖关系

**输出示例**:
```
auth → payment: 
  依赖类型: service call (contract)
  耦合强度: 2 (中)
  
payment → database:
  依赖类型: data access (write)
  耦合强度: 3 (强)
```

### validate-coupling [task_id]
验证原子的跨院子耦合情况，识别高风险

**输出示例**:
```
高耦合原子:
  A-001 (库存更新): 依赖4个院子 → 需多轮会审
  A-002 (订资调度): 跨pay/inventory/log → 需联合发布

建议:
  - 拆分A-001为L1/L2/L3
  - 为A-002设计兼容层
```

### report-coverage
生成院子覆盖率报告，评估任务分布

**输出**: 
- 各院子的原子数量
- 工作量分布
- 高负载警告

---

院子分明，则众生各得其所。协作有序，则大业易成。

