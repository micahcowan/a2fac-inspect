; toy/tool for printing the contents of
; FAC after various maths operations

;#define CFGFILE apple2-asm.cfg
;#link "load-and-run-basic.s"

.export ASoftProg, ASoftEnd
.import LoadAndRunBasic

;.macpack apple2

.include "basic-utils.inc"
.include "a2-monitor.inc"

.org $803
Start:
	; Setup PrintFac as USR
        lda #$4C
        sta $A
        lda #<PrintFac
        sta $B
        lda #>PrintFac
        sta $C
        
	jmp LoadAndRunBasic

.res $8000-*

PrintFac:
	ldx #0
:
        lda AS_FAC, x
        jsr Mon_PRBYTE
        lda #$A0
        jsr Mon_COUT
        inx
        cpx #5
        bne :-
        lda #$8D
        jsr Mon_COUT
	rts

ASoftProg:
	lineP "HELLO"
        ; setup PrintFac as USR
        ; (can't set up before BASIC is run, it'll
        ;  be overwritten!)
        line "POKE 10,76:POKE 11,",.sprintf("%d",<PrintFac),":POKE 12,",.sprintf("%d",>PrintFac)
        line "? USR(37190)"
        line "? USR(2^(1/12))"
        line "?"
        line "? USR((1022727/180)*60)"
        line "?"
        line "? USR(2^(1/12)^3)"
        line "? USR(.5)"
        line "? USR(1)"
        scrcode "RUN",$0D
        scrcode "CALL-151",$0D
ASoftEnd: