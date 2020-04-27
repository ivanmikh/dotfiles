#!/bin/bash

set -e
set -x

pck=(
  "alacritty" \
  "autoconf" \
  "automake" \
  "bc" \
  "binutils" \
  "build-essential" \
  "bzip2" \
  "cmake" \
  "cpio" \
  "curl" \
  "file" \
  "g++" \
  "gcc" \
  "git" \
  "gparted" \
  "gzip" \
  "libncurses-dev" \
  "libncurses5" \
  "libncurses5-dev" \
  "libncurses6" \
  "libtool" \
  "make" \
  "minicom" \
  "patch" \
  "perl" \
  "python3" \
  "python3-dev" \
  "python3-pip" \
  "ranger" \
  "rsync" \
  "sed" \
  "subversion" \
  "tar" \
  "tmux" \
  "trash-cli" \
  "unzip" \
  ""
)

py_pck=(
  "matplotlib" \
  "numpy" \
  "pyvisa" \
  "pyvisa-py" \
  "scipy" \
  ""
)

dotfiles=$(readlink -f ~/Documents/dotfiles)

### add repositories
sudo add-apt-repository ppa:mmstick76/alacritty

### install software
sudo apt install ${pck[@]} -y
pip3 install ${py_pck[@]}

### vim/nvim
# autoload
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.vim/autoload/cscope_maps.vim http://cscope.sourceforge.net/cscope_maps.vim
# colors
mkdir -p ~/.vim/colors
cp ${dotfiles}/vim/default.vim ~/.vim/colors
cp ${dotfiles}/vim/wombat256.vim ~/.vim/colors
# vimrc
if [ -f "~/.vimrc" ]; then
    mv ~/.vimrc ~/.vimrc.bk
fi
ln -s ${dotfiles}/vim/vimrc ~/.vimrc
# nvim
mkdir -p ~/.config/nvim
cp ${dotfiles}/nvim/init.vim ~/.config/nvim

### bash
if [ -f ~/.bashrc ]; then
    mv ~/.bashrc ~/.bashrc.bk
fi
ln -s ${dotfiles}/bash/bashrc ~/.bashrc

### ranger
mkdir -p ~/.config/ranger
ln -sf ${dotfiles}/ranger/commands.py ~/.config/ranger/commands.py
ln -sf ${dotfiles}/ranger/commands_full.py ~/.config/ranger/commands_full.py
ln -sf ${dotfiles}/ranger/rc.conf ~/.config/ranger/rc.conf
ln -sf ${dotfiles}/ranger/rifle.conf ~/.config/ranger/rifle.conf
ln -sf ${dotfiles}/ranger/scope.sh ~/.config/ranger/scope.sh

### tmux
if [ -f ~/.tmux.conf ]; then
   mv ~/.tmux.conf ~/.tmux.conf.bk
fi
ln -s ${dotfiles}/tmux/tmux.conf ~/.tmux.conf

### caps-to-esc
sudo cp -r ${dotfiles}/keyboard/X11 /etc/X11

### scripts
ln -s ${dotfiles}/diff_dirs/diff_dirs.sh ~/.local/bin/diff_dirs
ln -s ${dotfiles}/svn/svndiff.sh ~/.local/bin/svndiff
