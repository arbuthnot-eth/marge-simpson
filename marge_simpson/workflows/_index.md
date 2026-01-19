# Workflows Index

> Route to the right workflow based on intent. Read only what you need.

## Scope Inference

When a file path is ambiguous (e.g., "fix README.md"), infer scope:

| Workspace Contains | Context | Default Scope |
|-------------------|---------|---------------|
| `meta_marge/` exists | User is doing meta-development (improving Marge) | Files in `meta_marge/` |
| Only `marge_simpson/` | User is working on their project | Repo root / project files |

If still ambiguous after inference, **ask for clarification**.

## Quick Reference

| Intent | Signal | Workflow File | Creates ID? |
|--------|--------|---------------|-------------|
| **Question** | Curiosity, "how", "why", "what" | None (answer directly) | No |
| **Work** | Fix, add, change, build | [work.md](work.md) | Yes (or continue existing) |
| **Audit** | "audit", "review codebase" | [audit.md](audit.md) → then work.md | Yes (generates multiple) |
| **Session End** | Task complete, goodbye, natural end | [session_end.md](session_end.md) | No |

## Decision Tree

```
User message received
    │
    ├─ Just asking a question? → Answer directly, no ID needed
    │
    ├─ Wants something done (fix/add/change)?
    │   └─ Read workflows/work.md
    │
    ├─ Wants codebase audit/review?
    │   └─ Read workflows/audit.md (discovery)
    │   └─ Then workflows/work.md (execution)
    │
    └─ Task complete / session ending?
        └─ Read workflows/session_end.md
```

## Token Costs

| Scenario | Files to Read | Tokens |
|----------|---------------|--------|
| Question only | AGENTS.md only | ~1,500 |
| Single work item | AGENTS.md + work.md | ~2,500 |
| Audit | AGENTS.md + audit.md + work.md | ~3,000 |
| Session end | session_end.md | ~500 |
