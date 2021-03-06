# Should allow to delete the "dummy session" created when not attaching to tmux
# Credit to https://tech.serhatteker.com/post/2019-11/restore-tmux-after-reboot/
alias mux="pgrep -vx tmux > /dev/null && \
		tmux new -d -s delete-me && \
		tmux run-shell $HOME/.tmux/plugins/tmux-resurrect/scripts/restore.sh && \
		tmux kill-session -t delete-me && \
		tmux attach || tmux attach"
