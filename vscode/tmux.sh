#!/bin/sh
SESSION="vscode`pwd`"

if ! tmux attach-session -d -t $SESSION; then
    tmux new-session -d -s $SESSION
    tmux split-window -h -t $SESSION
    tmux attach-session -d -t $SESSION
    # echo "Hello"
    # tmux send-keys -t $SESSION -X cursor-left
    # tmux select-pane -t 1
fi