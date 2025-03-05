# Allow configuration that's specific to a machine to be put in ~/.local.fish
[ -f ~/.local.fish ] && source ~/.local.fish

if status is-interactive
  starship init fish | source
end

set -x FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border'

set -x VISUAL nvim
set -x EDITOR nvim

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
function tms
  if [ -z $1 ]
    set fzf_cmd "fzf"
  else
    set fzf_cmd "fzf -q \"$1\" -1"
  end

  set selected $(begin; echo ~/configs && find ~/dev ~/dev/others -mindepth 1 -maxdepth 1 -type d; end | eval " $fzf_cmd" )

  if [ -z $selected ]
    return
  end

  set selected_name $(basename "$selected" | tr . _)
  set tmux_running $(pgrep tmux)

  if [ -z $TMUX ] && [ -z $tmux_running ]
      tmux new-session -s $selected_name -c $selected
      return
  end

  if ! tmux has-session -t=$selected_name 2> /dev/null
      tmux new-session -ds $selected_name -c $selected
  end

  if [ -z $TMUX ]
    tmux attach -t $selected_name
  else
    tmux switch-client -t $selected_name
  end
end

# Create or open a tmux session with the name set to the dir name.
function tmd
  tms "$(pwd)"
end

function tma
  if [ -n $1 ]
    tmux attach -t "$1"
  else
    tmux attach
  end
end

# Fuzzy find and attach to a tmux session.
function tmas
  if [ -z $1 ]
    set selected $(tmux list-sessions | fzf)
  else
    set selected $1
  end

  if [ -z $selected ]
    tmux attach
  end

  set selected $(echo $selected | cut -d: -f1)

  tmux attach -t "$selected"
end

# Fuzzy search for a directory and cd into it.
function sd
  if [ -z $1 ]
    cd "$(fdfind -t d | fzf)"
  else
    cd "$(fdfind -t d '' $1 | fzf)"
  end
end

# Fuzzy search for a directory under my home and cd into it.
alias sdh="sd ~"

set -x GOPATH ~/go

set -x PATH ~/bin $PATH
set -x PATH ~/.local/bin $PATH
set -x PATH $PATH $GOPATH/bin
set -x PATH $PATH ~/.cargo/bin
set -x PATH $PATH ~/.rvm/bin set -x PATH "$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin $PATH"
set -x PATH "$PATH ~/.local/bin"

set -x RUST_SRC_PATH "$(rustc --print sysroot)/lib/rustlib/src/rust/library"
