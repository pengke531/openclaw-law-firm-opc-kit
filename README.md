# OpenClaw Legal OPC Overlay Kit

This repository is a cross-platform, additive legal-operations agent pack for
existing OpenClaw environments.

It does **not** replace the host's current setup. Instead, it imports one legal
domain into the host's existing `~/.openclaw` state root and adds four
namespaced legal agents:

- `law_main` -> `A01 Legal Commander`
- `law_finance` -> `A02 Finance Agent`
- `law_case` -> `A03 Case Agent`
- `law_business` -> `A04 Business & Compliance Agent`

## Design goals

- additive deployment into an existing OpenClaw host
- no overwrite of the host's base topology, models, channels, or provider wiring
- one legal commander plus three specialist legal agents
- layered legal memory with private + shared namespaces
- portable on Windows and macOS
- stable without N8N

## What this package adds

- an additive `openclaw.json` overlay focused on agent architecture
- complete legal agent role files
- legal constitution in `workspace/AGENTS.md`
- legal memory rules in `workspace/MEMORY.md`
- legal workflow templates
- additive deployment and smoke-test scripts
- required-skill manifest for rebuilding the shared legal skill layer

## What this package does not do

- it does not delete the host's existing agents
- it does not replace the host's base `main`
- it does not force a dedicated profile
- it does not hardcode the host's API credentials or provider choices
- it does not vendor every third-party skill payload

## Quick install

macOS:

```bash
git clone https://github.com/pengke531/openclaw-law-firm-opc-kit.git
cd openclaw-law-firm-opc-kit
chmod +x ./install-law-firm.sh
./install-law-firm.sh
```

Windows:

```powershell
git clone https://github.com/pengke531/openclaw-law-firm-opc-kit.git
cd openclaw-law-firm-opc-kit
powershell -ExecutionPolicy Bypass -File .\install-law-firm.ps1
```

## After install

1. Optionally copy the generated template:

```text
~/.openclaw/domains/legal-opc/.env.template
```

to:

```text
~/.openclaw/domains/legal-opc/.env
```

2. Fill only the integrations the host actually wants to use:

- `ZAI_API_KEY`
- `TAVILY_API_KEY`
- `FEISHU_APP_ID`
- `FEISHU_APP_SECRET`
- `MINIMAX_API_KEY`

3. Validate the host config:

```bash
openclaw config validate
```

4. Start OpenClaw normally:

```bash
openclaw gateway
```

## Incremental import model

This repository installs into:

```text
~/.openclaw/domains/legal-opc
```

and merges legal overlay settings into:

```text
~/.openclaw/openclaw.json
```

During install:

- the host config is backed up
- legal agents are appended if missing
- legal agent topology is merged without replacing unrelated host config
- the host `main` is given access to `law_main` as a subagent if `main` exists

The host keeps responsibility for:

- model provider setup
- API keys and secrets
- channel installation
- optional tool integrations beyond the legal pack itself

## Skill strategy

This repository keeps a shared legal skill manifest, then synchronizes
recommended global skills from the host skill catalog into:

```text
~/.openclaw/domains/legal-opc/workspace/skills/shared
```

Reference:

- `workspace/docs/runbooks/required-skills.md`

## Core references

- `workspace/docs/architecture/legal-opc-architecture-v1.md`
- `workspace/docs/architecture/legal-role-matrix-v1.md`
- `workspace/docs/architecture/legal-workflows-v1.md`
- `workspace/docs/runbooks/deployment-and-migration.md`
- `workspace/docs/runbooks/smoke-test.md`
- `workspace/docs/runbooks/stable-operations-v1.md`
