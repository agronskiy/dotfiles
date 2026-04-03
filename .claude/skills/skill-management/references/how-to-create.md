# How to Manage Skills (Create & Remove)

Always use the `claude-skill` CLI. Never create or delete skill files directly in `~/.claude/skills/`.

## Create

**Public** (tracked in `~/.dotfiles`):
```bash
claude-skill <skill-name> "<trigger description>"
```

**Local/work** (tracked in `~/.dotfiles-local`):
```bash
claude-skill --local <skill-name> "<trigger description>"
```

## Remove

```bash
claude-skill remove <skill-name>
```

Removes the symlink and source directory. Prompts for confirmation. Commit afterward.

## What the CLI does (create)

1. Creates `<repo>/.claude/skills/<skill-name>/SKILL.md` with frontmatter template
2. Creates `<repo>/.claude/skills/<skill-name>/references/notes.md` placeholder
3. Symlinks `~/.claude/skills/<skill-name>` to the source directory

## After creation

- Run `claude-setup --status` to verify the skill appears
- Commit the new skill directory
- Fill in `SKILL.md` trigger description and instructions
- Add detailed content to `references/`
