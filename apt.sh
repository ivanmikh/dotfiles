#!/bin/bash

set -e
set -x

pck=(
  "apt-file" \
  "asciidoc" \
  "atool" \
  "autoconf" \
  "automake" \
  "bash-completion" \
  "bc" \
  "bear" \
  "binutils" \
  "binutils-dev"
  "bison" \
  "build-essential" \
  "bzip2" \
  "cargo" \
  "ccls" \
  "clang" \
  "clang-tools" \
  "clangd" \
  "cmake" \
  "cpio" \
  "crash" \
  "cscope" \
  "curl" \
  "default-jre" \
  "fakeroot" \
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
  "git-doc" \
  "git-email" \
  "gparted" \
  "gzip" \
  "htop" \
  "kernel-wedge" \
  "kexec-tools" \
  "libelf-dev" \
  "libfontconfig1-dev" \
  "libfreetype6-dev" \
  "libncurses-dev" \
  "libncurses5-dev" \
  "libncurses6" \
  "liborc-dev" \
  "libssl-dev"
  "libtool" \
  "libxcb-xfixes0-dev" \
  "llvm" \
  "llvm" \
  "m4" \
  "make" \
  "makedumpfile" \
  "meson" \
  "minicom" \
  "neovim" \
  "net-tools" \
  "ninja-build" \
  "nodejs" \
  "npm" \
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
  "universal-ctags" \
  "unzip" \
  "vim-gtk3" \
  "yarn" \
  "yasm" \
  "zsh"
)

py_pck=(
  "pylint" \
  "python3-ipython" \
  "python3-matplotlib" \
  "python3-numpy" \
  "python3-pyvisa" \
  "python3-pyvisa-py" \
  "python3-scipy"
)

dotfiles=$(readlink -f "$(dirname $0)")

if [ "$dotfiles" == "" ]; then
    exit 1
fi

### install software
#sudo apt update
#sudo apt install "${pck[@]}" -y
#sudo apt install "${py_pck[@]}" -y

### alacritty
cargo install alacritty
sudo update-alternatives --install /usr/bin/alacritty alacritty "${HOME}/.cargo/bin/alacritty" 50
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50

### bash
cp --backup "${dotfiles}"/sh/bashrc ~/.bashrc

### zsh
cp --backup "${dotfiles}"/sh/zshrc ~/.zshrc

### aliases
cp --backup "${dotfiles}"/sh/aliases ~/.aliases

### default shell
sudo chsh --shell /bin/zsh ${USER}

### ranger
mkdir -p ~/.config/ranger
cp --backup "${dotfiles}"/ranger/commands.py ~/.config/ranger/commands.py
cp --backup "${dotfiles}"/ranger/commands_full.py ~/.config/ranger/commands_full.py
cp --backup "${dotfiles}"/ranger/rc.conf ~/.config/ranger/rc.conf
cp --backup "${dotfiles}"/ranger/rifle.conf ~/.config/ranger/rifle.conf
cp --backup "${dotfiles}"/ranger/scope.sh ~/.config/ranger/scope.sh

### tmux
cp --backup "${dotfiles}"/tmux/tmux.conf ~/.tmux.conf

### alacritty
mkdir -p ~/.config/alacritty
cp --backup "${dotfiles}"/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml 

### scripts
mkdir -p ~/.local/bin
ln -sf "${dotfiles}"/svn/svndiff.sh ~/.local/bin/svndiff.sh

### add cargo bin to profile
if [ "$(grep -e '.cargo/bin' ~/.profile)" == "" ]; then

cat << EOF >> ~/.profile

# add Cargo bin directory
if [ -d "\$HOME/.cargo/bin" ] ; then
    PATH="\$HOME/.cargo/bin:\$PATH"
fi
EOF

fi

