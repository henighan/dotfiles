#!/usr/bin/env bash

# vendored version of tmux-yank
# https://github.com/tmux-plugins/tmux-yank
source "$HOME/code/dotfiles/tmux_yank/yank-helpers.sh"

clipboard_copy_without_newline_command() {
    local copy_command="$1"
    printf "tr -d '\\n' | %s" "$copy_command"
}


set_copy_mode_bindings() {
    local copy_command="pbcopy"
    local copy_wo_newline_command="$(clipboard_copy_without_newline_command "$copy_command")"
    # local copy_command_mouse
    tmux bind-key -T copy-mode-vi "$(yank_key)" send-keys -X "$(yank_action)" "$copy_command"
    tmux bind-key -T copy-mode-vi "$(put_key)" send-keys -X copy-pipe-and-cancel "tmux paste-buffer -p"
    tmux bind-key -T copy-mode-vi "$(yank_put_key)" send-keys -X copy-pipe-and-cancel "$copy_command; tmux paste-buffer -p"
    tmux bind-key -T copy-mode-vi "$(yank_wo_newline_key)" send-keys -X "$(yank_action)" "$copy_wo_newline_command"
    tmux bind-key -T copy-mode "$(yank_key)" send-keys -X "$(yank_action)" "$copy_command"
    tmux bind-key -T copy-mode "$(put_key)" send-keys -X copy-pipe-and-cancel "tmux paste-buffer -p"
    tmux bind-key -T copy-mode "$(yank_put_key)" send-keys -X copy-pipe-and-cancel "$copy_command; tmux paste-buffer -p"
    tmux bind-key -T copy-mode "$(yank_wo_newline_key)" send-keys -X "$(yank_action)" "$copy_wo_newline_command"
}

set_copy_mode_bindings
TMUX_LOADED="true"