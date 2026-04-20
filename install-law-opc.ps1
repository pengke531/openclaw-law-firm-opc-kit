# 法律OPC系统一键安装脚本 (Windows)

Write-Host "⚖️  法律OPC系统安装" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan

# 检查OpenClaw安装
$openclawRoot = "$env:USERPROFILE\.openclaw"
if (-not (Test-Path $openclawRoot)) {
    Write-Host "❌ 错误: OpenClaw未安装" -ForegroundColor Red
    exit 1
}

Write-Host "✅ 检测到OpenClaw安装" -ForegroundColor Green

# 备份配置
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$backupFile = "$openclawRoot\openclaw.json.backup-law-$timestamp"
Copy-Item "$openclawRoot\openclaw.json" $backupFile
Write-Host "✅ 已备份配置" -ForegroundColor Green

# 创建Agent目录
$agentBaseDir = "$openclawRoot\agents"
Write-Host "📁 创建Agent目录..." -ForegroundColor Cyan

$agentIds = @("law_main", "law_finance", "law_case", "law_business", "law_quality")
foreach ($agentId in $agentIds) {
    New-Item -ItemType Directory -Force -Path "$agentBaseDir\$agentId\agent" | Out-Null
    New-Item -ItemType Directory -Force -Path "$agentBaseDir\$agentId\memory" | Out-Null
    New-Item -ItemType Directory -Force -Path "$agentBaseDir\$agentId\sessions" | Out-Null
}

# 创建配置文件
Write-Host "📝 创建Agent配置..." -ForegroundColor Cyan

@"
# A01 Legal Commander
你是法律事务总指挥官。
"@ | Out-File "$agentBaseDir\law_main\SOUL.md" -Encoding UTF8

@"
# A02 Finance Agent
你是法律财务专家。
"@ | Out-File "$agentBaseDir\law_finance\SOUL.md" -Encoding UTF8

@"
# A03 Case Agent
你是案件处理专家。
"@ | Out-File "$agentBaseDir\law_case\SOUL.md" -Encoding UTF8

@"
# A04 Business Agent
你是业务专家。
"@ | Out-File "$agentBaseDir\law_business\SOUL.md" -Encoding UTF8

@"
# A05 Quality Monitor
你是质量监控专家。
"@ | Out-File "$agentBaseDir\law_quality\SOUL.md" -Encoding UTF8

# 注册Agent
Write-Host "🔧 注册Agent..." -ForegroundColor Cyan

cd $openclawRoot

$pythonCode = @"
import json, os
user_home = os.path.expanduser('~').replace('\\', '/')
with open('openclaw.json', 'r', encoding='utf-8') as f: config = json.load(f)
agents = [
    {'agentDir': f'{user_home}/.openclaw/agents/law_main/agent', 'id': 'law_main', 'identity': {'emoji': 'A01', 'name': 'A01 Legal Commander'}, 'name': 'law_main', 'subagents': {'allowAgents': ['law_finance', 'law_case', 'law_business', 'law_quality']}, 'tools': {'alsoAllow': ['read', 'write', 'sessions_spawn', 'subagents', 'web_search', 'web_fetch', 'memory_search', 'memory_get', 'memory_store', 'agents_list'], 'profile': 'messaging'}, 'workspace': f'{user_home}/.openclaw/workspace'},
    {'agentDir': f'{user_home}/.openclaw/agents/law_finance/agent', 'id': 'law_finance', 'identity': {'emoji': 'A02', 'name': 'A02 Finance Agent'}, 'name': 'law_finance', 'subagents': {'allowAgents': []}, 'tools': {'alsoAllow': ['read', 'write', 'web_search', 'web_fetch', 'memory_search', 'memory_get', 'memory_store'], 'profile': 'minimal'}, 'workspace': f'{user_home}/.openclaw/workspace'},
    {'agentDir': f'{user_home}/.openclaw/agents/law_case/agent', 'id': 'law_case', 'identity': {'emoji': 'A03', 'name': 'A03 Case Agent'}, 'name': 'law_case', 'subagents': {'allowAgents': []}, 'tools': {'alsoAllow': ['read', 'write', 'web_search', 'web_fetch', 'memory_search', 'memory_get', 'memory_store'], 'profile': 'minimal'}, 'workspace': f'{user_home}/.openclaw/workspace'},
    {'agentDir': f'{user_home}/.openclaw/agents/law_business/agent', 'id': 'law_business', 'identity': {'emoji': 'A04', 'name': 'A04 Business Agent'}, 'name': 'law_business', 'subagents': {'allowAgents': []}, 'tools': {'alsoAllow': ['read', 'write', 'web_search', 'web_fetch', 'memory_search', 'memory_get', 'memory_store'], 'profile': 'minimal'}, 'workspace': f'{user_home}/.openclaw/workspace'},
    {'agentDir': f'{user_home}/.openclaw/agents/law_quality/agent', 'id': 'law_quality', 'identity': {'emoji': 'A05', 'name': 'A05 Quality Monitor'}, 'name': 'law_quality', 'subagents': {'allowAgents': ['law_main']}, 'tools': {'alsoAllow': ['read', 'write', 'web_search', 'web_fetch', 'memory_search', 'memory_get', 'memory_store'], 'profile': 'minimal'}, 'workspace': f'{user_home}/.openclaw/workspace'}
]
for agent in agents:
    if not any(a.get('id') == agent['id'] for a in config['agents']['list']):
        config['agents']['list'].append(agent)
with open('openclaw.json', 'w', encoding='utf-8') as f:
    json.dump(config, f, indent=2, ensure_ascii=False)
"@

$pythonCode | python

Write-Host ""
Write-Host "🎉 安装完成！重启OpenClaw后使用 @law_main 测试" -ForegroundColor Green
Write-Host ""
