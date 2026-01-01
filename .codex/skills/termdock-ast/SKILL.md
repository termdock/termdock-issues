---
name: termdock-ast
description: "Use the Termdock AST API to locate symbols, dependencies, callers/callees, or impact before exploring unknown code. Skip when the user gives an exact file path or only needs a literal string search."
---

# Termdock AST API

## When to Use This Skill

**Use AST API first when:**
- The user asks "where is X", "who calls X", "what does X call", or "what depends on X"
- You need a file path or symbol ownership before editing
- You expect a change to touch multiple files or affect behavior
- You are about to run broad search without a known target

**Skip AST API when:**
- The user provides an exact file path or a snippet to edit
- The task is doc-only or config-only (SKILL.md, README, settings)
- You only need a literal-string search

**Default rule:** Use AST for discovery and impact; skip it for known-file edits.

**If API is unavailable:** Fall back to `rg`/`rg --files` and note the limitation.

---

## Quick Start

### Step 1: Get Workspace ID (Required First)
```bash
curl -s 'http://localhost:3033/api/workspaces' | jq '.data.workspaces[0].id'
```
Save this ID for all subsequent calls.

### Step 2: Choose Your Query Type

| Goal | API | Example |
|------|-----|---------|
| Find symbol by name | `/api/search` | "Where is UserService?" |
| See file imports/exports | `/api/graph/deps` | "What does this file import?" |
| Find callers | `/api/graph/callers` | "Who calls this function?" |
| Find callees | `/api/graph/calls` | "What does this function call?" |
| Impact analysis | `/api/impact` | "What breaks if I change this?" |

---

## API Reference

### 1. Search Symbols
```bash
curl 'http://localhost:3033/api/search?q=<name>&workspace=<wsId>&limit=10'
```

**Response fields:**
- `symbolId`: Use for callers/calls queries
- `file`: Absolute path
- `line`: 0-indexed (add 1 for display)
- `type`: 5=Class, 6=Method, 11=Interface, 12=Function

### 2. File Dependencies
```bash
curl 'http://localhost:3033/api/graph/deps?file=src/path/to/file.ts&workspace=<wsId>'
```

Returns: imports (what this file uses) and exports (what it provides)

### 3. Who Calls This?
```bash
curl 'http://localhost:3033/api/graph/callers?to=<symbolId>&workspace=<wsId>'
```

### 4. What Does This Call?
```bash
curl 'http://localhost:3033/api/graph/calls?from=<symbolId>&workspace=<wsId>'
```

### 5. Impact Analysis
```bash
curl 'http://localhost:3033/api/impact?symbolId=<id>&depth=2&workspace=<wsId>'
```

Returns all symbols and files affected by changing this symbol.

---

## Decision Flowchart

```
User asks about code
        |
        v
Is it a "where is X?" question?
    |yes              |no
    v                 v
/api/search      Is it about dependencies?
    |                 |yes         |no
    v                 v            v
Got symbolId?    /api/graph/deps  Is it about call chain?
    |yes                              |yes         |no
    v                                 v            v
Need callers? -----> /api/graph/callers   Use other tools
Need callees? -----> /api/graph/calls
Need impact?  -----> /api/impact
```

---

## Common Patterns

### Pattern A: Find and Understand a Class
```bash
# 1. Find it
curl 'http://localhost:3033/api/search?q=TerminalService&workspace=ws_xxx&limit=1'
# Note: symbolId, file

# 2. See dependencies
curl 'http://localhost:3033/api/graph/deps?file=src/main/services/TerminalService.ts&workspace=ws_xxx'

# 3. Now read the file with context
```

### Pattern B: Trace Usage
```bash
# 1. Find function
curl 'http://localhost:3033/api/search?q=createSession&workspace=ws_xxx&limit=5'
# Pick the right symbolId

# 2. Find all callers
curl 'http://localhost:3033/api/graph/callers?to=<symbolId>&workspace=ws_xxx'
```

### Pattern C: Safe Refactoring
```bash
# Before changing a function, check impact
curl 'http://localhost:3033/api/impact?symbolId=<id>&depth=2&workspace=ws_xxx'
# Review impactedFiles before making changes
```

---

## Error Handling

| Error | Cause | Action |
|-------|-------|--------|
| No workspace found | API not running | Start Termdock app |
| Empty search results | Symbol not indexed | Try partial name or rebuild index |
| 404 on symbolId | Stale ID after code change | Re-search to get new ID |

**Rebuild index after code changes:**
```bash
curl -X POST 'http://localhost:3033/api/index/update' -H 'Content-Type: application/json' -d '{"workspace":"<wsId>"}'
```

---

## Response Format

All APIs return:
```json
{
  "success": true|false,
  "data": {...},
  "error": {"code": "...", "message": "..."}
}
```

Always check `success` before using `data`.

---

## Key Notes

1. **Line numbers are 0-indexed** - Add 1 when showing to users
2. **Use relative paths** for /api/graph/deps (e.g., `src/main/...`)
3. **Symbol IDs are stable** until code changes
4. **API base**: `http://localhost:3033` (prod) or `:3032` (dev)
