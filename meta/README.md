# Meta-Development Guide

> How to improve Marge itself using Marge.

## Overview

Meta-development means improving the Marge system while using it. The `.meta_marge/` folder contains a copy of Marge's AGENTS.md and supporting files that **guide the AI to make improvements directly to the parent `marge-simpson/` folder**.

**Key concept:** You don't edit files in `.meta_marge/` and copy them back. Instead, `.meta_marge/AGENTS.md` tells the AI to audit and improve `marge-simpson/` directly, while tracking work in `.meta_marge/planning_docs/`.

## Quick Start

```bash
# 1. Create meta guide folder
./meta/convert-to-meta.sh
# Creates: .meta_marge/ (gitignored)

# 2. Ask AI to improve Marge using the meta guide
./cli/marge --folder .meta_marge "run self-audit"
# OR: ./cli/marge meta "run self-audit"
# OR in chat: "Read AGENTS.md in .meta_marge and run a self-audit"

# 3. AI reads .meta_marge/AGENTS.md which tells it to:
#    - Audit marge-simpson/ (not .meta_marge/)
#    - Make improvements directly to marge-simpson/
#    - Track findings in .meta_marge/planning_docs/
```

## How It Works

```
marge-simpson/              ← Target of improvements (committed to git)
├── AGENTS.md               ← Production instructions
├── scripts/
├── workflows/
└── .meta_marge/            ← Meta guide (gitignored)
    ├── AGENTS.md           ← Says "audit marge-simpson/, not me"
    └── planning_docs/      ← Tracks meta-dev work
        ├── assessment.md   ← Issues found
        └── tasklist.md     ← Work queue

AI reads .meta_marge/AGENTS.md
      ↓
Audits marge-simpson/ folder
      ↓
Makes fixes directly to marge-simpson/
      ↓
Tracks work in .meta_marge/planning_docs/
```

## The Conversion Process

`convert-to-meta.sh` does:

1. **Creates** `.meta_marge/` inside your workspace
2. **Copies** all Marge files into it (excluding .git, node_modules)
3. **Transforms** AGENTS.md scope to target `marge-simpson/` instead of external repos
4. **Resets** planning_docs/ to clean state for new meta-dev session

## Commands

### Create Meta Guide
```bash
./meta/convert-to-meta.sh              # Creates .meta_marge/
./meta/convert-to-meta.sh -f           # Force overwrite existing
```

### PowerShell
```powershell
.\meta\convert-to-meta.ps1
.\meta\convert-to-meta.ps1 -Force
```

## Best Practices

1. **Always start fresh** — Run `convert-to-meta.sh` before each meta session
2. **Commit frequently** — Small, focused commits to marge-simpson/ make review easier
3. **Run tests** — Use `./scripts/verify.ps1 fast` after changes
4. **Track work** — The AI uses `.meta_marge/planning_docs/` to track findings

## Folder Structure

```
.meta_marge/                  ← Meta guide (gitignored, NOT edited directly)
├── AGENTS.md                 ← Guides AI to improve marge-simpson/
├── workflows/                ← Reference for AI
├── experts/                  ← Reference for AI
├── planning_docs/            ← AI tracks meta-dev work here
│   ├── assessment.md         ← Issues found in marge-simpson/
│   └── tasklist.md           ← Work queue for improvements
└── scripts/                  ← Can run tests from here too
```

## Tips

- Use `./cli/marge meta "task"` as shortcut for `--folder .meta_marge`
- The `.meta_marge/` folder is gitignored — won't pollute commits
- Changes happen in `marge-simpson/`, not `.meta_marge/`
- All meta folders use the same name (`.meta_marge/`) regardless of source
