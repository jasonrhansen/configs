#!/usr/bin/env bash

platform=`uname`

# For Mac only
if [[ $platform == 'Darwin' ]]; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    cd ~/.homebrew
    brew bundle
    cd -

    brew linkapps

    sudo pip2 install neovim
    sudo pip3 install neovim
fi

# Symlinks for neovim to use vim config
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim

# Install rust with rustup
curl https://sh.rustup.rs -sSf | sh
rustup component add rust-src
rustup component add clippy-preview
rustup component add rls-preview
rustup component add rustfmt-preview
rustup component add rust-analysis
rustup install stable
rustup install nightly

// Install wasm-pack
curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh

pub=$HOME/.ssh/id_rsa.pub
echo 'Checking for SSH key, generating one if it does not exist...'
[[ -f $pub ]] || ssh-keygen -t rsa

echo 'Copying public key to clipboard. Paste it into your Github account...'
[[ -f $pub ]] && cat $pub | pbcopy
open 'https://github.com/account/ssh'

echo "Installing base16-shell"
base16_dir=~/.config/base16-shell
if [ ! -e "$base16_dir" ]; then
    git clone https://github.com/chriskempson/base16-shell.git "$base16_dir"
fi

echo "Fixing terminfo entry for C-h"
TERM="xterm-256color"
infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
tic $TERM.ti
rm $TERM.ti

echo "Installing vim-plug and vim plugins"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugClean +qall
vim +PlugInstall +qall

echo "Installing tmux plugin manager"
tmux_plugins_dir=~/.tmux/plugins
tpm_dir="$tmux_plugins_dir"/tpm
if [ ! -e "$tpm_dir" ]; then
    mkdir -p "$tpm_dir"
    git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
fi

echo "Installing tmux plugins"
tmux start-server
tmux new-session -d
~/.tmux/plugins/tpm/scripts/install_plugins.sh
tmux kill-server

echo "Installing zgen (zsh plugin manager)"
zgen_dir=~/.zgen/zgen
if [ ! -e "$zgen_dir" ]; then
    mkdir -p "$zgen_dir"
    git clone https://github.com/tarjoilija/zgen.git "$zgen_dir"
fi

if [[ "$SHELL" != *zsh ]]; then
    echo "Making zsh the default shell"
    chsh -s $(which zsh)
fi

