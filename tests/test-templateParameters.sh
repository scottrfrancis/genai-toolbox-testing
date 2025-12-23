#!/bin/bash
# Test script for templateParameters fix
# Created: 2025-12-23
# Purpose: Verify that templateParameters works for Go template syntax

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "=================================================="
echo "GenAI Toolbox templateParameters Test"
echo "=================================================="
echo ""

# Source environment variables
source "$PROJECT_ROOT/.envrc"

# Check if container is running
CONTAINER_NAME="genai-toolbox-test"
CONTAINER_RUNNING=$(docker ps -q -f name="$CONTAINER_NAME" 2>/dev/null || true)

if [ -z "$CONTAINER_RUNNING" ]; then
    echo -e "${YELLOW}Starting genai-toolbox container with FIXED config...${NC}"

    # Use the fixed config
    docker run -d --name "$CONTAINER_NAME" \
        -p 5001:5000 \
        -e SQLCMDSERVER \
        -e SQLCMDUSER \
        -e SQLCMDPASSWORD \
        -e SQLCMDDBNAME \
        -e SQLCMDENCRYPT \
        -v "$PROJECT_ROOT/configs/tools-fixed.yaml:/app/tools.yaml:ro" \
        us-central1-docker.pkg.dev/database-toolbox/toolbox/toolbox:0.24.0 \
        --tools-file "/app/tools.yaml" \
        --address "0.0.0.0"

    echo "Waiting for container to start..."
    sleep 5
else
    echo -e "${GREEN}Container already running${NC}"
fi

# Test URL
BASE_URL="http://localhost:5001"

echo ""
echo "=================================================="
echo "Test 1: list-tables (fixed SQL - baseline)"
echo "=================================================="
echo ""

RESULT=$(curl -s -X POST "$BASE_URL/api/tool/list-tables/invoke" \
    -H "Content-Type: application/json" \
    -d '{}')

if echo "$RESULT" | grep -q "CarReport"; then
    echo -e "${GREEN}PASS${NC}: list-tables returned CarReport"
else
    echo -e "${RED}FAIL${NC}: list-tables did not return expected tables"
    echo "Response: $RESULT"
fi

echo ""
echo "=================================================="
echo "Test 2: describe-table with @p1 parameter"
echo "=================================================="
echo ""

RESULT=$(curl -s -X POST "$BASE_URL/api/tool/describe-table/invoke" \
    -H "Content-Type: application/json" \
    -d '{"table_name": "CarReport"}')

if echo "$RESULT" | grep -q "COLUMN_NAME"; then
    echo -e "${GREEN}PASS${NC}: describe-table with @p1 parameter works"
else
    echo -e "${RED}FAIL${NC}: describe-table failed"
    echo "Response: $RESULT"
fi

echo ""
echo "=================================================="
echo "Test 3: run-query with templateParameters (THE FIX)"
echo "=================================================="
echo ""

RESULT=$(curl -s -X POST "$BASE_URL/api/tool/run-query/invoke" \
    -H "Content-Type: application/json" \
    -d '{"query": "SELECT TOP 5 * FROM CarReport"}')

echo "Response:"
echo "$RESULT" | head -20

if echo "$RESULT" | grep -q "error"; then
    echo -e "${RED}FAIL${NC}: run-query with templateParameters failed"
    echo ""
    echo "Full error:"
    echo "$RESULT"
else
    echo -e "${GREEN}PASS${NC}: run-query with templateParameters works!"
fi

echo ""
echo "=================================================="
echo "Test 4: Security Test - SQL Injection (DROP TABLE)"
echo "=================================================="
echo ""

RESULT=$(curl -s -X POST "$BASE_URL/api/tool/run-query/invoke" \
    -H "Content-Type: application/json" \
    -d '{"query": "SELECT 1; DROP TABLE CarReport--"}')

echo "Response:"
echo "$RESULT"

if echo "$RESULT" | grep -q "error"; then
    echo -e "${GREEN}BLOCKED${NC}: SQL injection attempt was rejected"
else
    echo -e "${RED}WARNING${NC}: SQL injection may have succeeded (check database!)"
fi

echo ""
echo "=================================================="
echo "Test 5: Security Test - Stacked Query"
echo "=================================================="
echo ""

RESULT=$(curl -s -X POST "$BASE_URL/api/tool/run-query/invoke" \
    -H "Content-Type: application/json" \
    -d '{"query": "SELECT 1; SELECT 2"}')

echo "Response:"
echo "$RESULT"

echo ""
echo "=================================================="
echo "Container logs (last 20 lines)"
echo "=================================================="
echo ""

docker logs --tail 20 "$CONTAINER_NAME" 2>&1

echo ""
echo "=================================================="
echo "Tests complete. Stop container with:"
echo "docker stop $CONTAINER_NAME && docker rm $CONTAINER_NAME"
echo "=================================================="
