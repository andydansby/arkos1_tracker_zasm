;Test codes (commented)
;Entry and other points
;START initialize playing of module at MDLADDR
;START+3 initialization with module address in HL
;START+5 play one quark
;START+8 mute
;START+10 setup and status flags
;START+11 current position value (byte) (optional)

;START
;	LD HL,MDLADDR	;START
;	JR INIT			;START+3
;	JP PLAY			;START+5
;	JR MUTE			;START+8
;SETUP	DB 0 		;START+10
;CurPos	DB 0 		;START+11

;; pay attention to the stack
; in this version stack starts at #7FE6

;at start #8000 stack is #7FE8
;setup stack goes down to #7FE4
;when finished goes back to #7FE8

; play starts at #7FE8
; @ #c50c stack is stored
; @ c510 stack changes to #C97D



	ORG #8000
;	OUTPUT "S_output.bin"
	
;    LD A,2	
;    LD (START+10),A
;	ld hl, song1
	
;    CALL START+3
	ld sp, $ffff
	; Initialize music player
	ld de,atSongdata	;now at #C900
	call _atInit
    EI

_LP:
	HALT
;	CALL START+5
	call atPlay


	XOR A	;test keyboard	
	IN A,($FE)	
	CPL	
	AND 15	
	JR Z, _LP
	
;	JP START+8
	call atStop
;	call 0	;machine reset
ret
	

include "akg_player.asm"

SECTION MUSIC
ORG $c800
; *** Song ***
;song1:
atSongdata:
    binary "fuckit.bin"


;try to make buffer start at $c900
;uncompress song to $C900

