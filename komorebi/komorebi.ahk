#SingleInstance Force

#Include %A_ScriptDir%\lib.ahk

; Default to minimizing windows when switching workspaces
WindowHidingBehaviour("minimize")

; Set cross-monitor move behaviour to insert instead of swap
CrossMonitorMoveBehaviour("insert")

; Enable hot reloading of changes to this file
WatchConfiguration("enable")

; Ensure there is 1 workspace created on monitor 0
Loop, GetNumberOfMonitors()
{
    EnsureWorkspaces(A_Index - 1, 5)
}

EnsureWorkspaces(0, 1)

; Configure the invisible border dimensions
InvisibleBorders(7, 0, 14, 7)

; Configure the 1st workspace
WorkspaceName(0, 0, "I")

; Window border
ActiveWindowBorderColour(82, 189, 255, "single") ; blue
;ActiveWindowBorderColour(190, 149, 255, "single") ; purple
ActiveWindowBorderWidth(10)
ActiveWindowBorderOffset("-- -4") ; Two dashes to tell komorebi we are passing a negative value and not the option 4
ActiveWindowBorder("enable")

; Mouse
FocusFollowsMouse("disable", "windows")
MouseFollowsFocus("disable")

; Gaps
ContainerPadding(0, 0, 8)
WorkspacePadding(0, 0, 8)
ContainerPadding(1, 0, 8)
WorkspacePadding(1, 0, 8)
ContainerPadding(2, 0, 8)
WorkspacePadding(2, 0, 8)

;:Allow komorebi to start managing windows
CompleteConfiguration()

; Change the focused window, Ctrl + Win + Vim direction keys (HJKL)
^#h::
    Focus("left")
    return

^#j::
    Focus("down")
    return

^#k::
    Focus("up")
    return

^#l::
    Focus("right")
    return
	
^#n::
    CycleWorkspace("next")
    return
	
^#p::
    CycleWorkspace("previous")

; Move the focused window in a given direction, Ctrl + Shift + Win + Vim direction keys (HJKL)
^+#h::
    Move("left")
    return

^+#j::
    Move("down")
    return

^+#k::
    Move("up")
    return

^+#l::
    Move("right")
    return
	
^+#n::
    CycleSendToWorkspace("next")
    return
	
^+#p::
    CycleSendToWorkspace("previous")
    return

^#w::
    NewWorkspace()
    return

; Close active window
^#c::
    WinClose, A
    return
	
; Force kill active window
^+#c::
    WinKill, A
    return

^#-::
    WinMinimize, A
    return

^#m::
    ToggleMonocle()
    return

^#f::
    ToggleFloat()
    return

^#.::
    Promote()
    return

^+#.::
    PromoteFocus()
    return

^#Tab::
    CycleLayout("next")
    return

^+#Tab::
    CycleLayout("previous")
    return

; Hide title bar for active window
^#Home::
    WinSet, Style, -0xC40000, A
    return

; Show title bar for active window
^+#Home::
    WinSet, Style, +0xC40000, A
    return

; Force retile all windows
^+#r::
    Retile()
    return

;!^+Delete::
    ;RunWait, %ComSpec% /c "komorebic.exe stop", , hide
    ;RunWait, taskkill /im komorebi.exe /f
    ;TrayTip, Komorbi, Restarting...
    ;Sleep, 2000
    ;Run, %ComSpec% /c "komorebic.exe start --await-configuration", , hide
    ;Exit, 0
    ;return
