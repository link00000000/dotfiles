; You can generate a fresh version of this file with "komorebic ahk-library"
#Include %A_ScriptDir%\komorebic.lib.ahk
; https://github.com/LGUG2Z/komorebi/#generating-common-application-specific-configurations
#Include %A_ScriptDir%\komorebi.generated.ahk

CycleLayout(direction)
{
    static layouts := ["bsp", "columns", "rows", "vertical-stack", "horizontal-stack", "ultrawide-vertical-stack"]
    static layoutIndex := 1

    if (direction = "next")
    {
        layoutIndex := layoutIndex + 1
        if (layoutIndex > layouts.MaxIndex())
        {
            layoutIndex = 1
        }
    }
    else if (direction = "previous")
    {
        layoutIndex := layoutIndex - 1
        if (layoutIndex < 1)
        {
            layoutIndex = layouts.MaxIndex()
        }
    }

    ChangeLayout(layouts[layoutIndex])
}

GetNumberOfMonitors()
{
	numberOfMonitors := 0
	SysGet, numberOfMonitors, MonitorCount
	
	return numberOfMonitors
}