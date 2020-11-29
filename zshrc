# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/google-cloud-sdk/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(vi-mode zsh-system-clipboard git)

source $ZSH/oh-my-zsh.sh

bindkey "jj" vi-cmd-mode

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

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

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias watch='watch ' # so we can watch aliases
# for quicly creating new pull request
alias newpull='hub pull-request'
# open pull request associated with current branch in the browser
alias sp='hub pr show'
alias s='git status'
# alias fa='git ls-files -m -o --exclude-standard | fzf -m --print0 | xargs -0 -o -t git add'
# alias fa='git ls-files -m -o --exclude-standard | fzf -m --print0 | xargs -0 -J % tmux send-keys git Space add Space % Space'
# alias sk='pyp "stdin.read().replace("'" "'", "'" Space "'")'
# alias sk='pyp "'"'"' '"'"'.join(stdin.read().split('"'"'\n'"'"'))"'
# Replace \n with space.
alias oneline='tr '"'"'\n'"'"' '"'"' '"'"''

### fzf git
# 'file add' git add which fuzzy-matches unchecked/modified files in current working directory. Can add multiple files
# alias fa='git add `git ls-files -m -o --exclude-standard | fzf -m | oneline`'
# # 'file revert': fuzzy-matches modified files and reverts them. Can do multiple files
# alias fr='git checkout `git ls-files -m --exclude-standard | fzf -m | oneline`'
# # 'checkout' switch branches by fuzzy-searching them
# alias c='git branch | fzf | xargs git checkout'

# send command to tmux prompt, requires replacing space with the word "Space"
alias sendkeys='tr '"'"' '"'"' '"'"' Space '"'"' | xargs -0 tmux send-keys'
# sendkeys version of the above fzf git things, so they show up in my history
alias fa='echo git add `git ls-files -m -o --exclude-standard | fzf -m | oneline` | sendkeys'
alias fr='echo git checkout `git ls-files -m --exclude-standard | fzf -m | oneline` | sendkeys'
alias c='echo git checkout `git branch | fzf` | sendkeys'
# alias fa='tmux send-keys git Space add Space `git ls-files -m -o --exclude-standard | fzf -m | pyp ""'" Space "'".join([line for line in lines])"`'
# alias fa='tmux send-keys git Space add Space `git ls-files -m -o --exclude-standard | fzf -m | pyp ""'" Space "'".join([line for line in lines])"`'
# push/pull to origin from current branch
alias pull='git pull origin $(git rev-parse --abbrev-ref HEAD)'
alias push='git push origin $(git rev-parse --abbrev-ref HEAD)'
# blob
alias bls='bbb ls'
alias bcat='bbb cat'
# close vim across all my tmux sessions to avoid hanging swp files
alias allvimclose='tmux list-sessions -F "#{session_name}" | xargs -I SESSIONNAME tmux send-keys -t SESSIONNAME:0.0 ":qa" C-m'
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
alias t='echo pytest `find ./tests -name \*.py | fzf` | sendkeys'
# non tmux version
# alias t='pytest `find ./tests -name \*.py | fzf`'
alias tt="py.test tests"
# run python script
alias p='echo python `find . -name \*.py | fzf` | sendkeys'
# non tmux version
# alias p='python `find . -name \*.py | fzf`'
# framerate of a video
alias framerate='ffprobe -v 0 -of compact=p=0 -select_streams 0 -show_entries stream=r_frame_rate'

bindkey "jj" vi-cmd-mode
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH=$HOME/bin:$PATH
