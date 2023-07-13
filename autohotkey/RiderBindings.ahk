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
#IfWinActive ahk_exe rider64.exe

^j::
    Send {DOWN}
    return

^k::
    Send {UP}
    return

^h::
    Send {LEFT}
    return

^l::
    Send {RIGHT}
    return