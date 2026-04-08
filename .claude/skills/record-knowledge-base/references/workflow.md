# record-knowledge-base — Workflow

Store a knowledge snippet into the right skill's `references/` files.

## Step 1: Identify candidate skills

List all skills under `~/.claude/skills/`. Prioritize `kb-*` skills (dedicated knowledge bases). Also consider non-`kb-` skills whose topic matches.

## Step 2: Present a choice

Show a numbered list:
```
Where should I record this?
  1. kb-some-topic   — <description>
  2. some-skill      — <description>
  ...
  N. Create new kb-<name> skill
```

`kb-*` skills first. Always offer "Create new" as last option.

## Step 3a: Appending to existing skill

1. Read existing `references/` files.
2. Pick best-fit file, or create a new one if topic is clearly distinct.
3. Append as a dated section: `## <title> (recorded: YYYY-MM-DD)`
4. If `SKILL.md` description no longer covers the new topic, update `description` frontmatter only.

## Step 3b: Creating a new `kb-*` skill

1. Confirm name (must match `kb-[a-z][a-z0-9-]*`).
2. Ask public or local (default: public).
3. Run: `claude-skill [--local] kb-<name> "<trigger description>"`
4. Write into the new skill's `references/notes.md`.

## Rules

- Never put verbose content in `SKILL.md` — all detail goes in `references/`.
- Prefer appending to existing files over creating new ones.
- Use dated section headers for traceability.
- Remind user to commit afterward.
