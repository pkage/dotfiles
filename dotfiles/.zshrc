autoload bashcompinit
bashcompinit

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -v

# quality of life stuff
alias l="ls -AFG --color"
alias ll="ls -AFGhl --color"
alias res="cd ~/Repositories"
alias ..="cd .."
alias ...="cd ../.."
alias .="source"

# random compat stuff
alias tmux="tmux -u"
export HOMEBREW_VERBOSE=1
alias sqlite="sqlite3"
(cat ~/.cache/wal/sequences &)
alias reset-colors="cat ~/.cache/wal/sequences"
user_install() {
    ln -s $PWD/$1 ~/.local/bin/$1
    echo  $PWD/$1 " linked to " ~/.local/bin/$1
}
wal() {
    /home/patrick/.local/bin/wal -i $1 
    /home/patrick/.local/bin/betterlockscreen -u $1 
    
}

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

# latex
alias paper="cd ~/Repositories/school/phd/krhcai"
alias phd="cd ~/Repositories/school/phd/"

# rust
export PATH="$HOME/.cargo/bin:$PATH"

faketty () {
     script -qfec "$(printf "%q " "$@")"
}

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
export PATH="/home/patrick/.local/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
