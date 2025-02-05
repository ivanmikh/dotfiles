# config.nu
#
# Installed by:
# version = "0.101.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

$env.EDITOR = "nvim.exe"

alias pk = cd ~/Dev/proj_k
alias pkh = cd ~/Dev/proj_k/HEP
alias pka = cd ~/Dev/proj_k/HEP_Autotest

alias p87 = cd ~/Dev/proj_8700
alias p87h = cd ~/Dev/proj_8700/HEP
alias p87a = cd ~/Dev/proj_8700/HEP_Autotest

alias nvc = nvim -S ~/config.vim

def prompt [] {
  let cwd = ([ (pwd) ] | str replace 'C:\Users\SESA797721' '~')

  $cwd
}

$env.PROMPT_COMMAND = { || prompt }
$env.TRANSIENT_PROMPT_COMMAND_RIGHT = null
$env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = null

$env.config.edit_mode = 'emacs'
$env.config.show_banner = false

$env.config.history = {
  file_format: sqlite
  max_size: 1_000_000
  sync_on_enter: true
  isolation: true
}

$env.STARSHIP_CONFIG = ($nu.data-dir | path join "starship.toml")

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
