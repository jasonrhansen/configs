#!/usr/bin/env bash

platform=$(uname)

# For Mac only
if [[ $platform == 'Darwin' ]]; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    brew bundle
    brew linkapps

    sudo pip2 install pynvim
    sudo pip3 install pynvim
    sudo gem install neovim
fi

stow shell
stow editor
stow gui

# Install rust with rustup
curl https://sh.rustup.rs -sSf | sh
rustup install stable
rustup install nightly
rustup component add rust-src
rustup component add clippy
rustup component add rls
rustup component add rustfmt
rustup component add rust-analysis
rustup +nightly component add rust-analyzer-preview

# Install wasm-pack
curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh

# Install Node Version Manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Install latest LTS version of node
nvm install --lts --default
nvm alias default stable

# Install language servers to be used with neovim LSP
npm install -g @angular/language-server
npm install -g bash-language-server
npm install -g npm
npm install -g dockerfile-language-server-nodejs
npm install -g graphql-language-service-cli
npm install -g intelephense
npm install -g sql-language-server
npm install -g typescript typescript-language-server
npm install -g vim-language-server
npm install -g vls
npm install -g yaml-language-server
npm install -g vscode-langservers-extracted

# Install formatters to use with null-ls
npm install -g @fsouza/prettierd
cargo install stylua
gem install rubocop

cargo install tree-sitter-cli

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

echo "Installing packer.nvim and neovim plugins"
git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
nvim +PackerSync

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
zgen_dir=~/.zgen
if [ ! -e "$zgen_dir" ]; then
    mkdir -p "$zgen_dir"
    git clone https://github.com/tarjoilija/zgen.git "$zgen_dir"
fi

if [[ "$SHELL" != *zsh ]]; then
    echo "Making zsh the default shell"
    chsh -s "$(command -v zsh)"
fi

echo "Installing wezterm terminfo file"
tempfile=$(mktemp) \
  && curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo \
  && tic -x -o ~/.terminfo $tempfile \
  && rm $tempfile
