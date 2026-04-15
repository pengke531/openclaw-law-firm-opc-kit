$ErrorActionPreference = "Stop"

$root = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$config = Join-Path $root "openclaw.json"

Write-Host "[law-firm] root: $root"

if (-not (Test-Path $config)) {
  throw "openclaw.json not found: $config"
}

$required = @(
  "agents\\main\\AGENTS.md",
  "agents\\a02\\AGENTS.md",
  "agents\\a03\\AGENTS.md",
  "agents\\a04\\AGENTS.md",
  "workspace\\AGENTS.md",
  "workspace\\MEMORY.md"
)

foreach ($rel in $required) {
  $full = Join-Path $root $rel
  if (-not (Test-Path $full)) {
    throw "missing required file: $full"
  }
}

Write-Host "[law-firm] profile scaffold is structurally complete."
