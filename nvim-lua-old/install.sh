#! /bin/bash

set -e

cp init.vim ~/.config/nvim/init.vim
rm -rf ~/.config/nvim/lua
cp -r lua ~/.config/nvim/lua

echo "done!"
