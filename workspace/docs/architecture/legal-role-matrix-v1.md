# Legal Role Matrix v1

## Team structure

- `law_main / A01 Legal Commander`: intake, routing, scheduling, acceptance
- `law_finance / A02 Finance Agent`: bookkeeping, receipts, reimbursement, reconciliation
- `law_case / A03 Case Agent`: matter management, evidence, drafting, archive, case KB
- `law_business / A04 Business & Compliance Agent`: contracts, compliance, legal opinions

## Ownership matrix

| Work type | Primary owner | Secondary support | Final acceptance |
| --- | --- | --- | --- |
| New client intake | `law_main` | `law_case`, `law_business` | `law_main` |
| Conflict check | `law_main` | `law_case`, `law_business` | `law_main` |
| Schedule and deadline entry | `law_main` | `law_case` | `law_main` |
| Receipt capture and expense entry | `law_finance` | `law_main` | `law_finance` |
| Reconciliation and discrepancy review | `law_finance` | `law_main` | `law_finance` |
| Matter opening and file taxonomy | `law_case` | `law_main` | `law_case` |
| Evidence registration and chronology | `law_case` | `law_main` | `law_case` |
| Case memo / case draft support | `law_case` | `law_main` | `law_case` |
| Contract review | `law_business` | `law_main` | `law_business` |
| Compliance audit | `law_business` | `law_main` | `law_business` |
| Legal opinion outline | `law_business` | `law_main` | `law_business` |
| Cross-domain coordination | `law_main` | all specialists | `law_main` |

## Routing rules

- If the task is mostly calendar, inbox, or coordination, `law_main` owns it.
- If the task depends on money, invoices, receipts, or balances, `law_finance` owns it.
- If the task depends on matter history, evidence, filings, chronology, or case drafting, `law_case` owns it.
- If the task depends on contract terms, compliance checks, or legal risk language, `law_business` owns it.
- If a task spans two domains, `law_main` picks one clear owner and one support role.

## Escalation rules

- Missing facts -> return a structured clarification request, not a guessed answer.
- High-stakes legal conclusion -> `law_business` must surface assumptions and open issues.
- Missing evidence chain -> `law_case` must block completion until evidence references exist.
- Amount mismatch or unsupported entry -> `law_finance` must mark it unresolved, not inferred.
