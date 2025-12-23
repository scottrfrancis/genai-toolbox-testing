# Claude Desktop Setup Guide

**Last Updated:** 2025-12-22

This guide shows how to connect Claude Desktop to the genai-toolbox MCP server for database queries.

---

## Prerequisites

- **Docker** installed and running (Docker Desktop for macOS/Windows)
- **Claude Desktop** installed ([download](https://claude.ai/download))
- **Network access** to the SQL Server database
- **Database credentials** (provided separately)

---

## Quick Start (5 minutes)

### Step 1: Configure Environment

Copy the environment template and add your credentials:

```bash
cd genai-toolbox-testing

# Copy template
cp envrc .envrc

# Edit with your credentials
# Required: SQLCMDSERVER, SQLCMDUSER, SQLCMDPASSWORD, SQLCMDDBNAME
```

If you have the parent project's `.env` file configured, the `.envrc` will source credentials automatically:

```bash
# .envrc already sources from ../. env
source .envrc
echo $SQLCMDSERVER  # Should show your database host
```

### Step 2: Pull Container Image

```bash
./server/scripts/pull-docker.sh
```

Or manually:

```bash
docker pull us-central1-docker.pkg.dev/database-toolbox/toolbox/toolbox:0.24.0
```

### Step 3: Start MCP Server

```bash
source .envrc
./server/scripts/run-docker.sh
```

You should see:

```
Starting genai-toolbox MCP server v0.24.0...
  Database: your-db-host / YourDatabase
  Port: 5001 (HTTP transport at /mcp)
```

### Step 4: Configure Claude Desktop

Open Claude Desktop settings and add the MCP server:

**Option A: Via Claude Desktop UI**

1. Open Claude Desktop
2. Go to Settings → Developer → MCP Servers
3. Add new server:
   - Name: `toolbox-db`
   - Transport: `http`
   - URL: `http://localhost:5001/mcp`

**Option B: Via Command Line**

```bash
claude mcp add --transport http toolbox-db http://localhost:5001/mcp
```

**Option C: Edit config directly**

Add to `~/.config/claude/settings.json` (Linux) or `~/Library/Application Support/Claude/settings.json` (macOS):

```json
{
  "mcpServers": {
    "toolbox-db": {
      "transport": "http",
      "url": "http://localhost:5001/mcp"
    }
  }
}
```

### Step 5: Verify Connection

In Claude Desktop, try:

```
List all database tables
```

Expected response should mention `CarReport` and `TransactionReport` tables.

---

## Available Tools

Once connected, Claude Desktop has access to these database tools:

| Tool | Description | Example Prompt |
|------|-------------|----------------|
| `list-tables` | List all tables in the database | "What tables are available?" |
| `describe-table` | Get column details for a table | "Describe the CarReport table" |
| `run-query` | Execute a SQL SELECT query | "Show the top 10 rows from CarReport" |

### Example Queries

```
# List tables
"List all tables in the database"

# Describe schema
"What columns does the TransactionReport table have?"

# Run queries
"How many records are in the CarReport table?"
"Show me the top 5 records from CarReport ordered by DOS descending"
"What are the distinct SampleType values in CarReport?"

# Analysis
"What is the average TotalPaid by FinancialClass?"
"Which AccountManager has the most cases this month?"
```

---

## Troubleshooting

### Server Not Responding

**Symptom:** Claude Desktop shows "MCP server not available" or tools fail.

**Check:**

```bash
# Verify server is running
curl -X POST http://localhost:5001/mcp \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","method":"tools/list","id":1}'
```

**Expected:** JSON response with `tools` array.

**Solutions:**

1. Ensure Docker is running: `docker ps`
2. Check server logs: Look at terminal where you ran `run-docker.sh`
3. Restart server: `Ctrl+C`, then `./server/scripts/run-docker.sh`

### Database Connection Failed

**Symptom:** Tools return database connection errors.

**Check:**

```bash
# Verify environment variables
source .envrc
echo "Server: $SQLCMDSERVER"
echo "Database: $SQLCMDDBNAME"
echo "User: $SQLCMDUSER"
```

**Solutions:**

1. Verify credentials in `.envrc` or parent `.env`
2. Ensure database is accessible from your machine (firewall, VPN)
3. Test direct connection: `sqlcmd -S $SQLCMDSERVER -d $SQLCMDDBNAME -U $SQLCMDUSER`

### Wrong Port

**Symptom:** Connection refused on port 5001.

**Check:**

```bash
# See what's listening
lsof -i :5001
```

**Solutions:**

1. Ensure no other process uses port 5001
2. If needed, change port in `run-docker.sh` (edit `-p 5001:5000` to `-p 5002:5000`)
3. Update Claude Desktop config to use new port

### Claude Desktop Can't Find Tools

**Symptom:** "I don't have access to any database tools"

**Solutions:**

1. Restart Claude Desktop after adding MCP server
2. Check settings file syntax (valid JSON)
3. Try removing and re-adding the server: `claude mcp remove toolbox-db && claude mcp add --transport http toolbox-db http://localhost:5001/mcp`

---

## Security Notes

- **Local only:** The server listens on `localhost:5001` - not accessible from other machines
- **Read-only:** Only SELECT queries are allowed - no INSERT, UPDATE, DELETE
- **Credentials:** Database credentials are passed via environment variables, not stored in config files
- **Container isolation:** Runs in Docker container with minimal privileges

For production deployment with public access, see [CHATGPT-SETUP.md](./CHATGPT-SETUP.md) for authentication options.

---

## Stopping the Server

```bash
# If running in foreground: Ctrl+C

# If running in background:
docker ps | grep toolbox
docker stop <container-id>
```

---

## Files Reference

| File | Purpose |
|------|---------|
| `.envrc` | Environment configuration (DB credentials) |
| `envrc` | Template for `.envrc` |
| `server/scripts/run-docker.sh` | Start server with Docker |
| `server/scripts/pull-docker.sh` | Pull container image |
| `configs/tools.yaml` | MCP tool definitions |

---

## Next Steps

- **Run reports:** Use with `generate_report.sh` - see [../../docs/users/RUNNING_REPORTS.md](../../docs/users/RUNNING_REPORTS.md)
- **Custom queries:** Ask Claude to explore the data with natural language
- **Ollama integration:** See [OLLAMA-OPENWEBUI-SETUP.md](./OLLAMA-OPENWEBUI-SETUP.md) (coming soon)
