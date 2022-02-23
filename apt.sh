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
  "cmake" \
  "cpio" \
  "crash" \
  "cscope" \
  "universal-ctags" \
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
  "kernel-wedge" \
  "kexec-tools" \
  "libelf-dev" \
  "libfontconfig1-dev" \
  "libfreetype6-dev" \
  "libncurses-dev" \
  "libncurses5" \
  "libncurses5" \
  "libncurses5-dev" \
  "libncurses5-dev" \
  "libncurses6" \
  "liborc-dev" \
  "libssl-dev"
  "libtool" \
  "libxcb-xfixes0-dev" \
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
  "unzip" \
  "vim-gtk" \
  "yarn" \
  "yasm" \
  "zsh"
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

### alacritty
cargo install alacritty
sudo update-alternatives --install /usr/bin/alacritty alacritty "${HOME}/.cargo/bin/alacritty" 50
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50

function backup_and_link() {
    if [ -f "${2}" ]; then
        mv "${2}" "${2}".bk
    fi
    ln -sf "${1}" "${2}"
}

### bash
backup_and_link "${dotfiles}"/sh/bashrc ~/.bashrc

### zsh
backup_and_link "${dotfiles}"/sh/zshrc ~/.zshrc

### aliases
backup_and_link "${dotfiles}"/sh/aliases ~/.aliases

### default shell
sudo chsh --shell /bin/zsh ${USER}

### caps to esc
gsettings set org.gnome.desktop.input-sources xkb-options \[\'caps:escape\'\]

### ranger
mkdir -p ~/.config/ranger
backup_and_link "${dotfiles}"/ranger/commands.py ~/.config/ranger/commands.py
backup_and_link "${dotfiles}"/ranger/commands_full.py ~/.config/ranger/commands_full.py
backup_and_link "${dotfiles}"/ranger/rc.conf ~/.config/ranger/rc.conf
backup_and_link "${dotfiles}"/ranger/rifle.conf ~/.config/ranger/rifle.conf
backup_and_link "${dotfiles}"/ranger/scope.sh ~/.config/ranger/scope.sh

### tmux
backup_and_link "${dotfiles}"/tmux/tmux.conf ~/.tmux.conf

### alacritty
mkdir -p ~/.config/alacritty
backup_and_link "${dotfiles}"/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml 

sudo wget -O /usr/share/pixmaps/Alacritty.svg https://raw.githubusercontent.com/alacritty/alacritty/master/extra/logo/compat/alacritty-term.png
sudo wget -O /usr/share/applications/Alacritty.desktop https://raw.githubusercontent.com/alacritty/alacritty/master/extra/linux/Alacritty.desktop

### scripts
ln -sf "${dotfiles}"/svn/diff_dirs.sh ~/.local/bin/diff_dirs
ln -sf "${dotfiles}"/svn/svndiff.sh ~/.local/bin/svndiff

### add cargo bin to profile
if [ "$(grep -e '.cargo/bin' ~/.profile)" == "" ]; then

cat << EOF >> ~/.profile

# add Cargo bin directory
if [ -d "\$HOME/.cargo/bin" ] ; then
PATH="\$HOME/.cargo/bin:\$PATH"
fi
EOF

fi

