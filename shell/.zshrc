# Allow configuration that's specific to a machine to be put in ~/.zsh_local.sh
[ -f ~/.zsh_local.sh ] && source ~/.zsh_local.sh

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
if [ -d /usr/share/doc/fzf/examples ]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh
fi

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory extendedglob
bindkey -e

zstyle :compinstall filename "$HOME/.zshrc"

# Keep custom completions in .zfunc
fpath+=~/.zfunc

export VISUAL=nvim
export EDITOR=nvim

if [[ -v WEZTERM_PANE ]]; then
  export TERM=wezterm
fi

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
alias tmls='tmux list-sessions'
alias tmks='tmux kill-session -t'
alias tmksv='tmux kill-server'
alias tmn='tmux new -s'
# Fuzzy find project directory and create or open a tmux session.
tms() {
  if [ -z $1 ]
  then
    fzf_cmd="fzf"
  else
    fzf_cmd="fzf -q \"$1\" -1"
  fi

  selected=$({ echo ~/configs && find ~/dev ~/dev/others -mindepth 1 -maxdepth 1 -type d; } | eval " $fzf_cmd" )

  if [[ -z $selected ]]; then
    return
  fi

  selected_name=$(basename "$selected" | tr . _)
  tmux_running=$(pgrep tmux)

  if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
      tmux new-session -s $selected_name -c $selected
      return
  fi

  if ! tmux has-session -t=$selected_name 2> /dev/null; then
      tmux new-session -ds $selected_name -c $selected
  fi

  if [[ -z $TMUX ]]; then
    tmux attach -t $selected_name
  else
    tmux switch-client -t $selected_name
  fi
}
# Create or open a tmux session with the name set to the dir name.
tmd() {
  tms "$(pwd)"
}
tma() {
  if [ -n $1 ]
  then
    tmux attach -t "$1"
  else
    tmux attach
  fi
}
# Fuzzy find and attach to a tmux session.
tmas() {
  if [ -z $1 ]; then
    selected=$(tmux list-sessions | fzf)
  else
    selected=$1
  fi

  if [[ -z $selected ]]; then
    tmux attach
  fi

  selected=$(echo $selected | cut -d: -f1)

  tmux attach -t "$selected"
}

# Fuzzy search for a directory and cd into it.
sd() {
  if [ -z $1 ]; then
    cd "$(fdfind -t d | fzf)"
  else
    cd "$(fdfind -t d '' $1 | fzf)"
  fi
}

# Fuzzy search for a directory under my home and cd into it.
alias sdh="sd ~"

alias luamake=~/dev/others/lua-language-server/3rd/luamake/luamake

export GOPATH=~/go

export PATH=~/bin:$PATH
export PATH=~/.local/bin:$PATH
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:~/.cargo/bin
export PATH=$PATH:~/.rvm/bin
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$PATH:~/.local/bin"

export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/library"

# prompt (install with "cargo install starship")
eval "$(starship init zsh)"

eval "$(rbenv init -)"
