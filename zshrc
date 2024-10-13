bindkey "jj" vi-cmd-mode
# todo: use xclip if on unix
function vi-yank-pbcopy {
    zle vi-yank
    echo "$CUTBUFFER" | tr -d '\n'| pbcopy
}
zle -N vi-yank-pbcopy
bindkey -M vicmd 'y' vi-yank-pbcopy

export LSCOLORS=Gxfxcxdxbxegedabagacad
alias ls='ls -G'

alias regexgrep='grep -o -E'

# shared terminal history across terminals
setopt inc_append_history
setopt sharehistory

### Aliases
alias ss='source ~/.zshrc'
alias watch='watch ' # so we can watch aliases
alias pserve="python3 -m http.server"

### Some git+github aliases
# for quickly creating new pull request
alias prcreate='gh pr create'
# open pull request associated with current branch in the browser
alias sp='gh pr view --web'
# open a different pr, selected with fzf, in the browser
propen () {
    gh pr list | fzf | awk '{print $1}' | xargs gh pr view --web
}
# checkout the branch of another pr, selected with fzf
prcheckout () {
    branch=$(gh pr list | fzf | awk '{print $(NF-5)}')
    if ! git checkout $branch; then
        git fetch origin $branch
        git checkout $branch
    fi
}
alias prlist='gh pr list'
# list github issues
alias ilist='gh issue list'
# fzf select an issue and open it in the browser
iopen () {
    gh issue list | fzf | awk '{print $1}' | xargs gh issue view --web
}
alias icreate='gh issue create'
alias cbranch="git rev-parse --abbrev-ref HEAD | oneline | tr -d '[:space:]' | pbcopy"
copypatch () {
    git diff | pbcopy
}
savepatch () {
    TMPPATH="$HOME/Downloads/henighan.patch"
    git diff > $TMPPATH
    echo $TMPPATH | pbcopy
    echo "Patch path now in clipboard $TMPPATH"
}

# open current repo in browser
alias brepo='gh repo view --web'
alias bbranch='gh repo view --web --branch $(git rev-parse --abbrev-ref HEAD)'
alias s='git status'
alias ga='git add'
alias unstage='git reset'
alias amendcommit='git commit --amend --no-edit'

# kubernetes
# zshell autocomplete
# https://kubernetes.io/docs/tasks/tools/included/optional-kubectl-configs-zsh/
# this seems to hang if run multiple times, so I gate it on an env var
# if [ -z "$KUBECTL_COMPLETION_SOURCED" ]
# then
#     source <(kubectl completion zsh)
#     export KUBECTL_COMPLETION_SOURCED="1"
# fi
alias kc=kubectl
kcyaml () {
    kubectl get "$1" "$2" -o yaml | kubectl neat
}
# make autocomplete work for alias
complete -F __start_kubectl kc
alias kx=kubectx # https://github.com/ahmetb/kubectx

### fzf git
# 'file add' git add which fuzzy-matches unchecked/modified files in current working directory. Can add multiple files
# alias fa='git add `git ls-files -m -o --exclude-standard | fzf -m | oneline`'
# # 'file revert': fuzzy-matches modified files and reverts them. Can do multiple files
# alias fr='git checkout `git ls-files -m --exclude-standard | fzf -m | oneline`'
# # 'checkout' switch branches by fuzzy-searching them
# alias c='git branch | fzf | xargs git checkout'
# sendkeys version of the above fzf git things, so they show up in my history
alias fa='git ls-files -m -o --exclude-standard | fzf -m | oneline | xargs echo "git add $*" | sendkeys'
alias pa='git ls-files -m -o --exclude-standard | fzf -m | oneline | xargs echo "git add -p $*" | sendkeys'
alias fr='git ls-files -m --exclude-standard | fzf -m | oneline | xargs echo "git checkout $*" | sendkeys'
# alias bls='git branch | cat'
alias bls="git for-each-ref --color=always --sort=committerdate refs/heads/ --format='%(HEAD) %(color:white)%(refname:short)%(color:reset) - %(color:yellow)%(contents:subject)%(color:reset) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"
alias c='git branch | fzf | xargs echo "git checkout $1" | sendkeys'
alias checkout='bls --color=always | fzf --ansi --tac | squeezespace | cut -d " " -f 1 | xargs echo "git checkout $1" | sendkeys'
alias pull='git pull origin $(git rev-parse --abbrev-ref HEAD)'
alias push='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias emptycommit='git commit --allow-empty -m "empty commit"'
alias uncommit='git reset --soft HEAD~1'
alias pmaster='git pull origin master'
alias prunebranches="git fetch --prune --no-tags && git branch --merged master | grep -v '^[ *]*master$' | xargs -r git branch -d"
# close vim across all my tmux sessions to avoid hanging swp files
alias allvimclose='tmux list-sessions -F "#{session_name}" | xargs -I SESSIONNAME tmux send-keys -t SESSIONNAME:0.0 ":qa" C-m'

