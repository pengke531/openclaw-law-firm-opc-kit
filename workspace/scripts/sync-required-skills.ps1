$ErrorActionPreference = "Stop"

$root = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$dest = Join-Path $root "workspace\\skills\\shared"
$source = Join-Path $HOME ".agents\\skills"

$skills = @(
  "feishu-doc-1.2.7",
  "feishu-drive-1.0.0",
  "feishu-perm",
  "feishu-chat-history",
  "feishu-send-file",
  "search",
  "tavily",
  "agent-reach",
  "autoglm-browser-agent",
  "docx",
  "pdf",
  "nano-pdf",
  "web-scraping",
  "clawdefender-1"
)

New-Item -ItemType Directory -Force $dest | Out-Null

foreach ($name in $skills) {
  $from = Join-Path $source $name
  if (Test-Path $from) {
    $to = Join-Path $dest $name
    Copy-Item $from $to -Recurse -Force
  }
}

Write-Host "[law-firm] required shared skills synchronized."
