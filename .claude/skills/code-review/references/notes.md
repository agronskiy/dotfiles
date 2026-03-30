# Code Review Protocol

## Step 1 — Identify the diff source

Detect the context and fetch the diff:

- **GitHub PR** — URL contains `github.com` or user mentions PR number in a GitHub repo:
  ```bash
  gh pr diff [<number-or-url>]
  # Also fetch PR description for context:
  gh pr view [<number-or-url>]
  ```
- **GitLab MR** — URL contains `gitlab.com` / self-hosted GitLab, or user mentions MR:
  ```bash
  glab mr diff [<number-or-url>]
  glab mr view [<number-or-url>]
  ```
- **Plain git / anything else** — no PR/MR context:
  ```bash
  git diff main...HEAD   # or whatever base branch is appropriate
  # If on main with no explicit range, use:
  git diff HEAD
  ```

If ambiguous, ask the user which branch or PR/MR to compare against before proceeding.

## Step 2 — Review priorities (in order)

Apply feedback **only** in this priority order. Do not raise lower-priority issues if higher-priority ones dominate.

### 1. Consistency with existing code
- Naming conventions, error handling patterns, file/module structure, logging style.
- If the new code diverges from the surrounding codebase style, flag it.

### 2. Correctness and minimality
- Bugs, logic errors, off-by-ones, incorrect assumptions, unhandled edge cases.
- Unnecessary code: anything added that wasn't needed to accomplish the stated goal.
- Scope creep: changes outside the stated purpose of the PR/MR.

### 3. Reusability (only when warranted)
- Only raise this if an introduced pattern already appears **3 or more times** in the codebase.
- Use Grep to verify before suggesting extraction. Do not suggest abstractions speculatively.

### 4. No nitpicking
- Do **not** comment on: whitespace, formatting (if CI handles it), variable name aesthetics, minor style opinions, or anything that doesn't affect correctness or clarity.
- Do **not** suggest improvements beyond the scope of what was changed.

## Step 3 — Output format

- Group feedback by file.
- For each issue: quote the relevant line(s), state the problem, suggest a fix if one is clear.
- Keep each comment to 1–3 sentences. No summaries at the end.
- If there is nothing to flag, say so in one sentence.
