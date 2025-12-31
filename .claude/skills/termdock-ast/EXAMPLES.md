# AST API - Real Examples

This file contains real examples using the Termdock codebase.

## Example 1: Find All Service Classes

```bash
# Search for classes with "Service" in the name
curl -s 'http://localhost:3033/api/search?q=Service&workspace=ws_1759060469089_96y0sxcz7&limit=20' | jq '.data[] | select(.type == 5) | {name, file: (.file | split("/") | last)}'
```

**Expected Output**:
```json
{"name": "TerminalService", "file": "TerminalService.ts"}
{"name": "MockTerminalService", "file": "MockTerminalService.ts"}
{"name": "WorkspaceService", "file": "WorkspaceService.ts"}
...
```

## Example 2: Analyze TerminalService Dependencies

```bash
curl -s 'http://localhost:3033/api/graph/deps?file=src/main/services/TerminalService.ts&workspace=ws_1759060469089_96y0sxcz7' | jq '.data'
```

**Expected Output**:
```json
{
  "file": "src/main/services/TerminalService.ts",
  "imports": [
    {"spec": "electron", "symbols": ["ipcMain"], "type": "package"},
    {"spec": "./terminal/HybridTerminalManager", "type": "relative"}
  ],
  "exports": [
    {"name": "TerminalService", "type": "class", "isDefault": false}
  ]
}
```

## Example 3: Find Methods in a Class

```bash
# First find the class file
FILE=$(curl -s 'http://localhost:3033/api/search?q=TerminalService&workspace=ws_1759060469089_96y0sxcz7&limit=1' | jq -r '.data[0].file')

# Then search for methods and filter by that file
curl -s 'http://localhost:3033/api/search?q=&workspace=ws_1759060469089_96y0sxcz7&limit=100' | jq --arg file "$FILE" '.data[] | select(.file == $file and .type == 6) | {name, line}'
```

## Example 4: Trace initialize() Callers

```bash
# 1. Find initialize method
SYMBOL_ID=$(curl -s 'http://localhost:3033/api/search?q=initialize&workspace=ws_1759060469089_96y0sxcz7&limit=1' | jq -r '.data[0].symbolId')

# 2. Find what calls it
curl -s "http://localhost:3033/api/graph/callers?to=${SYMBOL_ID}&workspace=ws_1759060469089_96y0sxcz7" | jq '.data'
```

## Example 5: Get Code Slice for Context

```bash
# Get TerminalService with 2 levels of relationships
SYMBOL_ID=$(curl -s 'http://localhost:3033/api/search?q=TerminalService&workspace=ws_1759060469089_96y0sxcz7&limit=1' | jq -r '.data[0].symbolId')

curl -s "http://localhost:3033/api/ast/slice?id=${SYMBOL_ID}&depth=2&workspace=ws_1759060469089_96y0sxcz7" | jq '.data'
```

## Example 6: Check Index Health

```bash
curl -s 'http://localhost:3033/health' | jq '.data.statistics'
```

**Expected Output**:
```json
{
  "totalQueries": 42,
  "indexSize": 6542,
  "lastIndexUpdate": "2025-12-30T10:39:00.320Z"
}
```

## Example 7: List All Workspaces

```bash
curl -s 'http://localhost:3033/api/workspaces' | jq '.data.workspaces[] | {id, name, indexSize, status}'
```

## Useful jq Filters

```bash
# Get only classes (type 5)
jq '.data[] | select(.type == 5)'

# Get only functions (type 12)
jq '.data[] | select(.type == 12)'

# Filter by file name
jq '.data[] | select(.file | contains("Terminal"))'

# Extract just names and files
jq '.data[] | {name, file: (.file | split("/") | last)}'

# Count results
jq '.data | length'
```