alias yqless="yq -C . | less -R"

## vanilla unix aliases
# Replace \n with space.
alias oneline='tr '"'"'\n'"'"' '"'"' '"'"''
# collapse multiple spaces into one, also strip leading and trailing whitespace
squeezespace () {
    awk '{$1=$1};1'
}
# first column
alias firstcol="cut -d ' ' -f 1"
# any column
gcol () {
    squeezespace | cut -d ' ' -f $1
}
# collapse multiple spaces into one space
alias onespace="tr -s ' '"
# remove duplicate lines
lower () {
    tr '[:upper:]' '[:lower:]'
}
dedup () {
    awk '!seen[$0]++'
}
# dark-mode compatible bat. Bat is like cat but with nicer colors
dat() {
    bat --theme=$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo default || echo GitHub) $@
}
function daml {
    dat -l yaml
}
# use for nicer less with colors
dess() {
    dat -f $1 | less -r
}
# exa for nice ls -l output
alias ll="exa -lbhFa --git -s modified"
alias etree="exa --tree --color=always | less -R"

lsearch () {
    rg --color=always --column --line-number --no-heading . | fzf --ansi --delimiter : --preview 'bat --theme=$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo default || echo GitHub) --color=always {1} --highlight-line {2}' --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' | cut -d ":" -f 1-3 | xargs -I {} code -g {}
}

# list files which are committed but haven't been pushed
listnotpushed () {
    if ! git diff --stat --cached --name-only origin/$(git rev-parse --abbrev-ref HEAD); then
        git diff --name-only master
    fi
}

# pre-commit push: if first push fails, git add+commit and try again
pp () {
    if push; then
        echo "success"
    else
        listnotpushed | oneline | xargs git add
        git commit --amend --no-edit
        if push; then
            echo "success"
        else
            listnotpushed | oneline | xargs git add
            git commit --amend --no-edit
            if push; then
                echo "success"
            else
                echo "pushing did not succeed. Please check for precommit errors above"
            fi
        fi
    fi
}

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
alias ta='tmux a -t'
# pytest
alias t='find ./tests -name \*.py | fzf | oneline | xargs echo "pytest $1" | sendkeys'
alias tt="py.test tests"
# run python script
alias p='find . -name \*.py | fzf | oneline | xargs echo "python $1" | sendkeys'
# run python script with python -m (pretty brittle, depends on path)
alias mm='find . -name \*.py | fzf | rev | cut -d. -f2- | rev | cut -d/ -f3- | tr "/" "." | xargs -I {} echo "python -m {}" | oneline | sendkeys'
# framerate of a video
alias framerate='ffprobe -v 0 -of compact=p=0 -select_streams 0 -show_entries stream=r_frame_rate'

wat() { while true; do x=$(clear; $@); echo $x; sleep 1; done }

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


# terraform
alias tinit="terraform init"
alias tapply="terraform apply"
alias tdestroy="terraform destroy"
alias tplan="terraform plan"
