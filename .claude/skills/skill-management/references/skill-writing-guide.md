# Skill Writing Guide

## Progressive Disclosure

Skills use three-level loading:
1. **Metadata** (name + description) — always in context (~100 words)
2. **SKILL.md body** — loaded when skill triggers (keep short)
3. **References** — loaded conditionally (unlimited size, <50 lines per file)

Keep SKILL.md concise. Move detailed material into `references/`.

## Writing the Description

The `description` frontmatter is the primary trigger. Include what the skill does AND specific trigger phrases. Be slightly "pushy" — Claude tends to undertrigger.

```yaml
description: Use when working with GitHub repositories, pull requests, diffs,
  code reviews. Trigger phrases include "open PR", "review PR", "check CI".
```

## Writing Instructions

- Use imperative form
- Explain **why** rather than piling on MUSTs
- Include examples when helpful
- For multi-domain skills, organize references by variant (e.g., `references/aws.md`, `references/gcp.md`)

## Conditional Reference Loading

SKILL.md should load references conditionally, not unconditionally:

```markdown
# Good — conditional
If creating a skill, read `references/how-to-create.md`.
If the user asks about conventions, read `references/conventions.md`.

# Bad — unconditional
Read `references/how-to-create.md` for the full protocol, then follow it.
```

## Output Format

If the skill produces structured output, define the template explicitly in SKILL.md.

## Bundled Scripts

If every invocation writes the same helper script, bundle it in `scripts/` and reference from SKILL.md.
