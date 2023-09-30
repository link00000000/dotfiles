#Requires AutoHotkey v2.0
#Include "./Lib/TrayActionScript.ahk"
Persistent

OnExecuteAction(ItemName, ItemPosition, MenuInstance)
{
    Run("steam://open/friends/")
}

TrayActionScript_Create("Show Steam friends", "Icons/SteamFriends.png", OnExecuteAction, TrayActionScript_DefaultExitCallback, false)
