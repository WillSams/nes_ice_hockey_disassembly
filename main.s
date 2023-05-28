
;===============================================================================
.segment "HEADER"
;=====================
	.BYTE "NES", $1A	; iNES always stars with bytes  $4e,$45,$53,$1a
	.BYTE 2		; # of 16 KB PRG ROM Banks (this can vary by mapper)
	.BYTE 1		; # of 8 KB CHR ROM Banks (this can vary by mapper)
	;============================================================================================
	; iNES flag 6
	; 7654 3210
	; |||| ||||
	; |||| |||+- Mirroring: 0: horizontal (vertical arrangement) (CIRAM A10 = PPU A11)
	; |||| |||              1: vertical (horizontal arrangement) (CIRAM A10 = PPU A10)
	; |||| ||+-- 1: Cartridge contains battery-backed PRG RAM ($6000-7FFF) or other persistent memory
	; |||| |+--- 1: 512-byte trainer at $7000-$71FF (stored before PRG data)
	; |||| 
	; ||||+---- 1: Ignore mirroring control or above mirroring bit; instead provide four-screen VRAM
	; ++++----- Lower nybble of mapper number.  Note:  this can impact values used for PRG and CHR bytes
	;============================================================================================	
	.BYTE %00000001		; iNES flag 6
	.BYTE %00000000

;===============================================================================
.segment "PROG"
;=====================
	.include "program.s"

;===============================================================================
.segment "CHR"
;=====================
	.incbin "CHR.chr"
