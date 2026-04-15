$ErrorActionPreference = "Stop"

$port = 18789

Write-Host "[law-firm] validating host config..."
openclaw config validate

Write-Host "[law-firm] checking agent registry..."
$agentsJson = openclaw agents list --json
$agents = $agentsJson | ConvertFrom-Json
$expected = @("law_main", "law_finance", "law_case", "law_business")
$actual = @($agents | ForEach-Object { $_.id })

foreach ($id in $expected) {
  if ($actual -notcontains $id) {
    throw "missing expected agent: $id"
  }
}

Write-Host "[law-firm] probing gateway..."
openclaw gateway probe

Write-Host "[law-firm] checking HTTP endpoint..."
$response = Invoke-WebRequest "http://127.0.0.1:$port/" -UseBasicParsing
if ($response.StatusCode -ne 200) {
  throw "unexpected status code: $($response.StatusCode)"
}

Write-Host "[law-firm] smoke test passed."
