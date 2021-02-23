# My dotfiles and configs

(tmux, zshrc/bashrc, vim/vscode etc.)

Some bits and pieces of the bashrc used here and there across my machines, e.g. for prompt

![prompt](assets/prompt.png)

# Installation

```
# Assuming CURR_REPO_PATH
ln -s $CURR_REPO_PATH/.zshrc_macos ~/.zshrc
ln -s $CURR_REPO_PATH/scripts ~/scripts
```

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
