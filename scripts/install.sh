#!/bin/bash

set -e
set -x

dotfiles=$(readlink -f ~/Documents/utils/dotfiles)
home=$(readlink -f ~/)
cwd=$(readlink -f $(pwd))

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
    ln -s $dotfiles/bash/bashrc $bashrc
}

function VIFMRC() {
    backup $vifmrc
    ln -s $dotfiles/vifm/vifmrc $vifmrc
}

function VIMRC() {
    backup $vimrc
    ln -s $dotfiles/vim/vimrc $vimrc
}

function TERMINATOR() {
    mkdir -p ${home}/.config/terminator
    backup ${home}/.config/terminator/config
    cp $dorfile/terminator/config ${home}/.config/terminator
}

function VIM() {
    mkdir -p $vim/autoload
    mkdir -p $vim/bundle
    mkdir -p $vim/colors

    wget http://cscope.sourceforge.net/cscope_maps.vim -P $vim/autoload/

    cp $dotfiles/vim/pixelmuerto.vim $vim/colors/

    if [ ! -d $vim/bundle/Vundle.vim ]; then
    	git clone https://github.com/VundleVim/Vundle.vim.git $vim/bundle/Vundle.vim
    fi

    vim +VundleInstall +qall
}

function YCM {
    sudo apt install build-essential cmake python3-dev
    cd $vim/bundle/YouCompleteMe
    ./install.py --clang-completer
    cd $cwd
}

function backup() {
    if [ -L $1 ]; then
        rm $1
    elif [ -f $1 ]; then
        mv $1 ${1}_bk
    fi
}

MAIN

exit $?

