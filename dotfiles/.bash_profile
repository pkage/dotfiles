#! /bin/sh
export GITAWAREPROMPT=~/.bash/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"

alias l="ls -AFG"
alias ll="ls -lFGhA"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias res="cd ~/repositories";
alias weather="curl wttr.in/06492"
alias ubersicht="cd ~/Library/Application\ Support/Übersicht/widgets/"
transfer() { if [ $# -eq 0 ]; then echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi ;	tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; } 

createLump() { mkdir $1; touch $1/$1.html; touch $1/$1.js; }
alias createLump=createLump

export PS1="[\$?] > {\W}\[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]: "
source /Users/patrick/.bazel/bin/bazel-complete.bash
export PATH=/Users/patrick/Repositories/python/syntaxnet/env_syntaxnet/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/patrick/bin

# iterm profile switcher
it2prof() { echo -e "\033]50;SetProfile=$1\a"; }
alias it2prof=it2prof

# honestly i don't want to have to type nvim every time
alias vi="nvim"


# added by Miniconda2 4.0.5 installer
export PATH="/Users/patrick/miniconda2/bin:$PATH"
