#!/bin/bash

set -e
set -x

pck=(
  "alacritty" \
  "apt-file" \
  "autoconf" \
  "automake" \
  "bc" \
  "binutils" \
  "bison" \
  "build-essential" \
  "bzip2" \
  "cmake" \
  "cpio" \
  "cscope" \
  "ctags" \
  "curl" \
  "default-jre" \
  "file" \
  "flex" \
  "fzf" \
  "g++" \
  "g++-multilib" \
  "gawk" \
  "gcc" \
  "gcc-multilib" \
  "gdb" \
  "git" \
  "gparted" \
  "gzip" \
  "libncurses-dev" \
  "libncurses5" \
  "libncurses5-dev" \
  "libncurses6" \
  "liborc-dev" \
  "libtool" \
  "llvm" \
  "m4" \
  "make" \
  "minicom" \
  "net-tools" \
  "ninja-build" \
  "nodejs" \
  "patch" \
  "perl" \
  "python3" \
  "python3-dev" \
  "python3-pip" \
  "ranger" \
  "rsync" \
  "sed" \
  "subversion" \
  "swig" \
  "tar" \
  "texi2html" \
  "texinfo" \
  "tmux" \
  "trash-cli" \
  "unzip" \
  "yarn" \
  "yasm" \
  ""
)

py_pck=(
  "autopep8" \
  "cppman" \
  "ipython" \
  "matplotlib" \
  "neovim-remote" \
  "numpy" \
  "pylint" \
  "pyvisa" \
  "pyvisa-py" \
  "scipy" \
  ""
)

dotfiles=$(readlink -f ~/Documents/dotfiles)

### add repositories
sudo add-apt-repository ppa:mmstick76/alacritty

### install software
sudo apt update
sudo apt install "${pck[@]}" -y
pip3 install "${py_pck[@]}"

### vim/nvim
# autoload
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.vim/autoload/cscope_maps.vim http://cscope.sourceforge.net/cscope_maps.vim
# colors
mkdir -p ~/.vim/colors
ln -s "${dotfiles}"/vim/default.vim ~/.vim/colors/default.vim
ln -s "${dotfiles}"/vim/wombat256.vim ~/.vim/colors/wombat256.vim
# more folders
mkdir -p ~/.vim/swap
mkdir -p ~/.vim/undo
# vimrc
if [ -f "$HOME/.vimrc" ]; then
    mv ~/.vimrc ~/.vimrc.bk
fi
ln -s "${dotfiles}"/vim/vimrc ~/.vimrc
# nvim
mkdir -p ~/.config/nvim
ln -s "${dotfiles}"/nvim/init.vim ~/.config/nvim/init.vim
ln -s "${dotfiles}"/nvim/coc-settings.json ~/.config/nvim/coc-settings.json

### bash
if [ -f ~/.bashrc ]; then
    mv ~/.bashrc ~/.bashrc.bk
fi
ln -s "${dotfiles}"/bash/bashrc ~/.bashrc

### ranger
mkdir -p ~/.config/ranger
ln -sf "${dotfiles}"/ranger/commands.py ~/.config/ranger/commands.py
ln -sf "${dotfiles}"/ranger/commands_full.py ~/.config/ranger/commands_full.py
ln -sf "${dotfiles}"/ranger/rc.conf ~/.config/ranger/rc.conf
ln -sf "${dotfiles}"/ranger/rifle.conf ~/.config/ranger/rifle.conf
ln -sf "${dotfiles}"/ranger/scope.sh ~/.config/ranger/scope.sh

### tmux
if [ -f ~/.tmux.conf ]; then
   mv ~/.tmux.conf ~/.tmux.conf.bk
fi
ln -s "${dotfiles}"/tmux/tmux.conf ~/.tmux.conf

### alacritty
if [ -f ~/.config/alacritty/alacritty.yml ]; then
    mv ~/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml.bk
else
    mkdir -p ~/.config/alacritty
fi
ln -s "${dotfiles}"/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml 

### caps-to-esc
sudo cp -r "${dotfiles}"/keyboard/X11 /etc/X11

### scripts
ln -s "${dotfiles}"/diff_dirs/diff_dirs.sh ~/.local/bin/diff_dirs
ln -s "${dotfiles}"/svn/svndiff.sh ~/.local/bin/svndiff
