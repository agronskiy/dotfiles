# My dotfiles and configs

Some bits and pieces of the bashrc used here and there across my machines, e.g. for prompt and commands.
Heavily adjusted version by @holman, inspiration from @AndreiBarsan.

# Features

Along with many very personal features there are several which might be useful for common use-cases.

## Nested tmux

Allow to dynamically switch off the `prefix` for outer tmux when logging in to a remote ssh with another (inner) tmux.
The status bar is greyed out and the `prefix` is propagated to the inner tmux.

Local machine tmux only:

<img src="assets/tmux-outer.png" width="90%">

Local and remote, with local no receiving `prefix`:

<img src="assets/tmux-inner.png" width="90%">

# Installation

## Linking dotfiles:

```bash
./scripts/bootstrap
```

## Installing software and plugins:

**This is WIP**: currently there are some installation scripts untested, all should run by
```bash
./bin/dot
```

Otherwise, prefer for now to install stuff manually:

### plugins

```
# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install highlighting plugin
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### fzf

Installs via `./bin/dot`

## tmux

Installs via `./bin/dot`

## Caveat: Git autocompletion with git homebrew

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
