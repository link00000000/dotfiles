; Modifier Keys
; # -> Windows Key
; ! -> Alt
; ^ -> Ctrl
; + -> Shift
; & -> Used between any two keys ot mouse buttons to combine them into a custom hotkey
; < -> Use the left key of the pair (ie. left alt, left shift, etc.)
; > -> Use the right key of the pair (ie. right alt, right shift, etc.)
; <^>! -> AltGr key (not a standard key on keyboard)
; * -> Wild card for modifiers

#InputLevel 1

;$LWin Up::
;$RWin Up::
;    if (A_PriorKey = "LWin" || A_PriorKey = "RWin") {
;        Send, !{Space}
;    }
;    else {
;        SendLevel 1
;        SendEvent {LWin down}{%A_PriorKey%}{LWin up}
;        ; SendInput {LWin down}{%A_PriorKey%}{LWin up}
;    }
;    return

#b:: Run "ms-settings:bluetooth"
#j:: Run "shell:downloads"
#t:: Run "wt.exe"
