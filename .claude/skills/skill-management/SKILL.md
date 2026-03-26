---
name: skill-management
description: Use this skill when the user asks to create a new skill, add a Claude capability, scaffold a new Claude tool, or wants to add a new agentic workflow. Trigger phrases include "create a skill", "add a skill", "new skill", "add a capability", "make a skill".
version: 1.0.0
---

# Skill Management

This skill ensures new Claude skills are always created correctly — tracked in version control and properly symlinked into `~/.claude/skills/`.

## IMPORTANT: Always Use the CLI

Never create SKILL.md files directly in `~/.claude/skills/`. Always use the `claude-skill` command.

See `references/how-to-create.md` for full instructions.

## IMPORTANT: Confirm visibility before creating

Before running `claude-skill`, always ask the user explicitly:

> "Should this be a **local** (private, in `~/.dotfiles-local`) or **public** (tracked in `~/.dotfiles`) skill?"

- Local/private → use `claude-skill --local local-<name>` (name must be prefixed with `local-`)
- Public → use `claude-skill <name>` (no flag)

Do not assume — always confirm.
