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
        $Dest = Join-Path $Env:APPDATA -ChildPath "alacritty"
        Create-SymbolicLink -Source $Source -Destination $Dest
    }
    autohotkey = {
        $source = Get-ConfigPath -RelativePath "autohotkey/GlobalBindings.ahk"
        $Dest = Join-Path $Env:APPDATA -ChildPath "Microsoft/Windows/Start Menu/Programs/Startup/GlobalBindings.lnk"

        Create-Shortcut -Source $Source -Destination $Dest
    }
    flowlauncher = {
        # FlowLauncher does not support symlinks so the files must be copied

        $FlowLauncherSettingsDirectory = Join-Path $Env:APPDATA -ChildPath "flowlauncher"

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
		
        $Source = Get-ConfigPath -RelativePath "FlowLauncher/Settings/Plugins/Flow.Launcher.Plugin.WebSearch/CustomIcons"
        $Dest = Join-Path -Path $FlowLauncherSettingsDirectory -ChildPath "Settings/Plugins/Flow.Launcher.Plugin.WebSearch/CustomIcons"
        Remove-Item -Path $Dest -Force
        Copy-Item -Recurse -Path $Source -Destination $Dest
    }
    git = {
      $Source = Get-ConfigPath -RelativePath "git/.gitconfig"
      $Dest = Join-Path -Path $Env:USERPROFILE -ChildPath ".gitconfig"
      Create-SymbolicLink -Source $Source -Destination $Dest
    }
    helix = {
        $Source = Get-ConfigPath -RelativePath "helix/config.toml"
        $Dest = Join-Path -Path $Env:APPDATA -ChildPath "helix/config.toml"
        Create-SymbolicLink -Source $Source -Destination $Dest
    }
    komorebi = {
        $Source = Get-ConfigPath -RelativePath "komorebi/komorebi.json"
        $Dest = Join-Path -Path $Env:USERPROFILE -ChildPath "komorebi.json"
        Create-SymbolicLink -Source $Source -Destination $Dest

        $Source = Get-ConfigPath -RelativePath "komorebi/applications.yaml"
        $Dest = Join-Path -Path $Env:USERPROFILE -ChildPath "applications.yaml"
        Create-SymbolicLink -Source $Source -Destination $Dest
    }
    lazygit = {
        $Source = Get-ConfigPath -RelativePath "lazygit/config.yml"
        $Dest = Join-Path -Path $Env:APPDATA -ChildPath "lazygit/config.yml"
        Create-SymbolicLink -Source $Source -Destination $Dest
    }
    nushell = {
        $Source = Get-ConfigPath -RelativePath "nushell/env.nu"
        $Dest = Join-Path -Path $Env:APPDATA -ChildPath "nushell/env.nu"
        Create-SymbolicLink -Source $Source -Destination $Dest

        $Source = Get-ConfigPath -RelativePath "nushell/config.nu"
        $Dest = Join-Path -Path $Env:APPDATA -ChildPath "nushell/config.nu"
        Create-SymbolicLink -Source $Source -Destination $Dest

        $Source = Get-ConfigPath -RelativePath "nushell/share"
        $Dest = Join-Path -Path $Env:APPDATA -ChildPath "nushell/share"
        Create-SymbolicLink -Source $Source -Destination $Dest

        $Source = Get-ConfigPath -RelativePath "nushell/hooks"
        $Dest = Join-Path -Path $Env:APPDATA -ChildPath "nushell/hooks"
        Create-SymbolicLink -Source $Source -Destination $Dest
    }
    powershell = {
        $Source = Get-ConfigPath -RelativePath "powershell/profile.ps1"
        $Dest = $PROFILE
        Create-SymbolicLink -Source $Source -Destination $Dest

        $Source = Get-ConfigPath -RelativePath "powershell/LocalConfigs"
        $Dest = "$(Split-Path $PROFILE -Parent)/LocalConfigs"
        Create-SymbolicLink -Source $Source -Destination $Dest
    }
    starship = {
        $Source = Get-ConfigPath -RelativePath "starship/starship.toml"
        $Dest = Join-Path -Path $Env:USERPROFILE -ChildPath ".config/starship.toml"
        Create-SymbolicLink -Source $Source -Destination $Dest
    }
    vim = {
        $Source = Get-ConfigPath -RelativePath "vim/nvim"
        $Dest = Join-Path -Path $Env:LOCALAPPDATA -ChildPath "nvim"
        Create-SymbolicLink -Source $Source -Destination $Dest

        $Source = Get-ConfigPath -RelativePath "vim/nvim-lean"
        $Dest = Join-Path -Path $Env:LOCALAPPDATA -ChildPath "nvim-lean"
        Create-SymbolicLink -Source $Source -Destination $Dest

        $Source = Get-ConfigPath -RelativePath "vim/.ideavimrc"
        $Dest = Join-Path -Path $Env:UserProfile -ChildPath ".ideavimrc"
        Create-SymbolicLink -Source $Source -Destination $Dest

        $Source = Get-ConfigPath -RelativePath "vim/.vsvimrc"
        $Dest = Join-Path -Path $Env:UserProfile -ChildPath ".vsvimrc"
        Create-SymbolicLink -Source $Source -Destination $Dest
    }
    wezterm = {
        $Source = Get-ConfigPath -RelativePath "wezterm/.wezterm.lua"
        $Dest = Join-Path -Path $Env:USERPROFILE -ChildPath ".wezterm.lua"
        Create-SymbolicLink -Source $Source -Destination $Dest
    }
    whkd = {
        $Source = Get-ConfigPath -RelativePath "whkd/whkdrc"
        $Dest = Join-Path -Path $Env:USERPROFILE -ChildPath ".config/whkdrc"
        Create-SymbolicLink -Source $Source -Destination $Dest
		
		$Source = Get-ConfigPath -RelativePath "whkd/whkd.lnk"
        $Dest = Join-Path -Path $Env:APPDATA -ChildPath "Microsoft/Windows/Start Menu/Programs/Startup/whkd.lnk"
        Copy-Item -Path $Source -Destination $Dest -Recurse
    }
    windowsterminal = {
        $Source = Get-ConfigPath -RelativePath "windowsterminal/settings.json"
        $Dest = Join-Path -Path $Env:LOCALAPPDATA -ChildPath "Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
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
