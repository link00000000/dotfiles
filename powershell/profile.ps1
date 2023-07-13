Set-Alias -Name vim -Value nvim
Set-Alias -Name grep -Value ag

Remove-Alias -Name ls
Set-Alias -Name ls -Value Get-ChildItemWithExa
Set-Alias -Name l -Value Get-ChildItem

Remove-Alias -Name cat
Set-Alias -Name cat -Value Get-ContentWithBat

Set-Alias -Name less -Value Page-WithLess

Set-Alias -Name hex -Value hexyl

function Get-ChildItemWithExa
{
    exa --oneline --long --group-directories-first --icons @args
}

function Get-ContentWithBat
{
    bat --theme=ansi --pager="less.exe -i -F -R -X" @args
}

function Page-WithLess
{
    if ($MyInvocation.ExpectingInput) # If input is being piped in
    {
        $Input | less.exe -i -F -R -X @args
    }
    else
    {
        less.exe -i -F -R -X @args
    }
}
