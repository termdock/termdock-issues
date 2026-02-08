#!/bin/bash
# Usage: ./remember.sh <category> <content>
# Add new memory to the library via API (with file fallback)

MEMORY_GROUP_ID="default"
MEMORY_FILE="$HOME/.termdock/memory/groups/$MEMORY_GROUP_ID/index.md"
API_BASE="${TERMDOCK_API_BASE:-http://localhost:3033}"
CURL_TIMEOUT=5

CATEGORY="$1"
shift
CONTENT="$*"
DATE=$(date +%Y-%m-%d)
WORKSPACE=$(git rev-parse --show-toplevel 2>/dev/null || pwd)

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

# Validate and normalize category (aliases -> canonical names for API)
case "$CATEGORY" in
    architecture|arch) SECTION="Architecture Decisions"; API_CATEGORY="architecture" ;;
    lesson|lessons)    SECTION="Lessons Learned";        API_CATEGORY="lesson" ;;
    pattern|patterns)  SECTION="Common Patterns";        API_CATEGORY="pattern" ;;
    style)             SECTION="Code Style Preferences"; API_CATEGORY="style" ;;
    preference|pref)   SECTION="Work Preferences";       API_CATEGORY="preference" ;;
    *)
        echo "Unknown category: $CATEGORY"
        echo "Valid categories: architecture, lesson, pattern, style, preference"
        exit 1
        ;;
esac

# Try API first - this updates BM25 index and avoids shell operator issues
try_api_remember() {
    # Require curl and jq for API path
    if ! command -v curl >/dev/null 2>&1 || ! command -v jq >/dev/null 2>&1; then
        return 1
    fi

    local payload
    payload=$(jq -n \
        --arg category "$API_CATEGORY" \
        --arg content "$CONTENT" \
        --arg workspace "$WORKSPACE" \
        '{category: $category, content: $content, workspace: $workspace}')

    local result
    result=$(curl -s --max-time "$CURL_TIMEOUT" \
        -X POST "$API_BASE/api/memory/remember" \
        -H "Content-Type: application/json" \
        -d "$payload" 2>/dev/null)

    if [ -z "$result" ]; then
        return 1
    fi

    local success
    success=$(echo "$result" | jq -r '.success' 2>/dev/null)

    if [ "$success" = "true" ]; then
        echo "Memory added via API:"
        echo "  Category: $API_CATEGORY"
        echo "  Content: $CONTENT"
        echo "  Workspace: $(basename "$WORKSPACE")"
        return 0
    fi

    # Log API error if available
    local error_msg
    error_msg=$(echo "$result" | jq -r '.error // empty' 2>/dev/null)
    [ -n "$error_msg" ] && echo "API error: $error_msg" >&2

    return 1
}

# Fallback: write directly to file
file_fallback() {
    local content_safe
    content_safe=$(printf '%s' "$CONTENT" | tr -d '\000-\037' | sed 's/[`$]/\\&/g')

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

    local entry="- [$DATE] [$(basename "$WORKSPACE")] $content_safe"

    local temp_file
    temp_file=$(mktemp)
    trap 'rm -f "$temp_file"' EXIT

    awk -v section="## $SECTION" -v entry="$entry" '
        BEGIN { found=0 }
        { print }
        $0 == section { print entry; found=1 }
        END { if (found == 0) exit 1 }
    ' "$MEMORY_FILE" > "$temp_file"

    if [ $? -eq 0 ]; then
        mv "$temp_file" "$MEMORY_FILE"
        echo "Memory added (file fallback):"
        echo "  Category: $API_CATEGORY"
        echo "  Content: $CONTENT"
        echo "  File: $MEMORY_FILE"
    else
        rm -f "$temp_file"
        echo "Error: Failed to add memory. Section '$SECTION' not found."
        exit 1
    fi
}

# Main: Try API first, fallback to file write
if try_api_remember; then
    exit 0
else
    echo "(API not available, using file fallback)"
    file_fallback
fi
