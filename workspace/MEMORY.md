# Legal OPC Memory Architecture

This package uses one live memory system with layered retrieval and additive
host deployment.

## Layers

- `L0 Constitution`
- `L1 Private Role Memory`
- `L2 Shared Operations`
- `L3 Shared Knowledge`
- `L4 Evidence Archive`

## Private namespaces

- `agent.law_main`
- `agent.law_finance`
- `agent.law_case`
- `agent.law_business`

## Shared namespaces

- `shared.legal_ops`
- `shared.legal_knowledge`
- `shared.legal_archive`

## Retrieval order

1. `L0`
2. private role memory
3. shared operations
4. shared knowledge
5. evidence

## Write rules

Write to private memory first when the information is role-local.
Promote to shared memory when it affects another legal agent, a matter, a
client-facing conclusion, a deadline, a billing state, or archive status.
Store evidence references, not bloated raw dumps.
