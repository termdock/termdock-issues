#!/bin/bash
# recall-recent.sh - Display recent memories for SessionStart hook
# Shows a summary of recent decisions without requiring a search query

MEMORY_GROUP_ID="default"
MEMORY_FILE="$HOME/.termdock/memory/groups/$MEMORY_GROUP_ID/index.md"

# Check if memory file exists
if [ ! -f "$MEMORY_FILE" ]; then
    echo "No memories found for this project."
    exit 0
fi

# Count total memories
total_count=$(grep -c "^- \[" "$MEMORY_FILE" 2>/dev/null || echo "0")

if [ "$total_count" -eq 0 ]; then
    echo "No memories found for this project."
    exit 0
fi

echo "=== Project Memory Loaded ==="
echo ""
echo "Recent decisions ($total_count total):"
echo ""

# Show last 5 memories
grep "^- \[" "$MEMORY_FILE" | tail -5 | while read -r line; do
    echo "$line"
done

echo ""
echo "Use './recall.sh <keyword>' to search specific topics"
echo "Use './remember.sh <category> \"<content>\"' to save new memories"
