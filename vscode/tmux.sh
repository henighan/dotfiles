#!/bin/sh
SESSION="vscode`pwd`"

if ! tmux attach-session -d -t $SESSION; then
    tmux new-session -d -s $SESSION
    tmux split-window -h -t $SESSION
    tmux new-window -t $SESSION
    tmux split-window -v -t $SESSION
    tmux split-window -h -t $SESSION
    tmux select-pane -U -t $SESSION
    tmux split-window -h -t $SESSION
    tmux -t $SESSION select-window -t 0 
    tmux -t $SESSION select-pane -t 0
    tmux attach-session -d -t $SESSION
fi
