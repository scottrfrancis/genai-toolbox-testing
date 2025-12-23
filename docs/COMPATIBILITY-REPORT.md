# GenAI Toolbox for Databases: Compatibility Report

**Date:** 2025-12-23 (Updated)
**Version Tested:** genai-toolbox v0.24.0
**Database:** MS SQL Server (AWS RDS)
**Transports Tested:** SSE (deprecated) and Streamable HTTP (recommended)
**Environment:** Docker on macOS / WSL2

---

## Executive Summary

Google's GenAI Toolbox for Databases v0.24.0 works correctly with MSSQL.

**Previous Issue (RESOLVED):** Our original configuration incorrectly used `parameters` for Go template syntax. The correct field is `templateParameters`.

| Category | Status |
|----------|--------|
| Basic connectivity | ✅ Working |
| Fixed SQL tools | ✅ Working |
| SQL parameters (`@p1`) | ✅ Working |
| Template parameters (`{{.var}}`) | ✅ Working (use `templateParameters` field) |
| Claude CLI integration | ✅ Working |

---

## Test Results (2025-12-23)

### Tool-by-Tool Results

| Tool | Kind | Parameter Type | Status |
|------|------|----------------|--------|
| list-tables | mssql-sql | None (fixed) | ✅ Working |
| describe-table | mssql-sql | `@p1` (parameters) | ✅ Working |
| run-query | mssql-sql | `{{.query}}` (templateParameters) | ✅ Working |

### Correct Configuration

```yaml
sources:
  baseline-mssql:
    kind: mssql
    host: ${SQLCMDSERVER}
    port: 1433
    database: ${SQLCMDDBNAME}
    user: ${SQLCMDUSER}
    password: ${SQLCMDPASSWORD}

tools:
  # Fixed SQL - no parameters needed
  list-tables:
    kind: mssql-sql
    source: baseline-mssql
    description: List all user tables
    statement: |
      SELECT TABLE_SCHEMA, TABLE_NAME
      FROM INFORMATION_SCHEMA.TABLES
      WHERE TABLE_TYPE = 'BASE TABLE'

  # SQL Server parameters (@p1) - for safe parameterized queries
  describe-table:
    kind: mssql-sql
    source: baseline-mssql
    description: Get column details for a table
    parameters:
      - name: table_name
        type: string
    statement: |
      SELECT COLUMN_NAME, DATA_TYPE
      FROM INFORMATION_SCHEMA.COLUMNS
      WHERE TABLE_NAME = @p1

  # Go template parameters - for dynamic queries
  run-query:
    kind: mssql-sql
    source: baseline-mssql
    description: Run a SQL query
    templateParameters:        # <-- CORRECT: templateParameters, NOT parameters
      - name: query
        type: string
    statement: "{{.query}}"
```

---

## Key Learning: parameters vs templateParameters

| Field | Syntax | Use Case | Security |
|-------|--------|----------|----------|
| `parameters` | `@p1`, `@Name` | WHERE clause values | Safe (parameterized) |
| `templateParameters` | `{{.variable}}` | Dynamic table names, full queries | String substitution |

**Common Mistake:** Using `parameters` with `{{.variable}}` syntax will fail. Go templates require `templateParameters`.

---

## Transport Validation

### Streamable HTTP (Recommended)

**Endpoint:** `http://localhost:5001/mcp`
**MCP Spec:** 2025-03-26

```bash
# Add to Claude CLI
claude mcp add --transport http toolbox-db http://localhost:5001/mcp
```

### SSE (Deprecated)

**Endpoint:** `http://localhost:5001/mcp/sse`
**MCP Spec:** 2024-11-05

```bash
# Add to Claude CLI (deprecated)
claude mcp add --transport sse toolbox-db http://localhost:5001/mcp/sse
```

---

## Test Environment

```text
Container: us-central1-docker.pkg.dev/database-toolbox/toolbox/toolbox:0.24.0
Server Version: 0.24.0+container.release.linux.amd64
Database: MS SQL Server on AWS RDS
Host: Docker on macOS / WSL2
Claude CLI: Tested with HTTP transport
```

---

## References

- [mssql-sql documentation](https://googleapis.github.io/genai-toolbox/resources/tools/mssql/mssql-sql/)
- [GitHub Issue #535](https://github.com/googleapis/genai-toolbox/issues/535) - Parameter handling discussion
- [GitHub PR #671](https://github.com/googleapis/genai-toolbox/pull/671) - Added templateParameters for MSSQL

---

## Revision History

| Date | Change |
|------|--------|
| 2025-12-22 | Initial report - incorrectly documented template syntax as "broken" |
| 2025-12-23 | Corrected - issue was configuration error (parameters vs templateParameters) |

---

**Report updated by Claude Code on 2025-12-23**
