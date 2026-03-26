# Claude Global Preferences

## Communication Style

- Be concise and direct. No filler phrases.
- Use markdown formatting when helpful, but don't over-structure short answers.
- Skip summaries at the end of responses — I can read the diff.
- No emojis unless I explicitly ask.

## Coding Style

- Prefer minimal changes: fix what's asked, don't clean up surrounding code.
- No docstrings, comments, or type annotations on code I didn't ask you to change.
- Don't add error handling for scenarios that can't happen.
- Don't create abstractions for one-time operations.

## Tool Usage

- Use dedicated tools (Read, Grep, Glob, Edit) over Bash equivalents.
- Prefer targeted searches over broad exploration.
- Check before destructive operations.

## Dotfiles Setup

- Dotfiles are at `~/.dotfiles` (public) and `~/.dotfiles-local` (private).
- `$DOTFILES` env var points to `~/.dotfiles`.
- Install system: YASLI (`~/.yasli/yasli-main`).
- Symlinks follow `.symlink` naming convention, handled by `bin/symlink-everything`.
- Claude config wired by `bin/claude-setup` (not `symlink-everything`).
