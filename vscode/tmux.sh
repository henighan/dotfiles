#!/bin/sh
SESSION="vscode`pwd`"
echo $SESSION
echo $SHELL


if ! /opt/homebrew/bin/tmux attach-session -d -t $SESSION; then
    /opt/homebrew/bin/tmux new-session -d -s $SESSION
    /opt/homebrew/bin/tmux split-window -h -t $SESSION
    /opt/homebrew/bin/tmux new-window -t $SESSION
    /opt/homebrew/bin/tmux split-window -v -t $SESSION
    /opt/homebrew/bin/tmux split-window -h -t $SESSION
    /opt/homebrew/bin/tmux select-pane -U -t $SESSION
    /opt/homebrew/bin/tmux split-window -h -t $SESSION
    /opt/homebrew/bin/tmux -t $SESSION select-window -t 0 
    /opt/homebrew/bin/tmux -t $SESSION select-pane -t 0
    /opt/homebrew/bin/tmux attach-session -d -t $SESSION
fi
