# How to Manage Skills (Create & Remove)

Always use the `claude-skill` CLI. Never create or delete skill files directly in `~/.claude/skills/`.

## Create

**Public skill** (tracked in `~/.dotfiles`, visible in public git repo):
```bash
claude-skill <skill-name> "<trigger description>"
```

**Local/work skill** (tracked in `~/.dotfiles-local`, private):
```bash
claude-skill --local <skill-name> "<trigger description>"
```

## Remove

```bash
claude-skill remove <skill-name>
```

Removes the symlink from `~/.claude/skills/` and deletes the source directory from the dotfiles repo. Prompts for confirmation. Remember to commit the deletion afterward.

## What the CLI does (create)

1. Creates `<repo>/.claude/skills/<skill-name>/SKILL.md` with frontmatter template
2. Creates `<repo>/.claude/skills/<skill-name>/references/notes.md` placeholder
3. Symlinks `~/.claude/skills/<skill-name>` → the source directory (version-controlled)

## After creation

- Run `claude-setup --status` to verify the skill appears under `[public]` or `[local]`
- Commit the new skill directory in the appropriate repo
- Fill in `SKILL.md` with the actual trigger description and instructions
- Add detailed content to `references/notes.md`

## Naming conventions

- Lowercase kebab-case only: `my-workflow`, `code-review-helper`
- Local/work skills: prefix with `local-` (e.g. `local-deploy-pipeline`)
- Keep names short and descriptive

## Skill file structure

```
skills/
└── skill-name/
    ├── SKILL.md           # Trigger description + summary (required, small — always scanned)
    └── references/
        └── notes.md       # Detailed reference material (loaded only when skill activates)
```

## Writing effective trigger descriptions

The `description` field in SKILL.md frontmatter controls when Claude loads this skill. Be specific:

Good:
```yaml
description: Use when the user asks to review a pull request, mentions code review,
  or asks for feedback on code changes.
```

Bad:
```yaml
description: Use for code stuff
```

## Portability note

`references/` files are plain markdown — portable to any agent that can load files.
`SKILL.md` frontmatter is Claude Code-specific (thin adapter layer only).
