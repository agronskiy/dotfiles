#!/usr/bin/env bash
# YASLI integration for Claude Code config setup

install_claude_setup() {
    claude-setup
}

exists_claude_setup() {
    # Check if the primary symlink (CLAUDE.md) is already in place
    local claude_md="$HOME/.claude/CLAUDE.md"
    local expected_target="${DOTFILES:-$HOME/.dotfiles}/.claude/CLAUDE.md"
    [[ -L "$claude_md" ]] && [[ "$(readlink "$claude_md")" == "$expected_target" ]]
}

update_claude_setup() {
    claude-setup
}

install_wrapper "claude-setup" \
    install_claude_setup \
    exists_claude_setup \
    update_claude_setup
