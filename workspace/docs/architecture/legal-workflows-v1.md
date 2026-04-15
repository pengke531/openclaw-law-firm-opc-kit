# Legal Workflows v1

## Required workflow set

This OPC must cover these recurring workflows without role ambiguity:

1. client intake
2. conflict check
3. schedule and deadline capture
4. matter opening
5. evidence and file registration
6. drafting and review
7. contract and compliance review
8. billing and reimbursement
9. archive and retrieval

## Workflow details

### 1. Client intake

- Owner: `law_main`
- Inputs: client message, matter summary, opposing party, urgency
- Outputs: intake note, tentative matter type, routed owner, schedule item if needed

### 2. Conflict check

- Owner: `law_main`
- Support: `law_case` for matter relationships, `law_business` for commercial counterparties
- Outputs: clear pass / caution / block result with named counterparties

### 3. Finance capture

- Owner: `law_finance`
- Inputs: receipts, photos, bills, reimbursement requests, bank references
- Outputs: normalized entry, supporting source ref, discrepancy flag if needed

### 4. Matter handling

- Owner: `law_case`
- Inputs: case files, evidence, prior filings, client notes
- Outputs: matter brief, chronology, archive path, evidence index

### 5. Contract and compliance

- Owner: `law_business`
- Inputs: contract draft, policy requirement, regulatory context
- Outputs: issue list, clause comments, risk summary, legal opinion outline

### 6. Final delivery

- Owner: `law_main`
- Inputs: specialist output plus evidence
- Outputs: accepted answer, follow-up plan, next-step schedule if needed
