#Requires AutoHotkey v2.0

TrayActionScript_DefaultExecuteActionCallback(ItemName, ItemPos, MyMenu)
{
    MsgBox("Action executed!")
}

TrayActionScript_DefaultExitCallback(ItemName, ItemPos, MyMenu)
{
    ExitApp
}

TrayActionScript_DefaultActionName := "Execute Action"

TrayActionScript_Create(ActionName, Icon, OnExecuteActionCallback, OnExitCallback, IncludeStandardMenu)
{
    A_TrayMenu.Delete() ; Clear all default items in menu

    A_TrayMenu.Add(ActionName, OnExecuteActionCallback)
    A_TrayMenu.Add("Exit", OnExitCallback)

    A_TrayMenu.Default := ActionName
    A_TrayMenu.ClickCount := 1

    if (IncludeStandardMenu)
    {
        A_TrayMenu.Add() ; Add separator item
        A_TrayMenu.AddStandard()

        ; Remove the standard Exit item
        A_TrayMenu.Delete("E&xit")
    }

    TraySetIcon(Icon.GetIconPath())

    return A_TrayMenu
}

class TrayActionScript_Icon {
    __New(iconPath) {
        this.iconPath := iconPath
    }

    GetIconPath() {
        return this.iconPath
    }
}

class TrayActionScript_WindowsThemeAdaptableIcon {
    __New(lightModeIconPath, darkModeIconPath) {
        this.lightModeIconPath := lightModeIconPath
        this.darkModeIconPath := darkModeIconPath
    }

    GetIconPath() {
        SystemUsesLightTheme := RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize", "SystemUsesLightTheme")

        if (SystemUsesLightTheme = true) {
            return this.lightModeIconPath
        }
        else {
            return this.darkModeIconPath
        }
    }
}
