# My dotfiles and configs

[![license](https://badgen.net/badge/license/MIT/blue?label=License&icon=https%3A%2F%2Fapi.iconify.design%2Focticon%2Flaw-16.svg%3Fcolor%3Dwhite)](https://badgen.net/badge/license/MIT/blue?label=License&icon=https%3A%2F%2Fapi.iconify.design%2Focticon%2Flaw-16.svg%3Fcolor%3Dwhite)
[![uses](https://badgen.net/badge/license/agronskiy%2Fyasli/orange?label=&icon=https%3A%2F%2Fapi.iconify.design%2Fic%2Ftwotone-crib.svg%3Fcolor%3Dwhite)](https://github.com/agronskiy/yasli)
![Ubuntu Test Install](https://github.com/agronskiy/configs/actions/workflows/ubuntu-test.yml/badge.svg)
![Macod Test Install](https://github.com/agronskiy/configs/actions/workflows/macos-test.yml/badge.svg)

<img src="https://user-images.githubusercontent.com/9802715/146839432-fc9d8eee-a2bd-469e-b53e-52bcd5133617.gif" width="90%">

<img src="assets/overall.png" width="90%">

Some bits and pieces of the bashrc used here and there across my (Ubuntu/macos) machines, e.g. for prompt and commands.

# Features

Along with many very personal features there are several which might be useful for common use-cases.

## Nested tmux

Pressing `F12` allows to dynamically switch off the `prefix` for outer tmux when logging in to a remote ssh with another (inner) tmux.
The status bar is greyed out and the `prefix` is propagated to the inner tmux.

Local machine tmux only:

<img src="assets/tmux-outer.png" width="90%">

Local and remote, with local no receiving `prefix`:

<img src="assets/tmux-inner.png" width="90%">

# Installation

Clone this repo into `~/.dotfiles`, clone [YASLI Framework](https://github.com/agronskiy/yasli) to `.yasli`, and run `yasli-main`:
```bash
git clone https://github.com/agronskiy/configs.git $HOME/.dotfiles
git clone https://github.com/agronskiy/yasli.git $HOME/.yasli
~/.yasli/yasli-main
```

This would 99% smoothly install everything in a "Darwin" <-> "Ubuntu" cross-platform manner.

## tmux notes

Make sure that after installing tmux, you restart terminal and run it with `Prefix + Shift-I` to install
its own plugins.


## Trivia

### Caveat: Git autocompletion with git homebrew

See [SO thread](https://stackoverflow.com/questions/24513873/git-tab-completion-not-working-in-zsh-on-mac):

- Git from brew installs its own version of git completions which a) is less powerful and b) comes first on `$fpath`:
```
ls ${^fpath}/_git(N)
```

In the homebrew case that can be the violating path:
```
> ll /usr/local/share/zsh/site-functions/_git

/usr/local/share/zsh/site-functions/_git@ -> ../../../Cellar/git/2.30.1/share/zsh/site-functions/_git
```

Need to delete that one and, assuming `oh-my-zsh` is installed, one gets the right one.

# Acknowledgements
This started as a heavily adjusted version by @holman, inspiration from @AndreiBarsan and @samoshkin.

Uses [Material Icons](https://github.com/material-icons/material-icons)
