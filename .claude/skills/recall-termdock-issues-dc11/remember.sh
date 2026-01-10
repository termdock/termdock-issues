#!/bin/bash
# Usage: ./remember.sh <category> <content>
# Add new memory to the library

MEMORY_GROUP_ID="default"
MEMORY_FILE="$HOME/.termdock/memory/groups/$MEMORY_GROUP_ID/index.md"

CATEGORY="$1"
shift
CONTENT="$*"
DATE=$(date +%Y-%m-%d)
WORKSPACE=$(basename "$(git rev-parse --show-toplevel 2>/dev/null || pwd)")

# Validate inputs
if [ -z "$CATEGORY" ] || [ -z "$CONTENT" ]; then
    echo "Usage: remember <category> <content>"
    echo ""
    echo "Categories:"
    echo "  architecture  - Design decisions, technology choices"
    echo "  lesson        - Gotchas, debugging discoveries"
    echo "  pattern       - Reusable solutions, conventions"
    echo "  style         - Naming, code organization"
    echo "  preference    - Tooling, workflow choices"
    echo ""
    echo "Example: remember architecture \"Use zustand for global state\""
    echo "Example: remember lesson \"node-pty spawn issue on macOS 15\""
    exit 1
fi

# Sanitize content - remove dangerous characters for file operations
# Allow most characters but escape/remove ones that could cause issues
CONTENT_SAFE=$(printf '%s' "$CONTENT" | tr -d '\000-\037' | sed 's/[`$]/\\&/g')

# Ensure memory file exists
if [ ! -f "$MEMORY_FILE" ]; then
    mkdir -p "$(dirname "$MEMORY_FILE")"
    cat > "$MEMORY_FILE" << 'EOF'
# Termdock Memory Library

## Architecture Decisions

## Lessons Learned

## Common Patterns

## Code Style Preferences

## Work Preferences

EOF
fi

# Map category to section (must match BM25 parser headers)
case "$CATEGORY" in
    architecture|arch)
        SECTION="Architecture Decisions"
        ;;
    lesson|lessons)
        SECTION="Lessons Learned"
        ;;
    pattern|patterns)
        SECTION="Common Patterns"
        ;;
    style)
        SECTION="Code Style Preferences"
        ;;
    preference|pref)
        SECTION="Work Preferences"
        ;;
    *)
        echo "Unknown category: $CATEGORY"
        echo "Valid categories: architecture, lesson, pattern, style, preference"
        exit 1
        ;;
esac

# Create the entry
ENTRY="- [$DATE] [$WORKSPACE] $CONTENT_SAFE"

# Find the line number of the section and insert after it
# Using awk instead of sed for safer insertion
TEMP_FILE=$(mktemp)
trap 'rm -f "$TEMP_FILE"' EXIT
awk -v section="## $SECTION" -v entry="$ENTRY" '
    {print}
    $0 == section {print entry}
' "$MEMORY_FILE" > "$TEMP_FILE"

if [ -s "$TEMP_FILE" ]; then
    mv "$TEMP_FILE" "$MEMORY_FILE"
    echo "Memory added:"
    echo "$ENTRY"
    echo ""
    echo "Category: $CATEGORY"
    echo "File: $MEMORY_FILE"
else
    rm -f "$TEMP_FILE"
    echo "Error: Failed to add memory. Section '$SECTION' not found."
    exit 1
fi
