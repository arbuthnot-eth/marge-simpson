Read `marge_simpson/AGENTS.md` and follow it.

Run a system-wide audit of this workspace/repo.
- Read and understand the architecture and major workflows.
- Identify correctness issues, risky patterns, and high-impact improvements.
- Do not break intended functionality.

Update/create tracking docs (required)
- `marge_simpson/assessment.md`
  - Current snapshot (scope, status, top risks)
  - Findings by area
  - Issues Log entries (MS-####) with root cause, fix plan, and verification plan
- `marge_simpson/tasklist.md`
  - Prioritized, ordered tasks with Definition of Done and Verification (automated)
- `marge_simpson/instructions_log.md`
  - Append any new standing instructions the user provides

Then immediately start executing the remaining unchecked items in `marge_simpson/tasklist.md` (P0 → P1 → P2), keeping docs updated as you go.

Verification requirements (do not skip)
- For EACH MS item you implement, run automated verification and record evidence before moving on:
  - macOS/Linux: `./marge_simpson/verify.sh fast`
  - Windows (PowerShell): `./marge_simpson/verify.ps1 fast`
- Prefer adding an automated regression test for each fix.
- Never claim tests passed without raw output or a verify log file path.
- If command execution is unavailable in this environment, treat verification as BLOCKED and ask for the minimum capability to run `verify` (one question max).

Output using the Response Format (include IDs touched).
