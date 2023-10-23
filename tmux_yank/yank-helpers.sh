#!bash
# shellcheck disable=SC2239

yank_line="y"
yank_line_option="@yank_line"

yank_pane_pwd="Y"
yank_pane_pwd_option="@yank_pane_pwd"

yank_default="y"
yank_option="@copy_mode_yank"

put_default="Y"
put_option="@copy_mode_put"

yank_put_default="M-y"
yank_put_option="@copy_mode_yank_put"

yank_wo_newline_default="!"
yank_wo_newline_option="@copy_mode_yank_wo_newline"

yank_selection_default="clipboard"
yank_selection_option="@yank_selection"

yank_selection_mouse_default="primary"
yank_selection_mouse_option="@yank_selection_mouse"

yank_with_mouse_default="on"
yank_with_mouse_option="@yank_with_mouse"

yank_action_default="copy-pipe-and-cancel"
yank_action_option="@yank_action"

shell_mode_default="emacs"
shell_mode_option="@shell_mode"

custom_copy_command_default=""
custom_copy_command_option="@custom_copy_command"

override_copy_command_default=""
override_copy_command_option="@override_copy_command"

# helper functions
get_tmux_option() {
    local option="$1"
    local default_value="$2"
    local option_value
    option_value=$(tmux show-option -gqv "$option")
    if [ -z "$option_value" ]; then
        echo "$default_value"
    else
        echo "$option_value"
    fi
}

yank_line_key() {
    get_tmux_option "$yank_line_option" "$yank_line"
}

yank_pane_pwd_key() {
    get_tmux_option "$yank_pane_pwd_option" "$yank_pane_pwd"
}

yank_key() {
    get_tmux_option "$yank_option" "$yank_default"
}

put_key() {
    get_tmux_option "$put_option" "$put_default"
}

yank_put_key() {
    get_tmux_option "$yank_put_option" "$yank_put_default"
}

yank_wo_newline_key() {
    get_tmux_option "$yank_wo_newline_option" "$yank_wo_newline_default"
}

yank_selection() {
    get_tmux_option "$yank_selection_option" "$yank_selection_default"
}

yank_selection_mouse() {
    get_tmux_option "$yank_selection_mouse_option" "$yank_selection_mouse_default"
}

yank_with_mouse() {
    get_tmux_option "$yank_with_mouse_option" "$yank_with_mouse_default"
}

yank_action() {
    get_tmux_option "$yank_action_option" "$yank_action_default"
}

shell_mode() {
    get_tmux_option "$shell_mode_option" "$shell_mode_default"
}

custom_copy_command() {
    get_tmux_option "$custom_copy_command_option" "$custom_copy_command_default"
}

override_copy_command() {
    get_tmux_option "$override_copy_command_option" "$override_copy_command_default"
}
# Ensures a message is displayed for 5 seconds in tmux prompt.
# Does not override the 'display-time' tmux option.
display_message() {
    local message="$1"

    # display_duration defaults to 5 seconds, if not passed as an argument
    if [ "$#" -eq 2 ]; then
        local display_duration="$2"
    else
        local display_duration="5000"
    fi

    # saves user-set 'display-time' option
    local saved_display_time
    saved_display_time=$(get_tmux_option "display-time" "750")

    # sets message display time to 5 seconds
    tmux set-option -gq display-time "$display_duration"

    # displays message
    tmux display-message "$message"

    # restores original 'display-time' value
    tmux set-option -gq display-time "$saved_display_time"
}