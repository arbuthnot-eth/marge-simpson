# marge_simpson/README.md
Drop-in workflow for audits + bugfixing.

## Install
Copy the `marge_simpson/` folder into your repo root.

## Two prompts you use
- `marge_simpson/prompt_templates/system_wide_audit.md`
- `marge_simpson/prompt_templates/bulleted_issues.md`

## What you do day-to-day
1) Paste `bulleted_issues.md` prompt, then list your issues as bullets in the same message.
2) The assistant fixes issues linearly and MUST run automated verification after each fix:
   - macOS/Linux: `./marge_simpson/verify.sh fast`
   - Windows (PowerShell): `./marge_simpson/verify.ps1 fast`
3) You only reply again if the assistant is blocked from executing commands in your environment.

Verification evidence is recorded per issue in:
- `marge_simpson/assessment.md` (raw output or verify log file path)

## How to know what’s left
Open `marge_simpson/tasklist.md` and search for `- [ ]` (unchecked items).
