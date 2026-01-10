---
name: recall
description: Retrieves cross-session memories about past decisions, lessons, and patterns. Use when user asks about prior work, past decisions, or mentions a feature. Triggers include check memory, what did we decide, how did we solve.
context: fork
allowed-tools:
  - Bash
---

## Proactive Usage Guidelines

**You should proactively use this skill when:**

1. **Session Start**: When user mentions a feature/module, search for related memories first
   - User says "let's work on authentication" → `./recall.sh authentication`
   - User mentions a specific service → search for prior decisions about it

2. **Before Decisions**: Before making architectural or technical choices
   - About to choose a library → check if there's a prior decision
   - Designing a new feature → search for related patterns

3. **After Problem Solving**: When you've solved a tricky issue
   - Found a non-obvious bug → `./remember.sh lesson "description"`
   - Made an important decision → `./remember.sh architecture "description"`

4. **Encountering Familiar Issues**: When something seems like a recurring problem
   - Error looks familiar → search lessons learned

## Commands

| Action | Command |
|--------|---------|
| Search memories | `./recall.sh <keywords>` |
| Save memory | `./remember.sh <category> "<content>"` |
| Remove outdated | `./forget.sh "<keywords>"` |

## Categories

`architecture` - Design decisions, technology choices
`lesson` - Gotchas, debugging discoveries, edge cases
`pattern` - Reusable solutions, conventions
`style` - Naming, code organization
`preference` - Tooling, workflow choices

## Examples

```bash
./recall.sh terminal session
./recall.sh "error handling"
./remember.sh lesson "node-pty requires explicit shell path on macOS"
./remember.sh architecture "Use EventBus for cross-service communication"
```
