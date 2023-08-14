param(
    [string] $Configuration
)

function Print-Usage
{
    Write-Host "Create symbolic links, copy files, and set environment variables required for configurations.

Usage: ./link.ps1 <configuration>

Available configurations:
    all"

    foreach ($key in $Configurations.Keys | Sort-Object)
    {
        Write-Host "    $key"
    }

    Write-Host
}

function Get-ConfigPath
{
    param([string] $RelativePath)

    return Join-Path -Path $PSScriptRoot -ChildPath $RelativePath
}

function Create-SymbolicLink
{
    param([string] $Source, [string] $Destination)

    $DestinationParentDirectory = Split-Path -Path $Destination -Parent
    if (!(Test-Path $DestinationParentDirectory))
    {
        New-Item -ItemType Directory -Path $DestinationParentDirectory
        if (!$?)
        {
            return
        }
    }

    New-Item -ItemType SymbolicLink -Path $Destination -Target $Source
}

function Create-Shortcut
{
    param([string] $Source, [string] $Destination)

    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($Destination)
    $Shortcut.TargetPath = $Source
    $Shortcut.Save()
}

function Set-EnvironmentVariable
{
    param([string] $Key, [string] $Value, [string][ValidateSet("User", "Machine")] $Scope="User")

    [System.Environment]::SetEnvironmentVariable($Key, $Value, $Scope)
}

# Main

$Configurations = @{
    alacritty = {
        $Source = Get-ConfigPath -RelativePath "alacritty"
        $Dest = Join-Path $Env:AppData -ChildPath "alacritty"
        Create-SymbolicLink -Source $Source -Destination $Dest
    }
    autohotkey = {
        $source = Get-ConfigPath -RelativePath "autohotkey/GlobalBindings.ahk"
        $Dest = Join-Path $Env:AppData -ChildPath "Microsoft/Windows/Start Menu/Programs/Startup/GlobalBindings.lnk"

        Create-Shortcut -Source $Source -Destination $Dest

        $Source = Get-ConfigPath -RelativePath "autohotkey/RiderBindings.ahk"
        $Dest = Join-Path $Env:AppData -ChildPath "Microsoft/Windows/Start Menu/Programs/Startup/RiderBindings.lnk"

        Create-Shortcut -Source $Source -Destination $Dest
    }
    flowlauncher = {
        # FlowLauncher does not support symlinks so the files must be copied

        $FlowLauncherSettingsDirectory = Join-Path $Env:AppData -ChildPath "flowlauncher"

        $Source = Get-ConfigPath -RelativePath "FlowLauncher/Themes"
        $Dest = Join-Path -Path $FlowLauncherSettingsDirectory -ChildPath "Themes"
        Remove-Item -Path $Dest -Recurse -Force
        Copy-Item -Path $Source -Destination $Dest -Recurse

        $Source = Get-ConfigPath -RelativePath "FlowLauncher/Settings/Settings.json"
        $Dest = Join-Path -Path $FlowLauncherSettingsDirectory -ChildPath "Settings/Settings.json"
        Remove-Item -Path $Dest -Force
        Copy-Item -Path $Source -Destination $Dest

        $Source = Get-ConfigPath -RelativePath "FlowLauncher/Settings/Plugins/Flow.Launcher.Plugin.WebSearch/Settings.json"
        $Dest = Join-Path -Path $FlowLauncherSettingsDirectory -ChildPath "Settings/Plugins/Flow.Launcher.Plugin.WebSearch/Settings.json"
        Remove-Item -Path $Dest -Force
        Copy-Item -Path $Source -Destination $Dest
    }
    komorebi = {
        $KomorebiConfigHome = Join-Path -Path $Env:LocalAppData -ChildPath "komorebi/config"
        Set-EnvironmentVariable -Key "KOMOREBI_CONFIG_HOME" -Value $KomorebiConfigHome

        $Source = Get-ConfigPath -RelativePath "komorebi"
        $Dest = Join-Path -Path $Env:LocalAppData -ChildPath "komorebi/config"
        Create-SymbolicLink -Source $Source -Destination $Dest
    }
    lazygit = {
        $Source = Get-ConfigPath -RelativePath "lazygit/config.yml"
        $Dest = Join-Path -Path $Env:AppData -ChildPath "lazygit/config.yml"
        Create-SymbolicLink -Source $Source -Destination $Dest
    }
    vim = {
        $Source = Get-ConfigPath -RelativePath "vim/nvim"
        $Dest = Join-Path -Path $Env:LocalAppData -ChildPath "nvim"
        Create-SymbolicLink -Source $Source -Destination $Dest

        $Source = Get-ConfigPath -RelativePath "vim/.ideavimrc"
        $Dest = Join-Path -Path $Env:UserProfile -ChildPath ".ideavimrc"
        Create-SymbolicLink -Source $Source -Destination $Dest

        $Source = Get-ConfigPath -RelativePath "vim/.vsvimrc"
        $Dest = Join-Path -Path $Env:UserProfile -ChildPath ".vsvimrc"
        Create-SymbolicLink -Source $Source -Destination $Dest
    }
    powershell = {
        $Source = Get-ConfigPath -RelativePath "powershell/profile.ps1"
        $Dest = $PROFILE
        Create-SymbolicLink -Source $Source -Destination $Dest
    }
}

if ($Configuration -eq "all")
{
    foreach ($key in $Configurations.Keys)
    {
        Invoke-Command $Configurations[$key]
    }
}
elseif (![string]::IsNullOrWhiteSpace($Configuration) -And $Configurations.ContainsKey($Configuration))
{
    Invoke-Command $Configurations[$Configuration]
}
else
{
    Print-Usage
}