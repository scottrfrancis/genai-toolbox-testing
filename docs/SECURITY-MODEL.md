# genai-toolbox Security Model

**Date:** 2025-12-23
**Version:** genai-toolbox v0.24.0
**Context:** Sprint 4 - Hosted MCP Server for Claude Desktop

---

## Executive Summary

genai-toolbox provides **NO server-side query validation**. Security depends entirely on:

1. Database user permissions (read-only)
2. SQL Server configuration
3. Network isolation

This is the intended design - genai-toolbox is documented as being "for developer assistant workflows with human-in-the-loop."

---

## Security Architecture

```text
┌─────────────────┐     ┌──────────────────┐     ┌─────────────────┐
│  Claude/Client  │────▶│  genai-toolbox   │────▶│   SQL Server    │
│                 │     │  (NO validation) │     │  (permissions)  │
└─────────────────┘     └──────────────────┘     └─────────────────┘
                                                         │
                                                         ▼
                                                 ┌───────────────┐
                                                 │ Read-only user│
                                                 │ SELECT only   │
                                                 │ No EXECUTE    │
                                                 └───────────────┘
```

---

## What genai-toolbox Does NOT Block

| Attack Type | Blocked? | Why |
|-------------|----------|-----|
| `DROP TABLE` | Depends on DB | Server passes query through |
| `DELETE FROM` | Depends on DB | Server passes query through |
| `UPDATE SET` | Depends on DB | Server passes query through |
| `INSERT INTO` | Depends on DB | Server passes query through |
| `EXEC sp_help` | **NO** | Stored procedures execute if user has permission |
| `EXEC xp_cmdshell` | Depends on config | Usually disabled in SQL Server |
| Stacked queries | **NO** | `SELECT 1; SELECT 2` executes both |
| SQL comments | **NO** | `-- comment` passes through |

---

## Tested Injection Results (2025-12-23)

| Query | Result |
|-------|--------|
| `SELECT 1; DROP TABLE CarReport--` | BLOCKED by DB: "you do not have permission" |
| `DELETE FROM CarReport WHERE 1=1` | BLOCKED by DB: "DELETE permission was denied" |
| `UPDATE CarReport SET Status='X'` | BLOCKED by DB: "UPDATE permission was denied" |
| `INSERT INTO CarReport VALUES (...)` | BLOCKED by DB: "INSERT permission was denied" |
| `EXEC sp_help` | **EXECUTED** - returned full schema |

---

## Required Database Configuration

### 1. Create Read-Only User

```sql
-- Create login
CREATE LOGIN mcp_reader WITH PASSWORD = 'secure_password';

-- Create user in database
USE BiWeeklyReports;
CREATE USER mcp_reader FOR LOGIN mcp_reader;

-- Grant SELECT only on specific tables
GRANT SELECT ON dbo.CarReport TO mcp_reader;
GRANT SELECT ON dbo.TransactionReport TO mcp_reader;

-- Explicitly deny dangerous permissions
DENY INSERT, UPDATE, DELETE, EXECUTE ON SCHEMA::dbo TO mcp_reader;
DENY ALTER ON SCHEMA::dbo TO mcp_reader;
DENY CREATE TABLE TO mcp_reader;
```

### 2. Disable Dangerous Features

```sql
-- Disable xp_cmdshell (usually disabled by default)
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE;

-- Disable OLE Automation
EXEC sp_configure 'Ole Automation Procedures', 0;
RECONFIGURE;
```

### 3. Verify Permissions

```sql
-- Check what the user can do
EXECUTE AS USER = 'mcp_reader';
SELECT * FROM fn_my_permissions(NULL, 'DATABASE');
REVERT;
```

---

## Deployment Checklist

Before deploying genai-toolbox to production:

- [ ] Database user is read-only (SELECT only)
- [ ] No EXECUTE permission on stored procedures
- [ ] `xp_cmdshell` is disabled
- [ ] Network access restricted (VPC/firewall)
- [ ] API authentication configured (API Gateway + API Key)
- [ ] HTTPS enabled (CloudFront)
- [ ] Logging enabled for audit trail

---

## Comparison with Python MCP Server

| Feature | genai-toolbox | Python mcp_server.py |
|---------|---------------|---------------------|
| Query validation | None | `validate_query()` function |
| SELECT enforcement | DB permissions | Server-side check |
| Keyword blocking | None | Blocks INSERT, UPDATE, DELETE, DROP, etc. |
| Comment blocking | None | Blocks `--` and `/* */` |
| Stacked query blocking | None | Blocks `;` mid-query |
| Security model | Database-level | Server-level + Database-level |

---

## References

- [genai-toolbox documentation](https://googleapis.github.io/genai-toolbox/)
- [mssql-execute-sql warning](https://googleapis.github.io/genai-toolbox/resources/tools/mssql/mssql-execute-sql/): "This tool is intended for developer assistant workflows with human-in-the-loop and shouldn't be used for production agents."
- [COMPATIBILITY-REPORT.md](./COMPATIBILITY-REPORT.md) - Test results

---

**Document created by Claude Code on 2025-12-23**
