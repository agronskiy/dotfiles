# record-kb — Workflow

## Goal

Store a knowledge snippet into the right skill's `references/` files, keeping `SKILL.md` minimal.

## Step 1: Identify candidate skills

List all skills under `~/.claude/skills/` (via Glob or `ls`). Prioritize `kb-*` skills — they are dedicated knowledge bases. Also consider any non-`kb-` skill whose topic clearly matches the content.

## Step 2: Present a choice to the user

Show a numbered list:

```
Where should I record this?
  1. kb-some-topic   — <description from SKILL.md>
  2. kb-other-topic  — <description from SKILL.md>
  3. some-skill      — <description from SKILL.md>
  ...
  N. Create new kb-<name> skill
```

- `kb-*` skills come first.
- Include any non-`kb-` skill that is a plausible match.
- Always offer "Create new" as the last option.

## Step 3a: Appending to an existing skill

1. Read all existing `references/` files in that skill directory.
2. Pick the best-fit file, or create a new one if the topic is clearly distinct.
3. Append the content as a new dated section:

```markdown
## <concise title> (recorded: YYYY-MM-DD)

<knowledge content, cleaned up and concise>
```

4. If `SKILL.md`'s trigger description no longer covers the new topic area, update only the `description` frontmatter field — keep the body minimal (body should just point to `references/`).

## Step 3b: Creating a new `kb-*` skill

1. Confirm the name (must match `kb-[a-z][a-z0-9-]*`).
2. Ask public or local (default: public).
3. Run: `claude-skill [--local] kb-<name> "<trigger description>"`
4. Proceed as Step 3a — write into the new skill's `references/notes.md`.

## Rules

- Never put verbose content in `SKILL.md` — it is always scanned, keep it very short.
- All detailed knowledge goes in `references/` files only.
- Prefer appending to existing files over creating new ones unless the topic is clearly distinct.
- Use dated section headers so entries are traceable over time.
- After writing, remind the user to commit in the appropriate dotfiles repo.
