# RETRACTED: MSSQL Template Syntax Issue

**Status:** RETRACTED - Configuration error, not a bug
**Original Date:** 2025-12-22
**Retracted:** 2025-12-23

---

## Summary

The original bug report documented that `{{.query}}` template syntax didn't work with `mssql-sql` tool kind. **This was incorrect.**

The issue was a **configuration error** - we used `parameters` when genai-toolbox requires `templateParameters` for Go template syntax.

---

## Root Cause

### Our Broken Configuration

```yaml
run-query:
  kind: mssql-sql
  parameters:           # WRONG FIELD
    - name: query
      type: string
  statement: "{{.query}}"
```

### The Correct Configuration

```yaml
run-query:
  kind: mssql-sql
  templateParameters:   # CORRECT FIELD
    - name: query
      type: string
  statement: "{{.query}}"
```

---

## Documentation Reference

From [mssql-sql documentation](https://googleapis.github.io/genai-toolbox/resources/tools/mssql/mssql-sql/):

> **Standard Parameters** use `@Name` or `@p1` to `@pN` notation - processed through SQL Server's prepared statement mechanism
>
> **Template Parameters** use `{{.variableName}}` notation - applied before prepared statement execution

---

## Verification

Tested 2025-12-23 with genai-toolbox v0.24.0:

```bash
# With templateParameters - WORKS
curl -X POST http://localhost:5001/api/tool/run-query/invoke \
  -H "Content-Type: application/json" \
  -d '{"query": "SELECT TOP 5 * FROM CarReport"}'

# Result: 200 OK with query results
```

---

## Lesson Learned

Two distinct parameter mechanisms in genai-toolbox:

| Field | Syntax | Purpose | Security |
|-------|--------|---------|----------|
| `parameters` | `@p1`, `@Name` | SQL prepared statements | Parameterized (safe) |
| `templateParameters` | `{{.variable}}` | Go template substitution | String substitution |

- Use `parameters` for VALUES in WHERE clauses (safe, parameterized)
- Use `templateParameters` for dynamic table/column names or full queries

---

## Related Issues

- [GitHub Issue #535](https://github.com/googleapis/genai-toolbox/issues/535) - Describes parameter quoting behavior
- [GitHub PR #671](https://github.com/googleapis/genai-toolbox/pull/671) - Added templateParameters for MSSQL

---

## Original (Incorrect) Bug Report

<details>
<summary>Click to expand original content (for reference)</summary>

The original report claimed:

> The `mssql-sql` tool kind with Go template syntax (`{{.query}}`) does not work correctly in v0.24.0.

This was user error. The correct field is `templateParameters`, not `parameters`.

The "workaround" of using `mssql-execute-sql` was unnecessary - the proper fix is to use the correct configuration field.

</details>

---

**This bug report is RETRACTED. Do NOT file with googleapis/genai-toolbox.**
