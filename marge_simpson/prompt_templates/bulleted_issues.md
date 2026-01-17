Read `marge_simpson/AGENTS.md` and follow it.

GOAL
Fix the issues below in one run. After EACH fix, run automated verification and record evidence. Do not require follow-up input from me unless you are blocked from executing commands in this environment.

Execution rules
1) Minimize questions (cost-aware)
- Ask questions only if a wrong assumption would cause major rework or if you are blocked.
- If needed, ask ALL questions in one short batch (max 5).

2) Issue intake + tracking (required)
- Treat each bullet under "Issues:" as a new candidate item.
- For each bullet:
  - Create the next MS-#### ID.
  - Add an entry in `marge_simpson/assessment.md`.
  - Add a task in `marge_simpson/tasklist.md` (DoD + Verification).
  - Increment Next ID in BOTH files immediately.

3) Work order
A) Existing unchecked P0/P1 items already in `tasklist.md`
B) Then the newly created items from this message
C) Then remaining unchecked items (P0 → P1 → P2)

4) Verification Gate (NON-NEGOTIABLE)
For EACH issue (MS-####), work MUST be linear:
A) Test plan first
- Identify the smallest test(s) that prove the fix.
- Prefer adding an automated regression test.
- If automation is not feasible quickly, create a deterministic repro script/steps.

B) Prove it fails (before)
- Ensure the new/targeted test or repro fails on the current code, or document why it cannot.

C) Fix
- Implement the smallest safe fix.

D) Run verification (after)
- Run the repo verification runner (fast by default):
  - macOS/Linux: `./marge_simpson/verify.sh fast`
  - Windows (PowerShell): `./marge_simpson/verify.ps1 fast`
- Also run any issue-specific targeted command(s) if needed.

E) Record evidence
- In `assessment.md` under the MS entry, record:
  - Test(s) added/changed
  - Commands executed
  - Evidence: paste raw output OR reference `marge_simpson/verify_logs/...`

F) Only then
- Mark the task Verified/Done in `tasklist.md` and proceed.

If command execution is unavailable in the current environment, treat verification as BLOCKED and ask for the minimum capability to run `verify` (one question max).

Response format
- IDs touched:
- What changed:
- Patch/edits:
- Verification evidence (per ID):
- Notes/risks (only if needed):

Questions / Confirmations:
1.
2.

Issues:
- (Issue Here)
- (Issue Here)

After the issues above, continue remaining unchecked items (if any exist) in `marge_simpson/tasklist.md` (P0 → P1 → P2).
