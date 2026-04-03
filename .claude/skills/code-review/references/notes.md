# Code Review Protocol

## Step 1 — Identify the diff source

- **GitHub PR** — `gh pr diff [<number-or-url>]` + `gh pr view`
- **GitLab MR** — `glab mr diff [<number-or-url>]` + `glab mr view`
- **Plain git** — `git diff main...HEAD` (or `git diff HEAD` if on main)

If ambiguous, ask which branch or PR/MR to compare against.

## Step 2 — Review priorities (in order)

Apply feedback **only** in this priority order. Skip lower-priority issues if higher ones dominate.

### 1. Consistency with existing code
- Naming, error handling patterns, file/module structure, logging style.
- Flag divergence from surrounding codebase style.

### 2. Correctness and minimality
- Bugs, logic errors, off-by-ones, unhandled edge cases.
- Unnecessary code or scope creep beyond stated goal.

### 3. Reusability (only when warranted)
- Only flag if pattern already appears **3+ times** in the codebase.
- Grep to verify before suggesting extraction.

### 4. No nitpicking
- Do **not** comment on: formatting, variable name aesthetics, or minor style.
- Do **not** suggest improvements beyond the scope of changed code.

## Step 3 — Output format

- Group feedback by file.
- For each issue: quote relevant line(s), state the problem, suggest a fix.
- Keep each comment to 1-3 sentences. No trailing summaries.
- If nothing to flag, say so in one sentence.
