# Stable Operations v1

This legal package is designed to run inside an existing OpenClaw host without
N8N or an external workflow orchestrator.

## Stability principles

- keep one host OpenClaw root
- add one legal domain under `domains/legal-opc`
- keep the legal command path clear so `law_main` does not absorb specialist legal work
- prefer direct completion for simple tasks and one clear owner for complex tasks
- avoid replacing host channels, host models, or host memory systems

## Runtime expectations

- host `main` may route legal work into `law_main`
- `law_main` handles intake, routing, scheduling, and acceptance
- `law_finance` handles finance work
- `law_case` handles matter and case work
- `law_business` handles contracts, compliance, and legal opinions

## Operational notes

- validate the host config after import
- keep optional legal-domain integrations in `domains/legal-opc/.env`
- do not require the legal domain to own host provider configuration
- do not add unrelated plugins to the legal domain unless there is a legal workflow need
- keep legal templates and archive structure under `domains/legal-opc/workspace`

## Feishu operational notes

- use Feishu Docs for shared legal knowledge and working drafts
- use Feishu Drive for archive references
- use Feishu chat for operational coordination, not as the sole evidence store

## Memory guidance

- private memory is role-local
- shared memory contains matter status, reusable legal knowledge, and coordination facts
- evidence should be stored as references to source files or Feishu artifacts

## When to extend

Only extend the legal domain when there is a concrete legal workflow need, such as:

- a new matter taxonomy
- a new contract family
- a new billing/reporting format
- a new archive structure

Do not add extra agents or automation just because the host can support them.
