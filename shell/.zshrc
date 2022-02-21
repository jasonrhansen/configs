# Allow configuration that's specific to a machine to be put in ~/.zsh_local.sh
[ -f ~/.zsh_local.sh ] && source ~/.zsh_local.sh

platform=`uname`
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory extendedglob
bindkey -e

zstyle :compinstall filename '/home/jrhansen/.zshrc'

export PATH=~/bin:$PATH:~/go/bin:~/.cargo/bin

# OS X specific configuration
if [[ $platform == 'Darwin' ]]; then
    # Add coreutils to path.
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

    alias retroarch='/Applications/RetroArch.app/Contents/MacOS/RetroArch'
fi

# Keep custom completions in .zfunc
fpath+=~/.zfunc

export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/library"

export GOPATH=~/go

export VISUAL=nvim
export EDITOR=nvim

eval `dircolors ~/.dir_colors/dircolors.ansi-dark`

# autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

export SKIM_DEFAULT_COMMAND='rg --files --hidden --follow -g "!{node_modules}/*" 2> /dev/null'

# jellybeans theme
export FZF_DEFAULT_OPTS='
  --color fg:188,bg:233,hl:103,fg+:222,bg+:234,hl+:104
  --color info:183,prompt:110,spinner:107,pointer:167,marker:215
'

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

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

alias ls='exa'
alias ll='exa -l'
alias la='exa -a'
alias lla='exa -la'
alias lst='exa --tree'

alias clear='clear; tmux clear-history 2> /dev/null'
 
alias fixmouse='echo -e "\e[?1000h\e[?1000l"'

# Highlight
alias less='bat'
alias more='bat'

# tmux aliases
alias tms='tmux new-session -s'
alias tmls='tmux list-sessions'
alias tmks='tmux kill-session -t'
alias tmksv='tmux kill-server'
alias tma='tmux attach -t'
alias tmn='tmux new -s'
# Create a tmux session with the name set to the dir name. 
tmd() {
  tmux new -s $(basename $(pwd)) > /dev/null || tmux attach -t $(basename $(pwd))
}

# Boron is based on jellybeans
export BAT_THEME="Boron"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# prompt (install with "cargo install starship")
eval "$(starship init zsh)"

eval "$(rbenv init -)"

alias luamake=~/dev/others/lua-language-server/3rd/luamake/luamake
