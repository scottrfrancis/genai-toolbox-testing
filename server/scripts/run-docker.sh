#!/bin/bash
# Run genai-toolbox MCP server using Docker (macOS compatible)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Source environment variables
if [ -f "$PROJECT_ROOT/.envrc" ]; then
    source "$PROJECT_ROOT/.envrc"
else
    echo "Error: .envrc not found at $PROJECT_ROOT/.envrc"
    echo "Copy envrc to .envrc and configure your database credentials"
    exit 1
fi

# Validate required environment variables
if [ -z "$SQLCMDSERVER" ] || [ -z "$SQLCMDUSER" ] || [ -z "$SQLCMDPASSWORD" ] || [ -z "$SQLCMDDBNAME" ]; then
    echo "Error: Missing required SQLCMD* environment variables"
    echo "Required: SQLCMDSERVER, SQLCMDUSER, SQLCMDPASSWORD, SQLCMDDBNAME"
    exit 1
fi

export VERSION=0.24.0

echo "Starting genai-toolbox MCP server v$VERSION..."
echo "  Database: $SQLCMDSERVER / $SQLCMDDBNAME"
echo "  Port: 5001 (HTTP transport at /mcp)"
echo ""

docker run --rm -p 5001:5000 \
  -e SQLCMDSERVER \
  -e SQLCMDUSER \
  -e SQLCMDPASSWORD \
  -e SQLCMDDBNAME \
  -v "$PROJECT_ROOT/configs/tools.yaml:/app/tools.yaml:ro" \
  us-central1-docker.pkg.dev/database-toolbox/toolbox/toolbox:$VERSION \
  --tools-file "/app/tools.yaml" \
  --address "0.0.0.0"
