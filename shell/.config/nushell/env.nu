# Nushell Environment Config File

$env.VISUAL = "nvim"
$env.EDITOR = "nvim"

$env.STARSHIP_SHELL = "nu"

def create_left_prompt [] {
  starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = { create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = ""

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ": "
$env.PROMPT_INDICATOR_VI_NORMAL = "〉"
$env.PROMPT_MULTILINE_INDICATOR = "::: "

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
$env.NU_LIB_DIRS = [
  ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
$env.NU_PLUGIN_DIRS = [
  ($nu.config-path | path dirname | path join 'plugins')
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')

$env.GOPATH = '~/go'

let path_prepend = [
  '~/bin',
  '~/.yarn.bin',
  '~/.config/yarn/global/node_modules/.bin',
]

let path_append = [
  $env.GOPATH,
  $"($env.GOPATH)/bin",
  '~/.cargo/bin',
  '~/.rvm/bin',
  '~/.local/bin',
]

$env.PATH = (
  $env.PATH |
  split row (char esep) |
  prepend $path_prepend |
  append $path_append |
  each { |p| ($p | path expand -n) }
)

$env.RUST_SRC_PATH = $"(rustc --print sysroot)/lib/rustlib/src/rust/library"

# Workaround for prompt moving to bottom after typing when opening new terminal window.
sleep 100ms
