Set-Alias -Name vim -Value nvim.exe
Set-Alias -Name grep -Value ag.exe

Remove-Alias -Name ls
Set-Alias -Name ls -Value Get-ChildItemWithExa
Set-Alias -Name l -Value Get-ChildItem

Remove-Alias -Name cat
Set-Alias -Name cat -Value Get-ContentWithBat

Remove-Alias -Name rm
Set-Alias -Name rm -Value Remove-LikeUnix

Set-Alias -Name less -Value Page-WithLess

Set-Alias -Name hex -Value hexyl.exe

Set-Alias -Name notepad -Value Open-Kate

function Get-ChildItemWithExa
{
    exa.exe --oneline --long --group-directories-first --icons @args
}

function Get-ContentWithBat
{
    if ($args[$args.Count - 1].ToString().EndsWith(".md"))
    {
        glow.exe --local @args
        return
    }

    bat.exe --theme=ansi --pager="less.exe -i -F -R -X" @args
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

function Remove-LikeUnix
{
    if ($args.Count -eq 0)
    {
        Write-Host "Remove files like Unix rm

Usage:
    rm [-r] [-f] <path> [<...paths>]
"
        return
    }

    $Options = New-Object System.Collections.Generic.HashSet[string]
    $Paths = @()

    foreach ($Arg in $args)
    {
        if ($Arg.StartsWith("-"))
        {
            foreach ($Char in $Arg.ToCharArray())
            {
                if ($Char -eq "-")
                {
                    continue
                }
                elseif ($Char -eq "r")
                {
                    $null = $Options.Add("-Recurse")
                }
                elseif ($Char -eq "f")
                {
                    $null = $Options.Add("-Force")
                }
                else
                {
                    $Message = "Unknown option -$Char"
                    throw $Message;
                }
            }
        }
        else
        {
            $Paths += $Arg
        }
    }

    Invoke-Expression "Remove-Item $($Options -Join " ") $($Paths -Join ",")"
}

function Require-Module
{
    param(
        [Parameter(Mandatory = $true)]
        [string[]] $Modules
    )

    foreach ($Module in $Modules)
    {
        if (!$(Get-Module -ListAvailable -Name $Module))
        {
            Install-Module $Module
        }

        Import-Module $Module
    }
}

function Assert-Condition
{
    param(
        [Parameter(Mandatory = $true)]
        [bool] $Condition,

        [Parameter(Mandatory = $false)]
        [string] $Message
    )

    if (!$Condition)
    {
        if (![System.String]::IsNullOrWhiteSpace($Message))
        {
            Write-Error $Message
        }

        throw
    }
}

function Invoke-ExpressionWithEnvironmentVariables
{
    param(
        [Parameter(Mandatory = $true)]
        [HashTable] $Variables,

        [Parameter(Mandatory = $true)]
        [string] $Command
    )

    $VariableStrings = @()
    foreach ($Key in $Variables.Keys)
    {
        $VariableStrings += "$Key=$($Variables[$Key])"
    }

    Invoke-Expression "cross-env $($VariableStrings -Join " ") $Command"
}

function Using-EnvironmentVariables
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [HashTable] $Variables,

        [Parameter(Mandatory = $true)]
        [ScriptBlock] $ScriptBlock
    )

    $PreviousValues = @{}
    foreach ($Key in $Variables.Keys)
    {
        $Value = $Variables[$Key]

        $PreviousValues.Add($Key, $(Get-ChildItem -Path "Env:$Key" -ErrorAction SilentlyContinue).Value)

        [System.Environment]::SetEnvironmentVariable($Key, $Value)
    }

    Invoke-Command -ScriptBlock $ScriptBlock

    foreach ($Key in $Variables.Keys)
    {
        [System.Environment]::SetEnvironmentVariable($Key, $PreviousValues[$Key])
    }
}

function Open-Kate
{
    C:\"Program Files"\Kate\bin\kate.exe $args
}

Require-Module -Modules PSFzf, posh-git
