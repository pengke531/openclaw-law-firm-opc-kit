---
name: legal-opc-manifest
description: Shared operating guidance for the additive legal OPC domain. Use when the task involves intake, conflict checks, scheduling, bookkeeping, case handling, contracts, compliance, legal opinions, archive hygiene, or cross-agent collaboration inside the legal overlay.
---

# Legal OPC Manifest

## Team

- `law_main` = A01 Legal Commander
- `law_finance` = A02 Finance Agent
- `law_case` = A03 Case Agent
- `law_business` = A04 Business & Compliance Agent

## Routing

- finance / bookkeeping / receipts / reconciliation -> `law_finance`
- matter handling / drafts / evidence / archive / case analysis -> `law_case`
- contract / compliance / legal opinion -> `law_business`
- intake / scheduling / acceptance / final legal reply -> `law_main`

## Mandatory legal controls

- conflict check before substantive work when counterparties are present
- preserve confidentiality and privilege
- return evidence references for non-trivial outputs
- update shared operational memory when status changes
- respect the host environment and do not replace unrelated host agents
