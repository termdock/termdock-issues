---
name: termdock-ast
description: ALWAYS query this AST API BEFORE any codebase exploration (Glob, Grep, Read). First establish structural understanding: what classes exist, how files depend on each other, where symbols are defined. Then perform targeted file operations. This prevents blind searching and reduces token waste significantly.
---

# Termdock AST API - Complete Guide

This skill enables you to query a pre-built AST index of the codebase. Use it to help developers understand code structure, find definitions, and analyze relationships.

## Configuration

- **API Base**: `http://localhost:3033` (production)
- **Required**: Always include `workspace` parameter in requests

## Step 1: Get Workspace ID

First, identify the active workspace:

```bash
curl -s 'http://localhost:3033/api/workspaces' | jq '.data.workspaces[] | {id, name, indexSize}'
```

Use the workspace `id` in all subsequent requests.

---

## API Reference

### 1. Search Symbols

**Purpose**: Find classes, functions, interfaces, variables by name.

```bash
curl 'http://localhost:3033/api/search?q=<query>&workspace=<wsId>&limit=<n>'
```

**Parameters**:
| Param | Required | Description |
|-------|----------|-------------|
| q | Yes | Search term (partial match supported) |
| workspace | Yes | Workspace ID |
| limit | No | Max results (default: 50) |

**Response Example**:
```json
{
  "success": true,
  "data": [
    {
      "symbolId": "abc123def456",
      "name": "TerminalService",
      "type": 5,
      "file": "/absolute/path/to/TerminalService.ts",
      "line": 111,
      "column": 0,
      "detail": "class TerminalService",
      "documentation": "Manages terminal sessions...",
      "tags": ["export"]
    }
  ]
}
```

**Symbol Fields**:
| Field | Description |
|-------|-------------|
| detail | Function signature or type declaration |
| documentation | JSDoc/docstring content |
| tags | `["export", "default", "async", ...]` |

**Symbol Types**:
| type | Meaning | Example |
|------|---------|---------|
| 5 | Class | `class TerminalService {}` |
| 6 | Method | `initialize() {}` inside class |
| 7 | Property | `private sessions: Map<>` |
| 11 | Interface | `interface Config {}` |
| 12 | Function | `function createSession() {}` |
| 13 | Variable | `const instance = ...` |

---

### 2. Get Symbol Details

**Purpose**: Get full information about a specific symbol.

```bash
curl 'http://localhost:3033/api/symbols/<symbolId>?workspace=<wsId>'
```

**Response**: Full symbol with location, signature, and metadata.

---

### 3. Analyze File Dependencies

**Purpose**: Understand what a file imports and exports.

```bash
curl 'http://localhost:3033/api/graph/deps?file=<relativePath>&workspace=<wsId>'
```

**Parameters**:
| Param | Required | Description |
|-------|----------|-------------|
| file | Yes | Relative path from project root (e.g., `src/main/services/TerminalService.ts`) |
| workspace | Yes | Workspace ID |

**Response Example**:
```json
{
  "success": true,
  "data": {
    "file": "src/main/services/TerminalService.ts",
    "imports": [
      {"spec": "electron", "symbols": ["ipcMain"], "type": "package"},
      {"spec": "./utils", "resolvedFile": "src/main/utils.ts", "type": "relative"}
    ],
    "exports": [
      {"name": "TerminalService", "type": "class", "isDefault": false}
    ]
  }
}
```

**Who imports this file?** (reverse dependency)
```bash
curl 'http://localhost:3033/api/graph/importers?file=<relativePath>&workspace=<wsId>'
```

**Response Example**:
```json
{
  "success": true,
  "data": {
    "file": "src/utils/llmResponseParser.ts",
    "importers": [
      "src/services/stage1SearchService.ts",
      "src/services/stage2ClassificationService.ts"
    ],
    "count": 2
  }
}
```

---

### 4. Trace Function Calls

**What does this function call?**
```bash
curl 'http://localhost:3033/api/graph/calls?from=<symbolId>&workspace=<wsId>'
```

**What calls this function?**
```bash
curl 'http://localhost:3033/api/graph/callers?to=<symbolId>&workspace=<wsId>'
```

**Response**: Array of call edges with source, target, and call site location.

---

### 5. Generate Code Slice

**Purpose**: Get a symbol with its related context (callers, callees, dependencies).

```bash
curl 'http://localhost:3033/api/ast/slice?id=<symbolId>&depth=<1-2>&workspace=<wsId>'
```

**Parameters**:
| Param | Required | Description |
|-------|----------|-------------|
| id | Yes | Symbol ID |
| depth | No | 1 or 2 levels of relationships (default: 1) |
| workspace | Yes | Workspace ID |

**Response**: Nodes (symbols) and edges (relationships) forming a subgraph.

---

### 6. Unified Query API

**Purpose**: Programmatic query interface for relations, symbols, slices.

```bash
curl -X POST 'http://localhost:3033/api/query' \
  -H 'Content-Type: application/json' \
  -d '{
    "method": "relations",
    "params": {
      "symbolIds": ["<symbolId>"],
      "include": ["callers"]
    },
    "workspace": "<wsId>"
  }'
```

