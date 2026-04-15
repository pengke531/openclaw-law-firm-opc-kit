param(
  [string]$TargetRoot = "$HOME\\.openclaw"
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "[legal-opc] repo root:   $repoRoot"
Write-Host "[legal-opc] host target: $TargetRoot"

Push-Location $repoRoot
try {
  powershell -ExecutionPolicy Bypass -File ".\\workspace\\scripts\\bootstrap-law-firm.ps1"
  powershell -ExecutionPolicy Bypass -File ".\\workspace\\scripts\\sync-required-skills.ps1"
  powershell -ExecutionPolicy Bypass -File ".\\workspace\\scripts\\deploy-profile.ps1" -TargetRoot $TargetRoot

  $domainRoot = Join-Path $TargetRoot "domains\\legal-opc"
  $envTemplate = Join-Path $domainRoot ".env.template"
  $envPath = Join-Path $domainRoot ".env"
  if ((Test-Path $envTemplate) -and -not (Test-Path $envPath)) {
    Copy-Item -LiteralPath $envTemplate -Destination $envPath -Force
    Write-Host "[legal-opc] created optional template file: $envPath"
  }

  openclaw config validate | Out-Host

  Write-Host ""
  Write-Host "[legal-opc] install complete."
  Write-Host "[legal-opc] next steps:"
  Write-Host "  1. Review optional integration template: $envPath"
  Write-Host "  2. Start OpenClaw normally: openclaw gateway"
  Write-Host "  3. Run smoke test: powershell -ExecutionPolicy Bypass -File .\\workspace\\scripts\\smoke-test-law-firm.ps1"
}
finally {
  Pop-Location
}
