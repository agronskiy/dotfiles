# My dotfiles and configs

<a href="https://asciinema.org/a/2fPuaxRFuRH7MekwV8vKFKQDF" target="_blank"><img src="https://asciinema.org/a/2fPuaxRFuRH7MekwV8vKFKQDF.svg" width="90%" /></a>

<img src="assets/overall.png" width="90%">

Some bits and pieces of the bashrc used here and there across my machines, e.g. for prompt and commands.

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

## Pre-requisites:
- you run zsh
- you have installed oh-my-zsh and restarted the terminal so that environment is picked up:
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Linking dotfiles and installing all the tools:

```bash
./scripts/bootstrap
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
