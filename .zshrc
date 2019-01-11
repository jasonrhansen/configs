platform=`uname`
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory extendedglob
bindkey -e

zstyle :compinstall filename '/home/jrhansen/.zshrc'

autoload -Uz compinit
compinit

autoload -U promptinit
promptinit
prompt redhat

export PATH=~/bin:$PATH:~/go/bin:~/.cargo/bin

# OS X specific configuration
if [[ $platform == 'Darwin' ]]; then
    # Add coreutils to path.
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

    export ANDROID_HOME=~/Library/Android/sdk
    export NDK_HOME=$ANDROID_HOME/ndk-bundle

    alias retroarch='/Applications/RetroArch.app/Contents/MacOS/RetroArch'
fi

# Linux specific configuration
if [[ $platform == 'Linux' ]]; then
    alias pac='packer-color'
    alias way='env GDK_BACKEND=wayland'
fi

local rusthost=$(rustup show | grep "(default)" | awk '{ print $1 }')
export RUST_SRC_PATH=~"/.multirust/toolchains/$rusthost/lib/rustlib/src/rust/src"

export GOPATH=~/go

export VISUAL=nvim
export EDITOR=nvim

eval `dircolors ~/.dir_colors/dircolors.base16.dark`

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-atelier-dune.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
if [ -z $TERM ]; then
    export TERM="xterm-256color"
fi


if type thefuck > /dev/null; then
    eval "$(thefuck --alias)"
fi

# tmux aliases
alias tms='tmux new-session -s'
alias tmls='tmux list-sessions'
alias tmks='tmux kill-session -t'
alias tmksv='tmux kill-server'
alias tma='tmux attach -t'
alias tmn='tmux new -s'

tm() {
    local session
    newsession=${1:-new}
    session=$(tmux list-sessions -F "#{session_name}" | \
        sk --query="$1" --select-1 --exit-0) &&
        tmux attach-session -t "$session" || tmux new-session -s $newsession
}


# autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

export SKIM_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'

# Load zgen plugin manager
source "${HOME}/.zgen/zgen/zgen.zsh"

if ! zgen saved; then
    echo "Creating a zgen save"
    zgen oh-my-zsh

    # Plugins
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/command-not-found
    zgen load mafredri/zsh-async
    zgen load sindresorhus/pure
    zgen load zsh-users/zsh-completions
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
