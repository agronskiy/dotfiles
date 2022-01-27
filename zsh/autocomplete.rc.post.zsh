# Marked as post-load because those things should go after the compinit.

# Coloring partial match https://stackoverflow.com/questions/8300687/zsh-color-partial-tab-completions
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==02=00}:${(s.:.)LS_COLORS}")';

# This allows to immediately progress to first ambiguous character and list autocompletion options on TAB.
setopt auto_list
setopt list_types
unsetopt list_ambiguous
unsetopt list_beep

# This allows to see dotfiles and folders for autocomplete
# setopt globdots # this would also work, see https://unix.stackexchange.com/questions/308315/how-can-i-configure-zsh-completion-to-show-hidden-files-and-folders
_comp_options+=(globdots)
# And avoid suggesting current dir
zstyle ':completion:*' special-dirs false
# Disable sorting
zstyle ':completion:*' sort false

# Default highlight color of the input
export zle_highlight=( default:fg=7 )

