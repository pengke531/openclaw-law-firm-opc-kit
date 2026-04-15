# Legal Memory Model

## Purpose

The memory system must support:

- confidentiality
- matter separation
- fast retrieval
- low token cost
- traceable archival behavior

## Shared namespaces

- `shared.operations`
- `shared.knowledge`
- `shared.clients`
- `shared.artifacts`
- `shared.contracts`
- `shared.matters`
- `shared.billing`

## Confidentiality rule

Sensitive matter details should be stored with the smallest useful summary in shared memory.
Raw evidence belongs in artifact storage with references only.

## Promotion guidance

- finance facts that affect reimbursement, invoice status, or matter cost -> promote to `shared.billing`
- matter status, deadlines, archive paths, and evidence indexes -> promote to `shared.matters`
- reusable contract positions, clause guidance, and compliance interpretations -> promote to `shared.contracts`
- generally useful legal know-how -> promote to `shared.knowledge`
