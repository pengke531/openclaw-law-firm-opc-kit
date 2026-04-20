# 法律OPC系统 - OpenClaw法律事务所Agent包

一键安装即可为您的OpenClaw系统添加专业的法律事务所Agent！

## ⚡ 快速开始

### 🪟 Windows用户

```powershell
# 1. 克隆项目
git clone https://github.com/pengke531/openclaw-law-firm-opc-kit.git
cd openclaw-law-firm-opc-kit

# 2. 运行安装脚本
powershell -ExecutionPolicy Bypass -File .\install-law-opc.ps1
```

### 🍎 macOS/Linux用户

```bash
# 1. 克隆项目
git clone https://github.com/pengke531/openclaw-law-firm-opc-kit.git
cd openclaw-law-firm-opc-kit

# 2. 运行安装脚本
chmod +x install.sh
./install.sh
```

## 🤖 已安装的Agent

- **A01 Legal Commander** - 法律总指挥，负责案件决策和质量管理
- **A02 Finance Agent** - 财务管理专家，负责费用管理和财务风险
- **A03 Case Agent** - 案件处理专家，负责法律分析和文书起草
- **A04 Business Agent** - 业务专家，负责合同审查和合规管理
- **A05 Quality Monitor** - 质量监控专家，负责质量检查和风险预警

## 📋 使用方法

安装完成后重启OpenClaw，然后就可以使用：

```
@law_main 你好
@law_main 处理新案件：合同纠纷
@law_main 审查租赁合同
```

## ⚖️ 专业功能

- 案件管理和进度跟踪
- 合同审查和起草
- 财务管理和费用核算
- 质量监控和风险预警
- 法律研究支持

详细使用指南请查看 [USER_GUIDE.md](USER_GUIDE.md)

## 🔄 卸载

### Windows
```powershell
# 查找备份文件
dir $env:USERPROFILE\.openclaw\openclaw.json.backup-law-*

# 恢复最新备份
cp $env:USERPROFILE\.openclaw\openclaw.json.backup-law-最新时间 $env:USERPROFILE\.openclaw\openclaw.json
```

### macOS/Linux
```bash
# 恢复备份
cp ~/.openclaw/openclaw.json.backup-law-* ~/.openclaw/openclaw.json
```

## 📚 文档

- [USER_GUIDE.md](USER_GUIDE.md) - 完整使用指南
- [FAULT_TOLERANCE.md](FAULT_TOLERANCE.md) - 容错机制说明
- [LEGAL_AGENT_INTERACTION_ANALYSIS.md](LEGAL_AGENT_INTERACTION_ANALYSIS.md) - Agent交互分析

## ⚠️ 重要提醒

本系统仅供辅助法律服务工作，不能替代执业律师的专业判断。

---

**License**: MIT | **Star** ⭐ if you find this useful!
