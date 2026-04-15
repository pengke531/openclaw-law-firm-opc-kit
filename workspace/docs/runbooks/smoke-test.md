# Smoke Test

Run these checks after additive deployment into the host OpenClaw environment.

## 1. Structural checks

```powershell
powershell -ExecutionPolicy Bypass -File .\workspace\scripts\bootstrap-law-firm.ps1
openclaw config validate
```

## 2. Gateway checks

```powershell
openclaw gateway probe
Invoke-WebRequest http://127.0.0.1:18789/ -UseBasicParsing
```

## 3. Agent checks

```powershell
openclaw agents list --json
```

Confirm these agents exist:

- `law_main`
- `law_finance`
- `law_case`
- `law_business`

If the host has a base `main`, confirm that `main` can call `law_main`.

## 4. Functional checks

- Ask `law_main` to classify an intake and route it.
- Ask `law_finance` to normalize a receipt into a billing entry.
- Ask `law_case` to produce a matter brief from supplied facts.
- Ask `law_business` to produce a contract issue list from a short clause sample.

## 5. Deployment checks

- confirm `~/.openclaw/domains/legal-opc/.env.template` exists
- confirm `~/.openclaw/domains/legal-opc/workspace/skills/shared` exists
- confirm the host `openclaw.json` contains the four `law_*` agents
