#!/bin/bash
# Script to generate mcp.json from template using environment variable

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_FILE="$SCRIPT_DIR/mcp.json.template"
OUTPUT_FILE="$SCRIPT_DIR/mcp.json"

if [ ! -f "$TEMPLATE_FILE" ]; then
    echo "Error: Template file not found at $TEMPLATE_FILE" >&2
    exit 1
fi

if [ -z "$GITHUB_MCP_TOKEN" ]; then
    echo "Error: GITHUB_MCP_TOKEN environment variable is not set" >&2
    echo "Please set it first:" >&2
    echo "  export GITHUB_MCP_TOKEN=\"your_token_here\"" >&2
    exit 1
fi

# Replace the placeholder with the actual token
sed "s|{{GITHUB_MCP_TOKEN}}|${GITHUB_MCP_TOKEN}|g" "$TEMPLATE_FILE" > "$OUTPUT_FILE"

echo "✓ Generated $OUTPUT_FILE from template"
echo "  Token has been inserted from GITHUB_MCP_TOKEN environment variable"
