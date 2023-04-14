autoload bashcompinit
bashcompinit

fpath+=~/.zfunc
autoload -Uz compinit && compinit

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -v

# quality of life stuff
alias l="ls -AFG"
alias ll="ls -AFGhl"
alias res="cd ~/repositories"
alias ..="cd .."
alias ...="cd ../.."
alias .="source"

# cd*
alias cdw="pwd > /tmp/lastcd"
alias cdr="cd \`cat /tmp/lastcd\`"
alias cds="cat /tmp/lastcd"

# random compat stuff
alias tmux="tmux -u"
export HOMEBREW_VERBOSE=1
export JULIA_DEBUG=1
alias sqlite="sqlite3"
notify() {
    osascript -e "display notification \"$1\" with title \"iTerm2\""
}
alias jupyter-lab-remote="jupyter lab --ip=0.0.0.0 --no-browser"


# text editor setup
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
export EDITOR="nvim"

# git aliases
alias gB="git blame"
alias gC="git checkout"
alias gP="git push"
alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gd="git diff"
alias gf="git fetch"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gp="git pull"
alias gs="git status"
alias gm="git merge"

forgit_add=gai
forgit_diff=gdi
source ~/.local/share/forgit/forgit.plugin.zsh

# render manpages nicely
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# some nvr garbage
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

# jumps
alias phd="cd ~/Repositories/school/phd"
alias work="cd ~/Repositories/work"

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# local bin
export PATH="$HOME/.local/bin:$PATH"
faketty () {
     script -qfec "$(printf "%q " "$@")"
}

# poetry python
alias activate="poetry env info --path && source \`poetry env info --path\`/bin/activate"

# prompt
autoload -Uz vcs_info # git
zstyle ':vcs_info:git:*' formats '%b'

setopt PROMPT_SUBST

precmd() {
    vcs_info

    gbranch=""
    gdirty=""

    # quick n dirty status formatter
    if [[ -n $vcs_info_msg_0_ ]]; then
        gbranch=" $vcs_info_msg_0_"
        gdirty=$(git status --porcelain 2> /dev/null)
        if [[ -n $gdirty ]]; then
            gdirty="*"
        fi

        gitslug="%F{5}$gbranch%F{1}$gdirty%F{8}"
    else
        gitslug=""
    fi

    # virtualenv slug
    if [[ -n $VIRTUAL_ENV ]]; then
        venvslug=" %F{4}$VIRTUAL_ENV:t%F{8}"
    else
        venvslug=""
    fi

    # conda slug
    if [[ -n $CONDA_DEFAULT_ENV ]]; then
        condaslug=" %F{6}$CONDA_DEFAULT_ENV:t%F{8}"
    else
        condaslug=""
    fi

    PROMPT="%F{8}%? > %1~$gitslug$venvslug$condaslug λ%f%k "
}
export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="~/.local/bin:$PATH"
export PATH="/Library/TeX/texbin:$PATH"
export PATH="/Users/patrick/Library/Python/3.9/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/patrick/mambaforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/patrick/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/Users/patrick/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/Users/patrick/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/Users/patrick/mambaforge/etc/profile.d/mamba.sh" ]; then
    . "/Users/patrick/mambaforge/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

export PATH="/Users/patrick/Library/Python/3.10/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/patrick/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm endexport PATH="/opt/homebrew/opt/ruby/bin:$PATH"
