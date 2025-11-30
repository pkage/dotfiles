#! /bin/bash

set -e

# cp init.vim ~/.config/nvim/init.vim
# rm -rf ~/.config/nvim
# cp -r nvim ~/.config/nvim
rsync -rav nvim ~/.config

echo "done!"