**Methods**:
| method | params | Description |
|--------|--------|-------------|
| symbols | `{ query, filters, maxResults }` | Search symbols |
| relations | `{ symbolIds, include: ["calls"|"callers"] }` | Get call relationships |
| slice | `{ symbolIds, depth }` | Generate code slice |
| analyze | `{ symbolIds, include }` | Analyze symbols |

**Response Format**:
```json
{
  "success": true,
  "data": {
    "symbols": [...],
    "relations": [
      {
        "sourceSymbol": "abc123",
        "targetSymbol": "def456",
        "relationType": "Calls",
        "location": { "uri": "file://...", "range": {...} }
      }
    ]
  },
  "meta": { "totalResults": 3, "processingTime": 42 }
}
```

---

### 7. Rebuild Index

**Purpose**: Refresh the index after code changes.

```bash
curl -X POST 'http://localhost:3033/api/index/update' \
  -H 'Content-Type: application/json' \
  -d '{"workspace":"<wsId>"}'
```

---

### 8. Batch Callers Query

**Purpose**: Query callers for multiple symbols in one request.

```bash
curl -X POST 'http://localhost:3033/api/graph/callers/batch' \
  -H 'Content-Type: application/json' \
  -d '{"symbolIds":["abc123","def456"],"workspace":"<wsId>"}'
```

**Response Example**:
```json
{
  "success": true,
  "data": {
    "results": [
      { "symbolId": "abc123", "callers": [...] },
      { "symbolId": "def456", "callers": [...] }
    ],
    "totalSymbols": 2,
    "totalCallers": 5
  }
}
```

---

### 9. Impact Analysis

**Purpose**: Find all symbols and files affected if you change a function (recursive callers).

```bash
curl 'http://localhost:3033/api/impact?symbolId=<id>&depth=2&workspace=<wsId>'
```

**Parameters**:
| Param | Required | Description |
|-------|----------|-------------|
| symbolId | Yes | The symbol to analyze |
| depth | No | Recursion depth 1-3 (default: 2) |
| workspace | Yes | Workspace ID |

**Response Example**:
```json
{
  "success": true,
  "data": {
    "rootSymbol": "abc123",
    "depth": 2,
    "impactedSymbols": {
      "abc123": { "depth": 1, "callers": ["def456", "ghi789"] },
      "def456": { "depth": 2, "callers": ["jkl012"] }
    },
    "impactedFiles": ["src/services/foo.ts", "src/handlers/bar.ts"],
    "totalImpacted": 2,
    "totalFiles": 2
  }
}
```

---

## Common Workflows

### Workflow A: Understand a Class

```bash
# 1. Find the class
curl 'http://localhost:3033/api/search?q=TerminalService&workspace=ws_xxx&limit=1'
# Note the symbolId and file path

# 2. Get its imports/exports
curl 'http://localhost:3033/api/graph/deps?file=src/main/services/TerminalService.ts&workspace=ws_xxx'

# 3. Find all methods in this class
curl 'http://localhost:3033/api/search?q=initialize&workspace=ws_xxx&limit=20'
# Filter results by file path matching TerminalService.ts
```

### Workflow B: Trace a Function's Usage

```bash
# 1. Find the function
curl 'http://localhost:3033/api/search?q=createSession&workspace=ws_xxx&limit=5'
# Get the symbolId

# 2. Find what calls it
curl 'http://localhost:3033/api/graph/callers?to=<symbolId>&workspace=ws_xxx'

# 3. Find what it calls
curl 'http://localhost:3033/api/graph/calls?from=<symbolId>&workspace=ws_xxx'
```

### Workflow C: Analyze Module Structure

```bash
# 1. Get all symbols in a specific file
curl 'http://localhost:3033/api/search?q=&workspace=ws_xxx&limit=100'
# Filter by file path in results

# 2. Analyze dependencies
curl 'http://localhost:3033/api/graph/deps?file=src/main/index.ts&workspace=ws_xxx'
```

---

## Important Notes

1. **Line Numbers**: API returns 0-indexed lines. Add 1 when displaying to users.

2. **Relative Paths**: Use relative paths from project root for `/api/graph/deps`.

3. **Workspace Isolation**: Each workspace has completely isolated indexes. Querying workspace A will never return results from workspace B. The system uses:
   - LRU eviction (max 5 workspaces in memory)
   - 30-minute idle cleanup for unused workspaces
   - Per-project persistent index files (`~/.termdock/ast-indices/`)

4. **Index Freshness**: Call `/api/index/update` after significant code changes.

5. **Symbol IDs**: These are stable hashes based on file path, symbol name, and type. Use them for precise lookups.

---

## Error Handling

All responses follow this format:
```json
{
  "success": true|false,
  "data": {...},
  "error": {"code": "ERROR_CODE", "message": "..."},
  "timestamp": "...",
  "requestId": "..."
}
```

Check `success` field before processing `data`.
