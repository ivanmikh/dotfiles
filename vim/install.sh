#!/bin/bash

set -e
set -x

dotfiles=$(readlink -f "$(dirname $0)")

mkdir -p ~/.vim/swap
mkdir -p ~/.vim/undo
mkdir -p ~/.config/nvim

ln -sf ${dotfiles}/vimrc ~/.vimrc
ln -sf ${dotfiles}/colors ~/.vim/colors
ln -sf ${dotfiles}/init.vim ~/.config/nvim/init.vim
ln -sf ${dotfiles}/coc-settings.json ~/.config/nvim/coc-settings.json

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Node.js LTS (v16.x):
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

nvim -c PlugUpdate
nvim -c 'CocInstall coc-sh' \
     -c 'CocInstall coc-pyright' \
     -c 'CocInstall coc-clangd'
