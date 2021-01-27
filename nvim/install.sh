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

nvim -c PlugUpdate

