#!/usr/bin/env bash
set -euo pipefail

TARGET_ROOT="${1:-$HOME/.openclaw}"
REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"

echo "[legal-opc] repo root:   $REPO_ROOT"
echo "[legal-opc] host target: $TARGET_ROOT"

if ! command -v openclaw >/dev/null 2>&1; then
  echo "[legal-opc] openclaw not found in PATH"
  exit 1
fi

if ! command -v pwsh >/dev/null 2>&1; then
  echo "[legal-opc] pwsh not found in PATH"
  exit 1
fi

cd "$REPO_ROOT"

pwsh -ExecutionPolicy Bypass -File "./workspace/scripts/bootstrap-law-firm.ps1"
pwsh -ExecutionPolicy Bypass -File "./workspace/scripts/sync-required-skills.ps1"
pwsh -ExecutionPolicy Bypass -File "./workspace/scripts/deploy-profile.ps1" -TargetRoot "$TARGET_ROOT"

DOMAIN_ROOT="$TARGET_ROOT/domains/legal-opc"
if [ -f "$DOMAIN_ROOT/.env.template" ] && [ ! -f "$DOMAIN_ROOT/.env" ]; then
  cp "$DOMAIN_ROOT/.env.template" "$DOMAIN_ROOT/.env"
  echo "[legal-opc] created optional template file: $DOMAIN_ROOT/.env"
fi

openclaw config validate

cat <<EOF

[legal-opc] install complete.
[legal-opc] next:
  1. Review optional integration template: $DOMAIN_ROOT/.env
  2. Start OpenClaw normally: openclaw gateway
  3. Run smoke test: pwsh -ExecutionPolicy Bypass -File ./workspace/scripts/smoke-test-law-firm.ps1
EOF
