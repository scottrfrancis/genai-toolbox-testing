# genai-toolbox MCP Test Summary

**Date:** 2025-12-23
**Transport:** HTTP via genai-toolbox v0.24.0
**Config:** `templateParameters` (fixed from previous `parameters` error)

---

## Test Results

### Report Generation
| Section | Status | Time | Narrative Chars | MCP Tools Used |
|---------|--------|------|-----------------|----------------|
| f1-billing-update | ✅ SUCCESS | 81.8s | 1,261 | list-tables, describe-table, run-query, mcp_calculate |
| f2-billing-per-day | ✅ SUCCESS | 76.3s | 879 | list-tables, describe-table, run-query, mcp_calculate |
| o2-sample-summary | ✅ SUCCESS | 192.5s | 1,705 | list-tables, describe-table, run-query, mcp_calculate |

**Total Time:** 192.6s (parallel execution)
**Success Rate:** 100%

---

## MCP Request Log Analysis

### Server Initialization
- Initialized 1 source: `baseline-mssql`
- Initialized 3 tools: `list-tables`, `describe-table`, `run-query`
- Initialized 1 toolset: `default`

### Request Volume
- **Total HTTP requests during test:** 39
- **200 OK responses:** 35
- **202 Accepted:** 4 (async notifications)
- **405 Method Not Allowed:** 4 (GET requests to POST-only endpoint)

### Response Times
| Query Type | Avg Response Time |
|------------|-------------------|
| tools/list | <1ms |
| list-tables | ~100ms |
| describe-table | ~500ms |
| run-query (simple) | 350-400ms |
| run-query (complex) | 5-90 seconds |

---

## Sample MCP Sessions

### 1. tools/list (Initialize)
```json
REQUEST: {"jsonrpc":"2.0","method":"tools/list","id":1}
RESPONSE: 3 tools returned (list-tables, describe-table, run-query)
```

### 2. list-tables
```json
REQUEST: {"jsonrpc":"2.0","method":"tools/call","params":{"name":"list-tables","arguments":{}},"id":2}
RESPONSE: 2 tables (CarReport, TransactionReport)
```

### 3. describe-table
```json
REQUEST: {"jsonrpc":"2.0","method":"tools/call","params":{"name":"describe-table","arguments":{"table_name":"CarReport"}},"id":3}
RESPONSE: 70 columns with schema details
```

### 4. run-query (with templateParameters)
```json
REQUEST: {"jsonrpc":"2.0","method":"tools/call","params":{"name":"run-query","arguments":{"query":"SELECT TOP 5 SampleType, COUNT(*) as cnt FROM CarReport GROUP BY SampleType ORDER BY cnt DESC"}},"id":4}
RESPONSE: 5 rows with aggregated data
```

---

## Comparison with Baseline

| Metric | Dec 15 Baseline | Dec 23 genai-toolbox |
|--------|-----------------|----------------------|
| CLI Status | ERROR | SUCCESS |
| Sections Generated | 0 | 3 |
| Avg Narrative Length | 0 | 1,282 chars |
| MCP Transport | stdio | HTTP (genai-toolbox) |

**Note:** Dec 15 baseline had CLI errors in all sections - no successful outputs to compare content quality.

---

## Key Findings

1. **templateParameters works correctly** - Fixed config generates proper queries
2. **HTTP transport functional** - genai-toolbox v0.24.0 handles MCP requests reliably
3. **Parallel execution working** - 3 sections ran concurrently with 1.8x speedup
4. **MCP tool usage logged** - Each section reports tools called and queries executed
5. **Security model confirmed** - Server passes queries through; security at DB level

---

## Configuration Used

```yaml
# genai-toolbox-testing/configs/tools.yaml
run-query:
  kind: mssql-sql
  source: baseline-mssql
  description: Run a read-only SQL query against the database
  templateParameters:  # CORRECT - not "parameters"
    - name: query
      type: string
      description: The SQL query to execute
  statement: "{{.query}}"
```

---

**Test completed successfully. genai-toolbox is ready for Sprint 4 demo.**
