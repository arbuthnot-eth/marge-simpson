# Session End Workflow

> Knowledge capture after delivering user's work. Non-blocking - user's goal always comes first.

## When to Run

- After completing MS-#### tasks
- When user says thanks, goodbye, or conversation ends
- After significant discussions (even without formal tasks)

**Do NOT run during active work.** Finish the user's request first.

## Knowledge Review

Quickly scan the session:

| Check | If Yes → Action |
|-------|-----------------|
| User made an architecture/tech choice? | Add D-### to `knowledge/decisions.md` |
| Same approach used 2+ times? | Add P-### to `knowledge/patterns.md` |
| User said "I prefer..." or corrected you? | Add PR-### to `knowledge/preferences.md` |
| You noticed something user didn't state? | Add I-### to `knowledge/insights.md` |

## Writing Entries

### Entry Formats

**Decision (D-###):**
```markdown
### [D-###] Short title #tag1 #tag2
- **Date:** YYYY-MM-DD
- **Context:** Why this decision was needed
- **Decision:** What was decided
- **Alternatives:** What else was considered
- **Rationale:** Why this option
```

**Preference (PR-###):**
```markdown
### [PR-###] Short description #tag1 #tag2
- **Stated:** YYYY-MM-DD
- **Strength:** Weak / Moderate / Strong
- **Preference:** What the user prefers
- **Quote:** Direct quote if available
```

**Pattern (P-###):**
```markdown
### [P-###] Short title #tag1 #tag2
- **Observed:** YYYY-MM-DD
- **Frequency:** always / usually / sometimes
- **Pattern:** Description
- **Example:** Concrete example
```

**Insight (I-###):**
```markdown
### [I-###] Short description #tag1 #tag2
- **Observed:** YYYY-MM-DD
- **Confidence:** Low / Medium / High
- **Insight:** What was inferred
- **Evidence:** What led to this
- **Verified:** [ ] User has confirmed
```

## Index Update (Batch)

After adding entries, update `knowledge/_index.md` once:
1. Increment counts in Quick Stats
2. Add new entries to Recent Entries (keep last 5)
3. Add any new tags to Tag Index

## Pruning Check

While reviewing, check for entries to prune:

**KEEP if ANY:**
- Referenced by other entries
- Insight is verified
- Decision still in effect
- Preference is Strong/Moderate
- Pattern is always/usually

**PRUNE if ALL:**
- No references from other entries
- Older than 90 days
- AND: Low confidence unverified insight, OR Weak preference, OR superseded decision

### Pruning Process
1. Move to `knowledge/archive.md`
2. Add `Archived: YYYY-MM-DD | Reason: <reason>`
3. Update index (decrement count)

## Output (Minimal)

If knowledge was captured, note briefly:

```
---
📝 Knowledge captured: D-003 (database choice), PR-007 (prefer functional)
```

Keep this minimal - user's work is the main output.
