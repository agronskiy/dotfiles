# CLAUDE.md Merge Process

`claude-setup` concatenates the public and local CLAUDE.md files into `~/.claude/CLAUDE.md`.

## Merge order

1. Public (`~/.dotfiles/.claude/CLAUDE.md`) — loaded first
2. Local (`~/.dotfiles-local/.claude/CLAUDE.md`) — appended after a `---` separator

A header comment marks the file as auto-generated.

## Migration from symlink

Older setups symlinked `~/.claude/CLAUDE.md` directly to the public source.
Running `claude-setup` automatically replaces the symlink with the merged file.

## Workflow

```
# Edit the public source
$EDITOR ~/.dotfiles/.claude/CLAUDE.md

# Edit the local/work source
$EDITOR ~/.dotfiles-local/.claude/CLAUDE.md

# Regenerate merged output
claude-setup

# Verify
claude-setup --status
```

## File locations

```
~/.dotfiles/.claude/CLAUDE.md          # public source (version-controlled)
~/.dotfiles-local/.claude/CLAUDE.md    # local source (private, version-controlled)
~/.claude/CLAUDE.md                    # merged output (auto-generated, do not edit)
```
