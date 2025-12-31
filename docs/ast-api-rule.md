# Termdock AST API - LLM Integration Guide

> This document teaches LLMs how to use Termdock's AST API for code intelligence.
> Copy this into your LLM's system prompt, rules, or context.

## When to Use This API

Use the AST API when the user asks about:
- Code structure ("where is X defined?", "what calls Y?")
- Symbol search ("find all services", "show me interfaces")
- Dependencies ("what does this file import?", "who uses this module?")
- Call hierarchy ("what functions call X?", "what does X call?")

## Prerequisites

1. **Termdock must be running** with AST API enabled (default port: 3032)
2. **Get workspace ID first** - all queries require a workspace parameter

## Quick Start

### Step 1: Get Workspace ID

```bash
curl -s 'http://localhost:3033/api/workspaces' | jq '.data.workspaces[] | {id, name}'
```

Example output:
```json
{"id": "ws_abc123", "name": "my-project"}
```

### Step 2: Search Symbols

```bash
# Find symbols by name
curl -s 'http://localhost:3033/api/search?q=UserService&workspace=ws_abc123'
```

---

## Complete API Reference

### Health & Status

#### Check Health
```bash
curl 'http://localhost:3033/health'
# or
curl 'http://localhost:3033/api/health'
```

Returns: service status, uptime, index statistics

---

### Workspace Management

#### List All Workspaces
```bash
curl 'http://localhost:3033/api/workspaces'
```

Response fields:
- `workspaces[]` - Array of workspace objects
- `total` - Total workspace count
- `currentWorkspace` - Currently active workspace ID

#### Get Single Workspace
```bash
curl 'http://localhost:3033/api/workspaces/<wsId>'
```

Returns: workspace details including index size, status, project root

---

### Symbol Search & Details

#### Search Symbols
```bash
curl 'http://localhost:3033/api/search?q=<query>&workspace=<wsId>&limit=<n>'
```

Parameters:
- `q` - Search query (required)
- `workspace` - Workspace ID (required)
- `limit` - Max results (default: 50)

#### Get Symbol Details
```bash
curl 'http://localhost:3033/api/symbols/<symbolId>?workspace=<wsId>'
```

---

### Graph Queries

#### Analyze File Dependencies
```bash
curl 'http://localhost:3033/api/graph/deps?file=<relativePath>&workspace=<wsId>'
```

Returns: imports and exports for the specified file

#### Trace Outgoing Calls (what does X call?)
```bash
curl 'http://localhost:3033/api/graph/calls?from=<symbolId>&workspace=<wsId>'
```

#### Trace Incoming Calls (what calls X?)
```bash
curl 'http://localhost:3033/api/graph/callers?to=<symbolId>&workspace=<wsId>'
```

---

### Code Slice Generation

#### Generate AST Slice
```bash
curl 'http://localhost:3033/api/ast/slice?id=<symbolId>&depth=<1-2>&fanout=<n>&workspace=<wsId>'
```

Parameters:
- `id` - Symbol ID (required)
- `depth` - Traversal depth, 1-2 (default: 1)
- `fanout` - Max related symbols per node (default: 10, max: 50)

Returns: nodes and edges representing the code slice graph

---

### Advanced Queries

#### Unified Query Endpoint (POST)
```bash
curl -X POST 'http://localhost:3033/api/query' \
  -H 'Content-Type: application/json' \
  -d '{
    "method": "search",
    "params": {"query": "Service", "maxResults": 20},
    "workspace": "<wsId>"
  }'
```

Supported methods:
- `search` - Search symbols
- `symbols` - Get symbol details by IDs
- `relations` - Get symbol relationships
- `slice` - Generate code slice
- `analyze` - Analyze file

#### Natural Language Query (POST)
```bash
curl -X POST 'http://localhost:3033/api/ask' \
  -H 'Content-Type: application/json' \
  -d '{
    "intent": "find all classes that handle authentication",
    "workspace": "<wsId>",
    "context": {
      "currentFile": "src/auth/login.ts"
    }
  }'
```

#### Manual Index Update (POST)
```bash
curl -X POST 'http://localhost:3033/api/index/update' \
  -H 'Content-Type: application/json' \
  -d '{"workspace": "<wsId>"}'
```

---

## Symbol Types

| Type Code | Meaning |
|-----------|---------|
| 5 | Class |
| 6 | Method |
| 11 | Interface |
| 12 | Function |
| 13 | Variable |

---

## Common Patterns

### Find All Classes
```bash
curl -s 'http://localhost:3033/api/search?q=Service&workspace=<wsId>' | \
  jq '.data[] | select(.type == 5) | {name, file}'
```

### Trace a Function's Callers
```bash
# First, find the symbol
SYMBOL=$(curl -s 'http://localhost:3033/api/search?q=handleRequest&workspace=<wsId>' | jq -r '.data[0].symbolId')

# Then, find who calls it
curl -s "http://localhost:3033/api/graph/callers?to=${SYMBOL}&workspace=<wsId>"
```

### Analyze Import Dependencies
```bash
curl -s 'http://localhost:3033/api/graph/deps?file=src/main/index.ts&workspace=<wsId>' | \
  jq '.data.imports'
```

### Use Natural Language for Complex Queries
```bash
curl -s -X POST 'http://localhost:3033/api/ask' \
  -H 'Content-Type: application/json' \
  -d '{"intent":"show me all React components that use useState","workspace":"<wsId>"}' | jq
```

---

## Error Handling

| Status | Meaning |
|--------|---------|
| `200` | Success |
| `400` | Missing/invalid parameters |
| `404` | Workspace or symbol not found |
| `429` | Rate limit exceeded |
| `503` | AST service not ready (index loading) |

---

## Tips for LLMs

1. **Always get workspace ID first** - Cache it for the session
2. **Use jq for filtering** - The API returns detailed data, filter what you need
3. **Combine searches** - Use search -> get details -> trace calls workflow
4. **Check symbol type** - Filter by type code to find specific kinds of symbols
5. **Relative paths** - File paths in queries should be relative to workspace root
6. **Use POST /api/query for complex queries** - More flexible than REST endpoints
7. **Use POST /api/ask for fuzzy queries** - Natural language when exact query is unclear

---

## Integration Examples

### For Cursor/Aider/Claude Code
Add this to your rules or system prompt, then the LLM can use bash to query the API.

### For ChatGPT/Gemini with Plugins
Use the OpenAPI spec at `/api/openapi.json` (if available) for function calling.

### For Custom Integrations
The API is standard REST + JSON. Any HTTP client works.

---

**API Base**: `http://localhost:3033`
**Documentation**: https://termdock.com/docs/ast-api
