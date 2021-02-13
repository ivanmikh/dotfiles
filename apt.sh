#!/bin/bash

set -e
set -x


pck=(
  "apt-file" \
  "autoconf" \
  "automake" \
  "bc" \
  "binutils" \
  "bison" \
  "build-essential" \
  "bzip2" \
  "cargo" \
  "ccls" \
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
  "libfontconfig1-dev" \
  "libfreetype6-dev" \
  "libncurses-dev" \
  "libncurses5" \
  "libncurses5-dev" \
  "libncurses6" \
  "liborc-dev" \
  "libtool" \
  "libxcb-xfixes0-dev" \
  "llvm" \
  "m4" \
  "make" \
  "meson" \
  "minicom" \
  "neovim" \
  "net-tools" \
  "ninja-build" \
  "nodejs" \
  "patch" \
  "perl" \
  "pkg-config" \
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
  "yasm"
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
  "scipy"
)

dotfiles=$(readlink -f "$(dirname $0)")

if [ "$dotfiles" == "" ]; then
    exit 1
fi

### install software
sudo apt update
sudo apt install "${pck[@]}" -y
pip3 install "${py_pck[@]}"
cargo install alacritty

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

sudo wget -O /usr/share/pixmaps/alacritty-term.svg https://raw.githubusercontent.com/alacritty/alacritty/master/extra/logo/compat/alacritty-term.png
sudo wget -O /usr/share/applications/Alacritty.desktop https://raw.githubusercontent.com/alacritty/alacritty/master/extra/linux/Alacritty.desktop

### scripts
ln -s "${dotfiles}"/svn/diff_dirs.sh ~/.local/bin/diff_dirs
ln -s "${dotfiles}"/svn/svndiff.sh ~/.local/bin/svndiff

cat << EOF >> ~/.profile

# add Cargo bin directory
if [ -d "\$HOME/.cargo/bin" ] ; then
    PATH="\$HOME/.cargo/bin:\$PATH"
fi
EOF
