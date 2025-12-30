---
name: ast-api
description: Use this skill to understand codebase structure, find symbols (classes, functions, interfaces), analyze file dependencies, trace call hierarchies, and explore code relationships. Activate when user asks about code structure, wants to find where something is defined, needs to understand imports/exports, or wants to trace function calls.
---

# Termdock AST API - Complete Guide

This skill enables you to query a pre-built AST index of the codebase. Use it to help developers understand code structure, find definitions, and analyze relationships.

## Configuration

- **API Base**: `http://localhost:3032`
- **Required**: Always include `workspace` parameter in requests

## Step 1: Get Workspace ID

First, identify the active workspace:

```bash
curl -s 'http://localhost:3032/api/workspaces' | jq '.data.workspaces[] | {id, name, indexSize}'
```

Use the workspace `id` in all subsequent requests.

---

## API Reference

### 0. Health Check

**Purpose**: Verify API is running and get index statistics.

```bash
curl 'http://localhost:3032/health'
```

**Response**: Service status, uptime, total symbols indexed.

---

### 0.5 Get Single Workspace

**Purpose**: Get detailed info about a specific workspace.

```bash
curl 'http://localhost:3032/api/workspaces/<wsId>'
```

**Response**: Workspace details including index size, status, project root.

---

### 1. Search Symbols

**Purpose**: Find classes, functions, interfaces, variables by name.

```bash
curl 'http://localhost:3032/api/search?q=<query>&workspace=<wsId>&limit=<n>'
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
      "column": 0
    }
  ]
}
```

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
curl 'http://localhost:3032/api/symbols/<symbolId>?workspace=<wsId>'
```

**Response**: Full symbol with location, signature, and metadata.

---

### 3. Analyze File Dependencies

**Purpose**: Understand what a file imports and exports.

```bash
curl 'http://localhost:3032/api/graph/deps?file=<relativePath>&workspace=<wsId>'
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

---

### 4. Trace Function Calls

**What does this function call?**
```bash
curl 'http://localhost:3032/api/graph/calls?from=<symbolId>&workspace=<wsId>'
```

**What calls this function?**
```bash
curl 'http://localhost:3032/api/graph/callers?to=<symbolId>&workspace=<wsId>'
```

**Response**: Array of call edges with source, target, and call site location.

---

### 5. Generate Code Slice

**Purpose**: Get a symbol with its related context (callers, callees, dependencies).

```bash
curl 'http://localhost:3032/api/ast/slice?id=<symbolId>&depth=<1-2>&fanout=<n>&workspace=<wsId>'
```

**Parameters**:
| Param | Required | Description |
|-------|----------|-------------|
| id | Yes | Symbol ID |
| depth | No | 1 or 2 levels of relationships (default: 1) |
| fanout | No | Max related symbols per node (default: 10, max: 50) |
| workspace | Yes | Workspace ID |

**Response**: Nodes (symbols) and edges (relationships) forming a subgraph.

---

### 6. Unified Query (POST)

**Purpose**: Flexible query interface for complex operations.

```bash
curl -X POST 'http://localhost:3032/api/query' \
  -H 'Content-Type: application/json' \
  -d '{"method":"search","params":{"query":"Service","maxResults":20},"workspace":"<wsId>"}'
```

**Supported Methods**:
| method | Description |
|--------|-------------|
| search | Search symbols by name |
| symbols | Get symbol details by IDs |
| relations | Get symbol relationships |
| slice | Generate code slice |
| analyze | Analyze file structure |

---

### 7. Natural Language Query

**Purpose**: Ask questions in plain English.

```bash
curl -X POST 'http://localhost:3032/api/ask' \
  -H 'Content-Type: application/json' \
  -d '{"intent":"find all classes that handle terminal sessions","workspace":"<wsId>"}'
```

---

### 8. Rebuild Index

**Purpose**: Refresh the index after code changes.

```bash
curl -X POST 'http://localhost:3032/api/index/update' \
  -H 'Content-Type: application/json' \
  -d '{"workspace":"<wsId>"}'
```

---

## Common Workflows

### Workflow A: Understand a Class

```bash
# 1. Find the class
curl 'http://localhost:3032/api/search?q=TerminalService&workspace=ws_xxx&limit=1'
# Note the symbolId and file path

# 2. Get its imports/exports
curl 'http://localhost:3032/api/graph/deps?file=src/main/services/TerminalService.ts&workspace=ws_xxx'

# 3. Find all methods in this class
curl 'http://localhost:3032/api/search?q=initialize&workspace=ws_xxx&limit=20'
# Filter results by file path matching TerminalService.ts
```

### Workflow B: Trace a Function's Usage

```bash
# 1. Find the function
curl 'http://localhost:3032/api/search?q=createSession&workspace=ws_xxx&limit=5'
# Get the symbolId

# 2. Find what calls it
curl 'http://localhost:3032/api/graph/callers?to=<symbolId>&workspace=ws_xxx'

# 3. Find what it calls
curl 'http://localhost:3032/api/graph/calls?from=<symbolId>&workspace=ws_xxx'
```

### Workflow C: Analyze Module Structure

```bash
# 1. Get all symbols in a specific file
curl 'http://localhost:3032/api/search?q=&workspace=ws_xxx&limit=100'
# Filter by file path in results

# 2. Analyze dependencies
curl 'http://localhost:3032/api/graph/deps?file=src/main/index.ts&workspace=ws_xxx'
```

---

## Important Notes

1. **Line Numbers**: API returns 0-indexed lines. Add 1 when displaying to users.

2. **Relative Paths**: Use relative paths from project root for `/api/graph/deps`.

3. **Workspace Isolation**: Each workspace has its own index. Always specify the correct workspace.

4. **Index Freshness**: Call `/api/index/update` after significant code changes.

5. **Symbol IDs**: These are stable hashes. Use them for precise lookups.

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
