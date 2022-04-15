# Allow configuration that's specific to a machine to be put in ~/.zsh_local.sh
[ -f ~/.zsh_local.sh ] && source ~/.zsh_local.sh

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory extendedglob
bindkey -e

zstyle :compinstall filename '/home/jrhansen/.zshrc'

# Keep custom completions in .zfunc
fpath+=~/.zfunc

export VISUAL=nvim
export EDITOR=nvim

eval `dircolors ~/.dir_colors/dircolors.ansi-dark`

# autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

export SKIM_DEFAULT_COMMAND='rg --files --hidden --follow -g "!{node_modules}/*" 2> /dev/null'

# Disable lazy load the zsh-nvm plugin.
export NVM_LAZY_LOAD=false

# Load zgen plugin manager
source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
    echo "Creating a zgen save"
    zgen oh-my-zsh

    # Plugins
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/command-not-found
    zgen load mafredri/zsh-async
    zgen load zsh-users/zsh-completions
    zgen load chrissicool/zsh-256color
    zgen load lukechilds/zsh-nvm
    # This plugin should be loaded last
    zgen load zsh-users/zsh-syntax-highlighting

    zgen save
fi

alias ls='exa'
alias ll='exa -l'
alias la='exa -a'
alias lla='exa -la'
alias lst='exa --tree'

alias clear='clear; tmux clear-history 2> /dev/null'
 
alias fixmouse='echo -e "\e[?1000h\e[?1000l"'

# tmux aliases
alias tms='tmux new-session -s'
alias tmls='tmux list-sessions'
alias tmks='tmux kill-session -t'
alias tmksv='tmux kill-server'
alias tmn='tmux new -s'
# Create a tmux session with the name set to the dir name. 
tmd() {
  tmux new -s $(basename $(pwd)) > /dev/null || tmux attach -t $(basename $(pwd))
}
tma() {
  if [ -n $1 ]
  then
    tmux attach -t "$1"
  else
    tmux attach
  fi
}

alias luamake=~/dev/others/lua-language-server/3rd/luamake/luamake

export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/library"
export GOPATH=~/go

export PATH=~/bin:$PATH
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:~/.cargo/bin
export PATH=$PATH:~/.rvm/bin
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# prompt (install with "cargo install starship")
eval "$(starship init zsh)"

eval "$(rbenv init -)"
