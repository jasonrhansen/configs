# Allow configuration that's specific to a machine to be put in ~/.local.fish
[ -f ~/.local.fish ] && source ~/.local.fish

set fish_greeting ""

set -x FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border'

set -x VISUAL nvim
set -x EDITOR nvim

if command -q -v eza
    abbr -a ls eza
    abbr -a ll 'eza -l'
    abbr -a la 'eza -a'
    abbr -a lla 'eza -la'
    abbr -a lst 'eza --tree'
else
    abbr -a ls ls
    abbr -a ll 'ls -l'
    abbr -a la 'ls -a'
    abbr -a lla 'ls -la'
end

abbr -a tmls 'tmux list-sessions'
abbr -a tmks 'tmux kill-session -t'
abbr -a tmksv 'tmux kill-server'
abbr -a tmn 'tmux new -s'

# Fuzzy search for a directory under my home and cd into it.
abbr -a sdh "sd ~"

function clear
  command clear
  command -q tmux clear-history
end

function fixmouse
  echo -e "\e[?1000h\e[?1000l"
end

# Create or open a tmux session for the given directory.
# The session name will be based off of the directory name.
function tmux_for_dir -a dir
    set session_name $(basename "$dir" | tr . _)
    set tmux_running $(pgrep tmux)

    if test -z "$TMUX"; and test -z "$tmux_running"
        tmux new-session -s $session_name -c $dir
        return
    end

    if ! tmux has-session -t=$session_name 2>/dev/null
        tmux new-session -ds $session_name -c $dir
    end

    if test -z "$TMUX"
        tmux attach -t $session_name
    else
        tmux switch-client -t $session_name
    end
end

# Fuzzy find project directory and create or open a tmux session.
function tms -a search
    if set -q search
        set fzf_cmd "fzf -q \"$search\" -1"
    else
        set fzf_cmd fzf
    end

    set selected $(begin; echo ~/configs && find ~/dev ~/dev/others -mindepth 1 -maxdepth 1 -type d; end | eval " $fzf_cmd" )

    if test -z "$selected"
        return
    end

    tmux_for_dir "$selected"
end

# Create or open a tmux session with the name set to the dir name.
function tmd
    tmux_for_dir "$(pwd)"
end

function tma -a session
    if set -q session
        tmux attach
    else
        tmux attach -t "$session"
    end
end

# Fuzzy find and attach to a tmux session.
function tmas
    if set -q argv[1]
        set selected $(tmux list-sessions | fzf)
    else
        set selected $argv[1]
    end

    if set -q selected
        tmux attach
    end

    set selected $(echo $selected | cut -d: -f1)

    tmux attach -t "$selected"
end

# Fuzzy search for a directory and cd into it.
function sd -a directory
    if [ -z "$directory" ]
        cd "$(fdfind -t d | fzf)"
    else
        cd "$(fdfind -t d '' $search | fzf)"
    end
end

# Switch to parent directory of a repository.
function d
    while test $PWD != /
        if test -d .git
            break
        end
        cd ..
    end
end

function fish_user_key_bindings
    bind \cc cancel-commandline
    bind \cy accept-autosuggestion
end

set -x GOPATH ~/go

fish_add_path ~/bin
fish_add_path ~/.local/bin
fish_add_path "$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin $PATH"
fish_add_path --append ~/.cargo/bin
fish_add_path --append ~/.rvm/bin
fish_add_path --append $GOPATH/bin

if command -q -v rbenv
    source (rbenv init - | psub)
end

set -x RUST_SRC_PATH "$(rustc --print sysroot)/lib/rustlib/src/rust/library"

if status is-interactive
    starship init fish | source
    fish_config theme choose kanagawa
end
