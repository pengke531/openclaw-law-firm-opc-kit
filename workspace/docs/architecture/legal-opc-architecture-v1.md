# Legal OPC Architecture v1

## Purpose

This architecture is designed for a legal practice using OpenClaw 4.10 with:

- one commander
- three legal specialist agents
- one shared constitution
- one layered memory system
- full specialist permissions
- Feishu-centered operations
- no N8N dependency

## Topology

```mermaid
flowchart LR
  U["User / Team"] --> M["law_main / A01 Legal Commander"]
  M --> F["law_finance / A02 Finance Agent"]
  M --> C["law_case / A03 Case Agent"]
  M --> B["law_business / A04 Business & Compliance Agent"]

  F --> FS["Feishu Sheets / Bills / Reconciliation"]
  C --> FD["Feishu Docs / Matter KB / Archive"]
  B --> FC["Contracts / Compliance / Legal Opinions"]
  M --> CAL["Schedules / Intake / Daily coordination"]
```

## Legal workflow completeness requirements

The system must cover these workflows explicitly:

1. client intake
2. conflict check
3. schedule and deadline capture
4. matter opening
5. evidence and file registration
6. drafting and review
7. contract and compliance review
8. billing and reimbursement
9. archive and retrieval
