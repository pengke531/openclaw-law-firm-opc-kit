# 法律OPC系统使用攻略

## 快速开始指南

### 系统概览
法律OPC是一个五层智能代理法律事务所管理系统，专为OpenClaw环境设计。

**五大核心Agent：**
- **A01 Legal Commander** - 总指挥官，最终决策者
- **A02 Finance Agent** - 财务管理专家
- **A03 Case Agent** - 案件处理专家
- **A04 Business & Compliance Agent** - 业务合规专家
- **A05 Quality Monitor** - 质量监控专家

## 安装部署

### 一键安装

**macOS/Linux：**
```bash
git clone https://github.com/pengke531/openclaw-law-firm-opc-kit.git
cd openclaw-law-firm-opc-kit
chmod +x ./install-law-firm.sh
./install-law-firm.sh
```

**Windows：**
```powershell
git clone https://github.com/pengke531/openclaw-law-firm-opc-kit.git
cd openclaw-law-firm-opc-kit
powershell -ExecutionPolicy Bypass -File .\install-law-firm.ps1
```

## 案件处理流程

### 标准案件处理流程
```
客户委托 → A01评估 → A05风险监控 → A03案件分析 → A02财务评估 → A04合规审查 → A01决策 → 执行办理 → A05质量监控
```

### 用户操作示例

**新案件受理：**
```
> @law_main 受理新案件：合同纠纷，涉案金额50万元

A01: 收到案件委托，正在启动案件评估流程...
A05: 风险评估：中等风险，建议谨慎处理
A03: 案件分析：胜诉率70%
A02: 费用评估：律师费5万元
A04: 合规审查：无利益冲突
A01: 批准承接案件
```

## 质量控制

### 质量监控设置
```bash
# 查看质量监控状态
bash workspace/scripts/legal_control.sh status

# 启用严格质量控制
bash workspace/scripts/legal_control.sh quality-strict
```

### 风险管理
- 法律风险评估
- 财务风险控制
- 合规性检查
- 质量评分系统

---

**版本信息**：v2.1.0  
**最后更新**：2026-04-21
