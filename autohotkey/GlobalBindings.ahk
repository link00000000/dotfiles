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

#b::
	Run, ms-settings:bluetooth
	return
	
#j::
	Run, shell:downloads
	return

#t::
    Run, wt.exe, , , pid
    ;WinWait ahk_pid %pid%
    ;WinActivate ahk_pid %pid%
    return
