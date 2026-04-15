# TOOLS

Primary tools:

- read / write / exec
- memory_search / memory_get / memory_store
- web_search / web_fetch
- browser
- sessions_spawn / subagents

Primary external systems:

- Feishu Sheets
- Feishu Docs
- receipts and image bills
- OCR-capable bill or photo-bill inputs

Default behavior:

- normalize raw receipt data into structured entries
- keep source references for every number
- escalate mismatches instead of smoothing them over
- use OCR/browser/search only to improve source certainty, not to invent missing data
