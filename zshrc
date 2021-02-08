# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# export CLOUDSDK_PYTHON="/usr/local/opt/python@3.8/libexec/bin/python"
# source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
# source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

### zplug ####
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh
zplug romkatv/powerlevel10k, as:theme, depth:1
zplug "kutsan/zsh-system-clipboard", depth:1
zplug "zsh-users/zsh-syntax-highlighting", defer:2, depth:1
# zplug "plugins/vi-mode", from:oh-my-zsh, depth:1
# zplug "zsh-users/zsh-autosuggestions", defer:2, depth:1
# bindkey '^ ' autosuggest-accept
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load
### end zplug ###

bindkey "jj" vi-cmd-mode

export LSCOLORS=Gxfxcxdxbxegedabagacad
alias ls='ls -G'


###### START eval ssh-agent stuff ######
# stolen from here
# https://stackoverflow.com/questions/18880024/start-ssh-agent-on-login
SSH_ENV="$HOME/.ssh/agent-environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi
###### END eval ssh-agent stuff ######

### Aliases
alias ss='source ~/.zshrc'
alias watch='watch ' # so we can watch aliases
# for quicly creating new pull request
alias newpull='gh pr create'
# open pull request associated with current branch in the browser
alias sp='gh pr view --web'
# open current repo in browser
alias sr='gh repo view --web'
alias s='git status'

# kubernetes
alias kc=kubectl

### fzf git
# 'file add' git add which fuzzy-matches unchecked/modified files in current working directory. Can add multiple files
# alias fa='git add `git ls-files -m -o --exclude-standard | fzf -m | oneline`'
# # 'file revert': fuzzy-matches modified files and reverts them. Can do multiple files
# alias fr='git checkout `git ls-files -m --exclude-standard | fzf -m | oneline`'
# # 'checkout' switch branches by fuzzy-searching them
# alias c='git branch | fzf | xargs git checkout'
# sendkeys version of the above fzf git things, so they show up in my history
alias fa='git ls-files -m -o --exclude-standard | fzf -m | oneline | xargs echo "git add $*" | sendkeys'
alias fr='git ls-files -m --exclude-standard | fzf -m | oneline | xargs echo "git checkout $*" | sendkeys'
alias c='git branch | fzf | xargs echo "git checkout $1" | sendkeys'
alias pull='git pull origin $(git rev-parse --abbrev-ref HEAD)'
alias push='git push origin $(git rev-parse --abbrev-ref HEAD)'
# close vim across all my tmux sessions to avoid hanging swp files
alias allvimclose='tmux list-sessions -F "#{session_name}" | xargs -I SESSIONNAME tmux send-keys -t SESSIONNAME:0.0 ":qa" C-m'


alias listnotpushed='git diff --stat --cached --name-only origin/$(git rev-parse --abbrev-ref HEAD)'
pp () {
    if push; then
        echo "success"
    else
        listnotpushed | oneline | xargs git add
        mit "pre commit"
        push
    fi
}

# Replace \n with space.
alias oneline='tr '"'"'\n'"'"' '"'"' '"'"''
# send command to tmux prompt, requires replacing space with the word "Space"
alias sendkeys='tr '"'"' '"'"' '"'"' Space '"'"' | xargs -0 tmux send-keys'
# kill specific tmux session (closing vim first)
killsessionbyname () {
    for session_name in "$@"
    do
        tmux send-keys -t "$session_name":0.0 ":qa" C-m  # close vim to avoid .swp files
        tmux kill-session -t "$session_name" # kill session
        echo Killed "$session_name" session
    done
}
# kill tmux sessions, selecting session with fzf
alias skill='killsessionbyname `tmux list-sessions -F "#{session_name}" | fzf -m | oneline`'
# attach to tmux
alias ta='tmux a'
# pytest
alias t='find ./tests -name \*.py | fzf | oneline | xargs echo "pytest $1" | sendkeys'
alias tt="py.test tests"
# run python script
alias p='find . -name \*.py | fzf | oneline | xargs echo "python $1" | sendkeys'
# framerate of a video
alias framerate='ffprobe -v 0 -of compact=p=0 -select_streams 0 -show_entries stream=r_frame_rate'

### Functions
mcd () {
    mkdir -p $1
    cd $1
}

# git commit
mit () {
    git commit -m "$*"
}

# new branch
nb () {
    git checkout -b $1
}

pycache_clear () {
    find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf
}

search_n_replace () {
    find . -type f -name "*.py" -print0 | xargs -0 sed -i '' -e "s/$1/$2/g"
}

seconds_since_modified () {
    echo $(( $(date +%s) - $(stat -f%c $1) ))
}

# create tmux-session in specified directory with the window arrangement I
# like for development and open vim
mux () {
    if [ $TMUX ]
      then
        tmux detach-client
    fi

    SESSIONNAME="$(basename $1)"
    tmux has-session -t=$SESSIONNAME &> /dev/null

    if [ $? != 0 ] 
     then
        cd $1
        tmux new-session -s $SESSIONNAME -d
        tmux send-keys -t $SESSIONNAME "vim" C-m 
        tmux split-window
        tmux split-window -h
        tmux send-keys -t $SESSIONNAME -X cursor-left
        tmux select-pane -t 1
        tmux resize-pane -D 15
        cd ..
    fi

    tmux attach -t $SESSIONNAME
}

# source fzf key bindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# source conda init
[ -f ~/.conda.zsh ] && source ~/.conda.zsh
