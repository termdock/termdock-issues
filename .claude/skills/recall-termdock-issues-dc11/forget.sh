#!/bin/bash
# Usage: ./forget.sh <query>
# Remove memories matching query (interactive)

MEMORY_GROUP_ID="default"
MEMORY_FILE="$HOME/.termdock/memory/groups/$MEMORY_GROUP_ID/index.md"

QUERY="$1"

if [ -z "$QUERY" ]; then
    echo "Usage: forget <query>"
    echo "Example: forget \"old auth pattern\""
    exit 1
fi

if [ ! -f "$MEMORY_FILE" ]; then
    echo "Memory file not found: $MEMORY_FILE"
    exit 1
fi

echo "=== Memories matching: $QUERY ==="
echo ""

# Use -- to prevent query from being interpreted as grep flags
MATCHES=$(grep -n -i -- "$QUERY" "$MEMORY_FILE")

if [ -z "$MATCHES" ]; then
    echo "No memories found matching: $QUERY"
    exit 0
fi

echo "$MATCHES"
echo ""
echo "---"
echo "To remove a memory, use the Edit tool to delete the line from:"
echo "$MEMORY_FILE"
