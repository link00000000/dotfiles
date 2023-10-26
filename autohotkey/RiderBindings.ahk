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

#Requires AutoHotkey v2.0
#InputLevel 1

HotIfWinActive "ahk_exe rider64.exe"

^j:: Send "{DOWN}"
^k:: Send "{UP}"
^h:: Send "{LEFT}"
^l:: Send "{RIGHT}"
