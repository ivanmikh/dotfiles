
#Fzf (Import the fuzzy finder and set a shortcut key to begin searching)
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

function fzf-d {
    Get-ChildItem . -Recurse -Attributes Directory | Invoke-Fzf | Set-Location
}
function fzf-f {
    Get-ChildItem . -Recurse -Attributes !Directory | Invoke-Fzf | % { nvim $_ }
}

# Remove char or exit on ctrl-d
Set-PSReadlineKeyHandler -Key ctrl+d -Function DeleteCharOrExit

# Next/prev commands with ctrl-n/p
Set-PSReadlineKeyHandler -Key ctrl+p -Function PreviousHistory
Set-PSReadlineKeyHandler -Key ctrl+n -Function NextHistory

# oh-my-posh
oh-my-posh init pwsh --config '~\Dev\dotfiles\sh\stelbent.minimal.omp.json' | Invoke-Expression
# starship
#Invoke-Expression (&starship init powershell)
