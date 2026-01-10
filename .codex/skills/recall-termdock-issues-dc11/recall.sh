#!/bin/bash
# Usage: ./recall.sh <query>
# Search memory library using BM25 ranking (with grep fallback)

MEMORY_GROUP_ID="default"
MEMORY_FILE="$HOME/.termdock/memory/groups/$MEMORY_GROUP_ID/index.md"
API_BASE="${TERMDOCK_API_BASE:-http://localhost:3033}"
CURL_TIMEOUT=5

QUERY="$1"

if [ -z "$QUERY" ]; then
    echo "Usage: recall <query>"
    echo "Example: recall authentication"
    echo "Example: recall \"error handling\""
    exit 1
fi

# URL encode the query
url_encode() {
    local string="$1"
    printf '%s' "$string" | jq -sRr @uri 2>/dev/null || printf '%s' "$string"
}

# Try BM25 API first (more intelligent search)
try_bm25_search() {
    local query_encoded
    query_encoded=$(url_encode "$QUERY")

    # Get workspace path from git root (skill runs in skill directory, not project root)
    local workspace_path
    workspace_path=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
    local workspace_encoded
    workspace_encoded=$(url_encode "$workspace_path")

    local result
    result=$(curl -s --max-time "$CURL_TIMEOUT" \
        "$API_BASE/api/memory/search?q=$query_encoded&workspace=$workspace_encoded&limit=10" 2>/dev/null)

    # Check if API call succeeded
    if [ -z "$result" ]; then
        return 1
    fi

    local success
    success=$(echo "$result" | jq -r '.success' 2>/dev/null)

    if [ "$success" != "true" ]; then
        return 1
    fi

    local total
    total=$(echo "$result" | jq -r '.data.total' 2>/dev/null)

    echo "=== BM25 Search: $QUERY ==="
    echo ""

    if [ "$total" = "0" ] || [ "$total" = "null" ]; then
        echo "No memories found for: $QUERY"
        echo ""
        echo "Tip: Try different keywords or check available categories:"
        echo "  - Architecture Decisions"
        echo "  - Lessons Learned"
        echo "  - Patterns"
        echo "  - Style Preferences"
        return 0
    fi

    # Output formatted results with scores
    echo "$result" | jq -r '
        .data.results[] |
        "[\(.category | ascii_upcase)] (score: \(.score | tostring | .[0:4])) \(.content)"
    ' 2>/dev/null

    echo ""
    echo "Found $total result(s)"
    return 0
}

# Fallback to grep search
grep_fallback() {
    if [ ! -f "$MEMORY_FILE" ]; then
        echo "Memory file not found: $MEMORY_FILE"
        echo "Creating empty memory library..."
        mkdir -p "$(dirname "$MEMORY_FILE")"
        cat > "$MEMORY_FILE" << 'EOF'
# Termdock Memory Library

## Architecture Decisions

## Lessons Learned

## Patterns

## Style Preferences

EOF
        echo "Memory library initialized at $MEMORY_FILE"
        exit 0
    fi

    echo "=== Searching memories for: $QUERY ==="
    echo "(Using grep fallback - Termdock API not available)"
    echo ""

    # Use -- to prevent query from being interpreted as grep flags
    RESULTS=$(grep -i -n -- "$QUERY" "$MEMORY_FILE")

    if [ -z "$RESULTS" ]; then
        echo "No memories found for: $QUERY"
        echo ""
        echo "Tip: Try different keywords or check available categories:"
        echo "  - Architecture Decisions"
        echo "  - Lessons Learned"
        echo "  - Patterns"
        echo "  - Style Preferences"
    else
        echo "$RESULTS"
    fi
}

# Main: Try BM25 first, fallback to grep
if try_bm25_search; then
    exit 0
else
    grep_fallback
fi
