alias l="ls -AFG"
alias ll="ls -lFGhA"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias res="cd ~/repositories";
alias class="cd ~/Movies/Classes";
alias weather="curl wttr.in"
alias vi="nvim"
alias vim="nvim"
alias tmux="tmux -u"
export EDITOR="nvim"
export HOMEBREW_VERBOSE=1

# git
alias ga="git add"
alias gs="git status"
alias gp="git pull"
alias gP="git push"
alias gc="git commit"
alias gd="git diff"
alias gC="git checkout"
alias gf="git fetch"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"


find_git_branch() {
  # Based on: http://stackoverflow.com/a/13003854/170413
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      branch=' detached*'
    fi
    git_branch=" ($branch)"
  else
    git_branch=""
  fi
}

find_git_dirty() {
  local status=$(git status --porcelain 2> /dev/null)
  if [[ "$status" != "" ]]; then
    git_dirty=' *'
  else
    git_dirty=''
  fi
}

PROMPT_COMMAND="find_git_branch; find_git_dirty; $PROMPT_COMMAND"
txtred="$(tput setaf 1 2>/dev/null || echo '\e[0;31m')"  # red
txtcyn="$(tput setaf 6 2>/dev/null || echo '\e[0;36m')"  # cyan
txtrst="$(tput sgr 0 2>/dev/null || echo '\e[0m')"       # style reset

export PS1="\[\e[90m\]\$? > \W\[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\e[90m\] λ \[\e[0m\]"

export PATH="$HOME/.cargo/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/patrick/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/patrick/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/patrick/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/patrick/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

