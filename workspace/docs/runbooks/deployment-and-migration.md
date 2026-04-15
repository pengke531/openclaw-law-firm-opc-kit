# Deployment And Migration

## Safety objective

This package must augment an existing OpenClaw host without replacing the host's
base architecture.

Target host root:

```text
~/.openclaw
```

Legal domain install root:

```text
~/.openclaw/domains/legal-opc
```

## Local development steps

1. Run `workspace/scripts/bootstrap-law-firm.ps1`
2. Run `workspace/scripts/sync-required-skills.ps1`
3. Deploy with `workspace/scripts/deploy-profile.ps1`
4. Validate host config
5. Start the host gateway normally
6. Optionally wire legal-domain integrations in `domains/legal-opc/.env`

## Migration package

Portable asset set:

- `openclaw.json`
- `agents/`
- `workspace/`
- `.env.template`
- `workspace/scripts/bootstrap-law-firm.ps1`
- `workspace/scripts/sync-required-skills.ps1`
- `workspace/scripts/deploy-profile.ps1`
- `workspace/scripts/smoke-test-law-firm.ps1`

## Deployment contract

- deploy into the host's existing `~/.openclaw`
- copy legal assets into `domains/legal-opc`
- back up the host `openclaw.json` before merge
- merge legal config additively
- preserve an existing host `.env`, host channels, and host provider choices
- append legal agents without deleting unrelated host agents

## After migration

Run:

```powershell
openclaw config validate
openclaw gateway probe
powershell -ExecutionPolicy Bypass -File .\workspace\scripts\smoke-test-law-firm.ps1
```

## Cross-platform note

Windows and macOS should both install the legal domain into the same logical
host path structure:

- host root: `~/.openclaw`
- legal assets: `~/.openclaw/domains/legal-opc`

Do not require a dedicated profile unless the host owner explicitly wants one.
