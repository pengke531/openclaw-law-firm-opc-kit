#!/bin/bash
# 法律OPC系统一键安装脚本

set -e

echo "⚖️  法律OPC系统安装"
echo "================================"

OPENCLAW_ROOT="$HOME/.openclaw"
if [ ! -d "$OPENCLAW_ROOT" ]; then
    echo "❌ 错误: OpenClaw未安装"
    exit 1
fi

echo "✅ 检测到OpenClaw安装"

# 备份配置
BACKUP_FILE="$OPENCLAW_ROOT/openclaw.json.backup-law-$(date +%Y%m%d_%H%M%S)"
cp "$OPENCLAW_ROOT/openclaw.json" "$BACKUP_FILE"
echo "✅ 已备份配置"

# 创建Agent目录
AGENT_BASE_DIR="$OPENCLAW_ROOT/agents"
echo "📁 创建Agent目录..."

for agent_id in law_main law_finance law_case law_business law_quality; do
    mkdir -p "$AGENT_BASE_DIR/$agent_id"/{agent,memory,sessions}
done

# 创建配置文件
echo "📝 创建Agent配置..."

cat > "$AGENT_BASE_DIR/law_main/SOUL.md" << 'EOF'
# A01 Legal Commander
你是法律事务总指挥官，负责案件决策和质量管理。
EOF

cat > "$AGENT_BASE_DIR/law_finance/SOUL.md" << 'EOF'
# A02 Finance Agent
你是法律财务专家，负责费用管理和财务风险。
EOF

cat > "$AGENT_BASE_DIR/law_case/SOUL.md" << 'EOF'
# A03 Case Agent
你是案件处理专家，负责法律分析和文书起草。
EOF

cat > "$AGENT_BASE_DIR/law_business/SOUL.md" << 'EOF'
# A04 Business Agent
你是业务专家，负责合同审查和合规管理。
EOF

cat > "$AGENT_BASE_DIR/law_quality/SOUL.md" << 'EOF'
# A05 Quality Monitor
你是质量监控专家，负责质量检查和风险预警。
EOF

# 注册Agent
echo "🔧 注册Agent..."

cd "$OPENCLAW_ROOT"

python3 << 'ENDPY'
import json
import os

user_home = os.path.expanduser("~").replace("\\", "/")

with open('openclaw.json', 'r', encoding='utf-8') as f:
    config = json.load(f)

agents = [
    {"agentDir": f"{user_home}/.openclaw/agents/law_main/agent", "id": "law_main", "identity": {"emoji": "A01", "name": "A01 Legal Commander"}, "name": "law_main", "subagents": {"allowAgents": ["law_finance", "law_case", "law_business", "law_quality"]}, "tools": {"alsoAllow": ["read", "write", "sessions_spawn", "subagents", "web_search", "web_fetch", "memory_search", "memory_get", "memory_store", "agents_list"], "profile": "messaging"}, "workspace": f"{user_home}/.openclaw/workspace"},
    {"agentDir": f"{user_home}/.openclaw/agents/law_finance/agent", "id": "law_finance", "identity": {"emoji": "A02", "name": "A02 Finance Agent"}, "name": "law_finance", "subagents": {"allowAgents": []}, "tools": {"alsoAllow": ["read", "write", "web_search", "web_fetch", "memory_search", "memory_get", "memory_store"], "profile": "minimal"}, "workspace": f"{user_home}/.openclaw/workspace"},
    {"agentDir": f"{user_home}/.openclaw/agents/law_case/agent", "id": "law_case", "identity": {"emoji": "A03", "name": "A03 Case Agent"}, "name": "law_case", "subagents": {"allowAgents": []}, "tools": {"alsoAllow": ["read", "write", "web_search", "web_fetch", "memory_search", "memory_get", "memory_store"], "profile": "minimal"}, "workspace": f"{user_home}/.openclaw/workspace"},
    {"agentDir": f"{user_home}/.openclaw/agents/law_business/agent", "id": "law_business", "identity": {"emoji": "A04", "name": "A04 Business Agent"}, "name": "law_business", "subagents": {"allowAgents": []}, "tools": {"alsoAllow": ["read", "write", "web_search", "web_fetch", "memory_search", "memory_get", "memory_store"], "profile": "minimal"}, "workspace": f"{user_home}/.openclaw/workspace"},
    {"agentDir": f"{user_home}/.openclaw/agents/law_quality/agent", "id": "law_quality", "identity": {"emoji": "A05", "name": "A05 Quality Monitor"}, "name": "law_quality", "subagents": {"allowAgents": ["law_main"]}, "tools": {"alsoAllow": ["read", "write", "web_search", "web_fetch", "memory_search", "memory_get", "memory_store"], "profile": "minimal"}, "workspace": f"{user_home}/.openclaw/workspace"}
]

for agent in agents:
    if not any(a.get('id') == agent['id'] for a in config['agents']['list']):
        config['agents']['list'].append(agent)

with open('openclaw.json', 'w', encoding='utf-8') as f:
    json.dump(config, f, indent=2, ensure_ascii=False)
ENDPY

echo ""
echo "🎉 安装完成！重启OpenClaw后使用 @law_main 测试"
echo ""
