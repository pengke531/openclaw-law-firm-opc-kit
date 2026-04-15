param(
  [string]$TargetRoot = "$HOME\\.openclaw"
)

$ErrorActionPreference = "Stop"

$packageRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$domainRoot = Join-Path $TargetRoot "domains\\legal-opc"
$configPath = Join-Path $TargetRoot "openclaw.json"
$backupPath = Join-Path $TargetRoot ("openclaw.json.law-opc-backup." + (Get-Date -Format "yyyyMMdd-HHmmss") + ".bak")

Write-Host "[law-firm] package root: $packageRoot"
Write-Host "[law-firm] target root:  $TargetRoot"
Write-Host "[law-firm] domain root:  $domainRoot"

New-Item -ItemType Directory -Force $TargetRoot | Out-Null
New-Item -ItemType Directory -Force $domainRoot | Out-Null
New-Item -ItemType Directory -Force (Join-Path $domainRoot "agents") | Out-Null
New-Item -ItemType Directory -Force (Join-Path $domainRoot "workspace") | Out-Null

$agentMap = @{
  "main" = "law_main"
  "a02" = "law_finance"
  "a03" = "law_case"
  "a04" = "law_business"
}

foreach ($srcId in $agentMap.Keys) {
  $dstId = $agentMap[$srcId]
  $src = Join-Path $packageRoot ("agents\\" + $srcId)
  $dst = Join-Path $domainRoot ("agents\\" + $dstId)
  if (Test-Path $dst) {
    Remove-Item $dst -Recurse -Force
  }
  Copy-Item $src $dst -Recurse -Force
}

$workspaceSrc = Join-Path $packageRoot "workspace"
$workspaceDst = Join-Path $domainRoot "workspace"
if (Test-Path $workspaceDst) {
  Remove-Item $workspaceDst -Recurse -Force
}
Copy-Item $workspaceSrc $workspaceDst -Recurse -Force

$envTemplateSrc = Join-Path $packageRoot ".env.template"
$envTemplateDst = Join-Path $domainRoot ".env.template"
Copy-Item -LiteralPath $envTemplateSrc -Destination $envTemplateDst -Force

@"
import json
from copy import deepcopy
from pathlib import Path

target_root = Path(r"$TargetRoot").resolve()
domain_root = Path(r"$domainRoot").resolve()
config_path = Path(r"$configPath")
backup_path = Path(r"$backupPath")
overlay_path = Path(r"$packageRoot") / "openclaw.json"

overlay = json.loads(overlay_path.read_text(encoding="utf-8"))

def rewrite(value):
    if isinstance(value, str):
        return (
            value.replace("__DOMAIN_ROOT__", str(domain_root).replace("\\\\", "/"))
                 .replace("__PROFILE_ROOT__", str(target_root).replace("\\\\", "/"))
        )
    if isinstance(value, list):
        return [rewrite(v) for v in value]
    if isinstance(value, dict):
        return {k: rewrite(v) for k, v in value.items()}
    return value

overlay = rewrite(overlay)

if config_path.exists():
    current = json.loads(config_path.read_text(encoding="utf-8-sig"))
    backup_path.write_text(json.dumps(current, ensure_ascii=False, indent=2), encoding="utf-8")
else:
    current = {}

def deep_fill(dst, src):
    if isinstance(dst, dict) and isinstance(src, dict):
        for k, v in src.items():
            if k not in dst:
                dst[k] = deepcopy(v)
            else:
                dst[k] = deep_fill(dst[k], v)
        return dst
    return dst

plugins = current.setdefault("plugins", {})
plugins.setdefault("allow", [])
for name in overlay.get("plugins", {}).get("allow", []):
    if name not in plugins["allow"]:
        plugins["allow"].append(name)
plugins.setdefault("entries", {})
for name, cfg in overlay.get("plugins", {}).get("entries", {}).items():
    if name not in plugins["entries"]:
        plugins["entries"][name] = deepcopy(cfg)
    else:
        plugins["entries"][name] = deep_fill(plugins["entries"][name], cfg)

skills = current.setdefault("skills", {})
skills_load = skills.setdefault("load", {})
skills_load.setdefault("extraDirs", [])
for d in overlay.get("skills", {}).get("load", {}).get("extraDirs", []):
    if d not in skills_load["extraDirs"]:
        skills_load["extraDirs"].append(d)

models = current.setdefault("models", {})
if "mode" not in models:
    models["mode"] = overlay.get("models", {}).get("mode", "merge")
providers = models.setdefault("providers", {})
for pname, pcfg in overlay.get("models", {}).get("providers", {}).items():
    if pname not in providers:
        providers[pname] = deepcopy(pcfg)
    else:
        existing = providers[pname]
        for k, v in pcfg.items():
            if k == "models":
                existing.setdefault("models", [])
                existing_ids = {m.get("id") for m in existing["models"] if isinstance(m, dict)}
                for model in v:
                    if model.get("id") not in existing_ids:
                        existing["models"].append(deepcopy(model))
            elif k not in existing:
                existing[k] = deepcopy(v)

tools = current.setdefault("tools", {})
tools_web = tools.setdefault("web", {})
tools_search = tools_web.setdefault("search", {})
if "provider" not in tools_search and overlay.get("tools", {}).get("web", {}).get("search", {}).get("provider"):
    tools_search["provider"] = overlay["tools"]["web"]["search"]["provider"]

agents = current.setdefault("agents", {})
defaults = agents.setdefault("defaults", {})
for k, v in overlay.get("agents", {}).get("defaults", {}).items():
    if k == "workspace":
        continue
    if k not in defaults:
        defaults[k] = deepcopy(v)
    elif isinstance(v, dict) and isinstance(defaults[k], dict):
        defaults[k] = deep_fill(defaults[k], v)

agents.setdefault("list", [])
by_id = {a.get("id"): a for a in agents["list"] if isinstance(a, dict)}
for overlay_agent in overlay.get("agents", {}).get("list", []):
    by_id[overlay_agent["id"]] = deepcopy(overlay_agent)
agents["list"] = list(by_id.values())

main_agent = next((a for a in agents["list"] if a.get("id") == "main"), None)
if main_agent:
    sub = main_agent.setdefault("subagents", {})
    allow = sub.setdefault("allowAgents", [])
    if "law_main" not in allow:
        allow.append("law_main")

config_path.write_text(json.dumps(current, ensure_ascii=False, indent=2), encoding="utf-8")
"@ | python -

Write-Host "[law-firm] legal overlay imported."
Write-Host "[law-firm] backup created: $backupPath"
