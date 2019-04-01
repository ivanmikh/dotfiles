#!/bin/bash

dotfiles=$(readlink -f ~/Documents/utils/dotfiles)
home=$(readlink -f ~/)
pwd=$(readlink -f $(pwd))

vim=$home/.vim
vifm=$home/.config/vifm

bashrc=$home/.bashrc
vimrc=$home/.vimrc
vifmrc=$vifm/vifmrc

function MAIN() {
    BASHRC
    VIFMRC
    VIMRC
    VIM
    YCM
}

function BASHRC() {
    backup $bashrc
    ln -s $dotfiles/bashrc $bashrc
}

function VIFMRC() {
    backup $vifmrc
    ln -s $dotfiles/vifmrc $vifmrc
}

function VIMRC() {
    backup $vimrc
    ln -s $dotfiles/vimrc $vimrc
}

function VIM() {
    mkdir -p $vim/autoload
    mkdir -p $vim/bundle
    mkdir -p $vim/colors

    wget http://cscope.sourceforge.net/cscope_maps.vim -O $vim/autoload/

    cp $dotfiles/pixelmuerto.vim $vim/colors/

    git clone https://github.com/VundleVim/Vundle.vim.git $vim/bundle/Vundle.vim

    vim +VundleInstall +qall
}

function YCM {
    sudo apt install build-essential cmake python3-dev
    cd $vim/bundle/YouCompleteMe
    ./install.py --clang-completer
    backup .ycm_extra_conf.py
    ln -s $dotfiles/ycm_extra_conf.py .ycm_extra_conf.py
    cd $pwd
}

function backup() {
    if [ -f $1 ] && [ ! -L $1 ]; then
        mv $1 ${1}_bk
    fi
}

MAIN

exit $?

