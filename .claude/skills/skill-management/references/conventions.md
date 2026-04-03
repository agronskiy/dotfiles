# Skill Conventions

## Naming

- Lowercase kebab-case: `my-workflow`, `code-review-helper`
- Local/work skills: prefix with `local-` (e.g. `local-deploy-pipeline`)

## File structure

```
skills/skill-name/
├── SKILL.md           # Trigger + summary (required, always scanned — keep small)
└── references/        # Detail (loaded only when skill activates)
    └── notes.md
```

## Trigger descriptions

The `description` frontmatter field controls when Claude loads the skill. Be specific:

```yaml
# Good
description: Use when the user asks to review a pull request or asks for feedback on code changes.
# Bad
description: Use for code stuff
```

## Public repo safety

When committing to `~/.dotfiles` (public), scan for:
- Private keys (`BEGIN PRIVATE KEY`, `BEGIN RSA`, `BEGIN OPENSSH`)
- Hardcoded API keys, tokens, passwords
- Internal hostnames, URLs, or infrastructure paths

Flag to the user before committing; suggest moving to `.dotfiles-local`.

## Portability

`references/` files are plain markdown — portable to any agent.
`SKILL.md` frontmatter is Claude Code-specific (thin adapter layer).
