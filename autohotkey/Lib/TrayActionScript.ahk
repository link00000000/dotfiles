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

    TraySetIcon(Icon)

    return A_TrayMenu
}

