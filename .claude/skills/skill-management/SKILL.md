---
name: skill-management
description: "ALWAYS use this skill when the user asks to create, update, modify, edit, remove, or scaffold a skill — even if they just say \"create a skill\" or \"add a skill\". This is the ONLY skill for managing Claude skills. Trigger phrases: \"create a skill\", \"add a skill\", \"new skill\", \"add a capability\", \"make a skill\", \"update a skill\", \"update the skill\", \"modify a skill\", \"edit a skill\", \"change the skill\", \"remove a skill\", \"delete a skill\", \"skill for X\"."
version: 1.1.0
---

# Skill Management

This is the authoritative skill for creating, updating, and removing Claude skills. It ensures skills are tracked in version control and properly symlinked into `~/.claude/skills/`.

## IMPORTANT: Always Use the CLI

Never create SKILL.md files directly in `~/.claude/skills/`. Always use the `claude-skill` command.

Load references as needed:
- Creating or removing a skill: read `references/how-to-create.md`
- Naming, file structure, safety checks: read `references/conventions.md`
- Writing effective SKILL.md content: read `references/skill-writing-guide.md`

## IMPORTANT: Confirm visibility before creating

Before running `claude-skill`, always ask the user explicitly:

> "Should this be a **local** (private, in `~/.dotfiles-local`) or **public** (tracked in `~/.dotfiles`) skill?"

- Local/private → use `claude-skill --local local-<name>` (name must be prefixed with `local-`)
- Public → use `claude-skill <name>` (no flag)

Do not assume — always confirm.

