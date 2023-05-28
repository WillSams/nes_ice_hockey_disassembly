.setcpu "6502"       ; Set the CPU type to 6502

.include "./includes/hardware.inc"

;===============================================================================
.segment "PRG"
.org $8000
;===============================================================================

.include "./includes/vars.inc"

L0000           := $0000
L000A           := $000A
L0020           := $0020
L0100           := $0100
L0420           := $0420
L0C86           := $0C86
L0F0F           := $0F0F
L1286           := $1286
L1500           := $1500
L1624           := $1624
L1630           := $1630
L18C8           := $18C8
L1A1D           := $1A1D
L1E22           := $1E22
L2020           := $2020
L2021           := $2021
L20DB           := $20DB
L23A0           := $23A0
L2422           := $2422
L2622           := $2622
L2840           := $2840
L2A00           := $2A00
L2E2A           := $2E2A
L310F           := $310F
L348B           := $348B
L3820           := $3820
L3860           := $3860
L406D           := $406D
L4248           := $4248
L427E           := $427E
L441C           := $441C
L4642           := $4642
L4648           := $4648
L468F           := $468F
L4842           := $4842
L4881           := $4881
L4886           := $4886
L4887           := $4887
L5646           := $5646
L565E           := $565E
L5687           := $5687
L5A54           := $5A54
L5E81           := $5E81
L6070           := $6070
L6090           := $6090
L60D0           := $60D0
L624D           := $624D
L7E46           := $7E46
L7E54           := $7E54
L7E80           := $7E80
L7E81           := $7E81
L7E87           := $7E87
RESET:  sei
        lda     #$10
        sta     $FF
        sta     $2000
        ldx     #$FF
        txs
L800B:  lda     $2002
        bpl     L800B
L8010:  lda     $2002
        bpl     L8010
        lda     #$00
        .byte   $8D
L8018:  bpl     $805A
        lda     #$0F
        sta     $4015
        lda     #$C0
        sta     $4017
        lda     #$00
        sta     $FE
        sta     $2001
        sta     $0574
        sta     $FD
        jsr     L8159
        ldx     #$00
        jsr     L8111
L8038:  lda     #$90
        sta     $FF
        sta     $2000
        cli
        lda     LFFE0
        cmp     #$FF
        bne     L8050
        lda     #$3F
        sta     $06FF
L804C:  lda     #$0A
L804E:  sta     $08
L8050:  lda     L0000
        lda     #$00
        sta     $07
        jmp     L8050

        brk
        pha
        lda     $07
        beq     L8062
        jmp     L810F

L8062:  txa
        pha
        tya
        pha
        inc     $07
        inc     $0D
        lda     #$00
        sta     $2001
        lda     $2002
        lda     #$00
        sta     $2003
        lda     #$02
        sta     $4014
        jsr     L8194
        jsr     L81C5
        jsr     L8171
        lda     $FE
        sta     $2001
        jsr     L82F9
        lda     $08
        cmp     #$02
        bcc     L80D1
        cmp     #$0A
        beq     L80D1
        lda     $0F
        and     #$10
L809B:  bne     L80A4
        lda     #$00
        sta     $0433
        beq     L80D1
L80A4:  lda     L0000
        bmi     L80D1
        lda     $0433
        bne     L80D1
        lda     $0315
        bne     L80D1
        inc     $0433
        lda     $0412
        pha
        lda     $0432
        pha
L80BD:  eor     #$01
        sta     $0432
        lda     #$80
        jsr     LCFDD
        pla
        ora     #$50
        jsr     LD0D8
        pla
        sta     $0412
L80D1:  lda     $0432
        bne     L80F9
        lda     #$90
        sta     L000A
        lda     #$83
        sta     $0B
        lda     $08
        jsr     L8359
        lda     $DB
        asl     a
        asl     a
        bcs     L80F5
        tax
        lda     #$F0
L80EC:  sta     $0200,x
        inx
        inx
        inx
        inx
        bne     L80EC
L80F5:  lda     #$00
        sta     $DB
L80F9:  lda     $04A9
        beq     L8108
        lda     #$53
L8100:  sta     $0103
        lda     #$00
        jsr     L8376
L8108:  jsr     LF900
        pla
        tay
        pla
        tax
L810F:  pla
        rti

L8111:  lda     #$00
L8113:  sta     L0000,x
        inx
        cpx     #$F1
        bne     L8113
        ldx     #$00
L811C:  sta     $0200,x
        sta     $0300,x
        sta     $0400,x
        sta     $0500,x
        inx
        bne     L811C
L812B:  sta     $0600,x
        inx
        .byte   $E0
L8130:  .byte   $FF
        bne     L812B
        .byte   $A0
L8134:  .byte   $03
L8135:  tya
L8136:  ora     #$50
L8138:  .byte   $D9
        brk
L813A:  ora     ($D0,x)
        ora     $88
L813E:  bne     L8135
        beq     L814B
L8142:  txa
        sta     $0103
L8146:  lda     #$00
L8148:  sta     $06FF
L814B:  ldx     #$00
        lda     #$F0
L814F:  sta     $0200,x
L8152:  inx
        inx
        inx
        inx
        bne     L814F
        rts

L8159:  lda     #$20
        sta     $2006
        lda     #$00
L8160:  sta     $2006
        ldx     #$04
        ldy     #$00
L8167:  sta     $2007
        dey
        bne     L8167
        dex
        bne     L8167
        rts

L8171:  lda     $FD
        sta     $2005
        lda     $0574
        bpl     L817D
        and     #$EF
L817D:  sta     $FC
        sta     $2005
        lda     $FF
        sta     $2000
        rts

L8188:  clc
        adc     L000A
        sta     L000A
        lda     $0B
        adc     #$00
        sta     $0B
        rts

L8194:  lda     $0C
        beq     L81C4
        lda     #$00
        sta     $0C
        lda     #$3F
        sta     $2006
        lda     #$00
        sta     $2006
        ldy     #$20
        ldx     #$00
L81AA:  lda     $03D6,x
        sta     $2007
        inx
        dey
        bne     L81AA
        lda     #$3F
        sta     $2006
        lda     #$00
        sta     $2006
        sta     $2006
        sta     $2006
L81C4:  rts

L81C5:  lda     $0E
        beq     L8212
        ror     a
        bcc     L81D2
        jsr     L821B
        jmp     L820E

L81D2:  ldy     #$00
        ror     a
        bcs     L81E6
        iny
        iny
        ror     a
        bcs     L81E6
        iny
        iny
        ror     a
        bcs     L81E6
        iny
        iny
        ror     a
        bcc     L81F6
L81E6:  lda     L8213,y
        sta     L000A
        lda     L8214,y
        sta     $0B
        jsr     L824A
        jmp     L820E

L81F6:  ror     a
        bcc     L81FF
        jsr     L8282
        jmp     L8212

L81FF:  ror     a
L8200:  bcc     L8208
        jsr     L82E6
        jmp     L820E

L8208:  ror     a
        bcc     L820E
        jsr     LEEB4
L820E:  lda     #$00
        sta     $0E
L8212:  rts

L8213:  .byte   $F4
L8214:  .byte   $DC
        ora     LA0DE
        .byte   $DF
        cmp     $E1,x
L821B:  lda     #$20
        sta     $2006
        lda     #$57
        sta     $2006
        .byte   $A0
L8226:  brk
        ldx     #$09
L8229:  lda     $0413,y
        sta     $2007
        iny
L8230:  dex
        bne     L8229
        .byte   $A9
L8234:  bit     $8D
L8236:  asl     L0020
L8238:  lda     #$40
L823A:  sta     $2006
        .byte   $A2
L823E:  .byte   $09
L823F:  lda     $0413,y
L8242:  .byte   $8D
        .byte   $07
L8244:  jsr     $CAC8
        .byte   $D0
L8248:  inc     $60,x
L824A:  lda     #$20
L824C:  sta     $2006
        lda     #$00
        .byte   $8D
L8252:  asl     L0020
L8254:  ldy     #$00
L8256:  lda     (L000A),y
        bpl     L826D
        and     #$7F
        bne     L8260
        ora     #$80
L8260:  tax
        iny
        lda     (L000A),y
        iny
L8265:  sta     $2007
        dex
        bne     L8265
        beq     L827A
L826D:  beq     L8281
        tax
        iny
L8271:  lda     (L000A),y
        sta     $2007
        iny
        dex
        bne     L8271
L827A:  tya
        jsr     L8188
        jmp     L8254

L8281:  rts

L8282:  ldy     #$00
        lda     $0D
        and     #$10
        beq     L828C
        ldy     #$04
L828C:  lda     $D0
        cmp     #$FF
        bne     L8297
        tya
        clc
        adc     #$08
        tay
L8297:  lda     #$25
        sta     $2006
        lda     #$C4
        sta     $2006
        ldx     #$0C
L82A3:  lda     L82D6,y
        sta     $2007
        lda     L82D7,y
        sta     $2007
        tya
        eor     #$04
        tay
        dex
        bne     L82A3
        lda     #$25
        sta     $2006
        lda     #$E4
        sta     $2006
        ldx     #$0C
L82C2:  lda     L82D8,y
        sta     $2007
        lda     L82D9,y
        sta     $2007
        tya
        eor     #$04
        tay
        dex
        bne     L82C2
        rts

L82D6:  .byte   $04
L82D7:  .byte   $05
L82D8:  .byte   $06
L82D9:  .byte   $07
        sbc     $01
        .byte   $02
        .byte   $03
        .byte   $1C
        ora     $1F1E,x
        clc
        ora     $2120,y
L82E6:  lda     $057A
        sta     $2006
        lda     $0579
        sta     $2006
        lda     $057B
        sta     $2007
        rts

L82F9:  ldx     #$01
        stx     $4016
        dex
        .byte   $8E
L8300:  asl     $40,x
        ldx     #$02
L8304:  ldy     #$08
L8306:  lda     $4015,x
        lsr     a
        bcs     L830D
        lsr     a
L830D:  rol     $0E,x
        dey
        bne     L8306
        dex
        bne     L8304
        lda     $14
        beq     L8342
        ldx     #$02
L831B:  lda     $10,x
        eor     #$FF
        and     $0E,x
        pha
        lda     $0E,x
        sta     $10,x
        pla
        sta     $0E,x
        dex
L832A:  bne     L831B
        .byte   $A5
L832D:  .byte   $14
        bmi     L8342
L8330:  lda     $0F
        ora     $10
        bne     L833E
        dec     $13
        bne     L8342
L833A:  sta     $11
L833C:  sta     $12
L833E:  lda     $14
        .byte   $85
L8341:  .byte   $13
L8342:  lda     L0000
L8344:  bmi     L8358
        ror     a
        bcs     L8352
        lda     $06
        eor     #$01
        tax
        lda     $10
        sta     $15,x
L8352:  ldx     $06
        lda     $0F
        sta     $15,x
L8358:  rts

L8359:  asl     a
        jsr     L8188
        tya
        pha
        ldy     #$00
        lda     (L000A),y
        pha
        iny
        lda     (L000A),y
        sta     $0B
        pla
        sta     L000A
        pla
        tay
L836E:  jmp     (L000A)

L8371:  inc     $08
        jmp     L8378

L8376:  sta     $08
L8378:  lda     #$00
        sta     $09
L837C:  rts

L837D:  lda     $08
        asl     a
        tax
        lda     L83A6,x
        sta     L000A
        lda     L83A7,x
        sta     $0B
        .byte   $A5
L838C:  ora     #$4C
        eor     LBC83,y
        .byte   $83
        asl     $B18B
        sty     $9384
        .byte   $27
        sta     $AE,x
        stx     $0C,y
        .byte   $9B
        bne     L833C
        bcs     L8341
        .byte   $7C
        ldx     #$31
        .byte   $EE
L83A6:  .byte   $F3
L83A7:  .byte   $83
        .byte   $12
        .byte   $8B
        .byte   $FB
        sty     L93CE
L83AE:  .byte   $44
        sta     $F0,x
        stx     $1F,y
        .byte   $9B
        .byte   $F2
        .byte   $9C
        cmp     $9F
        sty     $35A2
        inc     $0EA5
        beq     L83DD
        lda     $D0
        sta     $FD
        ldy     #$06
        ldx     #$80
        jsr     L83E1
        lda     #$00
        sta     $FD
        ldy     #$03
        ldx     #$01
        jsr     L83E1
        ldy     $D0
        iny
        beq     L83DD
        inc     $D0
L83DD:  jsr     L837D
        rts

L83E1:  lda     L0000
        dex
        bne     L83E1
        dey
        bne     L83E1
        lda     $FF
        eor     #$18
        sta     $FF
        jsr     L8171
        rts

        .byte   $11
L83F4:  sty     $2B
        sty     $40
        sty     $7D
        sty     $94
        sty     $2D
        sta     $49
        sta     $74
        sta     $91
        sta     $C7
        sta     $07
        dey
        ora     LB088,x
        dey
        .byte   $02
        .byte   $89
        sed
        txa
        lda     L0000
        bpl     L841F
        ldx     #$05
L8417:  lda     $04AE,x
        sta     L0000,x
        dex
        bpl     L8417
L841F:  lda     #$01
        sta     $06
        ldx     #$07
        jsr     L8111
        inc     $09
        rts

        lda     #$30
        jsr     LD0D8
        lda     #$00
        sta     $FE
        sta     $0574
        sta     $FD
        .byte   $A9
L843A:  .byte   $02
        sta     $0E
        inc     $09
        rts

        ldx     #$20
L8442:  lda     LD99E,x
        sta     $03D5,x
        dex
        bne     L8442
        inc     $0C
L844D:  lda     #$1E
        sta     $FE
        lda     #$80
        sta     $14
        lda     #$FF
        sta     $043E
        sta     $D0
        lda     $0103
        cmp     #$53
        beq     L8470
        inc     $D0
        ldx     #$03
L8467:  txa
        ora     #$50
        sta     L0100,x
        dex
        bpl     L8467
L8470:  lda     L0000
        bne     L8476
        inc     L0000
L8476:  lda     #$20
        sta     $0E
        .byte   $E6
L847B:  ora     #$60
        lda     $0F
        bmi     L8493
        ldx     #$7F
L8483:  lda     LD9FD,x
        sta     $04B4,x
        dex
        bpl     L8483
        lda     #$80
L848E:  sta     $057D
        inc     $09
L8493:  rts

        jsr     LED00
        lda     $0F
        bne     L84CC
        lda     $11
        bne     L850A
        lda     $043E
        beq     L84A7
        dec     $043E
L84A7:  bne     L850A
        lda     $0313
        bne     L850A
        ldx     #$05
L84B0:  lda     L0000,x
        sta     $04AE,x
        dex
        bpl     L84B0
        lda     #$FF
        sta     L0000
        lda     #$00
        sta     $01
        sta     $02
        sta     $03
        lda     #$01
        sta     $04
        lda     #$0B
        bne     L8504
L84CC:  ldx     #$FF
        stx     $043E
        rol     a
        rol     a
        rol     a
        bcc     L84DF
        pha
        lda     L0000
        eor     #$03
        jsr     L850B
        pla
L84DF:  rol     a
        bcc     L84EF
        lda     #$02
        jsr     LD0D8
        lda     #$00
        sta     $14
        lda     #$05
        bne     L8504
L84EF:  rol     a
        bcc     L84F9
        pha
        lda     #$01
        jsr     L850B
        pla
L84F9:  rol     a
        bcc     L850A
        lda     #$02
        jsr     L850B
        jmp     L850A

L8504:  sta     $09
        lda     #$00
        sta     $FE
L850A:  rts

L850B:  .byte   $C5
L850C:  brk
        beq     L8516
        sta     L0000
        lda     #$02
        jsr     LD0D8
L8516:  rts

L8517:  lda     #$F5
        sta     $DD
        lda     #$22
        sta     $DE
L851F:  jsr     L8AD8
        lda     $DF
        clc
        adc     #$08
        sta     $DF
        dex
        bne     L851F
        rts

        jsr     L853C
        bne     L8535
        inc     $058F
L8535:  lda     #$80
        sta     $14
        inc     $09
        rts

L853C:  lda     $0F
L853E:  eor     #$10
        cmp     #$C0
L8542:  bne     L8548
        lda     $10
        cmp     #$C0
L8548:  rts

        lda     #$04
        .byte   $85
L854C:  asl     a:$A5
        ror     a
L8550:  bcc     L855C
        lda     $04
L8554:  ora     #$80
        sta     $04
        lda     #$00
        sta     $05
L855C:  lda     $04
        cmp     $03
L8560:  bne     L856C
        cmp     #$05
L8564:  bne     L856A
        dec     $04
        bne     L856C
L856A:  inc     $04
L856C:  lda     #$40
        jsr     LD0D8
        inc     $09
        rts

        lda     #$00
        sta     $03D7
        lda     #$05
        sta     $03D8
        lda     #$37
        sta     $03F3
        lda     #$12
        sta     $03F5
        inc     $0C
        .byte   $A9
L858B:  .byte   $1E
L858C:  sta     $FE
        inc     $09
        rts

        lda     L0000
        ror     a
        bcc     L85C4
        jsr     L86BD
        lda     $0F
        and     #$80
        bne     L85AB
        sta     L000A
        lda     $0F
        and     #$03
        jsr     L8601
        jmp     L85C6

L85AB:  lda     $04
        and     #$7F
        sta     $04
        cmp     $03
        bne     L85BF
        cmp     #$05
        bne     L85BD
        dec     $04
        bne     L85BF
L85BD:  inc     $04
L85BF:  lda     #$02
        jsr     LD0D8
L85C4:  inc     $09
L85C6:  rts

        jsr     L86BD
        lda     $0F
        and     #$10
        bne     L85F5
        lda     $05
        bne     L85E9
        lda     L0000
        and     #$02
        beq     L85E7
        lda     #$0C
        sta     L000A
        lda     $10
        jsr     L8601
        lda     #$00
        beq     L85E9
L85E7:  lda     #$04
L85E9:  asl     a
        asl     a
        sta     L000A
        lda     $0F
        jsr     L8601
        jmp     L8600

L85F5:  lda     #$02
        jsr     LD0D8
        lda     #$00
        sta     $14
        inc     $09
L8600:  rts

L8601:  ldx     #$03
L8603:  ror     a
        bcs     L860B
        dex
        bpl     L8603
        bmi     L8624
L860B:  txa
        ora     L000A
        tax
        lda     #$29
        sta     L000A
        lda     #$86
        sta     $0B
        txa
        jsr     L8359
        lda     $0B
        beq     L8624
        lda     #$02
        jsr     LD0D8
L8624:  lda     #$00
        sta     $0B
        rts

        bit     $86
        .byte   $54
        stx     $57
        stx     $73
        stx     $51
        stx     $54
        stx     $93
        stx     $9C
        stx     $51
L863A:  stx     $24
        stx     $A8
        stx     $B1
        stx     $24
        stx     $24
        stx     $65
        stx     $83
        stx     $24
        stx     $54
        stx     $65
        stx     $83
        stx     $C6
L8652:  ora     $60
        inc     $05
        rts

        ldx     $03
L8659:  dex
L865A:  bpl     L865E
        ldx     #$05
L865E:  cpx     $04
        beq     L8659
        stx     $03
        rts

        ldx     $04
L8667:  dex
        bpl     L866C
        ldx     #$05
L866C:  cpx     $03
        beq     L8667
        stx     $04
        rts

        ldx     $03
L8675:  inx
        cpx     #$06
        bne     L867C
        ldx     #$00
L867C:  cpx     $04
L867E:  beq     L8675
        stx     $03
        rts

        ldx     $04
L8685:  inx
        cpx     #$06
        bne     L868C
        ldx     #$00
L868C:  cpx     $03
        beq     L8685
        stx     $04
        rts

        lda     $01
        sta     $0B
        beq     L869B
        dec     $01
L869B:  rts

        lda     $01
        sec
        sbc     #$04
        sta     $0B
        beq     L86A7
        inc     $01
L86A7:  rts

        lda     $02
        sta     $0B
        beq     L86B0
        dec     $02
L86B0:  rts

        lda     $02
        sec
        sbc     #$02
        sta     $0B
        beq     L86BC
        inc     $02
L86BC:  rts

L86BD:  jsr     L86CA
        jsr     L86E5
        jsr     L87C7
        jsr     L87E8
        rts

L86CA:  lda     $05
        tax
        lda     L86E2,x
        sta     $DC
        lda     #$20
        sta     $DF
        lda     $05
        ror     a
        lda     #$04
        adc     #$00
        tax
        jsr     L8517
        rts

L86E2:  .byte   $27
        .byte   $9F
        .byte   $BF
L86E5:  jsr     LD09E
        ldx     #$0C
        lda     #$0F
L86EC:  sta     $03E6,x
        dex
        dex
        dex
        dex
        bpl     L86EC
        lda     #$AA
        sta     $0440
        lda     #$00
        sta     $CF
        lda     #$01
        sta     $0441
        lda     L0000
        ror     a
        bcc     L870F
        lda     $04
        bmi     L870F
        dec     $0441
L870F:  ldx     $03
        jsr     L873A
        lda     $04
        bmi     L872F
        lda     #$01
        sta     $CF
        sta     $0441
        inc     $0440
        lda     L0000
        ror     a
        .byte   $90
L8726:  .byte   $03
        inc     $0440
L872A:  ldx     $04
        jsr     L873A
L872F:  rts

L8730:  lda     $0D
        lsr     a
        lsr     a
        lsr     a
        eor     $0441
        lsr     a
        rts

L873A:  lda     $05
        bne     L8748
        lda     $0441
        beq     L8748
        jsr     L8730
        bcc     L875A
L8748:  lda     L879E,x
        sta     $DF
        lda     #$78
        sta     $DC
        txa
        pha
        ldx     #$03
        jsr     L8517
        pla
        tax
L875A:  lda     #$5F
        sta     L000A
L875E:  lda     L879E,x
        clc
        adc     #$04
        pha
        txa
        asl     a
        asl     a
        asl     a
        tax
        pla
        pha
        jsr     L87A4
        pla
        pha
        clc
        adc     #$08
        jsr     L87A4
        pla
        pha
        clc
        adc     #$08
L877C:  sta     $0B
        lda     #$5B
        sta     L000A
        ldy     #$1C
        jsr     LC0F5
        lda     #$43
        sta     $DC
        lda     $0440
        sta     $DD
        lda     #$02
        sta     $DE
        pla
        clc
        adc     #$04
        sta     $DF
        jsr     L8AD8
        rts

L879E:  bpl     L87D8
        rts

        dey
        bcs     L877C
L87A4:  pha
        jsr     LCE81
        pla
        pha
        sta     $DF
        lda     L000A
        sta     $DC
        lda     #$F5
        sta     $DD
        lda     #$02
        sta     $DE
        jsr     L8AD8
        lda     $DC
        clc
        adc     #$08
        sta     $DC
        jsr     L8AD8
        pla
        rts

L87C7:  lda     $05
        and     #$01
        beq     L87D2
        jsr     L8730
        bcc     L87E2
L87D2:  ldx     $01
        lda     L87E3,x
        .byte   $85
L87D8:  .byte   $DF
        lda     #$9F
        sta     $DC
        ldx     #$01
        jsr     L8517
L87E2:  rts

L87E3:  rts

        .byte   $80
        ldy     #$C0
        .byte   $E0
L87E8:  lda     $05
        and     #$02
        beq     L87F3
        jsr     L8730
        bcc     L8803
L87F3:  ldx     $02
        lda     L8804,x
        sta     $DF
        lda     #$BF
        sta     $DC
        ldx     #$03
        jsr     L8517
L8803:  rts

L8804:  rts

        tya
        bne     L8828
        .byte   $3C
        sta     $D0
        .byte   $03
        inc     $0590
        lda     #$80
        sta     $14
        asl     a
        sta     $FE
        lda     #$08
        sta     $0E
        inc     $09
        rts

        lda     L0000
        bpl     L8826
        lda     #$04
        sta     $04A8
L8826:  ldy     #$06
L8828:  ldx     #$00
        jsr     L8843
        ldy     #$06
        lda     L0000
        cmp     #$02
        beq     L8837
        ldy     $04
L8837:  ldx     #$08
        jsr     L8843
        lda     #$1E
        sta     $FE
        inc     $09
        rts

L8843:  lda     LE7F9,y
        sta     L000A
        lda     L000A
        and     #$03
        asl     a
        tay
        lda     L8898,y
        sta     $0534,x
        lda     L8899,y
        sta     $0535,x
        lsr     L000A
        lda     L000A
        and     #$06
        tay
        lda     L889E,y
        sta     $0536,x
        lda     L889F,y
        sta     $0537,x
        lsr     L000A
        lsr     L000A
        lda     L000A
        and     #$06
        tay
        lda     L88A4,y
        sta     $0538,x
        lda     L88A5,y
        sta     $0539,x
        .byte   $46
L8883:  asl     a
        lsr     L000A
        lda     L000A
L8888:  and     #$06
        tay
L888B:  lda     L88AA,y
        sta     $053A,x
        lda     L88AB,y
        sta     $053B,x
        rts

L8898:  brk
L8899:  inx
        rti

        inx
        .byte   $80
        inx
L889E:  .byte   $80
L889F:  sbc     #$00
        nop
        .byte   $80
        nop
L88A4:  .byte   $C0
L88A5:  inx
        brk
        sbc     #$40
        .byte   $E9
L88AA:  brk
L88AB:  .byte   $EB
        .byte   $80
        .byte   $EB
        brk
        cpx     a:$A5
        bpl     L88C4
        ldx     #$08
        lda     #$00
L88B8:  sta     $0357,x
        dex
        bne     L88B8
        lda     #$0E
        sta     $09
        bne     L88ED
L88C4:  lda     #$06
        ldx     #$00
        jsr     L88EE
        lda     L0000
        ror     a
        lda     $04
        bcs     L88D4
        lda     #$06
L88D4:  ldx     #$04
        jsr     L88EE
        lda     #$00
        sta     $03B0
        sta     $03B1
        lda     L0000
        ror     a
        bcc     L88EB
        lda     #$04
        sta     $03B1
L88EB:  inc     $09
L88ED:  rts

L88EE:  asl     a
        asl     a
        tay
        lda     #$04
        sta     $D0
L88F5:  lda     LD96E,y
        sta     $0358,x
        iny
        inx
        dec     $D0
        bne     L88F5
        rts

        lda     $03
        asl     a
        asl     a
        asl     a
        tax
        lda     #$3A
        sta     L000A
        lda     #$24
        jsr     L87A4
        lda     #$2C
        jsr     L87A4
        lda     $04
        asl     a
        asl     a
        asl     a
        tax
        lda     #$A4
        jsr     L87A4
        lda     #$AC
        jsr     L87A4
        ldx     #$00
        stx     $CF
        jsr     L8964
        inc     $CF
        jsr     L8964
        lda     #$40
        sta     $DF
        lda     $03B0
        pha
        ldy     #$00
        lda     $0F
        jsr     L8995
        pla
        bmi     L8949
        lda     L0000
        lsr     a
        bcs     L8963
L8949:  and     $03B1
        bmi     L8961
        lda     #$B8
        sta     $DF
        lda     L0000
        lsr     a
        tay
        lda     $0F,y
        ldy     #$01
        jsr     L8995
        jmp     L8963

L8961:  inc     $09
L8963:  rts

L8964:  lda     L8985,x
        sta     L000A
        lda     L898D,x
        sta     $0B
        lda     $0358,x
        lsr     a
        ror     a
        ror     a
        ora     #$0C
        tay
        txa
        pha
        jsr     LC0F5
        pla
        tax
        inx
        txa
        and     #$03
        bne     L8964
        rts

L8985:  rts

        dey
        .byte   $A0
L8988:  cpy     $8860
        ldy     #$CC
L898D:  .byte   $44
        jmp     (L441C)

        ldy     LE494,x
        .byte   $BC
L8995:  pha
        lda     $03B0,y
        bmi     L89A0
        jsr     L8730
        bcc     L89DC
L89A0:  tya
        ror     a
        lda     $03B0,y
        and     #$7F
        tax
        lda     L8A1C,x
        bcc     L89B0
        lda     L8A21,x
L89B0:  sta     $DC
        lda     L8A26,x
        clc
        adc     $DF
        sta     $DF
        lda     #$F5
        sta     $DD
        lda     #$22
        sta     $DE
        txa
        ldx     #$03
        cmp     #$04
        beq     L89CB
        dex
        dex
L89CB:  jsr     L8AD8
        lda     $DC
        clc
        adc     #$08
        sta     $DC
        dex
        bne     L89CB
        lda     $03B0,y
        rol     a
L89DC:  pla
        bcs     L8A1B
        rol     a
        bcc     L89E8
        jsr     L8A2B
        jmp     L8A14

L89E8:  rol     a
        bcc     L89F1
        jsr     L8A68
        jmp     L8A14

L89F1:  rol     a
        rol     a
        rol     a
        bcc     L89FC
        jsr     L8AA7
        jmp     L8A14

L89FC:  rol     a
        bcc     L8A05
        jsr     L8A98
        jmp     L8A14

L8A05:  rol     a
        bcc     L8A0E
        jsr     L8AB6
        jmp     L8A14

L8A0E:  rol     a
        bcc     L8A1B
        jsr     L8AC5
L8A14:  beq     L8A1B
        lda     #$02
        .byte   $20
L8A19:  cld
        .byte   $D0
L8A1B:  rts

L8A1C:  .byte   $6F
        .byte   $7F
        .byte   $97
        .byte   $A7
        .byte   $7F
L8A21:  .byte   $6F
        .byte   $97
        .byte   $7F
        .byte   $A7
        .byte   $7F
L8A26:  brk
        bpl     L8A19
        brk
        brk
L8A2B:  lda     $03B0,y
        cmp     #$04
        bne     L8A4E
        ora     #$80
        sta     $03B0,y
        lda     L0000
        ror     a
        bcc     L8A62
        ldy     $04
        lda     $06FF
        and     #$3F
        cmp     #$3F
        beq     L8A62
        lda     #$80
        sta     $03B1
        bne     L8A62
L8A4E:  tya
        asl     a
        asl     a
        ora     $03B0,y
        jsr     L8A89
        tax
        lda     $0358,x
        tay
        lda     L8A65,y
        sta     $0358,x
L8A62:  lda     #$FF
        rts

L8A65:  ora     ($02,x)
        brk
L8A68:  lda     $03B0,y
        cmp     #$04
        beq     L8A85
        tya
        asl     a
        asl     a
        ora     $03B0,y
        jsr     L8A89
        tax
        lda     $0358,x
        tay
        lda     L8A86,y
        sta     $0358,x
        lda     #$FF
L8A85:  rts

L8A86:  .byte   $02
        brk
        .byte   $01
L8A89:  cmp     #$05
L8A8B:  bne     L8A91
L8A8D:  lda     #$06
        bne     L8A97
L8A91:  cmp     #$06
        bne     L8A97
        lda     #$05
L8A97:  rts

L8A98:  lda     $03B0,y
        tax
        lda     L8AA2,x
        jmp     L8ACC

L8AA2:  .byte   $04
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
L8AA7:  lda     $03B0,y
        tax
        lda     L8AB1,x
        jmp     L8ACC

L8AB1:  brk
        brk
        brk
        .byte   $04
        brk
L8AB6:  lda     $03B0,y
        tax
L8ABA:  lda     L8AC0,x
        jmp     L8ACC

L8AC0:  .byte   $02
        .byte   $04
        .byte   $02
        .byte   $02
        .byte   $02
L8AC5:  lda     $03B0,y
        tax
        lda     L8AD3,x
L8ACC:  cmp     $03B0,y
        sta     $03B0,y
        rts

L8AD3:  ora     ($01,x)
        .byte   $04
        ora     ($01,x)
L8AD8:  txa
        pha
        lda     $DB
        asl     a
        asl     a
        tax
        lda     $DC
        sta     $0200,x
        lda     $DD
        sta     $0201,x
        lda     $DE
        sta     $0202,x
        lda     $DF
        sta     $0203,x
        inc     $DB
        pla
        tax
        rts

        ldx     #$04
L8AFA:  lda     $0357,x
        pha
        lda     $035B,x
        sta     $0357,x
        pla
        sta     $035B,x
        dex
        bne     L8AFA
        jmp     L8371

        jsr     L837D
        rts

        jsr     L348B
        .byte   $8B
        rts

        .byte   $8B
        lda     #$8B
        sbc     $4E8B
        sty     L8C9A
        lda     #$F8
        sta     $0574
        lda     #$80
        sta     $FD
        lda     #$00
        sta     $FE
        lda     #$10
        sta     $0E
        inc     $09
        rts

        ldx     #$20
L8B36:  lda     LD9BE,x
        sta     $03D5,x
        dex
        bne     L8B36
        jsr     LD09E
        jsr     L8B4C
        lda     #$1E
        sta     $FE
        inc     $09
        rts

L8B4C:  ldx     #$04
L8B4E:  lda     $03E5,x
        pha
        lda     $03E9,x
        sta     $03E5,x
        pla
        sta     $03E9,x
        dex
        bne     L8B4E
        rts

        lda     #$FD
        sta     L000A
        lda     #$D9
        sta     $0B
        ldy     #$00
        lda     L0000
        bmi     L8B7C
        ldy     $01
        beq     L8B7C
        tya
        tax
L8B74:  lda     #$80
        jsr     L8188
        dex
        bne     L8B74
L8B7C:  tya
        pha
        ldy     #$7F
L8B80:  lda     (L000A),y
        sta     $04B4,y
        dey
        bpl     L8B80
        pla
        asl     a
        tay
        lda     LDC7D,y
        sta     $04AB
        lda     LDC7E,y
        sta     $04AC
        lda     $0590
        beq     L8BA6
L8B9C:  lda     #$00
        sta     $04AC
        lda     #$08
        sta     $04AB
L8BA6:  inc     $09
        rts

        lda     #$80
        sta     L000A
        lda     #$EC
        sta     $0B
        ldx     #$00
L8BB3:  lda     L000A
        sta     $0700,x
        inx
        lda     $0B
        sta     $0700,x
        inx
        beq     L8BEA
        ldy     #$00
L8BC3:  lda     (L000A),y
        cmp     #$80
        bne     L8BD1
        iny
        tya
        jsr     L8188
        jmp     L8BB3

L8BD1:  cmp     #$8F
L8BD3:  beq     L8BDC
        iny
        bne     L8BC3
        inc     $0B
        bne     L8BC3
L8BDC:  lda     #$80
        sta     $0700,x
        inx
        lda     #$EC
        sta     $0700,x
        inx
        bne     L8BDC
L8BEA:  inc     $09
        rts

        ldx     #$08
L8BEF:  lda     #$40
        .byte   $95
L8BF2:  bit     $A9
        brk
        sta     $2C,x
        sta     $34,x
        sta     $3C,x
        txa
        tay
        dey
        tya
        .byte   $95
L8C00:  .byte   $44
        lda     L8C3D,x
        sta     $54,x
        .byte   $BD
L8C07:  eor     $8C
        asl     a
        sta     $64,x
        rol     a
        and     #$01
L8C0F:  sta     $6C,x
        dex
        bne     L8BEF
        ldy     #$08
        ldx     #$00
L8C18:  txa
        and     #$03
        sta     $0360,x
        inx
        dey
        bne     L8C18
        jsr     LB574
        lda     #$80
        sta     $FD
        sta     $B6
        sta     $BA
        lda     #$00
        sta     $14
        sta     $1A
        lda     #$60
        sta     $BB
        lda     #$9F
        sta     $B7
        inc     $09
L8C3D:  rts

        bvc     L8CB0
        bcc     L8BF2
        bvc     L8CB4
        .byte   $90
L8C45:  bcs     L8C07
        cpy     #$C0
        cpy     #$40
        rti

        rti

        rti

        ldx     #$11
L8C50:  lda     L8C7E,x
        .byte   $9D
        .byte   $13
L8C55:  .byte   $04
        dex
        bpl     L8C50
        ldx     #$09
L8C5B:  lda     L8C90,x
        sta     $0425,x
        dex
        bpl     L8C5B
        lda     #$01
        sta     $0E
        ldx     $02
        lda     L8C7B,x
        sta     $0436
        lda     #$37
        jsr     LD0D8
        inc     $0412
        inc     $09
        rts

L8C7B:  .byte   $07
        asl     a
        .byte   $0F
L8C7E:  .byte   $9C
        .byte   $B7
        .byte   $8B
        txa
        .byte   $9C
        .byte   $9C
        .byte   $9C
        .byte   $9C
        .byte   $9C
        .byte   $9C
        .byte   $9C
        .byte   $9C
        .byte   $9C
        .byte   $9C
        .byte   $8B
        txa
        .byte   $9C
        .byte   $B7
L8C90:  .byte   $9C
        .byte   $9C
        bne     L8C55
        cmp     $D3,x
        cmp     $9C
        .byte   $9C
        .byte   $9C
L8C9A:  lda     $0F
        and     #$10
        beq     L8CA1
        rts

L8CA1:  lda     #$00
        sta     $0571
        .byte   $20
        cld
L8CA8:  bne     $8C53
        .byte   $27
        jsr     LD0D8
        .byte   $4C
        .byte   $71
L8CB0:  .byte   $83
        lda     $0310
L8CB4:  ora     $0571
        bne     L8CC1
        lda     #$31
        jsr     LD0D8
        inc     $0571
L8CC1:  jsr     LCEB1
        bcs     L8CE0
        jsr     LC606
        lda     $03F6
        bpl     L8CD1
        jsr     LC693
L8CD1:  jsr     LADE4
        jsr     LCDF2
        jsr     L837D
        jsr     LD0C3
        jmp     L8CEB

L8CE0:  lda     #$06
        jsr     L8376
        inc     $0572
        jsr     LD0F5
L8CEB:  jsr     L8CF2
        jsr     LD154
        rts

L8CF2:  lda     $15
        sta     $17
        lda     $16
        sta     $18
        rts

        ora     $8D,x
        .byte   $BC
        .byte   $8D
L8CFF:  .byte   $04
        stx     L8E9D
        jsr     L468F
        .byte   $8F
        .byte   $74
        bcc     L8CFF
        bcc     L8CA8
        sta     ($C2),y
        sta     ($D5),y
        sta     ($0C),y
        .byte   $92
        .byte   $37
        .byte   $93
        lda     #$36
        sta     $03E1
        inc     $0C
        lda     #$00
        sta     $057C
        sta     $058E
        sta     $0555
        sta     $0410
        sta     $0411
        sta     $04AD
        sta     $1A
        sta     $1C
        sta     $23
        sta     $24
        ldx     #$08
L8D3A:  lda     $24,x
        beq     L8D42
        lda     #$40
        sta     $24,x
L8D42:  dex
        bne     L8D3A
        lda     L0000
        bpl     L8D58
        jsr     LCFDD
        jsr     L8D8F
        jsr     L8EB0
        lda     #$05
        sta     $09
        bne     L8D8E
L8D58:  jsr     L8D8F
        lda     #$10
        ldx     #$04
        jsr     L8F52
        lda     #$11
        ldx     #$08
        jsr     L8F52
        lda     #$03
        jsr     LCFDD
        ldy     $0431
        iny
        tya
        ldy     #$0B
        jsr     LD06E
        lda     #$00
        sta     $03F9
        sta     $03FA
        lda     #$80
        .byte   $85
L8D83:  .byte   $14
        .byte   $8D
L8D85:  .byte   $FF
L8D86:  .byte   $03
        lda     #$27
        .byte   $20
L8D8A:  cld
L8D8B:  .byte   $D0
L8D8C:  inc     $09
L8D8E:  rts

L8D8F:  lda     $03F6
        asl     a
        tay
        lda     L8DAA,y
        sta     $D1
        asl     a
        sta     $1F
        lda     L8DAB,y
        sta     $D2
        asl     a
        sta     $21
        rol     a
        and     #$01
        sta     $22
        rts

L8DAA:  rti

L8DAB:  .byte   $80
        rol     $96
        .byte   $5A
        stx     $26,y
        ror     a
        .byte   $5A
        ror     a
        rol     $BA
        .byte   $5A
        tsx
        rol     $46
        .byte   $5A
        lsr     L0020
        sbc     ($8D,x)
        bcs     L8DD0
        lda     #$A0
        sta     $043E
        lda     #$00
        jsr     LCFDD
        jsr     LCF2A
        inc     $09
L8DD0:  ldx     #$01
L8DD2:  lda     $15,x
        lsr     a
        lsr     a
        and     #$03
        beq     L8DDD
        sta     $03F9,x
L8DDD:  dex
        bpl     L8DD2
        rts

L8DE1:  lda     #$04
        sta     $0B
        sta     L000A
        ldx     #$08
L8DE9:  lda     $24,x
        beq     L8DFE
        jsr     LB915
        bcc     L8DF6
        rol     L000A
        bne     L8DFE
L8DF6:  lda     #$10
        sta     $84,x
        lda     $9C,x
        sta     $3C,x
L8DFE:  dex
        bne     L8DE9
L8E01:  .byte   $66
L8E02:  asl     a
        rts

L8E04:  jsr     L8DE1
        jsr     L8D8F
        lda     #$10
        ldx     #$04
        jsr     L8E20
        lda     #$11
        ldx     #$08
        jsr     L8E20
        dec     $043E
        bne     L8E1F
        inc     $09
L8E1F:  rts

L8E20:  sta     L000A
        jsr     LA9E1
        tay
        lda     L0000
        bmi     L8E32
        ror     a
        bcc     L8E47
        tya
        eor     $06
        beq     L8E47
L8E32:  lda     $4D
        and     #$07
        tay
        iny
        lda     $0D
        bne     L8E43
        sec
L8E3D:  rol     a
        dey
        bne     L8E3D
        beq     L8E4A
L8E43:  lda     #$00
        beq     L8E4A
L8E47:  lda     $15,y
L8E4A:  rol     a
        bcc     L8E51
        ldy     #$00
        beq     L8E6C
L8E51:  rol     a
        bcc     L8E58
        ldy     #$04
        bne     L8E6C
L8E58:  rol     a
        rol     a
        rol     a
        bcs     L8E60
        rol     a
        bcc     L8E64
L8E60:  ldy     #$08
        bne     L8E6C
L8E64:  rol     a
        bcs     L8E6A
        rol     a
        bcc     L8E8C
L8E6A:  ldy     #$0C
L8E6C:  lda     #$04
        sta     $0B
        txa
        pha
L8E72:  tya
        pha
        ora     $035F,x
        tay
        lda     L8E8D,y
        sta     $035F,x
        pla
        tay
        dex
        dec     $0B
        bne     L8E72
        pla
        tax
        lda     L000A
        jsr     L8F52
L8E8C:  rts

L8E8D:  ora     (L0000,x)
        .byte   $02
        .byte   $03
        brk
        ora     ($03,x)
        .byte   $02
        .byte   $03
        ora     ($02,x)
        brk
        brk
        .byte   $02
        ora     ($03,x)
L8E9D:  jsr     L8D8F
        jsr     L8EB0
        lda     #$80
        sta     $043E
        lda     #$03
        jsr     LD0D8
        inc     $09
        rts

L8EB0:  lda     $03F6
        asl     a
        asl     a
        pha
        sta     L000A
        bne     L8EC4
        lda     $03F9
        beq     L8EC4
        lsr     a
        eor     #$01
        bpl     L8ECE
L8EC4:  lda     $0D
        and     #$03
        ora     L000A
        tay
        lda     L8EFC,y
L8ECE:  sta     $03F7
        ldx     #$04
        jsr     L8F52
        pla
        sta     L000A
        bne     L8EE5
        lda     $03FA
        beq     L8EE5
        lsr     a
        eor     #$01
        bpl     L8EF1
L8EE5:  lda     $0D
        lsr     a
        lsr     a
        and     #$03
        ora     L000A
        tay
        lda     L8EFC,y
L8EF1:  ora     #$08
        sta     $03F8
        ldx     #$08
        jsr     L8F52
        rts

L8EFC:  .byte   $02
        .byte   $03
        asl     $07
        brk
        ora     ($02,x)
        .byte   $03
        .byte   $04
        ora     $06
        .byte   $07
        brk
        ora     ($02,x)
        .byte   $03
        .byte   $04
        ora     $06
        .byte   $07
        brk
        ora     (L0000,x)
        ora     ($04,x)
        ora     $04
        ora     L0000
        ora     (L0000,x)
        ora     ($04,x)
        ora     $04
        ora     L0020
        sbc     ($8D,x)
        bcc     L8F43
        jsr     L8D8F
L8F28:  lda     $03F7
        ldx     #$04
        jsr     L8E20
        lda     L0000
        cmp     #$02
L8F34:  bne     L8F3E
        lda     $03F8
        ldx     #$08
        .byte   $20
L8F3C:  .byte   $20
        .byte   $8E
L8F3E:  .byte   $CE
        .byte   $3E
L8F40:  .byte   $04
        bne     L8F45
L8F43:  inc     $09
L8F45:  rts

        jsr     L8DE1
        bcs     L8F51
        .byte   $A9
L8F4C:  brk
        sta     $14
        inc     $09
L8F51:  rts

L8F52:  asl     a
L8F53:  asl     a
        sta     L000A
        asl     a
        .byte   $65
L8F58:  asl     a
        adc     #$9C
        sta     L000A
        lda     #$8F
        adc     #$00
        sta     $0B
        .byte   $A9
L8F64:  .byte   $04
        sta     $D0
L8F67:  lda     $24,x
        beq     L8F96
        lda     $035F,x
        asl     a
        .byte   $7D
L8F70:  .byte   $5F
        .byte   $03
        tay
        lda     (L000A),y
        clc
        .byte   $65
L8F77:  cmp     ($95),y
        sty     $B1C8
L8F7C:  asl     a
        clc
        adc     $D2
        sta     $94,x
        iny
        .byte   $B1
L8F84:  asl     a
        sta     $9C,x
        lda     $0357,x
        tay
        lda     LD98A,y
        sta     $84,x
L8F90:  lda     $3C,x
        and     #$7F
        sta     $3C,x
L8F96:  dex
        dec     $D0
        .byte   $D0
L8F9A:  .byte   $CC
        rts

L8F9C:  .byte   $F4
        .byte   $0C
L8F9E:  sta     L0000
        bpl     L8F28
        sed
        jsr     L1286
        .byte   $0C
        .byte   $87
L8FA8:  sed
        .byte   $0C
        sta     L0000
        .byte   $10
L8FAD:  stx     $08
        .byte   $0C
        stx     $14
        .byte   $0C
        .byte   $87
L8FB4:  sed
        bpl     L8F3C
        brk
        bpl     L8F40
        bpl     L8FCC
        .byte   $87
        .byte   $1C
        .byte   $0C
        .byte   $80
L8FC0:  inc     $0C,x
        sta     L0000
        bpl     L8F4C
        .byte   $0C
        clc
        stx     $1C
        bpl     L8F53
L8FCC:  inc     L850C
        brk
        .byte   $10
L8FD1:  stx     $08
        jsr     L0C86
        .byte   $0C
        .byte   $87
L8FD8:  cpx     L850C
        brk
        bpl     L8F64
        sed
        .byte   $0C
        stx     $08
        .byte   $0C
        .byte   $87
        cpx     $0C
        sty     L0000
        bpl     L8F70
        beq     L8FFC
        sta     $08
        bpl     L8F77
        cpx     $10
        sta     L0000
        bpl     L8F7C
        .byte   $F4
        clc
        stx     L000A
        .byte   $0C
        .byte   $87
L8FFC:  .byte   $F4
        .byte   $F4
        .byte   $83
        brk
        beq     L8F84
        sed
        cpx     #$82
        .byte   $12
        .byte   $F4
        sta     ($F8,x)
        .byte   $F4
        .byte   $83
        brk
L900C:  beq     L8F90
        php
        .byte   $F4
        .byte   $82
        .byte   $14
        .byte   $F4
        sta     ($F8,x)
        beq     L8F9A
        brk
        beq     L8F9C
        bpl     L900C
        sta     ($1C,x)
        .byte   $F4
        .byte   $80
        inc     $F4,x
        .byte   $83
        brk
        beq     L8FA8
        .byte   $0C
        inx
        .byte   $82
        .byte   $1C
        beq     L8FAD
        inc     L83F4
        brk
        beq     L8FB4
        php
        cpx     #$82
        .byte   $0C
        .byte   $F4
        sta     ($EC,x)
        .byte   $F4
        .byte   $83
        brk
L903C:  beq     L8FC0
        sed
        .byte   $F4
        .byte   $82
        php
        .byte   $F4
        sta     ($E4,x)
        .byte   $F4
        .byte   $83
        brk
        beq     L8FCC
        beq     L903C
        .byte   $82
        php
        beq     L8FD1
        cpx     $F0
        .byte   $83
        brk
        beq     L8FD8
        .byte   $F4
        inx
        .byte   $82
        asl     a
        .byte   $F4
        sta     ($F4,x)
        asl     a:$84
        asl     $82
        brk
        asl     $86,x
        .byte   $0C
        asl     LF480
        .byte   $F2
        sty     L0000
        .byte   $FA
        stx     L0000
        nop
L9070:  .byte   $82
        .byte   $0C
        .byte   $F2
        .byte   $80
        ldx     #$04
        jsr     L90CB
        lda     $22
        lsr     a
        lda     $21
        ror     a
        clc
        adc     #$04
        sta     $94,x
        adc     #$F8
        pha
        lda     $1F
        lsr     a
        sta     $8C,x
        pha
        ldx     #$08
        jsr     L90CB
        pla
        sta     $8C,x
        pla
        sta     $94,x
        lda     $03F6
        asl     a
        tay
        lda     L90B9,y
        sta     $04A6
        lda     L90BA,y
        sta     $04A7
        lda     #$02
        sta     $04A5
        jsr     L9109
        lda     #$0C
        sta     $043E
        inc     $09
        rts

L90B9:  .byte   $30
L90BA:  .byte   $80
        asl     $96,x
        lsr     a
        stx     $16,y
        ror     a
        lsr     a
        ror     a
        asl     $BA,x
        lsr     a
        tsx
        asl     $46,x
        lsr     a
        .byte   $46
L90CB:  txa
        tay
L90CD:  lda     $035F,x
        cmp     #$01
        beq     L90D7
        dex
        bne     L90CD
L90D7:  lda     $24,x
        bne     L90F4
        tya
        tax
L90DD:  lda     $035F,x
        cmp     #$02
        beq     L90E7
        dex
        bne     L90DD
L90E7:  lda     $24,x
        bne     L90F4
        tya
        tax
L90ED:  lda     $24,x
        bne     L90F4
        dex
        bne     L90ED
L90F4:  rts

        jsr     L9109
        lda     $0D
        and     #$03
        bne     L9108
        .byte   $EE
        .byte   $A6
L9100:  .byte   $04
        dec     $043E
        bne     L9108
        inc     $09
L9108:  rts

L9109:  lda     $04A6
        asl     a
        sec
        sbc     $0574
        sbc     #$0A
        sta     $DC
        lda     $04A7
        asl     a
        sec
        sbc     $FD
        sbc     #$08
        sta     $DF
        lda     $04A5
        asl     a
        asl     a
        tay
        lda     L9174,y
        sta     $DD
        lda     L9188,y
        sta     $DE
        jsr     L8AD8
        lda     $DF
        pha
        clc
        adc     #$08
        sta     $DF
        lda     L9175,y
        sta     $DD
        lda     L9189,y
        sta     $DE
        jsr     L8AD8
        pla
        sta     $DF
        lda     $DC
        clc
        adc     #$08
        sta     $DC
        lda     L9176,y
        sta     $DD
        lda     L918A,y
        sta     $DE
        jsr     L8AD8
        lda     $DF
        clc
        adc     #$08
        sta     $DF
        lda     L9177,y
        sta     $DD
        lda     L918B,y
        sta     $DE
        jsr     L8AD8
        rts

L9174:  nop
L9175:  .byte   $EB
L9176:  .byte   $EC
L9177:  sbc     LE7E6
        inx
        sbc     #$E7
        .byte   $E7
        sbc     #$E9
        adc     ($61,x)
        sbc     #$E9
        adc     ($FD,x)
        sbc     #$E8
L9188:  .byte   $03
L9189:  .byte   $03
L918A:  .byte   $03
L918B:  .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $43
        .byte   $03
        .byte   $43
        .byte   $03
        .byte   $43
        .byte   $03
        .byte   $43
        .byte   $03
        .byte   $43
        .byte   $43
        .byte   $43
        .byte   $43
        jsr     L9109
        lda     #$02
        sta     $0B
        ldx     #$08
        jsr     L90CB
        jsr     LB915
        bcs     L91C1
        ldx     #$04
        jsr     L90CB
        jsr     LB915
        bcs     L91C1
        dec     $04A5
        lda     #$20
        sta     $043E
        inc     $09
L91C1:  rts

        jsr     L9109
        dec     $043E
        bne     L91D4
        dec     $04A5
        lda     #$0D
        sta     $043E
        inc     $09
L91D4:  rts

        jsr     L9109
        ldx     #$04
        jsr     L90CB
        lda     $0357,x
        tay
        lda     L9209,y
        sta     $03FB
        ldx     #$08
        jsr     L90CB
        lda     $0357,x
        tay
        lda     L9209,y
        sta     $03FC
        lda     #$A0
        sta     $03F6
        lda     #$00
        .byte   $8D
        .byte   $FD
L91FF:  .byte   $03
        sta     $03FE
        sta     $0412
        inc     $09
        rts

L9209:  .byte   $04
        php
        brk
        lda     $043E
        beq     L9220
        jsr     L9109
        lda     $0D
        and     #$03
        bne     L9220
        dec     $043E
        dec     $04A6
L9220:  jsr     L92F5
        lda     $03F6
        cmp     #$80
        beq     L9263
        dec     $03F6
L922D:  lda     $06
        eor     #$01
        tay
        lda     L0000
        ror     a
        bcc     L9242
        lda     $0D
        and     #$07
        bne     L9242
        lda     #$80
        sta     $15,y
L9242:  lda     $17,y
        bmi     L924F
        lda     $15,y
        bpl     L924F
        jsr     L92CA
L924F:  tya
        eor     #$01
        tay
        lda     $17,y
        bmi     L9260
        lda     $15,y
        bpl     L9260
        jsr     L92CA
L9260:  jmp     L92B1

L9263:  lda     L0000
        bmi     L9298
        lda     $06
        tax
        eor     #$01
        tay
        lda     $03FD,y
        cmp     $03FD,x
        beq     L922D
        bcs     L9280
        lda     $06
        ror     a
        lda     $15,x
        bcs     L9288
        bcc     L9290
L9280:  lda     $06
        ror     a
        lda     $15,y
        bcs     L9290
L9288:  and     #$0F
        tay
        lda     L92B2,y
        bpl     L929C
L9290:  and     #$0F
        tay
        lda     L92BE,y
        bpl     L929C
L9298:  lda     $0D
        and     #$1F
L929C:  sta     $1D
        cmp     #$10
        rol     a
        and     #$01
        sta     $03B2
        lda     #$60
        sta     $1C
        lda     #$21
        jsr     LD0D8
        inc     $09
L92B1:  rts

L92B2:  clc
        php
        clc
        .byte   $FF
        .byte   $14
        bpl     L92CF
        .byte   $FF
        .byte   $1C
        brk
        .byte   $1A
        .byte   $FF
L92BE:  php
        php
        clc
        .byte   $FF
        .byte   $0C
        asl     a
        .byte   $10
L92C5:  .byte   $FF
        .byte   $04
        asl     L0000
        .byte   $FF
L92CA:  lda     $03FD
        .byte   $0D
        .byte   $FE
L92CF:  .byte   $03
        bne     L92D6
        lda     #$08
        bne     L92E5
L92D6:  lda     $0D
        and     #$03
        ora     $03FB,y
        tax
        lda     $03FD,y
        clc
        adc     L92E9,x
L92E5:  sta     $03FD,y
        rts

L92E9:  .byte   $03
        ora     $04
        .byte   $03
        ora     ($02,x)
        .byte   $03
        .byte   $02
        ora     ($01,x)
        .byte   $02
        .byte   $01
L92F5:  ldx     #$04
        jsr     L90CB
        stx     $0442
        ldy     #$00
L92FF:  lda     $15
        jsr     L9314
        ldx     #$08
        jsr     L90CB
        stx     $0443
        ldy     #$04
        lda     $16
        jsr     L9314
        rts

L9314:  and     #$0F
L9316:  lsr     a
        bcc     L9329
        pha
        lda     L932F,y
        bmi     L9328
        lda     $3C,x
        and     #$F8
        ora     L932F,y
        sta     $3C,x
L9328:  pla
L9329:  beq     L932E
        iny
        bne     L9316
L932E:  rts

L932F:  .byte   $FF
        asl     $05
        .byte   $07
        .byte   $02
        .byte   $FF
        .byte   $03
        ora     ($A2,x)
        php
L9339:  lda     $24,x
        beq     L9354
        lda     #$02
        sta     $24,x
        lda     $0357,x
        tay
        lda     LD990,y
        sta     $84,x
        lda     #$FF
        sta     $9C,x
        lda     $3C,x
        and     #$7F
        sta     $3C,x
L9354:  dex
        bne     L9339
        ldx     #$04
        jsr     L90CB
        txa
        pha
        ldx     #$08
        jsr     L90CB
        pla
        tay
        lda     #$10
        sta     $033F,y
        ora     $24,y
        sta     $24,y
        lda     #$10
        sta     $033F,x
        ora     $24,x
        sta     $24,x
        jsr     LB2B4
        lda     #$00
        sta     $03FF
        jmp     L8371

        lda     #$00
        sta     $0572
        jsr     LC606
        lda     $1A
        bne     L9398
        bit     $04AD
        bvs     L9398
        jsr     LC693
L9398:  jsr     LADE4
        jsr     LCDF2
        jsr     L837D
        lda     $19
        beq     L93AC
        jsr     L93D6
        lda     #$04
        bne     L93BB
L93AC:  jsr     LCEB1
        bcc     L93C1
        lda     $1A
        bne     L93B9
        lda     $1C
        bne     L93C1
L93B9:  lda     #$06
L93BB:  jsr     L8376
        inc     $0572
L93C1:  jsr     LD0F5
        jsr     L8CF2
        jsr     LD0C3
        jsr     LD154
        rts

L93CE:  sbc     $6F93,y
        sty     $8C,x
        sty     $F8,x
        .byte   $94
L93D6:  lda     $0454
        beq     L93F8
        lda     $22
        eor     $06
        asl     a
        eor     #$02
        tay
        lda     $0459,y
        beq     L93F2
        cmp     $045A,y
        bcc     L93F3
        lda     $045A,y
        beq     L93F3
L93F2:  iny
L93F3:  lda     #$00
        sta     $0459,y
L93F8:  rts

        jsr     L9430
        lda     $0434
        bmi     L9404
        inc     $0434
L9404:  jsr     LBE27
        lda     $1A
        beq     L942F
        jsr     LBEFA
        lda     $04AD
        bpl     L9428
        ror     a
        lda     $1A
        bmi     L9428
        bcc     L9420
        cmp     #$05
        bcc     L9428
        bcs     L9424
L9420:  cmp     #$05
        bcs     L9428
L9424:  inc     $09
        bne     L942D
L9428:  lda     #$00
        sta     $04AD
L942D:  inc     $09
L942F:  rts

L9430:  lda     $04AD
        beq     L946E
        bmi     L946E
        ror     a
        bcc     L944A
        lda     $22
        bne     L946E
        lda     $21
        cmp     #$54
        bcc     L9466
        cmp     #$6C
        bcs     L946E
        bcc     L9458
L944A:  lda     $22
        beq     L946E
        lda     $21
        cmp     #$AD
        bcs     L9466
        cmp     #$95
        bcc     L946E
L9458:  lda     $1F
        cmp     #$5D
        bcc     L946E
        cmp     #$A4
        bcs     L946E
        lda     #$00
        beq     L946B
L9466:  lda     $04AD
        ora     #$80
L946B:  sta     $04AD
L946E:  rts

        lda     $043D
        bmi     L9477
        inc     $043D
L9477:  jsr     LA3CE
        lda     $1A
        bne     L948B
        lda     #$00
        sta     $0434
        sta     $043D
        sta     $0556
        dec     $09
L948B:  rts

        lda     #$00
        sta     $1A
        sta     $0410
        sta     $0411
        lda     $1F
        rol     a
        rol     a
        asl     a
        lsr     $04AD
        ora     $04AD
        and     #$03
        tay
        lda     L94F0,y
        sta     $03F6
        lda     #$11
        sta     $043E
        ldx     #$08
L94B1:  lda     $24,x
        beq     L94DD
        lda     #$40
        sta     $24,x
        lda     $3C,x
        and     #$07
        sta     $3C,x
        lda     $035F,x
        tay
        lda     L94F4,y
        sta     $8C,x
        lda     $04AD
        ror     a
        lda     #$40
        bcs     L94D2
        lda     #$C0
L94D2:  sta     $94,x
        lda     $0357,x
        tay
        lda     LD996,y
        sta     $84,x
L94DD:  dex
        bne     L94B1
        lda     #$03
        jsr     LD0D8
        lda     #$27
        sta     $057C
        jsr     LD0D8
        inc     $09
        rts

L94F0:  ora     $07
        asl     $08
L94F4:  .byte   $1C
        .byte   $34
        jmp     LA564

        ora     $0F29
        bne     L9526
        lda     $043E
        ror     a
        lda     #$00
        bcc     L9508
        lda     #$05
L9508:  jsr     LCFDD
        dec     $043E
        beq     L9521
        lda     $043E
        cmp     #$08
        bne     L9526
        lda     #$00
        sta     $21
        sta     $22
        inc     $22
        bne     L9526
L9521:  lda     #$02
        jsr     L8376
L9526:  rts

        jsr     LC606
        lda     $19
        bmi     L9531
        jsr     LC693
L9531:  jsr     LADE4
        jsr     LCDF2
        jsr     L837D
        jsr     LD0C3
        jsr     L8CF2
        jsr     LD154
        rts

        lsr     a
        sta     $A7,x
        sta     $8B,x
        stx     $A5,y
        .byte   $1C
        bne     L95A6
        sta     $0410
        sta     $0411
        lda     #$32
        jsr     LD0D8
        lda     #$27
        jsr     LD0D8
        ldx     $040F
        jsr     LA9E1
        eor     $06
        tax
        inc     $042F,x
        jsr     LD143
        lda     #$01
        jsr     LCFDD
        ldx     $040F
        lda     #$40
        sta     $24,x
        sta     $8C,x
        asl     a
        sta     $94,x
        ldx     #$08
L9580:  lda     $24,x
        beq     L958E
        and     #$4F
        sta     $24,x
        lda     $3C,x
        and     #$07
        sta     $3C,x
L958E:  dex
        bne     L9580
        lda     $03B3
        ora     #$01
        sta     $03B3
        lda     #$0C
        sta     $043E
        sta     $054C
        sta     $057C
        inc     $09
L95A6:  rts

        lda     $19
        bpl     L95B5
        ldx     #$00
        stx     $03B3
        stx     $21
        inx
        sta     $22
L95B5:  ldx     $040F
        cpx     #$05
        bcs     L95C5
        lda     #$01
        jsr     L95F3
        lda     #$05
        bne     L95CC
L95C5:  lda     #$05
        jsr     L95F3
        lda     #$01
L95CC:  jsr     L9655
        lda     $19
        and     #$07
        bne     L95DF
        lda     $19
        ror     a
        ror     a
        ror     a
        and     #$01
        jsr     LCFDD
L95DF:  inc     $19
        bne     L95E5
        inc     $09
L95E5:  dec     $043E
        bne     L95F2
        lda     $03B3
        and     #$FE
        sta     $03B3
L95F2:  rts

L95F3:  pha
        lda     $A4,x
        sta     L000A
        lda     $AC,x
        sta     $0B
        pla
        tax
        lda     #$04
        sta     $D0
L9602:  lda     $24,x
        beq     L9627
        lda     #$40
        sta     $24,x
        lda     $0357,x
        tay
        lda     LD999,y
        sta     $84,x
        lda     #$00
        sta     $2C,x
        jsr     L9632
        cpx     $040F
        beq     L9627
        lda     L000A
        sta     $8C,x
        lda     $0B
        sta     $94,x
L9627:  inx
        dec     $D0
        bne     L9602
        lda     #$00
        sta     $054C
        rts

L9632:  lda     $054C
        bne     L9647
        lda     $0D
        lsr     a
        lsr     a
        lsr     a
        and     #$07
        sta     $D1
        txa
        and     #$07
        cmp     $D1
        bne     L9654
L9647:  lda     $3C,x
        and     #$07
        ora     #$B0
        sta     $3C,x
        lda     #$20
        sta     $034F,x
L9654:  rts

L9655:  tax
        lda     $0D
        ldy     #$04
L965A:  tya
        pha
        lda     $24,x
        beq     L9682
        lda     #$40
        sta     $24,x
        lda     $0357,x
        tay
        lda     LD996,y
        sta     $84,x
        lda     #$00
        sta     $2C,x
        lda     $0D
        rol     a
        lda     #$20
        bcc     L967A
        lda     #$60
L967A:  sta     $8C,x
        cpx     #$05
        bcs     L9682
        lda     #$C0
L9682:  sta     $94,x
        inx
        pla
        tay
        dey
        bne     L965A
        rts

        lda     #$01
        jsr     LCFDD
        lda     #$00
        sta     $03F6
        sta     $1A
        lda     $0436
        ora     $0437
        bne     L96A9
        inc     $0572
        jsr     LD0F5
        lda     #$06
        bne     L96AB
L96A9:  lda     #$02
L96AB:  jmp     L8376

        lda     $0451
        bne     L96B6
        jsr     LCEB1
L96B6:  jsr     LC606
        jsr     LB27C
        jsr     LA9E7
        ldx     #$08
L96C1:  lda     $24,x
        beq     L96D7
        jsr     LB2A3
        jsr     LB587
        jsr     LBBEC
        jsr     LBCC3
        jsr     LBCF6
        jmp     L96DA

L96D7:  jsr     LAE1E
L96DA:  dex
        bne     L96C1
        jsr     LBF1A
        jsr     LB574
        jsr     LCDF2
        jsr     L837D
        jsr     L8CF2
        jsr     LD154
        rts

        asl     $97
        lda     #$97
        ldy     $97,x
        .byte   $E3
        tya
        .byte   $43
        sta     L99A3,y
        sbc     ($99,x)
        .byte   $32
        txs
        .byte   $72
        txs
        lda     LDC9A,y
        txs
        ldx     $0442
        lda     $A4,x
        lsr     a
        lsr     a
        and     #$18
        sta     $044C
        ldy     $0443
        lda     $AC,x
        clc
        adc     $AC,y
        rol     a
        rol     a
        rol     a
        and     #$07
        ora     $044C
        sta     $044C
        asl     a
        tay
        lda     LB967,y
        sta     $044D
        lda     LB968,y
        sta     $044E
        ldx     #$08
L9736:  lda     $24,x
        beq     L975E
        and     #$08
        beq     L9747
        jsr     LA9E1
        sta     $044A
        inc     $044A
L9747:  lda     #$40
        sta     $24,x
        lda     $0357,x
        tay
        lda     LD98D,y
        sta     $84,x
        lda     $044D
        sta     $8C,x
        lda     $044E
        sta     $94,x
L975E:  dex
        bne     L9736
        jsr     L9788
        lda     #$00
        sta     $044B
        lda     #$00
        sta     $1A
        sta     $1B
        sta     $1C
        lda     #$80
        sta     $14
        lda     #$40
        sta     $043E
        sta     $03FF
        lda     #$27
        sta     $057C
        jsr     LD0D8
        inc     $09
        rts

L9788:  ldy     #$01
L978A:  sty     L000A
        lda     $0442,y
        tax
        lda     $0357,x
        tay
        lda     L97A6,y
        ldy     L000A
        cpx     $1A
        bne     L979F
        adc     #$02
L979F:  sta     $0448,y
        dey
        bpl     L978A
        rts

L97A6:  .byte   $04
        brk
        php
        jsr     L97EF
        dec     $043E
        bne     L97B3
        inc     $09
L97B3:  rts

        jsr     L97EF
        ldy     $044A
        beq     L97CA
        dey
        dec     $048A
        bpl     L97CA
        jsr     LB15F
        lda     #$80
        sta     $15,y
L97CA:  jsr     L9817
        ldy     $044A
        beq     L97D8
        dey
        lda     #$00
        sta     $15,y
L97D8:  lda     L000A
        beq     L97E7
        bpl     L97E2
        lda     #$17
        bne     L97E4
L97E2:  lda     #$23
L97E4:  jsr     LD0D8
L97E7:  dec     $044B
        bne     L97EE
        inc     $09
L97EE:  rts

L97EF:  lda     $0D
        and     #$07
        tax
        inx
        lda     $24,x
        beq     L9816
        lda     $4C,x
        ror     a
        bcc     L9816
        and     #$03
        beq     L9803
        clc
L9803:  lda     $3C,x
        and     #$07
        bcc     L980D
        ora     #$B0
        bne     L980F
L980D:  ora     #$A8
L980F:  sta     $3C,x
        lda     #$08
        sta     $034F,x
L9816:  rts

L9817:  ldy     #$01
        lda     #$00
        sta     L000A
L981D:  lda     $15,y
L9820:  bpl     L983D
        inc     L000A
        lda     $0448,y
        clc
        adc     #$01
        sta     $0448,y
        and     #$07
        bne     L983D
        tya
        pha
        asl     a
        asl     a
        adc     #$04
        tax
        jsr     L9881
        pla
        tay
L983D:  dey
        bpl     L981D
        lda     $0452
        beq     L9880
        dec     $0452
        lda     $044D
        sbc     #$0C
        asl     a
        sbc     $0574
        sta     $DC
        lda     $0453
        ror     a
        lda     $044E
        bcc     L985E
        sbc     #$04
L985E:  sec
        sbc     #$02
        asl     a
        sec
        sbc     $FD
        sta     $DF
        lda     #$FF
        sta     $DD
        lda     #$03
        sta     $DE
        jsr     L8AD8
        lda     $DF
        clc
        adc     #$08
        sta     $DF
        lda     #$43
        sta     $DE
        jsr     L8AD8
L9880:  rts

L9881:  txa
        lsr     a
        and     #$04
        sta     $0B
        ldy     #$04
L9889:  lda     $24,x
        beq     L98B0
        bmi     L98B0
        lda     $A4,x
        sec
        sbc     $044D
        bcs     L989B
        eor     #$FF
        adc     #$01
L989B:  sta     $D0,y
        lda     $AC,x
        sec
        sbc     $044E
        bcs     L98AA
        eor     #$FF
        adc     #$01
L98AA:  clc
        adc     $D0,y
        bcc     L98B2
L98B0:  lda     #$FF
L98B2:  sta     $D0,y
        dex
        dey
        bne     L9889
        ldx     #$04
L98BB:  txa
        tay
        lda     $D0,x
L98BF:  dex
        beq     L98C8
        cmp     $D0,x
        bcc     L98BF
        bcs     L98BB
L98C8:  cmp     #$10
        bcs     L98D8
        tya
        clc
        adc     $0B
        tax
        jsr     LB24E
        lda     #$80
        sta     L000A
L98D8:  lda     #$10
        sta     $0452
        lda     $0D
        sta     $0453
        rts

        ldx     #$F4
        lda     $044C
        lsr     a
        lsr     a
        tay
        lda     L993B,y
        sta     $044C
        lsr     a
        pha
        bcc     L98F7
        ldx     #$0C
L98F7:  txa
        clc
        adc     $044D
        sta     $04A6
        ldx     #$F4
        pla
        beq     L9906
        ldx     #$0C
L9906:  txa
        clc
        adc     $044E
        sta     $04A7
        ldx     #$08
L9910:  lda     $24,x
        beq     L9923
        lda     $044E
        cpx     #$05
        bcs     L991F
        adc     #$04
        bne     L9921
L991F:  sbc     #$04
L9921:  sta     $94,x
L9923:  dex
        bne     L9910
        lda     #$04
        sta     $0451
        jsr     LD0D8
        lda     #$27
        jsr     LD0D8
        lda     #$20
        sta     $043E
        inc     $09
        rts

L993B:  .byte   $03
        ora     ($02,x)
        brk
        .byte   $03
        ora     ($02,x)
        brk
        ldy     $044C
        jsr     L99CC
        jsr     L9109
        lda     $043E
        beq     L9956
        dec     $043E
        bpl     L999E
L9956:  lda     $0D
        and     #$07
        bne     L999E
        lda     $044C
        lsr     a
        bne     L9967
        inc     $04A7
        bne     L996A
L9967:  dec     $04A7
L996A:  lda     $04A7
        cmp     $044E
        bne     L999E
        lda     $0448
        cmp     $0449
        bne     L9980
        lda     $0D
        rol     a
        rol     a
        rol     a
        rol     a
L9980:  rol     a
        and     #$01
        tay
        lda     $0442,y
        sta     $045D
        lda     $0D
        lsr     a
        lsr     a
        lsr     a
        lsr     a
        lsr     a
        ldx     $045D
        sta     $039F,x
        lda     #$00
        sta     $045E
        inc     $09
L999E:  rts

L999F:  ora     ($34,x)
        ora     ($34,x)
L99A3:  jsr     L9AFA
        ldy     $044C
        jsr     L99CC
        lda     $0D
        and     #$03
        bne     L99C8
        tya
        lsr     a
        bcs     L99BB
        inc     $04A6
        bne     L99BE
L99BB:  dec     $04A6
L99BE:  lda     $04A6
        cmp     $044D
        bne     L99C8
        inc     $09
L99C8:  jsr     L9109
        rts

L99CC:  lda     $0D
        ror     a
        ror     a
        ror     a
        ror     a
        lda     L999F,y
        bcc     L99DB
        ror     a
        ror     a
        ror     a
        ror     a
L99DB:  and     #$0F
        sta     $04A5
        rts

        jsr     L9AFA
        ldx     $045D
        jsr     LA9E1
        sta     L000A
        asl     a
        sta     $0B
        lda     $044D
        cmp     #$40
        rol     a
        and     #$01
        ora     $0B
        tay
        lda     L9A2E,y
        sta     $03F6
        lda     L000A
        eor     $06
        asl     a
        tay
        lda     $0455,y
        beq     L9A0C
        iny
L9A0C:  txa
        sta     $0455,y
        lda     #$78
        sta     $0459,y
        inc     $0454
        lda     #$14
        sta     $8C,x
        lda     L9A2A,y
        sta     $94,x
        jsr     L9A5D
        jsr     L9109
        inc     $09
        rts

L9A2A:  jmp     LB444

        .byte   $BC
L9A2E:  ora     ($02,x)
        .byte   $03
        .byte   $04
        jsr     L9AFA
        ldx     $045D
        jsr     L9A5D
        lda     $045E
        and     #$0F
        bne     L9A54
        ldx     #$08
L9A44:  lda     $24,x
        beq     L9A4F
        ldy     $01
        lda     L9A58,y
        sta     $84,x
L9A4F:  dex
        bne     L9A44
        inc     $09
L9A54:  jsr     L9109
        rts

L9A58:  rti

        and     $32,x
        and     #$27
L9A5D:  lda     $045E
        and     #$0F
        asl     a
        tay
        lda     $A4,x
        sta     $045F,y
        lda     $AC,x
        sta     $0460,y
        inc     $045E
        rts

        jsr     L9AFA
        ldx     $045D
        jsr     L9A5D
        lda     $A4,x
        cmp     #$14
        bcs     L9A92
        lda     $AC,x
        sec
        sbc     $94,x
        bcs     L9A8C
        eor     #$FF
        adc     #$01
L9A8C:  cmp     #$02
        bcs     L9A92
        inc     $09
L9A92:  ldy     #$01
        jsr     L99CC
        lda     $045E
        sec
        sbc     #$0F
        and     #$0F
        asl     a
        tay
        lda     $045F,y
        sta     $04A6
        lda     $0460,y
        sta     $04A7
        asl     a
        sta     $21
        rol     a
        and     #$01
        sta     $22
        jsr     L9109
        rts

        jsr     L9AFA
        ldx     $045D
        lda     #$1D
        sta     $54,x
        lda     $94,x
        asl     a
        sta     $64,x
        lda     #$00
        sta     $24,x
        sta     $74,x
        sta     $84,x
        lda     #$3C
        sta     $3C,x
        lda     #$40
        sta     $043E
        inc     $09
        rts

        jsr     L9AFA
        lda     $043E
        beq     L9AE9
        dec     $043E
        bpl     L9AF9
L9AE9:  lda     $0D
        and     #$10
        beq     L9AF9
        lda     #$00
        sta     $0451
        lda     #$02
        jsr     L8376
L9AF9:  rts

L9AFA:  lda     $0D
        and     #$0F
        bne     L9B0B
        lda     $0D
        and     #$10
        beq     L9B08
        lda     #$06
L9B08:  jsr     LCFDD
L9B0B:  rts

        jsr     LC606
        jsr     LADE4
        jsr     LCDF2
        jsr     L837D
        jsr     L8CF2
        jsr     LD154
        rts

        and     #$9B
        ldx     LBA9B
        .byte   $9B
        and     $5D9C,x
        .byte   $9C
        lda     #$00
        sta     $1A
        sta     $1C
        sta     $1F
        sta     $0410
        sta     $0411
        sta     $03F6
        jsr     L9B60
        jsr     LCFDD
        lda     #$37
        jsr     LD0D8
        ldx     #$08
L9B47:  .byte   $B5
L9B48:  .byte   $3C
        and     #$07
        sta     $3C,x
        lda     #$40
        sta     $24,x
        dex
        bne     L9B47
        stx     $0557
        .byte   $20
L9B58:  .byte   $6B
        .byte   $9B
        inc     $03FF
        inc     $09
        rts

L9B60:  lda     #$00
        sta     $BD
        lda     #$00
        sta     $B5
        sta     $B9
        rts

L9B6B:  lda     #$08
        sta     L000A
        sta     $0B
L9B71:  ldx     L000A
L9B73:  lda     $035F,x
        eor     #$03
        adc     $0557
        and     #$07
        tay
        cpx     #$05
        bcc     L9B8E
        lda     $035F,x
        clc
        adc     #$04
        adc     $0557
        and     #$07
        tay
L9B8E:  lda     L9B9E,y
        sta     $8C,x
        lda     L9BA6,y
        sta     $94,x
        dex
        .byte   $C6
L9B9A:  .byte   $0B
        .byte   $D0
L9B9C:  dec     $60,x
L9B9E:  plp
        sec
        pha
        cli
        cli
        pha
        sec
        plp
L9BA6:  bcc     L9B48
        ldy     #$90
        bvs     L9C0C
        rts

        bvs     L9B58
        brk
        jsr     LD0D8
        lda     #$27
        jsr     LD0D8
        inc     $09
        lda     $0D
        and     #$08
        sta     $04AA
        jsr     L9C04
        bne     L9BFD
        lda     #$00
        sta     $21
        sta     $22
        inc     $22
        lda     #$27
        jsr     LD0D8
        inc     $09
        inc     $0431
        lda     $0431
        cmp     #$03
        bcs     L9BE7
        cmp     #$02
        bne     L9BFD
        lda     #$08
        bne     L9BF5
L9BE7:  lda     $042F
        cmp     $0430
        bne     L9BF3
        lda     #$07
        bne     L9BF5
L9BF3:  lda     #$09
L9BF5:  jsr     L8376
        lda     #$08
        sta     $04AA
L9BFD:  lda     $04AA
L9C00:  jsr     LCFDD
        rts

L9C04:  lda     #$00
        sta     $0B
        ldx     #$08
L9C0A:  lda     $A4,x
L9C0C:  sec
        sbc     $8C,x
        bcs     L9C15
        eor     #$FF
        adc     #$01
L9C15:  sta     L000A
        lda     $AC,x
        sec
        sbc     $94,x
        bcs     L9C22
        eor     #$FF
        adc     #$01
L9C22:  clc
        adc     L000A
        bcs     L9C29
        bpl     L9C2B
L9C29:  lda     #$60
L9C2B:  pha
        ora     #$20
        sta     $84,x
        pla
        and     #$F0
        ora     $0B
        sta     $0B
        dex
        bne     L9C0A
        lda     $0B
        rts

        jsr     L9C04
        bne     L9C5C
        lda     $0557
        cmp     #$04
        beq     L9C52
        inc     $0557
        jsr     L9B6B
        jmp     L9C5C

L9C52:  ldy     $02
        lda     L8C7B,y
        sta     $0436
        inc     $09
L9C5C:  rts

        jsr     L9C6B
        lda     #$31
        jsr     LD0D8
        lda     #$02
        jsr     L8376
        rts

L9C6B:  lda     $06
        eor     #$01
        sta     $06
        jsr     L8B4C
        inc     $0C
        ldx     #$04
L9C78:  lda     $54,x
        pha
        lda     $58,x
        sta     $54,x
        pla
        sta     $58,x
        lda     $64,x
L9C84:  pha
        lda     $68,x
        sta     $64,x
        pla
        sta     $68,x
        lda     $6C,x
        pha
        lda     $70,x
        .byte   $95
L9C92:  jmp     ($9568)

        bvs     $9C54
        .byte   $57
        .byte   $03
        pha
        .byte   $BD
        .byte   $5B
L9C9C:  .byte   $03
        sta     $0357,x
        pla
        sta     $035B,x
        lda     $035F,x
        pha
        lda     $0363,x
        sta     $035F,x
        pla
        sta     $0363,x
        dex
        bne     L9C78
        rts

L9CB6:  ldx     #$04
L9CB8:  lda     $8C,x
        pha
        lda     $90,x
        sta     $8C,x
        pla
        sta     $90,x
        lda     $94,x
        pha
L9CC5:  lda     $98,x
        sta     $94,x
        pla
        sta     $98,x
        dex
        bne     L9CB8
        rts

        jsr     LC606
L9CD3:  lda     $055D
        beq     L9CDF
        lda     $1A
        bne     L9CDF
        jsr     LC693
L9CDF:  jsr     LADE4
        jsr     LCDF2
        jsr     L837D
        jsr     L9109
        jsr     L8CF2
        jsr     LD154
        rts

        asl     $4F9D
        sta     L9D5C,x
        .byte   $77
        sta     L9DBC,x
        .byte   $03
        .byte   $9E
        .byte   $36
L9CFF:  .byte   $9E
        eor     ($9E,x)
        .byte   $7A
        .byte   $9E
        sta     $9E,x
        asl     a
        .byte   $9F
        rol     $9F
        adc     #$9F
        .byte   $8F
        .byte   $9F
        ldx     #$08
L9D10:  lda     L9D46,x
        sta     $8C,x
        lda     #$60
        sta     $94,x
        dex
        bne     L9D10
        stx     $0559
        lda     #$01
        sta     $0558
        sta     $04A5
        lda     #$13
        sta     $04A6
        lda     #$80
        sta     $04A7
        lda     $042F
        sta     $055F
        lda     #$00
        sta     $042F
        sta     $0430
        lda     $06
        sta     $0561
        inc     $09
L9D46:  rts

        pha
        bvc     L9DA2
        rts

        sec
        bmi     L9D76
        jsr     L0420
        .byte   $9C
        bne     L9D5B
        lda     #$20
        sta     $043E
        inc     $09
L9D5B:  rts

L9D5C:  dec     $043E
        bne     L9D76
        jsr     LD143
        lda     #$00
        sta     $03FF
        sta     $055B
        jsr     LCFDD
        lda     #$31
        jsr     LD0D8
        inc     $09
L9D76:  rts

        lda     #$00
        sta     $23
        sta     $24
        ldx     #$08
L9D7F:  lda     #$82
        sta     $3C,x
        lda     #$00
        sta     $034F,x
        lda     #$10
        sta     $84,x
        dex
        bne     L9D7F
        jsr     L9DB2
        stx     $1A
        lda     $8C,x
        sta     $055E
        lda     #$40
        sta     $8C,x
        lda     #$88
        sta     $94,x
        .byte   $A9
L9DA2:  plp
        sta     $84,x
        lda     #$07
        jsr     LCFDD
        lda     #$03
        jsr     LD0D8
        inc     $09
        rts

L9DB2:  lda     $055B
        lsr     a
        tax
        lda     L9DF2,x
        tax
        rts

L9DBC:  jsr     L9DF6
        jsr     L9DB2
        lda     #$03
        sta     $0B
        jsr     LB915
        bcs     L9DF1
        lda     #$01
        sta     $24,x
        jsr     LA9E1
        tay
        lda     #$01
        sta     $0410,y
        lda     #$02
        sta     $3C,x
        lda     #$50
        sta     $84,x
        lda     #$01
        sta     $055A
        lda     $64,x
        sta     $055C
        lda     #$01
        sta     $04A5
        inc     $09
L9DF1:  rts

L9DF2:  ora     $06
        .byte   $07
        php
L9DF6:  lda     $0D
        lsr     a
        lsr     a
        lsr     a
        lsr     a
        lsr     a
        and     #$01
        sta     $04A5
        rts

        ldx     #$01
L9E05:  lda     $15,x
        bpl     L9E0F
        and     #$7F
        ora     #$40
        sta     $15,x
L9E0F:  dex
        bpl     L9E05
        jsr     LA3CE
        ldx     $1A
        beq     L9E2B
        bit     $BD
        bvs     L9E35
        lda     $64,x
        sta     $055C
        inc     $055C
        cmp     #$A8
        bcc     L9E35
        inc     $09
L9E2B:  lda     #$00
        sta     $0434
        sta     $0556
        inc     $09
L9E35:  rts

        lda     #$27
        jsr     LD0D8
        inc     $055D
        inc     $09
        rts

        lda     $19
        beq     L9E64
        inc     $0560
        lda     $06
        eor     #$01
        tax
        inc     $042F,x
        jsr     LD143
        lda     #$01
        jsr     LCFDD
        lda     $03B3
        ora     #$01
        sta     $03B3
        lda     #$40
        bne     L9E74
L9E64:  lda     #$40
        ldy     $1A
        bne     L9E74
        ldy     $1C
        beq     L9E74
        lda     #$01
        ldy     $22
        bne     L9E79
L9E74:  sta     $055D
        inc     $09
L9E79:  rts

        lda     #$01
        sta     $054C
        jsr     L9EC7
        jsr     L9DB2
        lda     #$40
        sta     $24,x
        lda     #$60
        sta     $94,x
        lda     $055E
        sta     $8C,x
        inc     $09
        rts

        jsr     L9DF6
        lda     #$00
        sta     $054C
        jsr     L9EC7
        lda     $0D
        and     #$10
        beq     L9EC6
        jsr     L9DB2
        lda     #$08
        sta     $0B
        jsr     LB915
        bcs     L9EC6
        lda     #$10
        sta     $84,x
        lda     #$00
        sta     $19
        lda     #$01
        sta     $04A5
        lda     #$40
        sta     $043E
        inc     $09
L9EC6:  rts

L9EC7:  lda     $055D
        beq     L9EE1
        dec     $055D
        bne     L9EEC
        lda     #$00
        sta     $03B3
        sta     $055D
        sta     $055A
        sta     $1A
        jsr     L9B60
L9EE1:  jsr     L9DB2
        lda     $64,x
        sta     $21
        lda     $6C,x
        sta     $22
L9EEC:  ldx     #$04
        lda     $0560
        beq     L9F00
        lda     $0D
        lsr     a
        lsr     a
        lsr     a
        lsr     a
        and     #$01
        jsr     LCFDD
        .byte   $A2
L9EFF:  php
L9F00:  ldy     #$04
L9F02:  jsr     L9632
        dex
        dey
        bne     L9F02
        rts

        jsr     L9EC7
        dec     $043E
        bne     L9F25
        ldx     #$08
L9F14:  lda     #$02
        sta     $3C,x
        lda     #$00
        sta     $034F,x
        dex
        bne     L9F14
        sta     $0560
        inc     $09
L9F25:  rts

        lda     $0561
        eor     #$01
        tax
        lda     $042F,x
        ldx     $0561
        sec
        sbc     $042F,x
        bcs     L9F3C
        eor     #$FF
        adc     #$01
L9F3C:  pha
        lda     $055B
        rol     a
        tay
        pla
        cmp     L9F59,y
        bcc     L9F53
        jsr     L9F9D
        lda     #$09
        jsr     L8376
        jmp     L9F58

L9F53:  inc     $055B
        inc     $09
L9F58:  rts

L9F59:  .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $02
        .byte   $03
        .byte   $02
        .byte   $02
        ora     ($02,x)
        ora     ($01,x)
        lda     $055B
        cmp     #$08
        bcs     L9F7C
        jsr     L9C6B
        jsr     L9CB6
        lda     #$03
        sta     $09
        bne     L9F8E
L9F7C:  jsr     L9F9D
        lda     #$02
        sta     $0436
        sta     $0559
        lda     #$37
        jsr     LD0D8
        inc     $09
L9F8E:  rts

        lda     #$00
        sta     $0571
        jsr     LD0D8
        lda     #$02
        jsr     L8376
        rts

L9F9D:  .byte   $A2
L9F9E:  .byte   $01
L9F9F:  lda     $055F
        clc
        adc     $042F,x
        sta     $042F,x
        dex
        bpl     L9F9F
        jsr     LD143
        rts

        jsr     LC606
        lda     $0562
        bne     L9FBB
        jsr     LADE4
L9FBB:  jsr     LCDF2
        jsr     L837D
        jsr     LD154
        rts

        .byte   $DB
        .byte   $9F
        inc     $9F,x
        sty     $A0
        .byte   $CF
        ldy     #$10
        ldx     #$1B
        ldx     #$26
        ldx     #$34
        ldx     #$41
        ldx     #$53
        ldx     #$60
        ldx     #$A2
        php
L9FDD:  lda     #$40
        sta     $84,x
        dex
        bne     L9FDD
        lda     #$01
        sta     $043E
        lda     #$00
        sta     $0563
        lda     #$27
        jsr     LD0D8
        inc     $09
        rts

        dec     $043E
        bne     LA031
        lda     #$20
        sta     $043E
        lda     #$08
        sta     L000A
        lda     #$20
        sta     $056F
        lda     #$D0
        sta     $0570
        jsr     LA032
        lsr     L000A
        lda     #$60
        sta     $056F
        lda     #$30
        sta     $0570
        jsr     LA032
        inc     $0563
        lda     $0563
        cmp     #$04
        bne     LA031
        lda     #$D0
        sta     $043E
        inc     $09
LA031:  rts

LA032:  lda     L000A
        lsr     a
        ora     #$03
        sta     $0B
        jsr     LA05F
        txa
        tay
        jsr     LA05F
        jsr     LA079
        txa
        tay
        jsr     LA05F
        jsr     LA079
        txa
        tay
        jsr     LA05F
        jsr     LA079
        lda     $056F
        sta     $8C,x
        lda     $0570
        sta     $94,x
        rts

LA05F:  ldx     $0B
        lda     LA071,x
        dec     $0B
        ldx     L000A
LA068:  cmp     $035F,x
        beq     LA070
        dex
        bne     LA068
LA070:  rts

LA071:  brk
        ora     ($02,x)
        .byte   $03
        .byte   $03
        .byte   $02
        ora     (L0000,x)
LA079:  lda     $8C,x
        sta     $8C,y
        lda     $94,x
        sta     $94,y
        rts

        dec     $043E
        bne     LA0B0
        lda     #$42
        jsr     LD0D8
        ldx     #$0C
LA090:  lda     LA0BC,x
        sta     $0562,x
        dex
        bne     LA090
        ldx     #$0C
LA09B:  lda     LA0B0,x
        sta     $03E5,x
        dex
        bne     LA09B
        inc     $0C
        inc     $0562
        lda     #$03
        sta     $043E
        inc     $09
LA0B0:  rts

        bmi     LA0E9
        .byte   $0F
        and     ($30,x)
        sec
        .byte   $0F
        asl     $30,x
        bpl     LA0CB
LA0BC:  asl     L0000,x
        clc
        inx
        cld
        ora     ($28,x)
        clc
        .byte   $C7
        brk
LA0C6:  sec
        inx
        ldx     $48,y
        cli
LA0CB:  pla
        bmi     LA10E
        bvc     LA0F0
        .byte   $D7
        ldy     #$D0
        .byte   $02
        inc     $09
        rts

        lda     $0D
        and     #$01
        bne     LA141
        .byte   $A2
LA0DE:  php
LA0DF:  lda     $0563,x
        ror     a
        bcs     LA0EA
        dec     $0565,x
        .byte   $D0
LA0E9:  .byte   $03
LA0EA:  inc     $0565,x
        lda     $0566,x
LA0F0:  and     #$0F
        bne     LA109
        lda     $0566,x
        lsr     a
        lsr     a
        lsr     a
        lsr     a
        ora     $0566,x
        sta     $0566,x
        lda     $0563,x
        eor     #$02
        sta     $0563,x
LA109:  dec     $0566,x
        dex
        dex
LA10E:  dex
        dex
        bpl     LA0DF
        lda     $0565
        cmp     #$18
        beq     LA11D
        cmp     #$E8
        bne     LA141
LA11D:  dec     $043E
        lda     $043E
        asl     a
        adc     $043E
        tax
        ldy     #$00
LA12A:  lda     $0563,y
        eor     #$01
        sta     $0563,y
        lda     LA0C6,x
        sta     $0564,y
        inx
        iny
        iny
        iny
        iny
        cpy     #$0C
        bne     LA12A
LA141:  jsr     LA148
        lda     $043E
        rts

LA148:  ldx     #$08
LA14A:  lda     $0563,x
        sta     $D1
        lda     $0564,x
        asl     a
        sta     $D2
        lda     $0565,x
        sta     $D3
        ldy     #$00
LA15C:  lda     $0574
        eor     #$FF
        clc
        adc     $D2
        adc     LA1B6,y
        sta     $DC
        lda     $D1
        and     #$02
        bne     LA174
        lda     LA1F2,y
        bne     LA177
LA174:  lda     LA201,y
LA177:  sta     $DD
        lda     $0563,x
        lsr     a
        ror     a
        lsr     a
        ora     LA1E3,y
        sta     $DE
        lda     $D1
        ror     a
        bcs     LA18E
        lda     LA1C5,y
        bcc     LA192
LA18E:  lda     LA1D4,y
        clc
LA192:  adc     $D3
        asl     a
        pha
        rol     a
        and     #$01
        sta     $D4
        pla
        sec
        sbc     $FD
        sta     $DF
        lda     $D4
        sbc     #$00
        bne     LA1AA
        jsr     L8AD8
LA1AA:  iny
        cpy     #$0F
        bne     LA15C
        dex
        dex
        dex
        dex
        bpl     LA14A
        rts

LA1B6:  inx
        inx
        beq     LA1AA
        sed
        sed
        sed
        sed
        brk
        brk
        brk
        brk
        brk
        brk
        brk
LA1C5:  sed
        .byte   $FC
        sed
        .byte   $FC
        .byte   $F4
        sed
        .byte   $FC
        brk
        .byte   $F4
        sed
        .byte   $FC
        brk
        .byte   $04
        php
        .byte   $0C
LA1D4:  .byte   $04
        brk
        .byte   $04
        brk
        php
        .byte   $04
        brk
        .byte   $FC
        php
        .byte   $04
        brk
        .byte   $FC
        sed
        .byte   $F4
        .byte   $F0
LA1E3:  brk
        brk
        ora     ($01,x)
        ora     ($01,x)
        ora     ($02,x)
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        brk
        brk
        brk
LA1F2:  cmp     LCDDA,y
        dec     LD0CF
        cmp     ($D2),y
        .byte   $D3
        .byte   $D4
        cmp     $D6,x
        sbc     LFAF9,y
LA201:  cmp     LCDDE,x
        dec     LD0CF
        cmp     ($D7),y
        .byte   $D3
        .byte   $D4
        cmp     $D8,x
        sbc     LFAF9,y
        jsr     LD09E
        lda     #$00
        sta     $0562
        inc     $09
        rts

        lda     #$04
        sta     $0557
        jsr     L9B6B
        inc     $09
        rts

        jsr     L9C6B
        jsr     L9CB6
        lda     #$37
        jsr     LD0D8
        inc     $09
        rts

        lda     #$00
        jsr     LD0D8
        lda     #$27
        jsr     LD0D8
        inc     $09
        rts

        lda     $0310
        bne     LA252
        lda     #$31
        jsr     LD0D8
        lda     #$27
        jsr     LD0D8
        inc     $09
LA252:  rts

        jsr     L9C04
        bne     LA25F
        lda     #$00
        sta     $0557
        inc     $09
LA25F:  rts

        ldy     $02
        lda     L8C7B,y
        sta     $0436
        lda     #$00
        sta     $0442
        sta     $0443
        sta     $0410
        sta     $0411
        lda     #$02
        jsr     L8376
        rts

        jsr     LC606
        jsr     LADE4
        jsr     LCDF2
        jsr     L837D
        jsr     LD154
        rts

        sty     $A2,x
        clv
        ldx     #$32
        .byte   $A3
        cli
        .byte   $A3
        lda     #$00
        sta     $21
        sta     $22
        inc     $22
        sta     $0557
        jsr     L9B6B
        lda     #$01
        sta     $054C
        lda     $0430
LA2AA:  cmp     $042F
        rol     a
        eor     $06
        and     #$01
        sta     $0573
        inc     $09
        rts

        jsr     LA2F4
        lda     #$00
        sta     $054C
        jsr     L9C04
        bne     LA2EE
        lda     L0000
        ror     a
        ldy     #$33
        bcc     LA2E8
        ldy     #$35
        lda     $0573
        beq     LA2E8
        lda     $01
        cmp     #$04
        bcc     LA2E7
        ldx     $04
        lda     #$00
LA2DD:  rol     a
        dex
        bpl     LA2DD
        ora     $06FF
        sta     $06FF
LA2E7:  dey
LA2E8:  tya
        jsr     LD0D8
        inc     $09
LA2EE:  rts

        ora     ($03,x)
        .byte   $07
        .byte   $0F
        .byte   $1F
LA2F4:  lda     $0573
        asl     a
        asl     a
        adc     #$04
        tax
        ldy     #$04
LA2FE:  jsr     L9632
        dex
        dey
        bne     LA2FE
        lda     $0312
        bne     LA30F
        lda     #$27
        jsr     LD0D8
LA30F:  lda     $0D
        and     #$0F
        bne     LA331
        lda     #$9C
        sta     $0413
        sta     $0414
        sta     $0423
        sta     $0424
        lda     $0D
        and     #$10
        beq     LA32E
        jsr     LD143
        lda     #$08
LA32E:  jsr     LCFDD
LA331:  rts

        jsr     LA2F4
        lda     $0573
        eor     #$01
        asl     a
        asl     a
        adc     #$04
        tax
        ldy     #$04
LA341:  lda     #$10
        sta     $8C,x
        cpx     #$05
        lda     #$4C
        bcs     LA34D
        lda     #$B4
LA34D:  sta     $94,x
        dex
        dey
        bne     LA341
        sty     $14
        inc     $09
        rts

        jsr     LA2F4
        lda     $0573
        eor     #$01
        asl     a
        asl     a
        adc     #$04
        tax
        ldy     #$04
        sty     $0B
LA369:  tya
        pha
        lda     $24,x
        beq     LA37C
        jsr     LB915
        bcs     LA37C
        lda     #$00
        sta     $24,x
        sta     $64,x
        sta     $6C,x
LA37C:  dex
        pla
        tay
        dey
        bne     LA369
        lda     $0573
        asl     a
        asl     a
        adc     #$04
        tax
        ldy     #$04
LA38C:  tya
        pha
        jsr     LB915
        pla
        tay
        bcs     LA3AC
        dex
        dey
        bne     LA38C
        inc     $0557
        lda     $0573
        asl     a
        asl     a
        adc     #$04
        sta     L000A
        lda     #$04
        sta     $0B
        jsr     L9B71
LA3AC:  lda     $0557
        cmp     #$09
        bcs     LA3BE
        lda     $0313
        bne     LA3CD
        lda     $0F
        ora     $10
        beq     LA3CD
LA3BE:  ldx     #$1F
        lda     #$0F
LA3C2:  sta     $03D6,x
        dex
        bpl     LA3C2
        inc     $0C
        jsr     L8371
LA3CD:  rts

LA3CE:  lda     $1A
        beq     LA3F6
        bpl     LA400
        and     #$01
        tay
        asl     a
        asl     a
        tax
        lda     L0000
        ror     a
        bcc     LA3E4
        tya
        eor     $06
        bne     LA3E9
LA3E4:  lda     $15,y
        bmi     LA40E
LA3E9:  lda     $B5,x
        beq     LA3FC
        dec     $B5,x
        bne     LA3F6
        sta     $17,y
        beq     LA3FC
LA3F6:  lda     #$00
        sta     $BD
        beq     LA42B
LA3FC:  lda     #$80
        bmi     LA40E
LA400:  tax
        lda     $24,x
        and     #$20
        bne     LA3F6
        jsr     LA9E1
        tay
        lda     $15,y
LA40E:  sta     L000A
        lda     $BD
        bne     LA42E
        lda     L000A
        and     #$C0
        beq     LA42B
        cmp     #$C0
        beq     LA42B
        sta     L000A
        eor     $17,y
        and     #$C0
        beq     LA42B
        lda     L000A
        sta     $BD
LA42B:  jmp     LA4A1

LA42E:  and     #$3F
        asl     a
        tay
        ldx     $1A
        bpl     LA440
        lda     LA4D0,y
        sta     $0B
        lda     LA4D1,y
        bpl     LA456
LA440:  bit     $BD
        bvs     LA44E
        lda     LA4A2,y
        sta     $0B
        lda     LA4A3,y
        bpl     LA456
LA44E:  lda     LA4B8,y
        sta     $0B
        lda     LA4B9,y
LA456:  pha
        asl     $0B
        bcc     LA470
        lda     #$C0
        and     L000A
        and     $BD
        bne     LA470
        lda     #$00
        sta     $BD
        lda     $3C,x
        and     #$07
        sta     $3C,x
        pla
        bpl     LA4A1
LA470:  asl     $0B
        bcc     LA487
        lda     #$C0
        and     L000A
        and     $BD
        beq     LA487
        lda     $1C
        clc
        adc     #$08
        bcc     LA485
        lda     #$FF
LA485:  sta     $1C
LA487:  asl     $0B
        bcc     LA493
        lda     $3C,x
        and     #$07
        ora     $0B
        sta     $3C,x
LA493:  inc     $BD
        lda     #$DC
        sta     L000A
        lda     #$A4
        sta     $0B
        pla
        jsr     L8359
LA4A1:  rts

LA4A2:  .byte   $B1
LA4A3:  ora     #$80
        ora     ($C0,x)
        brk
        cpy     #$00
        cpy     #$00
        cpy     #$00
        rti

        brk
        rti

        .byte   $07
        rti

        ora     $40
        php
        .byte   $32
        .byte   $03
LA4B8:  .byte   $B1
LA4B9:  ora     #$80
        brk
        .byte   $80
        brk
        .byte   $80
        brk
        .byte   $80
        brk
        .byte   $80
        brk
        .byte   $33
        .byte   $02
        brk
        .byte   $0F
        .byte   $32
        .byte   $04
        brk
        ora     L0000
        asl     $33
        asl     a
LA4D0:  brk
LA4D1:  ora     #$00
        .byte   $0B
        brk
        ora     $0500
        brk
        asl     $0C00
        lda     ($A4,x)
        .byte   $FC
        ldy     $01
        lda     $0E
        lda     $17
        lda     $51
        lda     $7B
        lda     $A5
        lda     $AF
        lda     $CD
        lda     $04
        ldx     $36
        ldx     $3B
        ldx     $5F
        ldx     $96
        ldx     L0020
        .byte   $A7
        lda     #$7F
LA4FE:  sta     $1C
LA500:  rts

        lda     $0357,x
        tay
        lda     LA50B,y
        sta     $1C
        rts

LA50B:  .byte   $9F
        .byte   $BF
        .byte   $7F
        jsr     LA756
        lda     #$21
        jsr     LD0D8
        rts

        jsr     LA87B
        jsr     LA9E1
        pha
        tay
        lda     $15,y
        and     #$0F
        ldy     #$00
        lsr     a
        bcs     LA535
        lsr     a
        bcs     LA535
        iny
        lsr     a
        bcs     LA535
        iny
        lsr     a
        bcs     LA535
        tay
LA535:  lda     LA54C,y
        sta     $0403
        pla
        tay
        lda     LA54F,y
        sta     $0404
        lda     #$01
        sta     $0400
        jsr     LA8CC
        rts

LA54C:  jsr     L1624
LA54F:  asl     $6A,x
        ldx     $0400
        beq     LA57A
LA556:  lda     $040A,x
        tay
        bne     LA562
        jsr     LA921
        jmp     LA577

LA562:  dey
        .byte   $D0
LA564:  asl     L0020
        .byte   $34
        lda     #$4C
        .byte   $77
        lda     $88
        bne     LA574
        jsr     LA95A
        jmp     LA577

LA574:  jsr     LA947
LA577:  dex
        bne     LA556
LA57A:  rts

        lda     $22
        ror     a
        lda     $21
        ror     a
        pha
        ldx     $1A
        jsr     LA9E1
        ror     a
        pla
        bcc     LA58D
        eor     #$FF
LA58D:  ldy     #$00
        cmp     #$60
        bcc     LA59C
        iny
        lda     $0D
        ror     a
        bcc     LA59C
        dey
        dey
        clc
LA59C:  tya
        adc     $040B
        and     #$1F
        sta     $1D
        rts

        jsr     LA87B
        jsr     LA7B2
        jsr     LA8CC
        rts

        ldx     $1A
        jsr     LA9E1
        asl     a
        asl     a
        adc     #$04
        tay
        lda     $44,x
        jsr     LA836
        cmp     #$09
        bcs     LA5C6
        lda     $D1
        bcc     LA5CA
LA5C6:  ldx     $1A
        lda     $44,x
LA5CA:  sta     $1D
        rts

        lda     #$00
        sta     $0575
        sta     $0591
        lda     $1A
        bpl     LA5DD
        asl     a
        asl     a
        ora     #$01
LA5DD:  sta     $040F
        lda     $043B
        bne     LA600
        lda     $0D
        ror     a
        lda     #$01
        bcc     LA5ED
        asl     a
LA5ED:  sta     $043A
        ldx     $01
        lda     LDC8D,x
        sta     $043C
        ldx     $04
        lda     LDC87,x
        sta     $043B
LA600:  dec     $043B
        rts

        ldx     $1A
        jsr     LA9E1
        ora     #$80
        sta     $0555
        lda     $1C
        cmp     #$FF
        bne     LA62D
        lda     $0575
        cmp     #$50
        bcc     LA62B
        lda     $0357,x
        ror     a
        bcs     LA628
        jsr     LB21A
        lda     #$17
        bne     LA632
LA628:  inc     $0591
LA62B:  inc     $23
LA62D:  jsr     LA756
        lda     #$20
LA632:  jsr     LD0D8
        rts

        lda     #$80
        sta     $1C
        rts

        lda     $1A
        asl     a
        asl     a
        tax
        lda     #$00
        sta     $0555
        sta     $1A
        sta     $BD
        lda     #$14
        sta     $B5,x
        txa
        lsr     a
        bne     LA653
        lda     #$01
LA653:  jsr     LA792
        jsr     LB2B4
LA659:  lda     #$21
        jsr     LD0D8
        rts

        lda     $1A
        and     #$01
        tax
        asl     a
        asl     a
        tay
        lda     $15,x
        and     #$0C
        beq     LA677
        and     #$04
        beq     LA675
        lda     #$08
        bne     LA677
LA675:  lda     #$F8
LA677:  clc
        adc     $B6,y
        lsr     a
        lsr     a
        sta     $0401
        txa
        eor     #$01
        ror     a
        lda     $B7,y
        ror     a
        lsr     a
        sta     $0402
        tya
        asl     a
        tax
        jsr     LA7B2
        jsr     LA8CC
        rts

        lda     $1A
        asl     a
        asl     a
        sta     L000A
        tax
        lda     $B6,x
        ldy     #$00
        cmp     #$70
        bcc     LA6BB
        cmp     #$90
        bcs     LA6B9
        iny
        lda     $B7,x
        bpl     LA6B2
        eor     #$FF
        adc     #$01
LA6B2:  cmp     #$64
        bcs     LA6BB
        iny
        bne     LA6BB
LA6B9:  ldy     #$03
LA6BB:  tya
        ora     L000A
        asl     a
        asl     a
        sta     L000A
        lda     $1A
        and     #$01
        tay
        lda     $15,y
        and     LA6FE,y
        beq     LA6DD
        ldy     #$00
        ror     a
        bcs     LA6DC
        ror     a
        bcs     LA6DC
        iny
        ror     a
        bcs     LA6DC
        iny
LA6DC:  tya
LA6DD:  ora     L000A
        tay
        lda     LA700,y
        pha
        sta     L000A
        lda     $1A
        asl     a
        asl     a
        adc     #$04
        tay
        lda     L000A
        ldx     #$04
        jsr     LA836
        cmp     #$05
        pla
        bcs     LA6FB
        lda     $D1
LA6FB:  sta     $1D
        rts

LA6FE:  .byte   $0E
        .byte   $0D
LA700:  clc
        .byte   $14
        brk
        brk
        clc
        .byte   $13
        ora     $1800,x
        .byte   $14
        .byte   $1C
        brk
        clc
        bpl     LA72B
        brk
        php
        .byte   $0C
        brk
        brk
        php
        ora     a:$03
        php
        .byte   $0C
        .byte   $04
        brk
        php
        bpl     LA723
        brk
        dec     $BD
        .byte   $A9
LA723:  .byte   $04
        ldy     $055A
        beq     LA72A
        asl     a
LA72A:  clc
LA72B:  adc     $1C
        bcc     LA731
        lda     #$FF
LA731:  sta     $1C
        tay
        jsr     LA9E1
        tax
        lda     $15,x
        asl     a
        bpl     LA753
        lda     $0D
        and     #$03
        bne     LA74B
        inc     $0575
        bne     LA74B
        dec     $0575
LA74B:  lda     $055A
        beq     LA755
        iny
        bne     LA755
LA753:  inc     $BD
LA755:  rts

LA756:  ldx     $1A
        lda     #$10
        sta     $033F,x
        ora     $24,x
        sta     $24,x
        lda     #$18
        sta     $034F,x
        cpx     #$05
        bcs     LA778
        lda     $22
        beq     LA788
        lda     $21
        cmp     #$04
        bcc     LA788
        ldy     #$01
        bne     LA784
LA778:  lda     $22
        bne     LA788
        lda     $21
        cmp     #$FD
        bcs     LA788
        ldy     #$02
LA784:  tya
        jsr     LA792
LA788:  lda     #$00
        sta     $1A
        sta     $BD
        jsr     LB2B4
        rts

LA792:  tay
        lsr     a
        eor     $06
        asl     a
        tax
        lda     $0455,x
        ora     $0456,x
        beq     LA7AE
        txa
        eor     #$02
        tax
        lda     $0456,x
        ora     $0456,x
        bne     LA7AE
        ldy     #$00
LA7AE:  sty     $04AD
        rts

LA7B2:  lda     #$00
        sta     $0400
        ldy     #$02
        jsr     LA9E1
        asl     a
        asl     a
        adc     #$04
        tax
LA7C1:  cpx     $1A
        beq     LA82F
        lda     $24,x
        beq     LA82F
        lda     $A4,x
        lsr     a
        sec
        sbc     $0401
        bcs     LA7D6
        eor     #$FF
        adc     #$01
LA7D6:  sta     L000A
        lda     $AC,x
        lsr     a
        sec
        sbc     $0402
        bcs     LA7E5
        eor     #$FF
        adc     #$01
LA7E5:  cmp     #$80
        bcs     LA82F
        inc     $0400
        adc     L000A
        cmp     #$20
        bcc     LA7F5
        lda     #$20
        clc
LA7F5:  adc     #$04
        sta     L000A
        lda     #$00
        sta     $0B
        lda     $74,x
        lsr     a
        lsr     a
        lsr     a
        lsr     a
        cmp     #$05
        bcc     LA809
        lda     #$04
LA809:  lsr     a
        bcc     LA817
        pha
        lda     L000A
        clc
        adc     $0B
        sta     $0B
        asl     L000A
        pla
LA817:  bne     LA809
        jsr     LCFB3
        tya
        pha
        lda     $0B
        ldy     $44,x
        jsr     LCF4E
        jsr     LA892
        pla
        tay
        jsr     LA8BA
        iny
        iny
LA82F:  dex
        txa
        and     #$03
        bne     LA7C1
        rts

LA836:  sta     $D1
        lda     $0400
        beq     LA87A
        tax
        lda     $D1
LA840:  pha
        sec
        sbc     $040A,x
        bcs     LA84B
        eor     #$FF
        adc     #$01
LA84B:  and     #$1F
        tay
        and     #$10
        beq     LA859
        tya
        eor     #$1F
        clc
        adc     #$01
        tay
LA859:  sty     $D0,x
        pla
        dex
        bne     LA840
        lda     $0400
LA862:  tay
        tax
        lda     $D0,x
LA866:  dex
        beq     LA870
        cmp     $D0,x
        bcc     LA866
        txa
        bpl     LA862
LA870:  lda     $D0,y
        pha
        lda     $040A,y
        sta     $D1
        pla
LA87A:  rts

LA87B:  jsr     LCF9F
        ldx     $1A
        lda     $74,x
        lsr     a
        lsr     a
        ldy     $44,x
        jsr     LCF4E
        jsr     LA892
        ldy     #$00
        jsr     LA8BA
        rts

LA892:  lda     $D2
        cmp     #$30
        bcs     LA89A
        lda     #$30
LA89A:  cmp     #$D0
        bcc     LA8A0
        lda     #$D0
LA8A0:  sta     $D2
        lda     $D5
        ror     a
        lda     $D4
        bcs     LA8B1
        cmp     #$58
        bcs     LA8B7
        lda     #$58
        bne     LA8B7
LA8B1:  cmp     #$A8
        bcc     LA8B7
        lda     #$A8
LA8B7:  sta     $D4
        rts

LA8BA:  lda     $D2
        lsr     a
        lsr     a
        sta     $0401,y
        lda     $D5
        ror     a
        lda     $D4
        ror     a
        lsr     a
        sta     $0402,y
        rts

LA8CC:  lda     $0400
        beq     LA904
        tax
        asl     a
        tay
LA8D4:  lda     #$00
        sta     $040A,x
        lda     $0401,y
        sec
        sbc     $0401
        bcs     LA8E6
        eor     #$FF
        adc     #$01
LA8E6:  sta     $0401,y
        rol     $040A,x
        lda     $0402,y
        sec
        sbc     $0402
        bcs     LA8F9
        eor     #$FF
        adc     #$01
LA8F9:  sta     $0402,y
        rol     $040A,x
LA8FF:  dey
        dey
        dex
        bne     LA8D4
LA904:  rts

LA905:  txa
        asl     a
        tay
        lda     $0401,y
        cmp     $0402,y
        bcc     LA919
        sta     $D2
        lda     $0402,y
        sta     $D1
        bcs     LA920
LA919:  sta     $D1
        lda     $0402,y
        sta     $D2
LA920:  rts

LA921:  jsr     LA905
        bcc     LA92E
        lda     #$00
        jsr     LA981
        jmp     LA933

LA92E:  lda     #$18
        jsr     LA96D
LA933:  rts

        jsr     LA905
        bcc     LA941
        lda     #$00
        jsr     LA96D
        jmp     LA946

LA941:  lda     #$08
        jsr     LA981
LA946:  rts

LA947:  jsr     LA905
        bcc     LA954
        lda     #$10
        jsr     LA981
        jmp     LA959

LA954:  lda     #$08
        jsr     LA96D
LA959:  rts

LA95A:  jsr     LA905
        bcc     LA967
        lda     #$10
        jsr     LA96D
        jmp     LA96C

LA967:  lda     #$18
        jsr     LA981
LA96C:  rts

LA96D:  sta     L000A
        txa
        pha
        jsr     LA999
        clc
        adc     L000A
        tay
        pla
        tax
        tya
        and     #$1F
        sta     $040A,x
        rts

LA981:  sta     L000A
        txa
        pha
        jsr     LA999
        sta     $0B
        lda     L000A
        sec
        sbc     $0B
        tay
        pla
        tax
        tya
        and     #$1F
        sta     $040A,x
        rts

LA999:  jsr     LA9B4
        ldy     #$00
        cmp     #$1A
        bcc     LA9B2
        iny
        cmp     #$4E
        bcc     LA9B2
        iny
        cmp     #$89
        bcc     LA9B2
        iny
        cmp     #$D3
        bcc     LA9B2
        iny
LA9B2:  tya
        rts

LA9B4:  lda     #$00
        sta     $D4
        lda     $D1
        cmp     $D2
        lda     #$FF
        bcs     LA9E0
        lda     #$80
        sta     $D3
LA9C4:  asl     $D1
        bcs     LA9CE
        lda     $D1
        cmp     $D2
        bcc     LA9DA
LA9CE:  lda     $D1
        sbc     $D2
        sta     $D1
        lda     $D4
        ora     $D3
        sta     $D4
LA9DA:  lsr     $D3
        bcc     LA9C4
        lda     $D4
LA9E0:  rts

LA9E1:  lda     #$00
        cpx     #$05
        rol     a
        rts

LA9E7:  lda     $0559
        ora     $058F
        bne     LAA46
        lda     $FD
        rol     a
        rol     a
        and     #$01
        sta     $D4
        asl     a
        asl     a
        tax
        jsr     LAAE8
        txa
        eor     #$04
        tax
        lda     L0000
        bmi     LAA14
        ror     a
        bcc     LAA0E
        lda     $D4
        eor     $06
        beq     LAA14
LAA0E:  jsr     LAB10
        jmp     LAA17

LAA14:  jsr     LAB4F
LAA17:  lda     $19
        bne     LAA3A
        lda     $03FF
        bne     LAA3A
        lda     #$00
        sta     $D1
        jsr     LAA47
        lda     $D1
        beq     LAA3A
        bpl     LAA31
        lda     #$17
        bne     LAA33
LAA31:  lda     #$01
LAA33:  stx     $D1
        jsr     LD0D8
        ldx     $D1
LAA3A:  lda     $0558
        beq     LAA43
        lda     $D4
        beq     LAA46
LAA43:  jsr     LAD21
LAA46:  rts

LAA47:  stx     $D3
        lda     $B6,x
        lsr     a
        sta     L000A
        clc
        lda     $B7,x
        bpl     LAA54
        sec
LAA54:  ror     a
        sta     $0B
        txa
        eor     #$05
        tax
        ldy     #$04
LAA5D:  lda     $24,x
        beq     LAADE
        and     #$A0
        bne     LAADE
        lda     $AC,x
        sec
        sbc     $0B
        bcs     LAA70
        eor     #$FF
        adc     #$01
LAA70:  rol     $D2
        cmp     #$08
        bcs     LAADE
        lda     $A4,x
        sec
        sbc     L000A
        bcs     LAA81
        eor     #$FF
        adc     #$01
LAA81:  rol     $D2
        cmp     #$07
        bcs     LAADE
        lda     $0357,x
        bne     LAA93
        lda     $0D
        ror     a
        bcs     LAAA5
        bcc     LAA9E
LAA93:  ror     a
        bcc     LAAA5
        lda     $0D
        and     #$03
        cmp     #$03
        beq     LAAA5
LAA9E:  jsr     LB221
        inc     $D1
        bne     LAAAC
LAAA5:  jsr     LB21A
        lda     #$80
        sta     $D1
LAAAC:  txa
        pha
        tya
        pha
        ldx     $D3
        ldy     #$03
        ror     $D2
        bcc     LAAC0
LAAB8:  jsr     LACE7
        dey
        bne     LAAB8
        beq     LAAC6
LAAC0:  jsr     LACF0
        dey
        bne     LAAC0
LAAC6:  ldy     #$03
        ror     $D2
        bcc     LAAD4
LAACC:  jsr     LACF9
        dey
        bne     LAACC
        beq     LAADA
LAAD4:  jsr     LAD0D
        dey
        bne     LAAD4
LAADA:  pla
        tay
        pla
        tax
LAADE:  inx
        dey
        beq     LAAE5
        jmp     LAA5D

LAAE5:  ldx     $D3
        rts

LAAE8:  lda     $1F
        cmp     #$60
        bcc     LAAFA
        cmp     #$A0
        bcs     LAB00
        lda     $B6,x
        cmp     #$80
        beq     LAB03
        bcc     LAB00
LAAFA:  jsr     LACE7
        jmp     LAB03

LAB00:  jsr     LACF0
LAB03:  txa
        bne     LAB0C
        jsr     LACF9
        jmp     LAB0F

LAB0C:  jsr     LAD0D
LAB0F:  rts

LAB10:  txa
        lsr     a
        lsr     a
        tay
        lda     $15,y
        ror     a
        bcc     LAB1F
        pha
        jsr     LAD0D
        pla
LAB1F:  ror     a
        bcc     LAB27
        pha
        jsr     LACF9
        pla
LAB27:  ror     a
        bcc     LAB3A
        ldy     $01
        lda     LDC92,y
        sta     $D0
LAB31:  jsr     LACF0
        dec     $D0
        bne     LAB31
        beq     LAB4B
LAB3A:  ror     a
        bcc     LAB4B
        ldy     $01
        lda     LDC92,y
        sta     $D0
LAB44:  jsr     LACE7
        dec     $D0
        bne     LAB44
LAB4B:  jsr     LABE5
        rts

LAB4F:  lda     $B7,x
        cmp     $21
        beq     LAB60
        bcs     LAB5D
        jsr     LAD0D
        jmp     LAB60

LAB5D:  jsr     LACF9
LAB60:  lda     $19
        bne     LABCC
        lda     $043A
        beq     LAB8A
        lda     $040F
        cmp     #$05
        bcs     LAB75
        txa
        beq     LAB8A
        bne     LAB78
LAB75:  txa
        .byte   $D0
LAB77:  .byte   $12
LAB78:  lda     $043A
        pha
        dec     $043C
        bne     LAB84
        jsr     LABCD
LAB84:  pla
        ror     a
        bcc     LAB97
        bcs     LABAB
LAB8A:  lda     $1F
        sec
        sbc     $B6,x
        beq     LABB9
        bcs     LABA7
        cmp     #$FE
        bcs     LABB9
LAB97:  ldy     $01
        lda     LDC97,y
        sta     $D0
LAB9E:  jsr     LACE7
        dec     $D0
        bne     LAB9E
        beq     LABB9
LABA7:  cmp     #$03
        bcc     LABB9
LABAB:  ldy     $01
        lda     LDC97,y
        sta     $D0
LABB2:  jsr     LACF0
        dec     $D0
        bne     LABB2
LABB9:  lda     $1A
LABBB:  bne     LABCC
        jsr     LABE5
        lda     $1A
        bpl     LABCC
        lda     $0D
        and     #$1F
        ora     #$20
        sta     $B5,x
LABCC:  rts

LABCD:  lda     $23
        beq     LABE1
        lda     $0D
        and     #$01
        beq     LABE1
        lda     #$10
        sta     $043C
        lda     $043A
        eor     #$03
LABE1:  sta     $043A
        rts

LABE5:  lda     $058E
        beq     LABED
        jmp     LAC78

LABED:  lda     $1A
        bmi     LAC09
        lda     $B5,x
        beq     LABF9
        dec     $B5,x
        bne     LAC78
LABF9:  lda     $19
        bne     LAC78
        lda     $1A
        beq     LAC15
        tay
        cmp     #$05
        bcs     LAC0B
        txa
        beq     LAC0E
LAC09:  bne     LAC78
LAC0B:  txa
        beq     LAC78
LAC0E:  lda     $24,y
        and     #$60
        bne     LAC78
LAC15:  lda     $B6,x
        sec
        sbc     $1F
        rol     L000A
        bne     LAC28
        eor     #$FF
        adc     #$01
        cmp     #$0D
        bcc     LAC2C
        bcs     LAC78
LAC28:  cmp     #$0D
        bcs     LAC78
LAC2C:  lsr     a
        lsr     a
        sta     $0B
        lda     L000A
        and     #$01
        asl     a
        asl     a
        ora     $0B
        sta     $0B
        lda     $B7,x
        sec
        sbc     $21
        bcs     LAC45
        eor     #$FF
        adc     #$01
LAC45:  cmp     #$08
        bcs     LAC78
        lda     #$00
        sta     $0555
        txa
        lsr     a
        lsr     a
        sta     L000A
        lda     $1A
        beq     LAC5C
        lda     $0556
        bne     LAC61
LAC5C:  jsr     LAC79
        bcs     LAC78
LAC61:  lda     L000A
        ora     #$80
        sta     $1A
        lda     #$FF
        sta     $B5,x
        lda     $055A
        bne     LAC78
        lda     #$08
        sta     $0410
        sta     $0411
LAC78:  rts

LAC79:  txa
        pha
        lda     $23
        bne     LAC9C
        lda     $1A
        bne     LAC86
        lda     $040F
LAC86:  cmp     #$05
        lda     #$00
        rol     a
        eor     L000A
        beq     LACCC
        lda     $0434
        cmp     #$18
        bcs     LACCC
        lda     $0D
        and     #$03
        beq     LACCC
LAC9C:  lda     $055A
        bne     LACB2
        lda     $0D
        ror     a
        ror     a
        and     #$0F
        sta     $0B
        txa
        asl     a
        asl     a
        eor     #$10
        ora     $0B
        bpl     LACBC
LACB2:  ldy     $0B
        lda     LACDF,y
        clc
        adc     $1D
        and     #$1F
LACBC:  sta     $1D
        lsr     $1C
        lda     #$0D
        sta     $B5,x
        lda     #$02
        jsr     LD0D8
        sec
        bcs     LACD7
LACCC:  lda     $055A
        bne     LACD6
        lda     #$23
        .byte   $20
LACD4:  cld
        .byte   $D0
LACD6:  clc
LACD7:  lda     #$00
        sta     $04AD
        pla
        tax
        rts

LACDF:  bpl     LACED
        php
        .byte   $04
        bpl     LACF9
        clc
        .byte   $1C
LACE7:  lda     $B6,x
        cmp     #$68
        beq     LACEF
LACED:  dec     $B6,x
LACEF:  rts

LACF0:  lda     $B6,x
        cmp     #$97
        beq     LACF8
        inc     $B6,x
LACF8:  rts

LACF9:  txa
        bne     LAD04
        lda     $B7
        cmp     #$95
        bne     LAD0A
        beq     LAD0C
LAD04:  lda     $BB
        cmp     #$5B
        beq     LAD0C
LAD0A:  dec     $B7,x
LAD0C:  rts

LAD0D:  txa
        bne     LAD18
        lda     $B7
        cmp     #$A5
        bne     LAD1E
        beq     LAD20
LAD18:  lda     $BB
        cmp     #$6B
        beq     LAD20
LAD1E:  inc     $B7,x
LAD20:  rts

LAD21:  lda     $1A
        bpl     LAD2D
        lda     #$00
        sta     $BC
        sta     $B8
        beq     LAD5B
LAD2D:  bne     LAD5B
        lda     $1C
        bpl     LAD5B
        txa
        asl     a
        asl     a
        eor     $1D
        and     #$10
        bne     LAD5B
        lda     $1F
        cmp     #$40
        bcc     LAD5B
        cmp     #$C0
        bcs     LAD5B
        lda     $D4
        ror     a
        lda     $21
        bcc     LAD4F
        eor     #$FF
LAD4F:  cmp     #$60
        .byte   $90
LAD52:  php
        cmp     #$C0
        bcs     LAD5B
        lda     #$40
        sta     $B8,x
LAD5B:  lda     $19
        bne     LAD65
        lda     $B8,x
        beq     LAD65
        dec     $B8,x
LAD65:  lda     $1A
        bpl     LAD7B
        and     #$01
        tay
        lda     $B6,x
        sta     $1F
        lda     LADCA,y
        clc
        adc     $B7,x
        sta     $21
        jsr     LCC66
LAD7B:  ldy     #$03
LAD7D:  lda     $B6,x
        clc
        adc     LADCC,y
        sec
        sbc     $0574
        sta     $DC
        lda     $D4
        lsr     a
        bcs     LAD90
        lda     #$41
LAD90:  sta     $DE
        lda     $B7,x
        bcs     LAD9B
        adc     LADD0,y
        bne     LAD9F
LAD9B:  clc
        adc     LADD4,y
LAD9F:  sec
        sbc     $FD
        sta     $DF
        rol     a
        eor     $D4
        ror     a
        bcc     LADC6
        lda     $B8,x
        beq     LADB3
        lda     LADE0,y
        bne     LADC1
LADB3:  lda     $0D
        and     #$08
        bne     LADBE
        lda     LADD8,y
        bne     LADC1
LADBE:  lda     LADDC,y
LADC1:  sta     $DD
        jsr     L8AD8
LADC6:  dey
        bpl     LAD7D
        rts

LADCA:  sed
        php
LADCC:  .byte   $F2
        .byte   $F2
        .byte   $FA
        .byte   $FA
LADD0:  brk
        sed
        brk
        sed
LADD4:  sed
        brk
        sed
        brk
LADD8:  cmp     LDBDA,y
        .byte   $DC
LADDC:  cmp     LDFDE,x
        .byte   $E0
LADE0:  sbc     ($E2,x)
        .byte   $E3
        .byte   $E4
LADE4:  .byte   $20
        .byte   $7C
LADE6:  .byte   $B2
        jsr     LA9E7
        jsr     LB873
        ldx     #$08
LADEF:  lda     $24,x
        beq     LAE05
        jsr     LB2A3
        jsr     LB587
        jsr     LBBEC
        jsr     LBCC3
LADFF:  jsr     LBCF6
LAE02:  jmp     LAE08

LAE05:  jsr     LAE1E
LAE08:  dex
        bne     LADEF
        jsr     LB2CC
        jsr     LBF1A
        jsr     LB574
        jsr     LAF35
        jsr     LBAA1
        jsr     LAE49
        rts

LAE1E:  dec     $03A7,x
        bpl     LAE40
        inc     $039F,x
        lda     $039F,x
        and     #$07
        tay
        lda     LAE41,y
        pha
        and     #$3F
        sta     $03A7,x
        pla
        rol     a
        rol     a
        rol     a
        and     #$03
        clc
        adc     #$3B
        sta     $3C,x
LAE40:  rts

LAE41:  .byte   $7F
        jsr     L9070
        bvc     LADE6
        pla
        .byte   $65
LAE49:  lda     $1A
        beq     LAE83
        bmi     LAE52
        cmp     #$05
        rol     a
LAE52:  and     #$01
        cmp     $03B2
        beq     LAE83
        sta     $03B2
        tay
        ldx     #$08
LAE5F:  lda     $24,x
        and     #$02
        beq     LAE80
        tya
        pha
        lda     $0357,x
        tay
        lda     LD99C,y
        sta     $84,x
        lda     $A4,x
        sta     $8C,x
        pla
        tay
        lda     LAE84,y
        sta     $94,x
        lda     #$FF
        sta     $038F,x
LAE80:  dex
        bne     LAE5F
LAE83:  rts

LAE84:  rti

        .byte   $C0
LAE86:  jsr     LA9E1
        tay
        cpx     $1A
        beq     LAEAF
        txa
        cmp     $0442,y
        bne     LAEAF
        lda     $0444,y
        bne     LAEA9
        lda     $17,y
        bmi     LAEAF
        .byte   $B9
        .byte   $15
LAEA0:  brk
        bpl     LAEAF
        jsr     LAEBC
        jmp     LAEB8

LAEA9:  jsr     LAF0D
        jmp     LAEB8

LAEAF:  lda     $15,y
        and     #$0F
        tay
        lda     LAF2A,y
LAEB8:  jsr     LBB14
LAEBB:  rts

LAEBC:  tya
        eor     $1A
        bpl     LAEC4
        ror     a
        bcc     LAEDF
LAEC4:  sty     L000A
        lda     #$10
        sta     $0444,y
        lda     $15,y
        and     #$0F
        bne     LAED6
        lda     $44,x
        bpl     LAEDA
LAED6:  tay
        lda     LAF2A,y
LAEDA:  ldy     L000A
        jsr     LAEE0
LAEDF:  rts

LAEE0:  sta     $0B
        sty     L000A
        lda     $24,x
        bmi     LAF0C
        lda     $0B
        sta     $44,x
        lda     $74,x
        lsr     a
        lsr     a
        lsr     a
        lsr     a
        tay
        lda     LAF1A,y
        sta     $74,x
        lda     $44,x
        lsr     a
        lsr     a
        ora     #$A8
        sta     $3C,x
        lda     #$08
        sta     $034F,x
        ldy     L000A
        lda     $0B
        sta     $0446,y
LAF0C:  rts

LAF0D:  lda     $0444,y
        sec
        sbc     #$01
        sta     $0444,y
        lda     $0446,y
        rts

LAF1A:  bmi     LAF5C
        bvc     LAF7E
        bvs     LAEA0
        .byte   $80
        .byte   $80
        .byte   $80
        .byte   $80
        .byte   $80
        .byte   $80
        .byte   $80
        .byte   $80
        .byte   $80
        .byte   $80
LAF2A:  .byte   $FF
        php
        clc
        .byte   $FF
        bpl     LAF3C
        .byte   $14
        .byte   $FF
        brk
        .byte   $04
        .byte   $1C
LAF35:  lda     #$04
        sta     $D0
        lda     #$00
        .byte   $85
LAF3C:  cmp     ($A0),y
        php
LAF3F:  lda     $24,y
        beq     LAFAF
        and     #$E0
        bne     LAFAF
        ldx     #$04
LAF4A:  lda     $24,x
        beq     LAFAC
        and     #$E0
        bne     LAFAC
        lda     $A4,x
        sec
        sbc     $A4,y
        bcs     LAF5E
        eor     #$FF
LAF5C:  adc     #$01
LAF5E:  cmp     #$04
        bcs     LAFAC
        lda     $AC,x
        sec
        sbc     $AC,y
        bcs     LAF6E
        eor     #$FF
        adc     #$01
LAF6E:  cmp     #$08
        bcs     LAFAC
        stx     $D3
        sty     $D4
        jsr     LAFC2
        ldx     #$01
        lda     $1A
        .byte   $C5
LAF7E:  .byte   $D3
        beq     LAF86
        dex
        cmp     $D4
LAF84:  bne     LAFA5
LAF86:  lda     $0442,x
        cmp     $D3,x
        bne     LAF9F
        lda     $0444,x
        beq     LAF9F
        lda     $043D
        cmp     #$40
        bcc     LAFA8
        jsr     LB01C
        jmp     LAFA8

LAF9F:  jsr     LB009
        jmp     LAFA8

LAFA5:  jsr     LAFE5
LAFA8:  ldx     $D3
        ldy     $D4
LAFAC:  dex
        .byte   $D0
LAFAE:  .byte   $9B
LAFAF:  dey
        dec     $D0
        bne     LAF3F
        lda     $D1
        beq     LAFC1
        bpl     LAFBC
        lda     #$17
LAFBC:  lda     #$01
        jsr     LD0D8
LAFC1:  rts

LAFC2:  lda     #$00
        sta     $0B
        ldx     $D4
        jsr     LB0A8
        sta     $0448
        ldx     $D3
        jsr     LB0A8
        sta     $0449
        sec
        sbc     $0448
        bcs     LAFE0
        eor     #$FF
        adc     #$01
LAFE0:  rol     $0B
        sta     L000A
        rts

LAFE5:  lda     L000A
        cmp     #$0A
        bcs     LAFF6
        lda     $0B
        eor     #$01
        tax
        lda     $D3,x
        tax
        jsr     LB221
LAFF6:  ldx     $0B
        lda     $D3,x
        tax
        lda     L000A
        bne     LB005
        jsr     LB221
        jmp     LB008

LB005:  jsr     LB21A
LB008:  rts

LB009:  lda     L000A
        cmp     #$0A
        bcc     LB01B
        ldx     $0B
        lda     $D3,x
        tax
        jsr     LB21A
        lda     #$80
        sta     $D1
LB01B:  rts

LB01C:  lda     $D3,x
        tay
        txa
        eor     #$01
        tax
        lda     $D3,x
        tax
        lda     $AC,y
        sta     $94,y
        cmp     $AC,x
        bcs     LB048
        adc     #$05
        sta     $94,x
        lda     $3C,y
        and     #$F8
        ora     #$82
        sta     $3C,y
        lda     $3C,x
        and     #$F8
        ora     #$86
        sta     $3C,x
        bne     LB05E
LB048:  sbc     #$05
        sta     $94,x
        lda     $3C,y
        and     #$F8
        ora     #$06
        sta     $3C,y
        lda     $3C,x
        and     #$F8
        ora     #$02
        sta     $3C,x
LB05E:  lda     #$10
        sta     $034F,x
        sta     $034F,y
        lda     $A4,y
        clc
        adc     $A4,x
        lsr     a
        sta     $8C,y
        sta     $8C,x
        lda     #$80
        sta     $74,y
        sta     $74,x
        lda     #$00
        sta     $84,y
        sta     $84,x
        lda     $24,y
        ora     #$20
        sta     $24,y
LB088:  lda     $24,x
        ora     #$20
        sta     $24,x
        lda     #$A0
        sta     $037F,y
        sta     $037F,x
        lda     #$00
        sta     $BD
        sta     $0444
        sta     $0445
        lda     #$FF
        sta     $0450
        inc     $D1
        rts

LB0A8:  lda     $0387,x
        bne     LB0B7
        lda     $0357,x
        tay
        lda     LB0BF,y
        sta     $0387,x
LB0B7:  tay
        lda     LB0C1,y
        dec     $0387,x
        rts

LB0BF:  .byte   $02
        .byte   $03
LB0C1:  ora     (L0000,x)
        ora     L000A
LB0C5:  dec     $037F,x
        bmi     LB0D2
        bne     LB0CF
        jmp     LB153

LB0CF:  jmp     LB159

LB0D2:  lda     $037F,x
        and     #$7F
        beq     LB142
        jsr     LA9E1
        tay
        lda     $24,x
        and     #$08
        beq     LB0EE
        dec     $048A
        bpl     LB134
        jsr     LB15F
        jmp     LB0F8

LB0EE:  lda     $17,y
        bmi     LB134
        lda     $15,y
        bpl     LB134
LB0F8:  jsr     LB17E
        bcs     LB142
        lda     $0454
LB100:  cmp     #$02
        bcs     LB122
        lda     $0436
        beq     LB122
        lda     $0448
        clc
        adc     $0449
        cmp     #$1B
        bcc     LB134
        lda     $1A
        bmi     LB122
        lda     L0000
        bmi     LB122
        lda     $0D
        and     #$02
        beq     LB12C
LB122:  lda     #$80
        sta     $0448
        sta     $0449
        bne     LB134
LB12C:  lda     #$05
        sta     $058E
        jsr     L8376
LB134:  lda     $8C,x
        sta     L000A
        lda     $94,x
        sta     $0B
        jsr     LB73B
        jmp     LB15B

LB142:  lda     $0357,x
        tay
        lda     LD98D,y
        sta     $84,x
        lda     #$00
        sta     $037F,x
        sta     $0450
LB153:  lda     $24,x
        and     #$CF
        sta     $24,x
LB159:  lda     #$FF
LB15B:  jsr     LBB14
        rts

LB15F:  tya
        pha
        lda     $0489
        tay
        and     #$F8
        sta     $0489
        iny
        tya
        and     #$07
        ora     $0489
        sta     $0489
        tay
        lda     LD25D,y
        sta     $048A
        pla
        tay
        rts

LB17E:  sty     L000A
        stx     $0B
        tya
        eor     #$01
        tay
        lda     $0442,y
        tay
        lda     $AC,x
        cmp     $AC,y
        bcs     LB1A5
        adc     #$02
        sta     $94,x
        adc     #$05
        sta     $94,y
        lda     #$AA
        sta     $3C,x
        lda     #$06
        sta     $3C,y
        bne     LB1B7
LB1A5:  sbc     #$02
        sta     $94,x
        sbc     #$05
        sta     $94,y
        lda     #$AE
        sta     $3C,x
        lda     #$02
        sta     $3C,y
LB1B7:  lda     $8C,y
        clc
        adc     $8C,x
        ror     a
        sta     $8C,x
        sta     $8C,y
        lda     #$03
        sta     $034F,x
        sta     $034F,y
        lda     #$80
        sta     $74,x
        sta     $74,y
        lda     #$A0
        sta     $037F,x
        sta     $037F,y
        ldy     L000A
        lda     $0448,y
        clc
        adc     #$01
        sta     $0448,y
        pha
        tya
        eor     #$01
        tay
        pla
        bmi     LB1F7
        sec
        sbc     $0448,y
        bcc     LB211
        cmp     #$06
        bcc     LB211
LB1F7:  lda     $0442,y
        tax
        lda     $0357,x
        tay
        .byte   $B9
LB200:  sta     $95D9
        sty     $A9
        brk
        sta     $037F,x
        jsr     LB21A
        ldx     $0B
        sec
        bcs     LB219
LB211:  lda     #$23
        jsr     LD0D8
        ldx     $0B
        clc
LB219:  rts

LB21A:  jsr     LB233
        jsr     LB24E
        rts

LB221:  jsr     LB233
        jsr     LB25A
        lda     $44,x
        lsr     a
        lsr     a
        sta     $3C,x
        lda     #$10
        sta     $034F,x
        rts

LB233:  cpx     $1A
        bne     LB24D
        lda     #$00
        sta     $1A
        sta     $BD
        lda     #$40
        sta     $1C
        lda     $0D
        ror     a
        ror     a
        ror     a
        and     #$1F
        sta     $1D
        jsr     LB2B4
LB24D:  rts

LB24E:  jsr     LB25A
        lda     $44,x
        lsr     a
        lsr     a
        ora     #$A0
        sta     $3C,x
        rts

LB25A:  lda     $24,x
        and     #$4F
        ora     #$90
        sta     $24,x
        lda     #$01
        sta     $033F,x
        lda     #$30
        sta     $034F,x
        lda     #$70
        sta     $74,x
        cpx     #$05
        lda     $0D
        bcc     LB277
        ror     a
LB277:  and     #$1F
        sta     $44,x
        rts

LB27C:  lda     $19
        bne     LB2A2
        lda     $0D
        and     #$04
        tax
        lda     $03E7,x
        sta     $03EF
        lda     $03E9,x
        sta     $03F1
        txa
        lsr     a
        lsr     a
        eor     $06
        tax
        lda     $03,x
        tax
        lda     LD9F7,x
        sta     $03F0
        inc     $0C
LB2A2:  rts

LB2A3:  lda     $034F,x
        beq     LB2B3
        dec     $034F,x
        bne     LB2B3
        lda     $3C,x
        and     #$7F
        sta     $3C,x
LB2B3:  rts

LB2B4:  lda     $055A
        bne     LB2C1
        lda     #$04
        sta     $0410
        sta     $0411
LB2C1:  rts

        ldx     #$08
        lda     #$00
LB2C6:  sta     $2C,x
        dex
        bne     LB2C6
        rts

LB2CC:  ldy     #$01
LB2CE:  tya
        pha
        ldx     #$08
        lda     L0000
        bmi     LB2E0
        ror     a
        bcc     LB2DE
        tya
        eor     $06
        bne     LB2E0
LB2DE:  ldx     #$01
LB2E0:  stx     $047F
        lda     $0410,y
        beq     LB317
        ror     a
        bcc     LB2F1
        jsr     LB31D
        jmp     LB317

LB2F1:  ror     a
        bcc     LB2FA
        jsr     LB33F
        jmp     LB317

LB2FA:  ror     a
        bcc     LB303
        jsr     LB3BE
        jmp     LB317

LB303:  ror     a
        bcc     LB30C
        jsr     LB41B
        jmp     LB317

LB30C:  ror     a
        bcc     LB314
        jsr     LB45A
        lda     #$01
LB314:  jsr     LB481
LB317:  pla
        tay
        dey
        bpl     LB2CE
        rts

LB31D:  lda     $1A
        sta     $0442,y
        tax
        lda     #$00
        sta     $0410,y
        jsr     LB4BA
        tya
        asl     a
        asl     a
        adc     #$04
        tax
        ldy     #$04
LB333:  cpx     $1A
        beq     LB33A
        jsr     LB49A
LB33A:  dex
        dey
        bne     LB333
        rts

LB33F:  tya
        pha
        asl     a
        asl     a
        adc     #$04
        tax
        jsr     LB4E4
        ldy     #$04
LB34B:  lda     $D4,y
        tax
        lda     $24,x
        bne     LB356
        dey
        bne     LB34B
LB356:  txa
        pha
        jsr     LB4BA
        dey
LB35C:  lda     $D4,y
        tax
        lda     $24,x
        and     #$0B
        beq     LB389
        jsr     LB49A
        tya
        pha
        lda     $0357,x
        tay
        lda     LD99C,y
        sta     $84,x
        lda     $A4,x
        sta     $8C,x
        lda     #$C0
        cpx     #$05
        bcc     LB380
        lda     #$40
LB380:  sta     $94,x
        lda     #$FF
        sta     $038F,x
        pla
        tay
LB389:  dey
        bne     LB35C
        pla
        tax
        pla
        tay
        txa
        jsr     LB39A
        lda     #$20
        sta     $0410,y
        rts

LB39A:  cmp     $0442,y
        beq     LB3BD
        sta     $0442,y
        lda     $1F
        lsr     a
        sta     L000A
        lda     $22
        ror     a
        lda     $21
        ror     a
        sta     $0B
        tya
        pha
        jsr     LB73B
        sta     L000A
        pla
        tay
        lda     L000A
        jsr     LAEE0
LB3BD:  rts

LB3BE:  lda     $15,y
        asl     a
        bpl     LB3F2
        lda     $17,y
        asl     a
        bmi     LB3F2
        lda     $0444,y
        bne     LB3F2
        tya
        pha
        asl     a
        asl     a
        adc     #$04
        tax
        jsr     LB4E4
        ldy     #$04
LB3DB:  lda     $D4,y
        tax
        lda     $24,x
        bne     LB3E6
        dey
        bne     LB3DB
LB3E6:  jsr     LB4BA
        pla
        tay
        txa
        jsr     LB39A
        jmp     LB41A

LB3F2:  tya
        ora     #$0E
        eor     $0D
        and     #$0F
        bne     LB41A
        tya
        asl     a
        asl     a
        adc     #$04
        tax
        jsr     LB4E4
        ldy     #$04
LB406:  lda     $D4,y
        tax
        lda     $24,x
        beq     LB412
        and     #$09
        beq     LB417
LB412:  dey
        bne     LB406
        beq     LB41A
LB417:  jsr     LB4BA
LB41A:  rts

LB41B:  lda     $0D
        and     #$1F
        bne     LB459
        tya
        pha
        asl     a
        asl     a
        adc     #$04
        tax
        jsr     LB4E4
        ldy     #$00
LB42D:  lda     $D5,y
        tax
        lda     $24,x
        and     #$09
        bne     LB43F
LB437:  iny
        cpy     #$04
        bne     LB42D
        sec
        bcs     LB450
LB43F:  txa
        pha
        jsr     LA9E1
LB444:  tax
        pla
        cmp     $0442,x
        beq     LB437
        tax
        jsr     LB49A
        clc
LB450:  pla
        bcc     LB459
        tay
        lda     #$20
        sta     $0410,y
LB459:  rts

LB45A:  lda     $0442,y
        sta     L000A
        tya
        pha
        asl     a
        asl     a
        adc     #$04
        tax
        ldy     #$04
LB468:  cpx     L000A
        beq     LB472
        jsr     LB49A
        jmp     LB475

LB472:  jsr     LB4BA
LB475:  dex
        dey
        bne     LB468
        pla
        tay
        lda     #$20
        sta     $0410,y
        rts

LB481:  lda     $0444,y
        bne     LB499
        lda     $15,y
        and     #$40
        beq     LB499
        lda     $17,y
        and     #$40
        bne     LB499
        lda     #$02
        sta     $0410,y
LB499:  rts

LB49A:  lda     $24,x
        and     #$09
        beq     LB4B9
        tya
        pha
        lda     $24,x
        and     #$F0
        ora     #$02
        sta     $24,x
        lda     $0357,x
        tay
        lda     LD990,y
        sta     $84,x
        lda     #$FF
        sta     $9C,x
        pla
        tay
LB4B9:  rts

LB4BA:  tya
        pha
        lda     $24,x
        and     #$04
        beq     LB4CF
        txa
        pha
        lda     $2C,x
        tax
        dec     $2C,x
        pla
        tax
        lda     #$00
        sta     $2C,x
LB4CF:  lda     $24,x
        and     #$F0
        ora     $047F
        sta     $24,x
        lda     $0357,x
        tay
        lda     LD98D,y
        sta     $84,x
        pla
        tay
        rts

LB4E4:  txa
        pha
        lda     $1F
        lsr     a
        sta     L000A
        lda     $22
        ror     a
        lda     $21
        ror     a
        sta     $0B
        ldy     #$04
LB4F5:  lda     #$00
        cpx     $1A
        beq     LB51E
        lda     $A4,x
        sec
        sbc     L000A
        bcs     LB506
        eor     #$FF
        adc     #$01
LB506:  lsr     a
        sta     $D0,y
        lda     $AC,x
        sec
        sbc     $0B
        bcs     LB515
        eor     #$FF
        adc     #$01
LB515:  lsr     a
        clc
        adc     $D0,y
        bne     LB51E
        lda     #$01
LB51E:  sta     $D0,y
        dex
        dey
        bne     LB4F5
        jsr     LB54B
        stx     $D8
        jsr     LB54B
        stx     $D7
        jsr     LB54B
        stx     $D6
        jsr     LB54B
        stx     $D5
        pla
        and     #$08
        beq     LB54A
        ldx     #$04
LB540:  lda     $D4,x
        clc
        adc     #$04
        sta     $D4,x
        dex
        bne     LB540
LB54A:  rts

LB54B:  ldx     #$04
        lda     $D4
        cmp     $D3
        bcs     LB55B
        cmp     $D2
        bcs     LB566
        cmp     $D1
        bcc     LB56F
LB55B:  dex
        lda     $D3
        cmp     $D2
        bcs     LB566
        cmp     $D1
        bcc     LB56F
LB566:  ldx     #$02
        lda     $D2
        cmp     $D1
        bcc     LB56F
        dex
LB56F:  lda     #$FF
        sta     $D0,x
        rts

LB574:  ldx     #$08
LB576:  lda     $54,x
        lsr     a
        sta     $A4,x
        lda     $6C,x
        ror     a
        lda     $64,x
        ror     a
        sta     $AC,x
        dex
        bne     LB576
        rts

LB587:  lda     $24,x
        rol     a
        bcc     LB592
        jsr     LB5CE
        jmp     LB5CD

LB592:  rol     a
        bcc     LB59B
        jsr     LB5E5
        jmp     LB5CD

LB59B:  rol     a
        bcc     LB5A4
        jsr     LB0C5
        jmp     LB5CD

LB5A4:  rol     a
        bcc     LB5AC
        pha
        jsr     LB7C7
        pla
LB5AC:  rol     a
        bcc     LB5B5
        jsr     LD1AE
        jmp     LB5CD

LB5B5:  rol     a
        bcc     LB5BE
        jsr     LBA57
        jmp     LB5CD

LB5BE:  rol     a
        bcc     LB5C7
        jsr     LB7D3
        jmp     LB5CD

LB5C7:  rol     a
        bcc     LB5CD
        jsr     LAE86
LB5CD:  rts

LB5CE:  lda     #$FF
        jsr     LBB14
        lda     $034F,x
        bne     LB5E4
        lda     $24,x
        and     #$4F
        sta     $24,x
        lda     $3C,x
        and     #$07
        sta     $3C,x
LB5E4:  rts

LB5E5:  txa
        pha
        lda     $8C,x
        tay
        lda     $94,x
        tax
        jsr     LB664
        sta     L000A
        pla
        tax
        pha
        lda     $A4,x
        tay
        lda     $AC,x
        tax
        jsr     LB664
        asl     a
LB5FF:  asl     a
        asl     a
        ora     L000A
        tay
        pla
        tax
        lda     #$50
        sta     L000A
        lda     #$B6
        sta     $0B
        lda     LB618,y
        jsr     L8359
        jsr     LBB14
        rts

LB618:  brk
        .byte   $04
        ora     $01
        ora     ($01,x)
        ora     ($FF,x)
        ora     #$00
        .byte   $03
        php
        php
        php
        php
        .byte   $FF
        ora     #$03
        brk
        php
        php
        php
        php
        .byte   $FF
        .byte   $02
        asl     $07
        brk
        .byte   $04
        ora     $01
        .byte   $FF
        ora     #$09
        ora     #$09
        brk
        .byte   $03
        php
        .byte   $FF
        ora     #$09
        ora     #$09
        .byte   $03
        brk
        php
        .byte   $FF
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        asl     $07
        brk
        .byte   $FF
        .byte   $AF
        ldx     $BB,y
        ldx     $D8,y
        ldx     $F5,y
        ldx     $01,y
        .byte   $B7
        asl     $1BB7
        .byte   $B7
        plp
        .byte   $B7
        and     $B7,x
        sec
        .byte   $B7
LB664:  cpy     #$50
        bcs     LB688
        cpy     #$30
        bcs     LB67E
        cpx     #$21
        bcc     LB69A
        cpx     #$38
        bcc     LB69D
        cpx     #$C8
        bcc     LB6A3
        cpx     #$E1
        bcc     LB6A6
        bcs     LB6AC
LB67E:  cpx     #$2C
        bcc     LB69A
        cpx     #$D5
        bcc     LB6A3
        bcs     LB6AC
LB688:  cpx     #$21
        bcc     LB69A
        cpx     #$38
        bcc     LB6A0
        cpx     #$C8
        bcc     LB6A3
        cpx     #$E1
        bcc     LB6A9
        bcs     LB6AC
LB69A:  lda     #$00
        rts

LB69D:  lda     #$01
        rts

LB6A0:  lda     #$02
        rts

LB6A3:  lda     #$03
        rts

LB6A6:  lda     #$04
        rts

LB6A9:  lda     #$05
        rts

LB6AC:  lda     #$06
        rts

        lda     $8C,x
        sta     L000A
        lda     $94,x
        sta     $0B
        jsr     LB73B
        rts

        lda     $54,x
        cmp     #$50
        bcc     LB6C5
        cmp     #$B0
        bcc     LB6C8
LB6C5:  jmp     LB735

LB6C8:  lda     $44,x
        cmp     #$08
        bcc     LB6D2
        cmp     #$18
        bcc     LB6D5
LB6D2:  jmp     LB701

LB6D5:  jmp     LB70E

        lda     $54,x
        cmp     #$50
        bcc     LB6E2
        cmp     #$B0
        bcc     LB6E5
LB6E2:  jmp     LB738

LB6E5:  lda     $44,x
        cmp     #$08
        bcc     LB6EF
        cmp     #$18
        bcc     LB6F2
LB6EF:  jmp     LB71B

LB6F2:  jmp     LB728

        lda     $44,x
        cmp     #$10
        bcs     LB6FE
        jmp     LB735

LB6FE:  jmp     LB738

LB701:  lda     $54,x
        cmp     #$50
        bcc     LB70B
        lda     #$00
        beq     LB70D
LB70B:  lda     #$08
LB70D:  rts

LB70E:  lda     $54,x
        cmp     #$B0
        bcs     LB70B
        lda     #$10
        bne     LB71A
        lda     #$00
LB71A:  rts

LB71B:  lda     $54,x
        cmp     #$50
        bcc     LB725
        lda     #$00
        beq     LB727
LB725:  lda     #$18
LB727:  rts

LB728:  lda     $54,x
        cmp     #$B0
        bcs     LB732
        lda     #$10
        bne     LB734
LB732:  lda     #$18
LB734:  rts

LB735:  lda     #$08
        rts

LB738:  lda     #$18
        rts

LB73B:  lda     $AC,x
        sec
        sbc     $0B
        bcs     LB764
        eor     #$FF
        adc     #$01
        pha
        .byte   $B5
LB748:  ldy     $38
        sbc     L000A
        bcc     LB757
        sta     $D2
        pla
        sta     $D1
        ldy     #$00
        beq     LB780
LB757:  eor     #$FF
        adc     #$01
        sta     $D1
        pla
        sta     $D2
        ldy     #$08
        bne     LB780
LB764:  pha
        lda     $A4,x
        sec
        sbc     L000A
        bcs     LB779
        eor     #$FF
        adc     #$01
        sta     $D2
        pla
        sta     $D1
        ldy     #$10
        bne     LB780
LB779:  sta     $D1
        pla
        sta     $D2
        ldy     #$18
LB780:  lda     $D1
        cmp     $D2
        bcs     LB79F
        jsr     LA9B4
        cmp     #$1A
        bcc     LB7C3
        iny
        cmp     #$4E
        bcc     LB7C3
        iny
        cmp     #$89
        bcc     LB7C3
        iny
        cmp     #$D3
        bcc     LB7C3
        iny
        bne     LB7C3
LB79F:  pha
        lda     $D2
        sta     $D1
        pla
        sta     $D2
        tya
        clc
        adc     #$08
        tay
        jsr     LA9B4
        cmp     #$1A
        bcc     LB7C3
        dey
        cmp     #$4E
        bcc     LB7C3
        dey
        cmp     #$89
        bcc     LB7C3
        dey
        cmp     #$D3
        bcc     LB7C3
        dey
LB7C3:  tya
        and     #$1F
        rts

LB7C7:  dec     $033F,x
        bne     LB7D2
        lda     $24,x
        and     #$EF
        sta     $24,x
LB7D2:  rts

LB7D3:  lda     $038F,x
        beq     LB7DE
        jsr     LB849
        jmp     LB848

LB7DE:  lda     $0367,x
        beq     LB7F6
        dec     $0367,x
        lda     $0D
        lsr     a
        and     #$08
        jsr     LBBB4
        lda     #$FF
        jsr     LBB14
        jmp     LB848

LB7F6:  jsr     LA9E1
        eor     $03B2
        bne     LB802
        lda     #$80
        bne     LB804
LB802:  lda     #$00
LB804:  sta     $03B5
        lda     $9C,x
        bpl     LB828
        cmp     #$FF
        bne     LB81A
        jsr     LB89B
        bcc     LB83F
        jsr     LB5E5
        jmp     LB848

LB81A:  jsr     LB5E5
        lda     #$04
        sta     $0B
        jsr     LB915
        bcs     LB848
        bcc     LB844
LB828:  lda     $8C,x
        sta     L000A
        lda     $94,x
        sta     $0B
        jsr     LB73B
        jsr     LBB14
        lda     #$04
        sta     $0B
        jsr     LB915
        bcs     LB848
LB83F:  jsr     LB9A7
        bcc     LB848
LB844:  lda     #$FF
        sta     $9C,x
LB848:  rts

LB849:  jsr     LB5E5
        lda     $94,x
        sec
        sbc     $AC,x
        bcs     LB857
        eor     #$FF
        adc     #$01
LB857:  cmp     #$08
        bcc     LB860
        dec     $038F,x
        bne     LB872
LB860:  lda     #$00
        sta     $038F,x
        lda     $0357,x
        tay
        lda     LD990,y
        sta     $84,x
        lda     #$FF
        sta     $9C,x
LB872:  rts

LB873:  lda     $1F
        ldy     #$00
        cmp     #$50
        bcc     LB889
        ldy     #$08
        cmp     #$80
        bcc     LB889
        ldy     #$10
        cmp     #$B0
        bcc     LB889
        ldy     #$18
LB889:  sty     L000A
        lda     $22
        ror     a
        lda     $21
        rol     a
        rol     a
        rol     a
        and     #$07
        ora     L000A
        sta     $03B4
        rts

LB89B:  jsr     LA9E1
        eor     $06
        pha
        lda     $03B5
        rol     a
        pla
        rol     a
        asl     a
        asl     a
        sta     $0544
        tay
        lda     $0534,y
        sta     L000A
        lda     $0535,y
        sta     $0B
        lda     #$00
        sta     $BE
        jsr     LB8F0
        rol     $BE
        lsr     a
        tay
        lda     (L000A),y
        bcc     LB8CA
        lsr     a
        lsr     a
        lsr     a
        lsr     a
LB8CA:  and     #$0F
        sta     $0B
        tya
        lsr     a
        and     #$10
        ora     $0B
        pha
        jsr     LB901
        lda     #$08
        sta     $0B
        jsr     LB915
        pla
        sta     $9C,x
        bcc     LB8EB
        ora     #$80
        sta     $9C,x
        sec
        bne     LB8EF
LB8EB:  jsr     LB932
        clc
LB8EF:  rts

LB8F0:  lda     $035F,x
        lsr     a
        ror     a
        ror     a
        ror     a
        ora     $03B4
        cpx     #$05
        bcc     LB900
        eor     #$07
LB900:  rts

LB901:  asl     a
        tay
        lda     LB967,y
        sta     $8C,x
        lda     $BE
        ror     a
        lda     LB968,y
        bcc     LB912
        eor     #$FF
LB912:  sta     $94,x
        rts

LB915:  lda     $8C,x
        sec
        sbc     $A4,x
        bcs     LB920
        eor     #$FF
        adc     #$01
LB920:  cmp     $0B
        bcs     LB931
        lda     $94,x
        sec
        sbc     $AC,x
        bcs     LB92F
        eor     #$FF
        adc     #$01
LB92F:  cmp     $0B
LB931:  rts

LB932:  asl     a
        asl     a
        sta     $0B
        lda     $0D
        and     #$03
        ora     $0B
        pha
        ldy     $0544
        lda     $0536,y
        sta     L000A
        lda     $0537,y
        sta     $0B
        pla
        tay
        lda     (L000A),y
        asl     a
        tay
        rol     a
        and     #$01
        sta     $0397,x
        txa
        asl     a
        tax
        lda     $0700,y
        sta     $BD,x
        lda     $0701,y
        sta     $BE,x
        txa
        lsr     a
        tax
        rts

LB967:  .byte   $1C
LB968:  .byte   $1C
        .byte   $1C
        bmi     LB988
        bvc     LB98A
        bvs     LB98C
        .byte   $8F
        .byte   $1C
        .byte   $AF
        .byte   $1C
        .byte   $CF
        .byte   $1C
        .byte   $E3
        .byte   $34
        .byte   $1C
        .byte   $34
        .byte   $3C
        .byte   $34
        bvc     LB9B2
        bvs     LB9B4
        .byte   $8F
        .byte   $34
        .byte   $AF
        .byte   $34
        .byte   $C3
        .byte   $34
        .byte   $E3
        .byte   $4B
LB988:  .byte   $1C
        .byte   $4B
LB98A:  .byte   $3C
        .byte   $4B
LB98C:  bvc     LB9D9
        bvs     LB9DB
        .byte   $8F
        .byte   $4B
        .byte   $AF
        .byte   $4B
        .byte   $C3
        .byte   $4B
        .byte   $E3
        .byte   $63
        .byte   $1C
        .byte   $63
        bmi     LB9FF
        bvc     LBA01
        bvs     LBA03
        .byte   $8F
        .byte   $63
        .byte   $AF
        .byte   $63
        .byte   $CF
        .byte   $63
        .byte   $E3
LB9A7:  stx     L000A
        txa
        asl     a
        tax
        lda     ($BD,x)
        inc     $BD,x
        bne     LB9B4
LB9B2:  inc     $BE,x
LB9B4:  ldx     L000A
        pha
        and     #$F0
        cmp     #$80
LB9BB:  bne     LB9D1
        lda     #$0F
        sta     L000A
        lda     #$BA
        sta     $0B
        pla
        and     #$0F
        sec
        beq     LBA0E
        jsr     L8359
        jmp     LBA0D

LB9D1:  lsr     a
        lsr     a
        cmp     #$20
        bcc     LB9D9
        ora     #$C0
LB9D9:  sta     $0B
LB9DB:  pla
        and     #$0F
        asl     a
        asl     a
        cmp     #$20
        bcc     LB9E6
        ora     #$C0
LB9E6:  pha
        lda     $9C,x
        and     #$10
        beq     LB9F6
        lda     $0B
        eor     #$FF
        clc
        adc     #$01
        sta     $0B
LB9F6:  cpx     #$05
        bcc     LBA00
        pla
        eor     #$FF
        adc     #$00
LB9FF:  pha
LBA00:  .byte   $B5
LBA01:  .byte   $8C
        clc
LBA03:  adc     $0B
        sta     $8C,x
        pla
        clc
        adc     $94,x
        sta     $94,x
LBA0D:  clc
LBA0E:  rts

        asl     $2FBA
        tsx
        .byte   $42
        tsx
        asl     $0EBA
        tsx
        asl     $0EBA
        tsx
        asl     $0EBA
        tsx
        asl     $0EBA
        tsx
        asl     $0EBA
        tsx
        asl     $0EBA
        tsx
        asl     L8ABA
        sta     L000A
        asl     a
        tax
        lda     ($BD,x)
        inc     $BD,x
        bne     LBA3C
        inc     $BE,x
LBA3C:  ldx     L000A
        sta     $0367,x
        rts

        txa
        sta     L000A
LBA45:  asl     a
        tax
        lda     ($BD,x)
        inc     $BD,x
        bne     LBA4F
        inc     $BE,x
LBA4F:  ldx     L000A
        clc
        adc     $84,x
        sta     $84,x
        rts

LBA57:  lda     $0450
        bne     LBA8C
        lda     $2C,x
        tay
        lda     $A4,y
        sta     $8C,x
        lda     $AC,y
        sta     $94,x
        dec     $0347,x
        beq     LBA8C
        lda     $8C,x
        sec
        sbc     $A4,x
        bcs     LBA79
        eor     #$FF
        adc     #$01
LBA79:  cmp     #$10
        bcs     LBA9D
        lda     $94,x
        sec
        sbc     $AC,x
        bcs     LBA88
        eor     #$FF
        adc     #$01
LBA88:  cmp     #$10
        bcs     LBA9D
LBA8C:  lda     #$02
        sta     $24,x
        lda     $0357,x
        tay
        lda     LD990,y
        sta     $84,x
        lda     #$FF
LBA9B:  sta     $9C,x
LBA9D:  jsr     LB5E5
        rts

LBAA1:  lda     $0D
        ora     $0450
        bne     LBB13
        .byte   $A9
LBAA9:  .byte   $04
LBAAA:  sta     $D0
        ldy     $1A
        beq     LBB13
        bmi     LBB13
        cpy     #$05
        bcs     LBADB
        ldx     #$05
LBAB8:  lda     $24,x
        .byte   $F0
LBABB:  clc
        and     #$ED
        bne     LBAD4
        lda     $24,x
        and     #$02
        beq     LBACB
        lda     $0397,x
        bne     LBAD4
LBACB:  lda     $AC,y
        cmp     $AC,x
        beq     LBAD4
        bcs     LBAFE
LBAD4:  inx
        dec     $D0
        bne     LBAB8
        beq     LBB13
LBADB:  ldx     #$01
LBADD:  lda     $24,x
        beq     LBAF7
        and     #$ED
        bne     LBAF7
        lda     $24,x
        and     #$02
        beq     LBAF0
        lda     $0397,x
        bne     LBAF7
LBAF0:  lda     $AC,y
        cmp     $AC,x
        bcc     LBAFE
LBAF7:  inx
        dec     $D0
        bne     LBADD
        beq     LBB13
LBAFE:  lda     #$04
        sta     $24,x
        tya
        sta     $2C,x
        lda     #$00
        sta     $0347,x
        lda     $0357,x
        tay
        lda     LD993,y
        sta     $84,x
LBB13:  rts

LBB14:  cmp     #$FF
        beq     LBB28
        sec
        sbc     $44,x
        bne     LBB2F
        lda     $84,x
        beq     LBB28
        lda     #$80
        sta     $34,x
        jmp     LBB55

LBB28:  lda     #$81
        sta     $34,x
        jmp     LBB55

LBB2F:  and     #$1F
        cmp     #$09
        bcs     LBB3C
        lda     #$40
        sta     $34,x
        jmp     LBB55

LBB3C:  cmp     #$18
        bcc     LBB47
        lda     #$41
        sta     $34,x
        jmp     LBB55

LBB47:  cmp     #$10
        bne     LBB4E
        lda     $4C,x
        ror     a
LBB4E:  rol     a
        and     #$01
        ora     #$20
        sta     $34,x
LBB55:  jsr     LBB59
        rts

LBB59:  lda     $3C,x
        bmi     LBB6F
        lsr     a
        lsr     a
        and     #$0E
        tay
        lda     LBB70,y
        sta     L000A
        lda     LBB71,y
        sta     $0B
        jsr     L836E
LBB6F:  rts

LBB70:  .byte   $80
LBB71:  .byte   $BB
        sta     LAEBB,x
        .byte   $BB
        ldx     LAEBB
        .byte   $BB
        ldx     LAEBB
        .byte   $BB
        .byte   $6F
        .byte   $BB
LBB80:  lda     $7C,x
        and     #$08
        beq     LBB99
        lda     #$00
        sta     $7C,x
        cpx     $1A
        bne     LBB97
        txa
        pha
        lda     #$22
        jsr     LD0D8
        pla
        tax
LBB97:  lda     #$08
LBB99:  jsr     LBBB4
        rts

        ldy     #$08
        tya
        and     $7C,x
        beq     LBBA9
        lda     #$00
        tay
        sta     $7C,x
LBBA9:  tya
        jsr     LBBB4
        rts

        lda     #$00
        jsr     LBBB4
        rts

LBBB4:  sta     $3C,x
        lda     $44,x
        lsr     a
        lsr     a
        .byte   $E4
LBBBB:  .byte   $1A
        bne     LBBE7
        ldy     $055A
        beq     LBBC5
        lda     #$02
LBBC5:  pha
        lda     $0D
        and     #$0F
        bne     LBBD9
LBBCC:  lda     $04A4
        bpl     LBBD6
        lda     #$02
        sta     $04A4
LBBD6:  dec     $04A4
LBBD9:  lda     $74,x
        bne     LBBE0
LBBDD:  .byte   $8D
LBBDE:  ldy     $04
LBBE0:  pla
        clc
        adc     $04A4
        and     #$07
LBBE7:  ora     $3C,x
        sta     $3C,x
        rts

LBBEC:  .byte   $B5
LBBED:  .byte   $34
LBBEE:  rol     a
        bcc     LBBF7
        jsr     LBC0D
        jmp     LBC0C

LBBF7:  rol     a
        bcc     LBC00
        jsr     LBC55
        jmp     LBC0C

LBC00:  rol     a
        bcc     LBC09
        jsr     LBCA4
        jmp     LBC0C

LBC09:  rol     a
        bcc     LBC0C
LBC0C:  rts

LBC0D:  lda     $34,x
        ror     a
        bcs     LBC36
        lda     $74,x
        cmp     $84,x
        beq     LBC2F
        bcs     LBC36
        lda     $24,x
        and     #$0F
        tay
        lda     LBC3F,y
        tay
        lda     LBC49,y
        clc
        adc     $74,x
        cmp     $84,x
        bcc     LBC2F
        lda     $84,x
LBC2F:  sta     $74,x
        inc     $7C,x
        jmp     LBC3E

LBC36:  lda     $74,x
        sbc     #$02
        bcc     LBC3E
        sta     $74,x
LBC3E:  rts

LBC3F:  brk
        php
        brk
        brk
        .byte   $04
        brk
        brk
        brk
        php
        php
LBC49:  php
        .byte   $04
        bpl     LBC4D
LBC4D:  jsr     L8018
        brk
        clc
        bpl     LBC74
        brk
LBC55:  lda     $84,x
        sta     L000A
        lda     $24,x
        and     #$09
        bne     LBC61
        lsr     L000A
LBC61:  lda     L000A
        cmp     $74,x
        bcc     LBC83
        lda     $24,x
        and     #$0F
        tay
        lda     LBC3F,y
        tay
        lda     LBC49,y
        clc
LBC74:  adc     $74,x
        cmp     L000A
        bcc     LBC7C
        lda     L000A
LBC7C:  sta     $74,x
        inc     $7C,x
        jmp     LBC8C

LBC83:  lda     $74,x
        sec
        sbc     #$02
        bcc     LBC83
        sta     $74,x
LBC8C:  lda     $0D
        and     #$03
        bne     LBCA3
        lda     $34,x
        ror     a
        bcs     LBC9B
        inc     $44,x
        bcc     LBC9D
LBC9B:  dec     $44,x
LBC9D:  lda     $44,x
        and     #$1F
        sta     $44,x
LBCA3:  rts

LBCA4:  lda     #$00
        sta     $74,x
        lda     $34,x
        ror     a
        bcs     LBCB9
        lda     $44,x
        clc
        adc     #$08
        and     #$1F
        sta     $44,x
        jmp     LBCC2

LBCB9:  lda     $44,x
        clc
        adc     #$F8
        and     #$1F
        sta     $44,x
LBCC2:  rts

LBCC3:  lda     $055A
        bne     LBCD0
        lda     $BD
        beq     LBCD0
        cpx     $1A
        beq     LBCF5
LBCD0:  jsr     LCFB3
        lda     $74,x
        lsr     a
        lsr     a
        lsr     a
        lsr     a
        ldy     $44,x
        jsr     LCF4E
        jsr     LCFC8
        lda     $055A
        beq     LBCF5
        lda     $24,x
        and     #$09
        beq     LBCF5
        lda     $055C
        sta     $64,x
        lda     #$01
        sta     $6C,x
LBCF5:  rts

LBCF6:  lda     $24,x
        bne     LBCFD
        jmp     LBDC6

LBCFD:  stx     $0B
        .byte   $B5
LBD00:  .byte   $54
        ror     a
        ror     a
        and     #$20
        sta     $D1
        lda     $6C,x
        ror     a
        ror     a
        ror     a
        ror     a
        and     #$20
        sta     $D2
        lda     $54,x
        bmi     LBD17
        eor     #$FF
LBD17:  and     #$7F
        sta     $D3
        lda     $6C,x
        ror     a
        lda     $64,x
        bcs     LBD24
        eor     #$FF
LBD24:  sta     $D4
        lda     $D3
        sec
        sbc     #$30
        bcs     LBD2F
        lda     #$00
LBD2F:  tay
        sta     L000A
        lda     $D4
        sec
        sbc     #$B0
        bcs     LBD3B
        lda     #$00
LBD3B:  tax
        cmp     L000A
        bcs     LBD56
        cpx     #$20
        bcc     LBD46
        ldx     #$1F
LBD46:  tya
        cmp     LBE07,x
        bcc     LBD6C
        txa
        ora     $D1
        tax
        lda     LBDC7,x
        jmp     LBDB6

LBD56:  cpy     #$20
        bcc     LBD5C
        ldy     #$1F
LBD5C:  txa
        cmp     LBE07,y
        bcc     LBD6C
        tya
        ora     $D2
        tax
        lda     LBDC7,x
        jmp     LBDBD

LBD6C:  lda     $D4
        cmp     #$B0
        bcs     LBD8E
        sbc     #$97
        bcc     LBDC4
        sta     L000A
        lda     #$20
        sbc     $D3
        bcc     LBDC4
        cmp     L000A
        bcc     LBDAC
        lda     $D2
        beq     LBD8A
        lda     #$98
        bne     LBDBD
LBD8A:  lda     #$67
        bne     LBDBD
LBD8E:  lda     #$C0
        sbc     $D4
        bcc     LBDC4
        sta     L000A
        lda     #$20
        sbc     $D3
        bcc     LBDC4
        cmp     L000A
        bcc     LBDAC
        lda     $D2
        beq     LBDA8
        lda     #$C0
        bne     LBDBD
LBDA8:  lda     #$3F
        bne     LBDBD
LBDAC:  lda     $D1
        bne     LBDB4
        lda     #$5F
        bne     LBDB6
LBDB4:  lda     #$A0
LBDB6:  ldx     $0B
        sta     $54,x
        jmp     LBDC6

LBDBD:  ldx     $0B
        sta     $64,x
        jmp     LBDC6

LBDC4:  ldx     $0B
LBDC6:  rts

LBDC7:  and     $25
        and     $25
        and     $25
        and     $26
        rol     $26
        rol     $27
        .byte   $27
        .byte   $27
        plp
        plp
        plp
        and     #$29
        rol     a
        rol     a
        .byte   $2B
        .byte   $2B
        bit     $2D2D
        rol     $302F
        and     ($32),y
        .byte   $33
        .byte   $DA
        .byte   $DA
        .byte   $DA
        .byte   $DA
        .byte   $DA
        .byte   $DA
        .byte   $DA
        cmp     LD9D9,y
        cmp     LD8D8,y
        cld
        .byte   $D7
        .byte   $D7
        .byte   $D7
        dec     $D6,x
        cmp     $D5,x
        .byte   $D4
        .byte   $D4
        .byte   $D3
        .byte   $D2
        .byte   $D2
        cmp     ($D0),y
        .byte   $CF
        dec     LCCCD
LBE07:  rol     a
        rol     a
        rol     a
        rol     a
        rol     a
        rol     a
        rol     a
        and     #$29
        and     #$29
        plp
        plp
        plp
        .byte   $27
        .byte   $27
        .byte   $27
        rol     $26
        and     $25
        bit     $24
        .byte   $23
        .byte   $22
        .byte   $22
        and     (L0020,x)
        .byte   $1F
        asl     $1C1D,x
LBE27:  lda     $1C
        and     #$F0
        bne     LBE30
        sta     $0555
LBE30:  lda     $1A
        rol     a
        bcs     LBE3D
        lda     $23
        beq     LBE3F
        lda     $1C
        cmp     #$E0
LBE3D:  bcs     LBEB5
LBE3F:  lda     $1F
        lsr     a
        sta     L000A
        lda     $22
        ror     a
        lda     $21
        ror     a
        sta     $0B
        ldx     #$08
LBE4E:  lda     $0555
        beq     LBE5D
        jsr     LA9E1
        ora     #$80
        eor     $0555
        beq     LBEAD
LBE5D:  lda     $24,x
        beq     LBEAD
        and     #$10
        bne     LBEAD
        lda     $0357,x
        asl     a
        sta     $D1
        jsr     LA9E1
        eor     $03B2
        ora     $D1
        tay
        lda     $A4,x
        sec
        sbc     L000A
        bcs     LBE82
        cmp     LDCDC,y
        bcs     LBE87
        bcc     LBEAD
LBE82:  cmp     LDCE2,y
        bcs     LBEAD
LBE87:  lda     $AC,x
        sec
        sbc     $0B
        bcs     LBE95
        cmp     LDCE8,y
        bcs     LBE9A
        bcc     LBEAD
LBE95:  cmp     LDCEE,y
        bcs     LBEAD
LBE9A:  lda     #$00
        sta     $0555
        jsr     LBEB6
        bcs     LBEB3
        lda     #$10
        sta     $033F,x
        ora     $24,x
        sta     $24,x
LBEAD:  dex
        bne     LBE4E
        clc
        bcc     LBEB5
LBEB3:  stx     $1A
LBEB5:  rts

LBEB6:  jsr     LA9E1
        eor     $03B2
        sec
        beq     LBEF9
        lda     $04AD
        bmi     LBEF9
        lda     $23
        bne     LBEE3
        lda     $0434
        cmp     #$0D
        bcs     LBEF9
        lda     $0D
        and     #$07
        sec
        beq     LBEF9
        lda     $4C,x
        and     #$07
        beq     LBEE3
        lda     $0434
        cmp     #$04
        bcc     LBEF9
LBEE3:  lda     #$00
        sta     $04AD
        lda     $0D
        lsr     a
        and     #$0F
        ora     #$10
        eor     $1D
        txa
        pha
        jsr     LC98C
        pla
        tax
        clc
LBEF9:  rts

LBEFA:  ldx     $1A
        bmi     LBF19
        lda     #$01
        sta     $0556
        jsr     LA9E1
        tay
        lda     #$01
        sta     $0410,y
        tya
        eor     #$01
        tay
        lda     #$10
        sta     $0410,y
        lda     #$00
        sta     $1C
LBF19:  rts

LBF1A:  lda     #$00
        ldx     #$08
LBF1E:  sta     $054C,x
        dex
        bne     LBF1E
        lda     $0D
        ror     a
        bcc     LBF2C
        jmp     LBF90

LBF2C:  ldx     #$08
LBF2E:  txa
        pha
        ldx     #$08
LBF32:  lda     $054C,x
        beq     LBF3A
        dex
        bne     LBF32
LBF3A:  inc     $054C,x
        txa
        tay
        dey
        beq     LBF87
LBF42:  lda     $054C,y
        bne     LBF76
        sec
        lda     $54,x
        sbc     $54,y
        bcs     LBF76
        cmp     #$F0
        bcc     LBF76
        sec
        lda     $64,x
        sbc     $64,y
        sta     $0B
        lda     $6C,x
        sbc     $6C,y
        bcc     LBF6C
        bne     LBF76
        lda     $0B
        cmp     #$11
        bcs     LBF76
        bcc     LBF7B
LBF6C:  cmp     #$FF
        bne     LBF76
        lda     $0B
        cmp     #$F0
        bcs     LBF7B
LBF76:  dey
        bne     LBF42
        beq     LBF87
LBF7B:  dec     $054C,x
        tya
        tax
        inc     $054C,x
        ldy     #$08
        bne     LBF42
LBF87:  jsr     LC027
        pla
        tax
        dex
        bne     LBF2E
        rts

LBF90:  ldx     #$08
LBF92:  txa
        pha
        ldx     #$01
LBF96:  lda     $054C,x
        beq     LBF9E
        inx
        bne     LBF96
LBF9E:  inc     $054C,x
        txa
        tay
        iny
        cpy     #$09
        beq     LBFEF
LBFA8:  lda     $054C,y
        bne     LBFDC
        sec
        lda     $54,x
        sbc     $54,y
        bcs     LBFDC
        cmp     #$F0
        bcc     LBFDC
        sec
        lda     $64,x
        sbc     $64,y
        sta     $0B
        lda     $6C,x
        sbc     $6C,y
        bcc     LBFD2
        bne     LBFDC
        lda     $0B
        cmp     #$11
        bcs     LBFDC
        bcc     LBFE3
LBFD2:  cmp     #$FF
        bne     LBFDC
        lda     $0B
        cmp     #$F0
        bcs     LBFE3
LBFDC:  iny
        cpy     #$09
        bne     LBFA8
        beq     LBFEF
LBFE3:  dec     $054C,x
        tya
        tax
        inc     $054C,x
        ldy     #$01
        bne     LBFA8
LBFEF:  jsr     LC027
        pla
        tax
        dex
        bne     LBF92
        rts

LBFF8:  jsr     LA9E1
        sta     $CF
        lda     $0D
        lsr     a
        lsr     a
        and     #$01
        cmp     $CF
        bne     LC026
        lda     $19
        bne     LC026
        lda     $24,x
        and     #$09
        beq     LC026
        ror     a
        bcc     LC01E
        ldy     $CF
        txa
        cmp     $0442,y
        beq     LC022
        bne     LC026
LC01E:  cpx     $1A
        bne     LC026
LC022:  lda     #$02
        sta     $CF
LC026:  rts

LC027:  jsr     LBFF8
        cpx     $1A
        bne     LC06D
        lda     $0357,x
        asl     a
        asl     a
        asl     a
        asl     a
        sta     L000A
        lda     $3C,x
        and     #$0F
        ora     L000A
        asl     a
        tay
        lda     LC095,y
        php
        and     #$7F
        clc
        adc     $54,x
        sta     $1F
        lda     LC096,y
        bmi     LC05C
        clc
        adc     $64,x
        sta     $21
        lda     $6C,x
        adc     #$00
        sta     $22
        bcc     LC067
LC05C:  clc
        adc     $64,x
        sta     $21
        lda     $6C,x
        adc     #$FF
        sta     $22
LC067:  plp
        bmi     LC06D
        jsr     LCC66
LC06D:  lda     $64,x
        sec
        sbc     $FD
        sta     $0B
        lda     $6C,x
        sbc     #$00
        bne     LC094
        lda     $54,x
        sec
        sbc     $0574
        sta     L000A
        lda     $3C,x
        and     #$3F
        sta     $D9
        lda     $0357,x
        lsr     a
        ror     a
        ror     a
        ora     $D9
        tay
        jsr     LC0F5
LC094:  rts

LC095:  .byte   $80
LC096:  brk
        .byte   $80
        ora     L0000
        php
        brk
        ora     L0000
        brk
        brk
        .byte   $FB
        brk
        sed
        brk
        .byte   $FB
        .byte   $80
        brk
        brk
        ora     L0000
        php
        brk
        ora     L0000
        brk
        brk
        .byte   $FB
        brk
        sed
        brk
        .byte   $FB
        .byte   $80
        brk
        .byte   $80
        ora     L0000
        ora     #$00
        ora     L0000
        brk
LC0BF:  brk
        .byte   $FB
        brk
        .byte   $F7
        brk
        .byte   $FB
        .byte   $80
        brk
        brk
        ora     L0000
        ora     #$00
        ora     L0000
        brk
        brk
        .byte   $FB
        brk
        .byte   $F7
        brk
        .byte   $FB
        .byte   $80
        brk
        .byte   $80
        ora     L0000
        php
        brk
        ora     L0000
        brk
        brk
        .byte   $FB
        brk
        sed
        brk
        .byte   $FB
        .byte   $80
        brk
        brk
        ora     L0000
        php
        brk
        ora     L0000
        brk
        brk
        sed
        brk
        .byte   $F7
        brk
        .byte   $FB
LC0F5:  lda     LC2A3,y
        asl     a
        tax
        lda     LC3FB,x
        sta     $D3
        lda     LC3FC,x
        sta     $D4
        lda     LC1E3,y
        asl     a
        tax
        lda     LC3D5,x
        sta     $D7
        lda     LC3D6,x
        sta     $D8
        tya
        lsr     a
        tax
        lda     LC183,x
        bcc     LC11F
        lsr     a
        lsr     a
        lsr     a
        lsr     a
LC11F:  and     #$0F
        asl     a
        tax
        lda     LC3C3,x
        sta     $D1
        lda     LC3C4,x
        sta     $D2
        tya
        lsr     a
        tax
        lda     LC363,x
        bcc     LC139
        lsr     a
        lsr     a
        lsr     a
        lsr     a
LC139:  and     #$0F
        asl     a
        tax
        lda     LC473,x
        sta     $D5
        lda     LC474,x
        sta     $D6
        ldx     #$05
        ldy     #$00
LC14B:  lda     ($D1),y
        cmp     #$80
        beq     LC17E
        clc
        adc     L000A
        sta     $DC
        lda     ($D7),y
        clc
        adc     $0B
        sta     $DF
        lda     $0B
        and     #$C0
        bne     LC169
        lda     $DF
        bpl     LC171
        bmi     LC17E
LC169:  cmp     #$C0
        bne     LC171
        lda     $DF
        bpl     LC17E
LC171:  lda     ($D3),y
        sta     $DD
        lda     ($D5),y
        ora     $CF
        sta     $DE
        jsr     L8AD8
LC17E:  iny
        dex
        bne     LC14B
        rts

LC183:  brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        .byte   $22
        .byte   $22
        .byte   $22
        .byte   $22
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        .byte   $22
        .byte   $22
        .byte   $22
        .byte   $22
        .byte   $53
        eor     ($53),y
        eor     ($15),y
        eor     ($55),y
        ora     ($11),y
        eor     ($55),y
        ora     ($11),y
        ora     ($11),y
        ora     (L0000),y
        brk
        brk
        brk
        ora     ($11),y
        ora     ($11),y
        ror     $66
        ror     $66
        .byte   $87
        dey
        .byte   $87
        dey
LC1E3:  brk
        ora     ($01,x)
        ora     (L0000,x)
        brk
        brk
        brk
        brk
        ora     ($01,x)
        ora     (L0000,x)
        brk
        brk
        brk
        brk
        ora     ($01,x)
        ora     (L0000,x)
        brk
        brk
        brk
        ora     ($01,x)
        ora     ($01,x)
        brk
        brk
        brk
        brk
        ora     ($01,x)
        ora     ($01,x)
        brk
        brk
        brk
        brk
        ora     ($01,x)
        ora     ($01,x)
        brk
        brk
        brk
        brk
        ora     ($01,x)
        ora     ($01,x)
        brk
        brk
        brk
        brk
        brk
        ora     ($01,x)
        ora     (L0000,x)
        brk
        brk
        brk
        brk
        ora     ($01,x)
        ora     (L0000,x)
        brk
        brk
        brk
        brk
        ora     ($01,x)
        ora     (L0000,x)
        brk
        brk
        brk
        brk
        ora     ($01,x)
        ora     (L0000,x)
        brk
        brk
        brk
        ora     ($01,x)
        ora     ($01,x)
        brk
        brk
        brk
        brk
        ora     ($01,x)
        ora     ($01,x)
        brk
        brk
        brk
        brk
        ora     ($01,x)
        ora     ($01,x)
        brk
        brk
        brk
        brk
        ora     ($01,x)
        ora     ($01,x)
        brk
        brk
        brk
        brk
        brk
        ora     ($01,x)
        ora     (L0000,x)
        brk
        brk
        brk
        .byte   $04
        bpl     LC271
        .byte   $0C
        .byte   $04
        ora     L000A
        .byte   $0F
        ora     $07
        .byte   $0B
        asl     $0D05
LC271:  asl     a
        asl     $07
        .byte   $07
        .byte   $0B
        .byte   $0C
        ora     $05
        asl     a
        asl     $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        ora     ($01,x)
        ora     ($01,x)
        brk
        brk
        brk
        brk
        .byte   $0B
        .byte   $0B
        .byte   $0B
        .byte   $0B
        asl     a
        asl     a
        asl     a
        asl     a
        .byte   $12
        .byte   $12
        .byte   $12
        .byte   $12
        ora     ($11),y
        ora     ($11),y
        .byte   $04
        .byte   $0C
        .byte   $0C
        .byte   $0C
        .byte   $04
        ora     $05
        .byte   $05
LC2A3:  brk
        ora     ($02,x)
        .byte   $03
        .byte   $04
        .byte   $03
        .byte   $02
        ora     ($05,x)
        asl     $07
        php
        ora     #$08
        .byte   $07
        asl     L000A
        asl     a
        .byte   $0B
        .byte   $0C
        ora     $0B0C
        asl     a
        asl     $0F0E
        bpl     LC2D0
        .byte   $0F
        asl     $110E
        ora     ($11),y
        ora     ($11),y
        ora     ($11),y
        ora     ($12),y
        .byte   $12
        .byte   $12
        .byte   $12
        .byte   $12
LC2D0:  .byte   $12
        .byte   $12
        .byte   $12
        .byte   $13
        .byte   $13
        .byte   $13
        .byte   $13
        .byte   $13
        .byte   $13
        .byte   $13
        .byte   $13
        brk
        ora     ($02,x)
        .byte   $03
        .byte   $04
        .byte   $03
        .byte   $02
        ora     ($14,x)
        ora     $16,x
        .byte   $17
        clc
        .byte   $17
        asl     $15,x
        ora     $1B1A,y
        .byte   $1C
        ora     $1B1C,x
        .byte   $1A
        ora     $1F1E,y
        jsr     L2021
        .byte   $1F
        asl     $2222,x
        .byte   $23
        bit     $24
LC300:  bit     $23
        .byte   $22
        and     $25
        and     $25
        and     $25
        and     $25
        rol     $26
        rol     $26
        rol     $26
        rol     $26
        .byte   $27
        .byte   $27
        .byte   $27
        .byte   $27
        .byte   $27
        .byte   $27
        .byte   $27
        .byte   $27
        .byte   $14
        ora     $16,x
        .byte   $17
        clc
        .byte   $17
        asl     $15,x
        plp
        and     #$2A
        .byte   $2B
        bit     $2A2B
        and     #$2D
        rol     $302F
        and     ($30),y
        .byte   $2F
        rol     $3232
        .byte   $33
        .byte   $34
        and     $34,x
        .byte   $33
        .byte   $32
        rol     $36,x
        .byte   $37
        sec
        sec
        sec
        .byte   $37
        rol     $39,x
        and     $3939,y
        and     $3939,y
        and     $3A3A,y
        .byte   $3A
        .byte   $3A
        .byte   $3A
        .byte   $3A
        .byte   $3A
        .byte   $3A
        .byte   $3B
        .byte   $3B
        .byte   $3B
        .byte   $3B
        .byte   $3B
        .byte   $3B
        .byte   $3B
        .byte   $3B
        bit     $3535
        and     $2C,x
        and     $35,x
        .byte   $35
LC363:  .byte   $12
        ora     ($02),y
        brk
        bpl     LC37A
        .byte   $02
        brk
        bpl     LC37E
        brk
        brk
        ora     ($11),y
        brk
        brk
        ora     ($11),y
        brk
        brk
        ora     ($11),y
        brk
LC37A:  brk
        ora     ($11),y
        brk
LC37E:  brk
        .byte   $12
        ora     ($02),y
        brk
        .byte   $12
        ora     ($02),y
        brk
        bpl     LC39A
        .byte   $02
        brk
        bpl     LC39E
        brk
        brk
        ora     ($11),y
        brk
        brk
        ora     ($11),y
        brk
        brk
        ora     ($11),y
        brk
LC39A:  brk
        ora     ($11),y
        brk
LC39E:  brk
        .byte   $12
        ora     ($02),y
        brk
        bpl     LC3B6
        brk
        brk
        bpl     LC3BA
        brk
        brk
        ora     ($11),y
        brk
        brk
        ora     ($11),y
        brk
        brk
        ora     ($11),y
        brk
LC3B6:  brk
        ora     ($11),y
        brk
LC3BA:  brk
        ora     ($11),y
        brk
        brk
        bpl     LC3D2
        brk
        brk
LC3C3:  .byte   $7B
LC3C4:  cpy     $80
        cpy     $85
        cpy     $8A
        cpy     $94
        cpy     $8F
        cpy     $99
        cpy     $9E
LC3D2:  cpy     $A3
        .byte   $C4
LC3D5:  tay
LC3D6:  cpy     $AC
        cpy     $B0
        cpy     $B5
        cpy     $BA
        cpy     $BD
        cpy     $C1
        cpy     $C6
        cpy     $CB
        cpy     $D0
        cpy     $D5
        cpy     $DA
        cpy     $DF
        cpy     $E3
        cpy     $E7
        cpy     $EB
        cpy     $EF
        cpy     $F3
        cpy     $F7
        .byte   $C4
LC3FB:  .byte   $FB
LC3FC:  cpy     $FF
        cpy     $03
        cmp     $07
        cmp     $0B
        cmp     $0F
        cmp     $13
        cmp     $17
        cmp     $1B
        cmp     $1F
        cmp     $23
        cmp     $27
        cmp     $2B
        cmp     $2F
        cmp     $33
        cmp     $37
        cmp     $3B
        cmp     $3F
        cmp     $43
        cmp     $47
        cmp     $4B
        cmp     $4F
        cmp     $53
        cmp     $57
        cmp     $5B
        cmp     $5F
        cmp     $63
        cmp     $67
        cmp     $6B
        cmp     $6F
        cmp     $73
        cmp     $77
        cmp     $7B
        cmp     $7F
        cmp     $83
        cmp     $87
        cmp     $8B
        cmp     $8F
        cmp     $93
        cmp     $97
        cmp     $9B
        cmp     $9E
        cmp     $A2
        cmp     $A7
        cmp     $AB
        cmp     $AE
        cmp     $B2
        cmp     $B7
        cmp     $BC
        cmp     $C0
        cmp     $C4
        cmp     $C9
        cmp     $CE
        cmp     $D2
        cmp     $D6
        cmp     $DB
        cmp     $E0
        cmp     $E5
        cmp     $E9
        cmp     $EE
        .byte   $C5
LC473:  .byte   $F2
LC474:  cmp     $F7
        cmp     $FC
        cmp     $01
        dec     $F2
        .byte   $F2
        .byte   $FA
        .byte   $FA
        .byte   $80
        .byte   $F2
        .byte   $F2
        .byte   $FA
        .byte   $FA
        nop
        .byte   $F2
        .byte   $F2
        .byte   $80
        .byte   $80
        .byte   $80
        .byte   $F2
        .byte   $FA
        nop
        .byte   $80
        .byte   $80
        .byte   $F2
        .byte   $FA
        .byte   $FA
        nop
        .byte   $80
        .byte   $F2
        .byte   $FA
        nop
        .byte   $80
        .byte   $80
        .byte   $F2
        .byte   $F2
        .byte   $FA
        nop
        .byte   $80
        .byte   $F2
        .byte   $80
        nop
        .byte   $80
        .byte   $80
        .byte   $F2
        .byte   $80
        .byte   $80
        nop
        .byte   $80
        sed
        brk
        sed
        brk
        brk
        sed
        brk
        sed
        sed
        brk
        sed
        brk
        sbc     LF800,y
        brk
        sed
        .byte   $FF
        .byte   $FC
        .byte   $FC
        .byte   $FC
        .byte   $FC
        sbc     LFC01,y
        sed
        brk
        sed
        brk
        .byte   $FB
        brk
        sed
        brk
        sed
        sbc     a:$F8,x
        sed
        brk
        .byte   $FC
        brk
        sed
        brk
        sed
        .byte   $FC
        sed
        brk
        sed
        brk
        sbc     LF800,x
        brk
        sed
        .byte   $FB
        .byte   $FC
        inc     LFCF6,x
        .byte   $FC
        sbc     LFD01,y
        .byte   $FC
        .byte   $FF
        .byte   $F7
        .byte   $FB
        .byte   $FC
        sed
        brk
        .byte   $FC
        .byte   $FC
        brk
        sed
        .byte   $FC
        sed
        brk
        .byte   $FB
        .byte   $FB
        brk
        sed
        sbc     $35FD,x
        and     $36,x
        .byte   $37
        rol     $27
        plp
        and     #$04
        ora     $06
        .byte   $07
        .byte   $1C
        ora     $1F1E,x
        ora     ($11),y
        .byte   $12
        .byte   $13
        sec
        and     $3B3A,y
        rol     a
        .byte   $2B
        bit     LE52D
        ora     ($02,x)
        .byte   $03
        clc
        ora     $1B1A,y
        asl     $0F0E
        bpl     LC552
        .byte   $2F
        bmi     LC554
        .byte   $04
        ora     $08
        ora     #$18
        ora     $2120,y
        .byte   $14
        ora     $16,x
        .byte   $17
        and     ($32),y
        .byte   $33
        .byte   $34
LC537:  asl     a
        .byte   $0B
        .byte   $0C
        eor     $2322
        bit     $25
        .byte   $3C
        and     $3F3E,x
        sbc     $C2
        .byte   $C3
        cpy     $B5
        .byte   $B6
LC549:  .byte   $B7
        ora     #$75
        adc     $76,x
        .byte   $77
        rol     $67
        pla
LC552:  .byte   $69
LC553:  .byte   $44
LC554:  eor     $46
        .byte   $47
        .byte   $5C
        eor     $5F5E,x
        eor     ($51),y
        .byte   $52
        .byte   $53
        sei
        adc     $7B7A,y
        rol     a
        .byte   $6B
        jmp     (L406D)

        eor     ($42,x)
        .byte   $43
        cli
        eor     $5B5A,y
        lsr     $4F4E
        bvc     LC5E2
        .byte   $6F
        bvs     LC5E4
        .byte   $44
        eor     $48
        eor     #$58
        eor     $5B60,y
        .byte   $54
        eor     $56,x
        .byte   $57
        adc     ($72),y
        .byte   $73
        .byte   $74
        lsr     a
        .byte   $4B
        jmp     L624D

        .byte   $63
        .byte   $64
        adc     $7C
        adc     $7F7E,x
        cmp     $C6
        .byte   $C7
        iny
        clv
        lda     $49BA,y
        .byte   $A3
        ldy     $93
        ldy     #$A1
        ldx     #$80
        sta     $86
        .byte   $87
        dey
        .byte   $80
        .byte   $9C
        .byte   $9F
        .byte   $9E
        .byte   $8F
        sty     $95,x
        .byte   $93
        lda     $A8
        lda     #$8F
        lda     LAFAE
        bcs     LC537
        sta     $86
        .byte   $83
        sty     $80
        sta     L9B9A,y
        .byte   $80
        bcc     LC553
        .byte   $92
        .byte   $8F
        lda     ($B2),y
        .byte   $B3
        bcs     LC549
        sta     $86
        .byte   $89
LC5CC:  txa
        .byte   $80
        .byte   $9C
        sta     L8F9E,x
        stx     $97,y
        tya
        .byte   $8F
        ldy     $8C,x
        sta     L809B
        .byte   $8B
        sty     L8E8D
        .byte   $80
        ldx     $8C
LC5E2:  .byte   $A7
        .byte   $8E
LC5E4:  .byte   $80
        ldx     LC0BF,y
        cmp     ($C9,x)
        dex
        .byte   $CB
        cpy     LBB80
        ldy     L80BD,x
        brk
        brk
        brk
        brk
        brk
        rti

        rti

        rti

        rti

        rti

        brk
        rti

        brk
        brk
        brk
        rti

        brk
        rti

        rti

        rti

LC606:  lda     $22
        bne     LC615
        lda     $21
        sec
        sbc     #$80
        bcs     LC61E
        lda     #$00
        beq     LC61E
LC615:  lda     $21
        sec
        sbc     #$80
        bcc     LC61E
        lda     #$FF
LC61E:  sec
        sbc     $FD
        bcc     LC635
        sbc     #$10
        bcc     LC667
        sbc     $0435
        beq     LC64F
        bcs     LC646
        lda     $0435
        bmi     LC646
        bpl     LC64C
LC635:  adc     #$10
        bcs     LC667
        sec
        sbc     $0435
        beq     LC64F
        bcc     LC64C
        lda     $0435
        bpl     LC64C
LC646:  inc     $0435
        jmp     LC64F

LC64C:  dec     $0435
LC64F:  lda     $0435
        pha
        clc
        adc     $FD
        sta     $FD
        pla
        bcs     LC661
        bpl     LC66C
        lda     #$00
        bpl     LC665
LC661:  bmi     LC66C
        lda     #$FF
LC665:  sta     $FD
LC667:  lda     #$00
        sta     $0435
LC66C:  lda     $0412
        bne     LC677
        lda     $1F
        cmp     #$60
        bcs     LC684
LC677:  lda     $0574
        cmp     #$F8
        beq     LC692
        dec     $0574
        jmp     LC692

LC684:  cmp     #$A0
        bcc     LC692
        lda     $0574
        cmp     #$08
        beq     LC692
        inc     $0574
LC692:  rts

LC693:  lda     $1C
        bpl     LC6B1
        lsr     $1C
        jsr     LC6D2
        jsr     LC6D2
        lda     $055A
        ora     $0591
        beq     LC6AD
        jsr     LC6D2
        jsr     LC6D2
LC6AD:  asl     $1C
        bmi     LC6B4
LC6B1:  jsr     LC6D2
LC6B4:  jsr     LCC66
        lda     $1B
        sec
        sbc     $04AB
        sta     $1B
        lda     $1C
        bpl     LC6C8
        sbc     $04AC
        bne     LC6CF
LC6C8:  sbc     $04AC
        bpl     LC6CF
        lda     #$00
LC6CF:  sta     $1C
        rts

LC6D2:  jsr     LC6E1
        jsr     LC6F3
        jsr     LC714
        bcs     LC6E0
        jsr     LC9CB
LC6E0:  rts

LC6E1:  jsr     LCF9F
        lda     $1C
        lsr     a
        lsr     a
        lsr     a
        lsr     a
        ldy     $1D
        jsr     LCF4E
        jsr     LCFA9
        rts

LC6F3:  lda     $1F
        rol     a
        lda     $22
        ror     a
        ror     a
        and     #$C0
        sta     $D1
        lda     $1F
LC700:  bmi     LC704
        eor     #$FF
LC704:  and     #$7F
        sta     $D2
        lda     $22
        ror     a
        lda     $21
        bcs     LC711
        eor     #$FF
LC711:  sta     $D3
        rts

LC714:  lda     $D2
        sec
        sbc     #$30
        bcs     LC71D
        lda     #$00
LC71D:  tay
        sta     L000A
        lda     $D3
        sec
        sbc     #$B0
        bcs     LC729
        lda     #$00
LC729:  tax
        cmp     L000A
        bcs     LC749
        cpx     #$20
        bcc     LC734
        ldx     #$1F
LC734:  tya
        cmp     LC767,x
        bcc     LC766
        txa
        asl     a
        ora     $D1
        tax
        lda     LC787,x
        sta     $1F
        lda     LC788,x
        bne     LC762
LC749:  cpy     #$20
        bcc     LC74F
        ldy     #$1F
LC74F:  txa
        cmp     LC767,y
        bcc     LC766
        tya
        asl     a
        ora     $D1
        tay
        lda     LC887,y
        sta     $21
        lda     LC888,y
LC762:  jsr     LC987
        sec
LC766:  rts

LC767:  bit     $2C2C
        bit     $2C2C
        bit     $2B2B
        .byte   $2B
        .byte   $2B
        rol     a
        rol     a
        rol     a
        and     #$29
        and     #$28
        plp
        .byte   $27
        .byte   $27
        rol     $26
        and     $25
        bit     $23
        .byte   $23
        .byte   $22
        and     (L0020,x)
        .byte   $1F
LC787:  .byte   $24
LC788:  bpl     LC7AE
        bpl     LC7B0
        bpl     LC7B2
        bpl     LC7B4
        asl     $0E24
        bit     $0E
        and     $0E
        and     $0E
        and     $0E
        and     $0E
        rol     $0E
        rol     $0E
        rol     $0C
        .byte   $27
        .byte   $0C
LC7A5:  .byte   $27
        .byte   $0C
LC7A7:  .byte   $27
        .byte   $0C
        plp
        .byte   $0C
LC7AB:  plp
        .byte   $0C
        .byte   $29
LC7AE:  .byte   $0C
        .byte   $29
LC7B0:  .byte   $0C
        rol     a
LC7B2:  asl     a
        rol     a
LC7B4:  asl     a
        .byte   $2B
        asl     a
        .byte   $2B
        asl     a
        bit     $2D0A
        asl     a
        and     $2E0A
        php
        .byte   $2F
        php
        bmi     LC7CD
        and     ($08),y
        .byte   $DB
        bmi     LC7A5
        bmi     LC7A7
        .byte   $30
LC7CD:  .byte   $DB
        bmi     LC7AB
        .byte   $32
        .byte   $DB
        .byte   $32
        .byte   $DB
        .byte   $32
        .byte   $DA
        .byte   $32
        .byte   $DA
        .byte   $32
        .byte   $DA
        .byte   $32
        .byte   $DA
        .byte   $32
        cmp     LD932,y
        .byte   $32
        cmp     LD834,y
        .byte   $34
        cld
        .byte   $34
        cld
        .byte   $34
        .byte   $D7
        .byte   $34
        .byte   $D7
        .byte   $34
        dec     $34,x
        dec     $34,x
        cmp     $36,x
        cmp     $36,x
        .byte   $D4
        rol     $D4,x
        rol     $D3,x
        rol     $D2,x
        rol     $D2,x
        .byte   $36
LC7FF:  cmp     ($38),y
        bne     LC83B
        .byte   $CF
        sec
        dec     $2438
        bpl     LC82E
        bpl     LC830
        bpl     LC832
        bpl     LC834
        .byte   $12
        bit     $12
        bit     $12
        and     $12
        and     $12
        and     $12
        and     $12
        rol     $12
        rol     $12
        rol     $14
        .byte   $27
        .byte   $14
LC825:  .byte   $27
        .byte   $14
LC827:  .byte   $27
        .byte   $14
LC829:  plp
        .byte   $14
LC82B:  plp
        .byte   $14
        .byte   $29
LC82E:  .byte   $14
        .byte   $29
LC830:  .byte   $14
        rol     a
LC832:  asl     $2A,x
LC834:  asl     $2B,x
        asl     $2B,x
        asl     $2C,x
        .byte   $16
LC83B:  and     $2D16
        asl     $2E,x
        clc
        .byte   $2F
        clc
        bmi     LC85D
        and     ($18),y
        .byte   $DB
        bmi     LC825
        bmi     LC827
        bmi     LC829
        bmi     LC82B
        rol     $2EDB
        .byte   $DB
        rol     $2EDA
        .byte   $DA
        rol     $2EDA
        .byte   $DA
        .byte   $2E
LC85D:  cmp     LD92E,y
        rol     $2CD9
        cld
        bit     $2CD8
        cld
        bit     $2CD7
        .byte   $D7
        bit     $2CD6
        dec     $2C,x
        cmp     $2A,x
        cmp     $2A,x
        .byte   $D4
        rol     a
        .byte   $D4
        rol     a
        .byte   $D3
        rol     a
        .byte   $D2
        rol     a
        .byte   $D2
        rol     a
        cmp     ($28),y
        bne     LC8AB
        .byte   $CF
        plp
        .byte   $CE
        plp
LC887:  .byte   $24
LC888:  brk
        bit     L0000
        bit     L0000
        bit     L0000
        bit     $02
        bit     $02
        bit     $02
        and     $02
        and     $02
        and     $02
        .byte   $25
LC89C:  .byte   $02
        rol     $02
        rol     $02
        rol     $04
        .byte   $27
        .byte   $04
        .byte   $27
        .byte   $04
        .byte   $27
        .byte   $04
        plp
        .byte   $04
LC8AB:  plp
        .byte   $04
        and     #$04
        and     #$04
        rol     a
        asl     $2A
        asl     $2B
        asl     $2B
        asl     $2C
        asl     $2D
        asl     $2D
        asl     $2E
        php
        .byte   $2F
        php
        bmi     LC8CD
        and     ($08),y
        bit     $40
        bit     $40
        bit     $40
LC8CD:  bit     $40
        bit     $3E
        bit     $3E
        bit     $3E
        and     $3E
        and     $3E
        and     $3E
        and     $3E
        rol     $3E
        rol     $3E
        rol     $3C
        .byte   $27
        .byte   $3C
        .byte   $27
        .byte   $3C
        .byte   $27
        .byte   $3C
        plp
        .byte   $3C
        plp
        .byte   $3C
        and     #$3C
        and     #$3C
        rol     a
        .byte   $3A
        rol     a
        .byte   $3A
        .byte   $2B
        .byte   $3A
        .byte   $2B
        .byte   $3A
        bit     $2D3A
        .byte   $3A
        .byte   $2D
LC8FE:  .byte   $3A
        rol     $2F38
        sec
        bmi     LC93D
        and     ($38),y
        .byte   $DB
        jsr     L20DB
        .byte   $DB
        jsr     L20DB
        .byte   $DB
        asl     $1EDB,x
        .byte   $DB
        asl     $1EDA,x
        .byte   $DA
        asl     $1EDA,x
        .byte   $DA
        asl     $1ED9,x
        cmp     LD91E,y
        .byte   $1C
        cld
        .byte   $1C
        cld
        .byte   $1C
        cld
        .byte   $1C
        .byte   $D7
        .byte   $1C
        .byte   $D7
        .byte   $1C
        dec     $1C,x
        dec     $1C,x
        cmp     $1A,x
        cmp     $1A,x
        .byte   $D4
        .byte   $1A
        .byte   $D4
        .byte   $1A
        .byte   $D3
        .byte   $1A
        .byte   $D2
        .byte   $1A
LC93D:  .byte   $D2
        .byte   $1A
        cmp     ($18),y
        bne     LC95B
        .byte   $CF
        clc
        dec     LDB18
        jsr     L20DB
        .byte   $DB
        jsr     L20DB
        .byte   $DB
        .byte   $22
        .byte   $DB
        .byte   $22
        .byte   $DB
        .byte   $22
        .byte   $DA
        .byte   $22
        .byte   $DA
        .byte   $22
        .byte   $DA
        .byte   $22
LC95B:  .byte   $DA
        .byte   $22
        cmp     LD922,y
        .byte   $22
        cmp     LD824,y
        bit     $D8
        bit     $D8
        bit     $D7
        bit     $D7
        bit     $D6
        bit     $D6
        bit     $D5
        rol     $D5
        rol     $D4
        rol     $D4
        rol     $D3
        rol     $D2
        rol     $D2
        rol     $D1
        plp
        bne     LC9AB
        .byte   $CF
        plp
        .byte   $CE
        plp
LC987:  sec
        sbc     $1D
        and     #$1F
LC98C:  pha
        sec
        sbc     $1D
        and     #$1F
        tay
        lda     $0590
        beq     LC99D
        lda     $1C
        jmp     LC9B7

LC99D:  lda     LDC9C,y
        bmi     LC9C2
        sta     $1D
        lda     $1C
        and     #$E0
        lsr     a
        lsr     a
        lsr     a
LC9AB:  ora     $1D
        tay
        lda     LDCBC,y
        adc     $1C
        bcs     LC9B7
        lda     #$00
LC9B7:  sta     $1C
        and     #$E0
        beq     LC9C2
        lda     #$02
        jsr     LD0D8
LC9C2:  pla
        sta     $1D
        lda     #$00
        sta     $0555
        rts

LC9CB:  lda     $1C
        beq     LCA09
        asl     $D1
        rol     $D1
        rol     $D1
        lda     $D2
        cmp     #$1C
        bcs     LCA09
        tay
        lda     $D3
        sec
        sbc     #$A4
        bcc     LCA09
        cmp     #$18
        bcs     LCA09
        tax
        cpy     #$13
        bcs     LC9F2
        jsr     LCA0A
        jmp     LCA09

LC9F2:  cpx     #$0E
        bcc     LC9FC
        jsr     LCA0A
        jmp     LCA09

LC9FC:  cpx     #$04
        bcs     LCA06
        jsr     LCBA0
        jmp     LCA09

LCA06:  jsr     LCC0A
LCA09:  rts

LCA0A:  lda     $19
        bne     LCA38
        cpx     #$0E
        bcs     LCA38
        cpx     #$07
        bcc     LCA38
        cpy     #$13
        bcs     LCA38
        lda     #$01
        sta     $19
        lda     $040F
        cmp     #$05
        rol     a
        and     #$01
        eor     $22
        beq     LCA38
        dec     $040F
        lda     $040F
        eor     #$04
        sta     $040F
        inc     $040F
LCA38:  tya
        asl     a
        tay
        txa
        cmp     LCA88,y
        bcc     LCA87
        cmp     LCA89,y
        bcs     LCA87
        lda     $19
        beq     LCA6D
        lda     $1C
        cmp     #$60
        lda     #$00
        sta     $1C
        bcc     LCA6D
        cpy     #$04
        bcc     LCA6D
        cpy     #$26
        bcs     LCA6D
        lda     $D1
        asl     a
        ora     #$80
        sta     $03B3
        lda     #$07
        sta     $03F1
        inc     $0C
        bne     LCA87
LCA6D:  tya
        ora     $19
        asl     a
        asl     a
        ora     $D1
        lsr     a
        tay
        lda     LCAC0,y
        sta     $21
LCA7B:  tya
        and     #$FC
        ora     $D1
        tay
        lda     LCB30,y
        jsr     LC987
LCA87:  rts

LCA88:  asl     a
LCA89:  asl     $0B,x
        asl     $0C,x
        .byte   $17
        ora     $0E17
        clc
        .byte   $0F
        clc
        .byte   $0F
        clc
        .byte   $0F
        clc
        .byte   $0F
        clc
        .byte   $0F
        clc
        .byte   $0F
        clc
        .byte   $0F
        clc
        .byte   $0F
        clc
        .byte   $0F
        clc
        .byte   $0F
        clc
        .byte   $0F
        clc
        .byte   $0F
        clc
        asl     $0D17
        .byte   $17
        .byte   $0C
        asl     $0B,x
        asl     L000A,x
        ora     $09,x
        .byte   $14
        php
        .byte   $13
        .byte   $07
        .byte   $12
        asl     $11
        ora     $0F
        .byte   $04
LCABF:  .byte   $0E
LCAC0:  eor     $BA
        .byte   $52
        lda     LBA45
        eor     ($AE),y
        .byte   $44
        .byte   $BB
        bvc     LCA7B
        .byte   $44
        .byte   $BB
        .byte   $4F
        bcs     LCB15
        .byte   $BB
        lsr     $43B1
        ldy     LB24D,x
        .byte   $43
        ldy     LB24D,x
        .byte   $43
        ldy     LB24D,x
        .byte   $43
        ldy     LB24D,x
        .byte   $43
        ldy     LB24D,x
        .byte   $43
        ldy     LB24D,x
        .byte   $43
        ldy     LB24D,x
        .byte   $43
        ldy     LB24D,x
        .byte   $43
        ldy     LB24D,x
        .byte   $43
        ldy     LB24D,x
        .byte   $43
        ldy     LB24D,x
        .byte   $43
        ldy     LB24D,x
        .byte   $44
        .byte   $BB
        lsr     $44B1
        .byte   $BB
        .byte   $4F
        bcs     LCB52
        tsx
        bvc     LCABF
        eor     $BA
        eor     ($AE),y
        .byte   $46
LCB15:  lda     LAD52,y
        .byte   $47
        clv
        .byte   $53
        ldy     LB748
        .byte   $54
        .byte   $AB
        eor     #$B6
        eor     $AA,x
        lsr     a
        lda     $56,x
        lda     #$4C
        .byte   $B3
        .byte   $57
        tay
        eor     $58B2
        .byte   $A7
LCB30:  .byte   $1C
        bit     $04
        .byte   $1C
        .byte   $1C
        bit     $04
        .byte   $1C
        asl     $0222,x
        asl     $221E,x
        .byte   $02
        asl     $221E,x
        brk
        jsr     L2020
        brk
        jsr     L2020
        brk
        jsr     L2020
        brk
        jsr     L2020
LCB52:  brk
        jsr     L2020
        brk
        jsr     L2020
        brk
        jsr     L2020
        brk
        jsr     L2020
        brk
        jsr     L2020
        brk
        jsr     L2020
        brk
        jsr     L2020
        brk
        jsr     L2020
        brk
        jsr     L1E22
        rol     $2222,x
        asl     $223E,x
        bit     $1C
        .byte   $3C
        bit     $24
        .byte   $1C
        .byte   $3C
        bit     $28
        clc
        sec
        plp
        plp
        clc
        sec
        plp
        plp
        clc
        sec
        plp
        plp
        clc
        sec
        plp
        plp
        clc
        sec
        plp
        plp
        clc
        sec
        plp
        plp
        clc
        sec
        plp
LCBA0:  tya
        sec
        sbc     #$14
        bcc     LCBCA
        cmp     #$07
        bcs     LCBCA
        tay
        txa
        cmp     LCBCB,y
        bcc     LCBCA
        tya
        asl     a
        asl     a
        ora     $D1
        tay
        lda     $19
        beq     LCBBF
        lda     #$00
        sta     $1C
LCBBF:  lda     LCBD2,y
        sta     $21
        lda     LCBEE,y
        jsr     LC987
LCBCA:  rts

LCBCB:  .byte   $02
        ora     (L0000,x)
        brk
        brk
        ora     ($02,x)
LCBD2:  eor     LA659,y
        ldx     $5A
        .byte   $5A
        lda     $A5
        .byte   $5B
        .byte   $5B
        ldy     $A4
        .byte   $5B
        .byte   $5B
        ldy     $A4
        .byte   $5B
        .byte   $5B
        ldy     $A4
        .byte   $5A
        .byte   $5A
        lda     $A5
        eor     LA659,y
        .byte   $A6
LCBEE:  plp
        clc
        clc
        plp
        plp
        clc
        clc
        plp
        bit     $1C
        .byte   $1C
        bit     L0020
        jsr     L2020
        .byte   $1C
        bit     $04
        .byte   $1C
        clc
        plp
        php
        clc
        clc
        plp
        php
        clc
LCC0A:  lda     $19
        beq     LCC12
        lda     #$00
        sta     $1C
LCC12:  ldx     $1D
        lda     $D1
        and     #$01
        beq     LCC28
        asl     a
        ora     LCC46,x
        bpl     LCC36
        and     #$7F
        cpy     #$17
        bcs     LCC34
        bcc     LCC36
LCC28:  asl     a
        ora     LCC46,x
        bpl     LCC36
        and     #$7F
        cpy     #$17
        bcs     LCC36
LCC34:  ora     #$01
LCC36:  tax
        lda     LCC42,x
        sta     $1F
        lda     #$10
        jsr     LC987
        rts

LCC42:  .byte   $63
        adc     L9C92
LCC46:  ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        .byte   $80
        .byte   $80
        .byte   $80
        .byte   $80
        .byte   $80
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        .byte   $80
        .byte   $80
        .byte   $80
        .byte   $80
        .byte   $80
        ora     ($01,x)
        ora     ($01,x)
        .byte   $01
LCC66:  lda     $03B3
        bpl     LCCB4
        and     #$07
        tax
        lda     LCD32,x
        sec
        sbc     $0574
        sta     $DC
        lda     LCD52,x
        sta     $DD
        lda     LCD62,x
        sta     $DE
        lda     LCD42,x
        sec
        sbc     $FD
        sta     $DF
        jsr     L8AD8
        lda     LCD3A,x
        sec
        sbc     $0574
        sta     $DC
        lda     LCD5A,x
        sta     $DD
        lda     LCD6A,x
        sta     $DE
        lda     LCD4A,x
        sec
        sbc     $FD
        sta     $DF
        jsr     L8AD8
        lda     LCD22,x
        sta     $1F
        lda     LCD2A,x
        sta     $21
LCCB4:  lda     $1F
        clc
        adc     #$FC
        sbc     $0574
        sta     $DC
        lda     $21
        sec
        sbc     $FD
        sec
        sbc     #$04
        sta     $DF
        lda     $23
        bne     LCCD8
        .byte   $A9
LCCCD:  inc     LDD85,x
        lda     $19
        beq     LCD1C
LCCD4:  lda     #$20
        bne     LCD1C
LCCD8:  lda     $0D
        ror     a
        bcc     LCCEC
        lda     #$6A
        sta     $DD
        lda     $19
        beq     LCCE7
        lda     #$20
LCCE7:  sta     $DE
        jsr     L8AD8
LCCEC:  lda     #$66
        sta     $DD
        lda     $0D
        ror     a
        bcc     LCD0F
        lda     $1C
        cmp     #$D0
        bcc     LCD05
        lda     $24
        cmp     #$F8
        beq     LCD0F
        dec     $24
        bne     LCD0F
LCD05:  lda     $24
        bne     LCD0D
        sta     $23
        beq     LCD0F
LCD0D:  inc     $24
LCD0F:  lda     $24
        clc
        adc     $DC
        sta     $DC
        lda     $19
        beq     LCD1C
        lda     #$20
LCD1C:  sta     $DE
        jsr     L8AD8
        rts

LCD22:  .byte   $73
        .byte   $73
        .byte   $8B
        .byte   $8B
        .byte   $73
        .byte   $73
        .byte   $8B
        .byte   $8B
LCD2A:  lsr     a
        .byte   $47
        lsr     a
        .byte   $47
        ldx     $B9,y
        ldx     $B9,y
LCD32:  .byte   $6B
        .byte   $6B
        .byte   $83
        .byte   $83
        .byte   $6B
        .byte   $6B
        .byte   $83
        .byte   $83
LCD3A:  .byte   $73
        .byte   $73
        .byte   $8B
        .byte   $8B
        .byte   $73
        .byte   $73
        .byte   $8B
        .byte   $8B
LCD42:  .byte   $42
        .byte   $42
        .byte   $42
        .byte   $42
        ldx     $B6,y
        ldx     $B6,y
LCD4A:  .byte   $42
        .byte   $42
        .byte   $42
        .byte   $42
        ldx     $B6,y
        ldx     $B6,y
LCD52:  inc     LEEEF
        .byte   $EF
        inc     LEEEF
        .byte   $EF
LCD5A:  inc     LEEEF
        .byte   $EF
        inc     LEEEF
        .byte   $EF
LCD62:  .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $42
        .byte   $42
        .byte   $42
        .byte   $42
LCD6A:  .byte   $82
        .byte   $82
        .byte   $82
        .byte   $82
        .byte   $C2
        .byte   $C2
        .byte   $C2
        .byte   $C2
        brk
        brk
        brk
        brk
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($02,x)
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        brk
        brk
        brk
        .byte   $04
        .byte   $04
        .byte   $04
        .byte   $04
        ora     $05
        ora     $05
        ora     $05
        ora     $05
        ora     $06
        asl     $06
        asl     $06
        asl     $06
        .byte   $07
        .byte   $07
        .byte   $07
        .byte   $07
        .byte   $07
        .byte   $07
        .byte   $07
        .byte   $07
        .byte   $07
        .byte   $04
        .byte   $04
        .byte   $04
        brk
        brk
        brk
        brk
        ora     $05
        ora     $05
        ora     $05
        ora     $05
        ora     L000A
        asl     a
        asl     a
        asl     a
        asl     a
        asl     a
        asl     a
        .byte   $0F
        .byte   $0F
        .byte   $0F
        .byte   $0F
        .byte   $0F
        .byte   $0F
        .byte   $0F
        .byte   $0F
        .byte   $0F
        brk
        brk
        brk
        .byte   $14
        .byte   $14
        .byte   $14
        .byte   $14
        ora     $1919,y
        .byte   $19
LCDDA:  ora     $1919,y
        .byte   $19
LCDDE:  ora     $1E1E,y
        asl     $1E1E,x
        asl     $231E,x
        .byte   $23
        .byte   $23
        .byte   $23
        .byte   $23
        .byte   $23
        .byte   $23
        .byte   $23
        .byte   $23
        .byte   $14
        .byte   $14
        .byte   $14
LCDF2:  lda     #$0A
        sec
        sbc     $0574
        sta     L000A
        lda     $0D
        ror     a
        bcs     LCE08
        jsr     LCE2E
        jsr     LCE0F
        jmp     LCE0E

LCE08:  jsr     LCE0F
        jsr     LCE2E
LCE0E:  rts

LCE0F:  lda     $03
        asl     a
        asl     a
        asl     a
        tax
        lda     #$A0
        sec
        sbc     $FD
        bcc     LCE1F
        jsr     LCE81
LCE1F:  txa
        ora     #$04
        tax
        lda     #$A8
        sec
        sbc     $FD
        bcc     LCE2D
        jsr     LCE81
LCE2D:  rts

LCE2E:  lda     $04
        asl     a
        asl     a
        asl     a
        tax
        lda     #$50
        sec
        sbc     $FD
        bcs     LCE50
        cmp     #$F8
        bcs     LCE50
        jsr     LCE81
        lda     #$58
        sec
        sbc     $FD
        bcs     LCE50
        cmp     #$F8
        bcs     LCE50
        jsr     LCE81
LCE50:  rts

LCE51:  .byte   $F1
LCE52:  .byte   $03
LCE53:  .byte   $F2
LCE54:  .byte   $03
        .byte   $F2
        .byte   $03
        .byte   $F2
        .byte   $03
        .byte   $FB
        .byte   $03
        .byte   $FB
        .byte   $83
        .byte   $FC
        .byte   $03
        .byte   $FC
        .byte   $83
        sbc     L0000,x
        sbc     $03,x
        sbc     L0000,x
        sbc     $03,x
        .byte   $F7
        .byte   $03
        sed
        .byte   $03
        .byte   $F7
        .byte   $43
        sed
        .byte   $43
        inc     $03,x
        sbc     $03,x
        sbc     $03,x
        sbc     $03,x
        .byte   $F3
        .byte   $03
        .byte   $F4
        .byte   $03
        sbc     L0000,x
        sbc     $03,x
LCE81:  sta     $DF
        lda     L000A
        sta     $DC
        lda     LCE51,x
        sta     $DD
        lda     LCE52,x
        beq     LCE96
        sta     $DE
        jsr     L8AD8
LCE96:  lda     $DC
        clc
        adc     #$08
        sta     $DC
        lda     LCE53,x
        sta     $DD
        lda     LCE54,x
        beq     LCE96
        sta     $DE
        jsr     L8AD8
        inx
        inx
        inx
        inx
        rts

LCEB1:  lda     $0412
        bne     LCEEB
        lda     $0438
        beq     LCEC1
LCEBB:  dec     $0438
        jmp     LCEEB

LCEC1:  lda     #$13
        sta     $0438
        lda     $0437
LCEC9:  bne     LCED8
        lda     $0436
        beq     LCF1A
        dec     $0436
        lda     #$3C
        sta     $0437
LCED8:  dec     $0437
        jsr     LCF2A
        ldx     #$04
LCEE0:  lda     $0458,x
        beq     LCEE8
        dec     $0458,x
LCEE8:  dex
        bne     LCEE0
LCEEB:  lda     $0431
        cmp     #$02
        bcc     LCF17
        lda     $0436
        cmp     #$02
        bcs     LCF17
        lda     $042F
        sec
        sbc     $0430
        bcs     LCF06
        eor     #$FF
        adc     #$01
LCF06:  cmp     #$02
        bcs     LCF17
        lda     $0312
        bne     LCF17
        lda     #$27
        sta     $057C
        jsr     LD0D8
LCF17:  clc
        bcc     LCF1E
LCF1A:  jsr     LCF1F
        sec
LCF1E:  rts

LCF1F:  ldx     #$04
        lda     #$00
LCF23:  sta     $0458,x
        dex
        bne     LCF23
        rts

LCF2A:  lda     L0000
        bmi     LCF4D
        lda     $0436
        ldy     #$06
        jsr     LD06E
        lda     $0437
        ldy     #$09
        inc     $0439
        jsr     LD06E
        dec     $0439
        lda     #$DB
        sta     $041B
        lda     #$01
        sta     $0E
LCF4D:  rts

LCF4E:  pha
        tya
        asl     a
        asl     a
        tay
        lda     $04B4,y
        sta     $D6
        lda     $04B5,y
        sta     $D7
        lda     $04B6,y
        sta     $D8
        lda     $04B7,y
        sta     $D9
        sta     $DA
        pla
LCF6A:  lsr     a
        bcc     LCF8F
        pha
        lda     $D1
        clc
        adc     $D6
        sta     $D1
        lda     $D2
        adc     $D7
        sta     $D2
        lda     $D3
        clc
        adc     $D8
        sta     $D3
        lda     $D4
        adc     $D9
        sta     $D4
        lda     $D5
        adc     $DA
        sta     $D5
        pla
LCF8F:  beq     LCF9E
        asl     $D6
        rol     $D7
        asl     $D8
        rol     $D9
        rol     $DA
        jmp     LCF6A

LCF9E:  rts

LCF9F:  ldx     #$04
LCFA1:  lda     $1E,x
        sta     $D1,x
        dex
        bpl     LCFA1
        rts

LCFA9:  ldx     #$04
LCFAB:  lda     $D1,x
        sta     $1E,x
        dex
        bpl     LCFAB
        rts

LCFB3:  lda     $4C,x
        sta     $D1
        lda     $54,x
        sta     $D2
        lda     $5C,x
        sta     $D3
        lda     $64,x
        sta     $D4
        lda     $6C,x
        sta     $D5
        rts

LCFC8:  lda     $D1
        sta     $4C,x
        lda     $D2
        sta     $54,x
        lda     $D3
        sta     $5C,x
        lda     $D4
        sta     $64,x
        lda     $D5
        sta     $6C,x
        rts

LCFDD:  tax
        lda     L0000
        bpl     LCFE4
        ldx     #$08
LCFE4:  lda     #$2B
        sta     L000A
        lda     #$D0
        sta     $0B
        ldy     #$00
        inx
        bmi     LD013
LCFF1:  dex
        beq     LCFFD
LCFF4:  lda     (L000A),y
        iny
        cmp     #$00
        bne     LCFF4
        .byte   $F0
LCFFC:  .byte   $F4
LCFFD:  lda     (L000A),y
        tax
LD000:  iny
LD001:  lda     (L000A),y
        beq     LD00C
        sta     $0413,x
        inx
        iny
        bne     LD001
LD00C:  lda     #$01
        sta     $0412
        bne     LD026
LD013:  ldx     #$09
LD015:  lda     $0417,x
        pha
        lda     $0425,x
        sta     $0417,x
        pla
        sta     $0425,x
        dex
        bpl     LD015
LD026:  lda     #$01
        sta     $0E
        rts

        .byte   $04
        .byte   $9C
        .byte   $9C
        .byte   $9C
        .byte   $9C
        .byte   $9C
        .byte   $9C
        .byte   $9C
        .byte   $9C
        .byte   $9C
        .byte   $9C
        brk
        .byte   $07
        .byte   $C7
        .byte   $CF
        cmp     ($CC,x)
        .byte   $DC
        brk
        brk
        ora     $D0
        cmp     $D2
        cmp     #$CF
        cpy     L0000
        php
        .byte   $D4
        cmp     #$C5
        brk
        asl     $C9
        .byte   $C3
        cmp     #$CE
        .byte   $C7
        brk
        ora     $D0
        cmp     $CE
        cmp     ($CC,x)
        .byte   $D4
        cmp     $DC,y
        .byte   $07
        bne     LCFFC
        .byte   $D3
        .byte   $9C
        .byte   $9C
        brk
        ora     $CE
        cmp     #$CE
        .byte   $D4
        cmp     $CE
        cpy     $CF
        brk
LD06E:  ldx     #$00
LD070:  cmp     #$0A
        bcc     LD079
        inx
        sbc     #$0A
        bne     LD070
LD079:  pha
        txa
        bne     LD089
        lda     $0439
        ror     a
        lda     #$9C
        bcc     LD093
        lda     #$B7
        bcs     LD093
LD089:  cmp     #$0A
        bcc     LD091
        sbc     #$0A
        bcs     LD089
LD091:  adc     #$B7
LD093:  sta     $0413,y
        pla
        clc
        adc     #$B7
        .byte   $99
        .byte   $14
LD09C:  .byte   $04
        rts

LD09E:  lda     $03
        asl     a
        asl     a
        tay
        ldx     #$04
LD0A5:  lda     LD9DF,y
        sta     $03E5,x
        iny
        dex
        bne     LD0A5
        .byte   $A5
LD0B0:  .byte   $04
        asl     a
        asl     a
        tay
        ldx     #$04
LD0B6:  lda     LD9DF,y
        sta     $03E9,x
        iny
        dex
        bne     LD0B6
        inc     $0C
        rts

LD0C3:  lda     L0000
        bpl     LD0D7
        lda     $0F
        bne     LD0D4
        lda     $0D
        bne     LD0D7
LD0CF:  dec     $04A8
        bne     LD0D7
LD0D4:  inc     $04A9
LD0D7:  rts

LD0D8:  pha
        lda     L0000
        rol     a
        pla
        bcs     LD0F4
        pha
        lsr     a
        lsr     a
        lsr     a
        lsr     a
        tax
        pla
        and     #$07
        tay
        iny
        lda     #$00
        sec
LD0ED:  rol     a
        dey
        bne     LD0ED
        sta     $0300,x
LD0F4:  rts

LD0F5:  lda     $0454
        beq     LD142
        lda     #$00
        sta     L000A
        ldy     #$04
LD100:  lda     $0454,y
        beq     LD131
        lda     $0458,y
        bne     LD131
        tya
        pha
        lda     $0454,y
        tax
        lda     #$00
        sta     $0454,y
        dec     $0454
        lda     #$02
        sta     $24,x
        lda     $0357,x
        tay
        lda     LD990,y
        sta     $84,x
        lda     #$FF
        sta     $9C,x
        lda     #$04
        sta     $3C,x
        inc     L000A
        pla
        tay
LD131:  dey
        bne     LD100
        lda     L000A
        beq     LD142
        lda     $0572
        bne     LD142
        lda     #$07
        jsr     LD0D8
LD142:  rts

LD143:  lda     $042F
        ldy     #$00
        jsr     LD06E
        lda     $0430
        ldy     #$10
        jsr     LD06E
        rts

LD154:  lda     $BD
        bne     LD18B
        lda     $0E
        bne     LD18B
        inc     $0576
        lda     $0576
        and     #$03
        asl     a
        tay
        lda     LD1A6,y
        sta     L000A
        lda     LD1A7,y
        sta     $057A
        ldy     $0D
        lda     RESET,y
        lsr     a
        and     #$1F
        ora     L000A
        sta     $0579
        lda     #$03
        bcc     LD184
        lda     #$D1
LD184:  sta     $057B
        lda     #$40
        sta     $0E
LD18B:  lda     $057C
        beq     LD1A5
        lda     $0D
        and     #$07
        bne     LD1A5
        lda     $0D
        ldy     #$36
        and     #$08
        bne     LD1A0
        ldy     #$38
LD1A0:  sty     $03E1
        inc     $0C
LD1A5:  rts

LD1A6:  brk
LD1A7:  jsr     L23A0
        brk
        bit     $A0
        .byte   $27
LD1AE:  lda     $1A
        cmp     $0480
        beq     LD1C0
        sta     $0480
        lda     #$00
        sta     $0483
        sta     $0482
LD1C0:  lda     L0000
        bpl     LD1CC
        lda     #$00
        sta     $15
        sta     $16
        beq     LD1D6
LD1CC:  lda     $06
        eor     #$01
        tay
        lda     #$00
        sta     $15,y
LD1D6:  jsr     LA9E1
        tay
        lda     $1A
        beq     LD1E6
        bmi     LD1E6
        tya
        eor     $03B2
        beq     LD200
LD1E6:  lda     $0482
        bne     LD1FA
        tya
        eor     $06
        lda     $03,y
        asl     a
        asl     a
        asl     a
        jsr     LD31D
        jmp     LD224

LD1FA:  jsr     LD3F0
        jmp     LD224

LD200:  lda     $0483
        bne     LD215
        tya
        eor     $06
        lda     $03,y
        asl     a
        asl     a
        asl     a
        asl     a
        jsr     LD635
        jmp     LD224

LD215:  asl     a
        tay
        lda     LD223,y
        sta     L000A
        lda     LD224,y
        sta     $0B
        .byte   $20
        .byte   $6E
LD223:  .byte   $83
LD224:  rts

        cmp     $1DD8,y
        cmp     LD948,y
        rts

        .byte   $D9
LD22D:  .byte   $10
LD22E:  .byte   $20
LD22F:  clc
LD230:  sec
LD231:  brk
LD232:  bpl     LD234
LD234:  brk
        bpl     LD257
        asl     $28,x
        jsr     L0020
        brk
        bpl     LD257
        .byte   $14
        jsr     L2840
        brk
        brk
        bpl     LD25F
        .byte   $12
        ora     $60,x
        bmi     LD24C
LD24C:  brk
        bpl     LD25F
        bpl     LD259
        .byte   $80
        sec
        brk
        brk
        bpl     LD267
LD257:  .byte   $0E
        php
LD259:  ldy     #$38
        brk
        brk
LD25D:  .byte   $0F
        .byte   $03
LD25F:  .byte   $0C
        .byte   $0C
        .byte   $07
        .byte   $07
        .byte   $0C
        .byte   $0C
        .byte   $0F
        .byte   $03
LD267:  .byte   $0C
        .byte   $07
        .byte   $0C
        ora     $0D0C
        .byte   $0F
        .byte   $03
        asl     $0707
        .byte   $0B
        asl     a
        ora     #$0F
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $0F
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $07
        ora     $0B0C
        .byte   $0F
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $07
        .byte   $0F
        cpx     $0D
        .byte   $0F
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $07
        ora     #$0A
        .byte   $0B
        .byte   $0F
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $0F
        php
        php
        ora     $0D0D
        php
        php
        .byte   $0F
        php
        php
        ora     $0D0D
        asl     a
        asl     a
        .byte   $0F
        .byte   $03
        php
        .byte   $03
        ora     $0803
        .byte   $03
        .byte   $0F
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $0F
        .byte   $03
        .byte   $03
        ora     #$09
        ora     #$09
        .byte   $07
        .byte   $0F
        .byte   $03
LD2C7:  .byte   $03
        .byte   $03
        ora     #$09
        ora     #$08
        .byte   $0F
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        asl     a
LD2D4:  .byte   $0B
        .byte   $0F
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $0F
        .byte   $03
        .byte   $03
        .byte   $03
        asl     a
        asl     a
        asl     a
        asl     a
        .byte   $0F
        .byte   $03
        .byte   $03
        .byte   $03
        asl     a
        asl     a
        asl     a
        asl     a
        .byte   $0F
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        php
        php
        php
        .byte   $0F
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $0F
        .byte   $03
        asl     a
        asl     a
        asl     a
        asl     a
        ora     #$08
        .byte   $0F
        .byte   $03
        .byte   $03
        .byte   $03
        ora     #$09
        ora     #$09
        .byte   $0F
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $0F
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
LD31D:  sta     $0484
        tay
        lda     $0485
        beq     LD32C
        dec     $0485
        jmp     LD3B2

LD32C:  lda     $0486
        bne     LD33F
        lda     LD22D,y
        sta     $0485
        lda     LD22E,y
        sta     $0486
        bne     LD3B2
LD33F:  dec     $0486
        lda     $0487
        bne     LD359
        lda     LD22F,y
        sta     $0487
        lda     $06
        eor     #$01
        tay
        lda     #$40
        sta     $15,y
        bne     LD3B2
LD359:  dec     $0487
        lda     $1A
        bmi     LD3B2
        jsr     LD3C2
        lda     $1A
        beq     LD3BA
        lda     $0488
        beq     LD372
        dec     $0488
        jmp     LD3BA

LD372:  lda     LD230,y
        sta     $0488
        jsr     LD3D0
        cmp     LD232,y
        bcs     LD3BA
        lda     $D1
        and     #$03
        tay
        lda     LD3BE,y
        pha
        lda     $06
        eor     #$01
        tay
        pla
        sta     $15,y
        jsr     LAEBC
        jsr     LBB14
        ldy     $0484
        .byte   $A5
LD39C:  ora     $1829
        ora     LD231,y
        tay
        sta     $0489
        lda     LD25D,y
        sta     $048A
        inc     $0482
        jmp     LD3BD

LD3B2:  lda     #$FF
        jsr     LBB14
        jmp     LD3BD

LD3BA:  jsr     LB5E5
LD3BD:  rts

LD3BE:  sta     $86
LD3C0:  .byte   $89
        txa
LD3C2:  lda     $1F
        lsr     a
        sta     $8C,x
        lda     $22
        ror     a
        lda     $21
        ror     a
        sta     $94,x
        rts

LD3D0:  lda     $A4,x
        sec
        sbc     $8C,x
        bcs     LD3DB
        eor     #$FF
        adc     #$01
LD3DB:  rol     $D1
        sta     $D2
        lda     $AC,x
        sec
        sbc     $94,x
        bcs     LD3EA
        eor     #$FF
        adc     #$01
LD3EA:  rol     $D1
        clc
        adc     $D2
        rts

LD3F0:  lda     $06
        eor     #$01
        tay
        lda     $0444,y
        beq     LD403
        jsr     LAF0D
        jsr     LBB14
LD400:  jmp     LD406

LD403:  sta     $0482
LD406:  rts

LD407:  .byte   $01
LD408:  brk
LD409:  .byte   $03
LD40A:  brk
        brk
LD40C:  .byte   $01
LD40D:  brk
LD40E:  brk
LD40F:  .byte   $10
LD410:  brk
LD411:  brk
LD412:  brk
LD413:  brk
        brk
        brk
        brk
LD417:  ora     ($02,x)
        .byte   $03
        php
        brk
        brk
        .byte   $02
        .byte   $04
        bpl     LD425
        php
        .byte   $04
        php
        brk
LD425:  brk
        brk
        brk
        .byte   $04
        .byte   $04
        bpl     LD42C
LD42C:  ora     ($04,x)
LD42E:  php
        bpl     LD439
        bpl     LD43B
        bpl     LD435
LD435:  brk
        brk
        brk
        .byte   $06
LD439:  .byte   $02
        clc
LD43B:  brk
        ora     ($06,x)
        .byte   $0C
        bpl     LD44D
        clc
        .byte   $0C
LD443:  clc
        brk
        brk
        brk
        brk
        php
        .byte   $03
        jsr     L0100
LD44D:  php
        bpl     LD460
        bpl     LD472
        bpl     LD474
        brk
        brk
        brk
        brk
        asl     a
        .byte   $02
        plp
        brk
        brk
        asl     a
        .byte   $14
LD45F:  .byte   $10
LD460:  .byte   $14
        plp
        .byte   $14
        plp
        brk
        brk
        brk
LD467:  .byte   $73
LD468:  .byte   $D4
        stx     $D4
        sta     LACD4,y
        .byte   $D4
        lda     LCCD4,y
LD472:  .byte   $D4
        .byte   $03
LD474:  brk
        bmi     LD417
        iny
        sec
        rts

        bmi     LD4CC
        bcc     LD42E
        sec
        cli
        .byte   $50
LD481:  .byte   $FF
        ldy     #$C8
        sec
        rts

        .byte   $03
        brk
        jsr     LD0B0
        bmi     LD4DD
        bmi     LD4DF
        tay
        ldy     $38,x
        cli
        rts

        .byte   $FF
        bcs     LD467
        bmi     LD4E9
        .byte   $03
        brk
        .byte   $FF
LD49C:  .byte   $80
        tya
        pla
        .byte   $80
        brk
        bmi     LD443
        bne     LD4D5
        rts

        .byte   $50
LD4A7:  .byte   $FF
        ldy     #$D0
        bmi     LD50C
        .byte   $02
        .byte   $30
LD4AE:  .byte   $FF
        .byte   $80
        ldy     #$60
        .byte   $80
        bmi     LD505
        ldy     #$B8
        pha
        rts

        .byte   $03
        brk
        plp
        .byte   $80
        bne     LD4EF
        .byte   $80
        brk
        .byte   $FF
        ldy     #$B4
        rti

LD4C5:  rts

        cli
        .byte   $FF
        .byte   $80
        bne     LD4FB
        .byte   $80
LD4CC:  .byte   $03
        brk
        .byte   $FF
        .byte   $80
        cpy     #$40
        .byte   $80
        brk
        .byte   $30
LD4D5:  .byte   $80
        bne     LD508
        .byte   $80
        .byte   $50
LD4DA:  .byte   $FF
        .byte   $80
        .byte   $D0
LD4DD:  bmi     LD45F
LD4DF:  clc
LD4E0:  iny
        pla
        iny
        rti

        bcs     LD526
        bcc     LD520
        .byte   $C0
LD4E9:  rti

        ldy     #$15
        bne     LD558
        .byte   $D0
LD4EF:  jsr     L60D0
        bne     LD514
        tya
        rts

        tya
        clc
        iny
        pla
        iny
LD4FB:  and     $B0
        eor     $98,x
LD4FF:  clc
        ldy     #$40
        ldy     #$68
        .byte   $A0
LD505:  rti

        bcs     LD520
LD508:  iny
        pla
        iny
        .byte   $30
LD50C:  bcs     LD55E
        .byte   $A0
LD50F:  clc
LD510:  sec
        pla
        sec
        rti

LD514:  bvc     LD556
        bvs     LD550
        rti

        rti

        rts

        ora     $30,x
        ror     a
        bmi     LD540
LD520:  bmi     LD582
        bmi     LD544
        pla
        rts

LD526:  pla
        clc
        sec
        pla
        sec
        and     $60
        eor     $68,x
        clc
        rts

        rti

        rts

        pla
        rts

        rti

        bvc     LD550
        sec
        pla
        sec
        and     ($50),y
        bvc     LD59F
LD53F:  rts

LD540:  rts

        rts

        rts

        rti

LD544:  rti

        bmi     LD577
        bmi     LD579
        bmi     LD57B
LD54B:  plp
LD54C:  .byte   $80
        plp
        bvs     LD570
LD550:  pla
        clc
        rts

        bpl     LD5A5
        .byte   $10
LD556:  pha
LD557:  asl     a
LD558:  asl     a
        asl     a
        asl     a
        asl     a
        asl     a
        asl     a
LD55E:  asl     a
        asl     a
        asl     a
        asl     a
        asl     a
        asl     a
        asl     a
        asl     a
        asl     a
        asl     a
        asl     a
        asl     a
        asl     a
        asl     a
        asl     a
        asl     a
        asl     a
LD56F:  .byte   $10
LD570:  bpl     LD582
        bpl     LD584
        bpl     LD586
        .byte   $10
LD577:  bpl     LD589
LD579:  bpl     LD58B
LD57B:  bpl     LD58D
        bpl     LD58F
        bpl     LD591
        .byte   $10
LD582:  bpl     LD594
LD584:  bpl     LD596
LD586:  .byte   $10
LD587:  plp
LD588:  .byte   $E0
LD589:  .byte   $20
        iny
LD58B:  .byte   $20
        .byte   $B0
LD58D:  rts

        .byte   $B0
LD58F:  plp
        .byte   $E0
LD591:  jsr     L18C8
LD594:  clv
        pla
LD596:  clv
        plp
        cpx     #$20
        iny
        jsr     L6090
        .byte   $90
LD59F:  plp
        cpx     #$20
        iny
        clc
        .byte   $B0
LD5A5:  pla
        bcs     LD5D0
        cpx     #$20
        iny
        jsr     L6090
        bcc     LD5D8
LD5B0:  cpx     #$20
        iny
        clc
        cpy     #$68
        .byte   $C0
LD5B7:  cli
LD5B8:  jsr     L3860
        rts

        rti

        rti

        bvs     LD618
        jsr     L3860
        clc
        pha
        pla
        pha
        cli
        jsr     L3860
        jsr     L6070
        bvs     LD628
LD5D0:  jsr     L3860
        clc
        bvc     LD63E
        bvc     LD630
LD5D8:  jsr     L3860
        jsr     L6070
        bvs     LD638
        jsr     L3860
        clc
        rti

        pla
        pha
LD5E7:  bpl     LD5F9
        php
        php
        bpl     LD5FD
        php
        php
        bpl     LD601
        php
        php
        bpl     LD5FD
        php
        php
        bpl     LD601
LD5F9:  php
        php
        bpl     LD605
LD5FD:  php
        php
LD5FF:  php
        asl     a
LD601:  .byte   $0C
        .byte   $0F
        .byte   $0F
        .byte   $11
LD605:  and     ($21,x)
        php
        asl     a
        .byte   $0C
        .byte   $0F
        ora     ($19),y
        and     ($21,x)
        php
        .byte   $0F
        ora     ($19),y
        and     ($21,x)
        and     ($21,x)
        php
LD618:  asl     a
        .byte   $0C
        ora     $2119,y
        and     ($21,x)
        php
        .byte   $0F
        ora     $1919,y
        and     ($21,x)
        and     ($08,x)
LD628:  .byte   $0F
        ora     ($11),y
        ora     $2119,y
        .byte   $21
LD62F:  sec
LD630:  rti

        and     L0020
        sec
        .byte   $24
LD635:  sta     $0494
LD638:  jsr     LD69E
        bcs     LD643
        .byte   $20
LD63E:  .byte   $02
        .byte   $D7
        jmp     LD698

LD643:  lda     $055A
        bne     LD652
        jsr     LD773
        bcs     LD698
        jsr     LD871
        bcs     LD698
LD652:  ldy     $0494
        lda     $0D
        and     #$06
        ora     LD411,y
        tay
        lda     $06
        bne     LD678
        lda     $0D
        and     $055A
        beq     LD66C
        lda     #$40
        bne     LD66F
LD66C:  lda     LD587,y
LD66F:  sta     $8C,x
        lda     LD588,y
        sta     $94,x
        bne     LD682
LD678:  lda     LD5B7,y
        sta     $8C,x
        lda     LD5B8,y
        sta     $94,x
LD682:  ldy     $0494
        lda     $0D
        and     #$03
        ora     LD412,y
        tay
        lda     LD5E7,y
        sta     $049F
        lda     #$04
        sta     $0483
LD698:  lda     #$FF
        jsr     LBB14
        rts

LD69E:  lda     $055A
        beq     LD6AC
        lda     $AC,x
        cmp     #$B0
        bcc     LD6AC
        clc
        bcc     LD701
LD6AC:  ldy     $0494
        lda     $0495
        bne     LD6FD
        lda     LD407,y
        sta     $0495
        lda     LD408,y
        tay
        lda     LD467,y
        sta     L000A
        lda     LD468,y
        sta     $0B
        ldy     #$00
        lda     (L000A),y
        sta     $D0
        iny
LD6CF:  tya
        pha
        lda     $A4,x
        cmp     (L000A),y
        bcc     LD6F1
        iny
        cmp     (L000A),y
        bcs     LD6F1
        iny
        lda     $06
        beq     LD6E3
        iny
        iny
LD6E3:  lda     $AC,x
        cmp     (L000A),y
        bcc     LD6F1
        iny
        cmp     (L000A),y
        bcs     LD6F1
        pla
        bcc     LD701
LD6F1:  pla
        clc
        adc     #$06
        tay
        dec     $D0
        bne     LD6CF
        inc     $0495
LD6FD:  dec     $0495
        sec
LD701:  rts

        ldy     $0494
        lda     $0D
        lsr     a
        and     #$06
        ora     LD40A,y
        tay
        lda     $06
        bne     LD720
        lda     LD4DF,y
        sta     $0497
        lda     LD4E0,y
        sta     $0498
        bne     LD72C
LD720:  lda     LD50F,y
        sta     $0497
        lda     LD510,y
        sta     $0498
LD72C:  ldy     $0494
        lda     $0496
        bne     LD73A
        lda     LD409,y
        sta     $0496
LD73A:  dec     $0496
        lda     $0D
        and     #$03
        ora     #$04
        sta     $0499
        ldy     $0494
        lda     $0D
        lsr     a
        lsr     a
        lsr     a
        lsr     a
        and     #$07
        ora     LD413,y
        tay
        lda     LD5FF,y
        sta     $04A0
        lda     $0D
        lsr     a
        and     #$03
        tay
        lda     #$00
        sec
LD764:  rol     a
        dey
        bpl     LD764
        ora     #$40
        sta     $04A1
        lda     #$01
        sta     $0483
        rts

LD773:  lda     $049A
        beq     LD77E
        dec     $049A
        jmp     LD86F

LD77E:  lda     $A4,x
        sta     $D5
        lda     $AC,x
        sta     $D6
        ldy     $0494
        lda     LD40C,y
        sta     $049A
        lda     LD40D,y
        tay
        lda     $D5
        sec
        sbc     LD53F,y
        bcs     LD79D
        .byte   $A9
LD79C:  brk
LD79D:  sta     $D1
        lda     $D5
        clc
        adc     LD540,y
        bcc     LD7A9
        lda     #$FF
LD7A9:  sta     $D2
        lda     #$04
        sta     L000A
        lda     $06
        bne     LD7DC
        asl     L000A
LD7B5:  lda     $D6
        cmp     #$D0
        bcs     LD7DC
        cmp     #$50
        bcs     LD7C3
        lda     #$50
        bne     LD7CB
LD7C3:  sec
        sbc     LD54B,y
        bcs     LD7CB
        lda     #$00
LD7CB:  sta     $D3
        lda     $D6
        clc
        adc     LD54C,y
        bcc     LD7D7
        lda     #$FF
LD7D7:  sta     $D4
        jmp     LD7FE

LD7DC:  lda     $D6
        cmp     #$30
        bcc     LD7B5
        sbc     LD54C,y
        bcs     LD7E9
        lda     #$00
LD7E9:  sta     $D3
        lda     $D6
        cmp     #$A0
        bcc     LD7F5
        lda     #$A0
        bne     LD7FC
LD7F5:  adc     LD54B
        bcc     LD7FC
        lda     #$FF
LD7FC:  sta     $D4
LD7FE:  stx     $0B
        ldx     L000A
        lda     #$04
        sta     $D0
        cpx     #$05
        rol     a
        and     #$01
        tay
        lda     $03,y
        tay
LD810:  cpx     $0B
        beq     LD848
        lda     $A4,x
        cmp     $D1
        bcc     LD848
        cmp     $D2
        bcs     LD848
        sec
        sbc     $D5
        bcs     LD827
        .byte   $49
LD824:  .byte   $FF
        adc     #$01
LD827:  cmp     LD62F,y
        rol     $D7
        lda     $AC,x
        cmp     $D3
        bcc     LD848
        cmp     $D4
LD834:  bcs     LD848
        ror     $D7
        bcs     LD851
        sec
        sbc     $D6
        bcs     LD843
        eor     #$FF
        adc     #$01
LD843:  cmp     LD62F,y
        bcs     LD851
LD848:  dex
        dec     $D0
        bne     LD810
        ldx     $0B
        bne     LD86F
LD851:  stx     $049B
        ldy     $0494
        lda     $0D
        and     #$03
        ora     LD40E,y
        tay
        lda     LD557,y
        sta     $049C
        ldx     $0B
        lda     #$02
        sta     $0483
        sec
        bcs     LD870
LD86F:  clc
LD870:  rts

LD871:  ldy     $0494
        lda     LD40F,y
        sta     L000A
        lda     $A4,x
        sta     $D1
        lda     $AC,x
        sta     $D2
        stx     $0B
        lda     $06
        asl     a
        rol     a
        sec
        rol     a
        tax
        ldy     #$04
LD88C:  lda     $A4,x
        sec
        sbc     $D1
        bcs     LD897
        eor     #$FF
        adc     #$01
LD897:  rol     $D3
        sta     $D4
        lda     $AC,x
        sec
        sbc     $D2
        bcs     LD8A6
        eor     #$FF
        adc     #$01
LD8A6:  rol     $D3
        clc
        adc     $D4
        cmp     L000A
        bcs     LD8D1
        lda     $D3
        and     #$03
        sta     $049D
        ldy     $0494
        lda     $0D
        and     #$03
        ora     LD410,y
        tay
        lda     LD56F,y
        sta     $049E
        lda     #$03
        sta     $0483
        ldx     $0B
        sec
        bcs     LD8D8
LD8D1:  inx
        dey
        bne     LD88C
        ldx     $0B
        clc
LD8D8:  rts

        lda     $0499
        beq     LD8E4
        dec     $0499
        jmp     LD90C

LD8E4:  lda     $06
        eor     #$01
        tay
        lda     $04A1
        sta     $15,y
        lda     #$00
        sta     $17,y
        dec     $04A0
        beq     LD904
        lda     $0496
        bne     LD90C
        lda     $0D
        and     #$07
        bne     LD90C
LD904:  lda     #$00
        sta     $15,y
        sta     $0483
LD90C:  lda     $0497
        sta     L000A
        lda     $0498
        sta     $0B
        jsr     LB73B
        jsr     LBB14
        rts

        .byte   $AC
LD91E:  .byte   $9B
        .byte   $04
        .byte   $B9
        .byte   $A4
LD922:  brk
        sta     $8C,x
        lda     $AC,y
        sta     $94,x
        jsr     LB5E5
        .byte   $AD
LD92E:  .byte   $9C
        .byte   $04
        beq     LD938
LD932:  dec     $049C
        jmp     LD947

LD938:  lda     $06
        eor     #$01
        tay
        lda     #$80
        sta     $15,y
        lda     #$00
        sta     $17,y
LD947:  rts

LD948:  ldy     $049C
        lda     LD95C,y
        jsr     LBB14
        dec     $049E
        bne     LD95B
        lda     #$00
        sta     $0483
LD95B:  rts

LD95C:  ora     $06
        ora     #$0A
        jsr     LB5E5
        dec     $049F
        bne     LD96D
        lda     #$00
        sta     $0483
LD96D:  rts

LD96E:  brk
        brk
        brk
        brk
        brk
        ora     ($02,x)
        brk
        .byte   $02
        ora     (L0000,x)
        .byte   $02
        brk
        ora     (L0000,x)
        .byte   $02
        brk
        ora     ($01,x)
        .byte   $02
        ora     ($01,x)
        brk
        ora     (L0000,x)
        ora     (L0000,x)
        .byte   $02
LD98A:  rti

        bmi     LD9DD
LD98D:  bvc     LD9CF
        rts

LD990:  rti

        sec
        pha
LD993:  rts

        bvc     LDA06
LD996:  asl     $201C,x
LD999:  rol     $302C
LD99C:  adc     $6A,x
LD99E:  .byte   $80
        .byte   $0F
        rol     $06,x
        .byte   $27
        .byte   $0F
        ora     $05,x
        brk
        .byte   $0F
        and     $15
        jsr     L310F
        bmi     LD9D1
        .byte   $0F
        rol     L0000,x
        asl     $0F,x
        rol     $12,x
        and     #$0F
        jsr     L1630
        .byte   $0F
        rol     $16,x
LD9BE:  bmi     LD9F0
        .byte   $0F
LD9C1:  ora     $3B,x
        bmi     LD9F5
        .byte   $07
        ora     ($30,x)
        .byte   $0F
        ora     $36,x
        bmi     LD9CE
        .byte   $05
LD9CE:  .byte   $30
LD9CF:  bmi     LD9D1
LD9D1:  brk
        brk
        bmi     LD9D5
LD9D5:  brk
        brk
        bmi     LD9D9
LD9D9:  ora     L0000
        bmi     LDA13
LD9DD:  asl     $12,x
LD9DF:  and     ($0F,x)
        rol     $30
        sec
        .byte   $0F
        rol     $30,x
        clc
        .byte   $0F
        rol     $30,x
        and     #$0F
        rol     $30,x
        .byte   $16
LD9F0:  .byte   $0F
        rol     $30,x
        bpl     LDA04
LD9F5:  rol     $30,x
LD9F7:  .byte   $27
        and     $27
        and     $27
        .byte   $27
LD9FD:  .byte   $B0
LD9FE:  .byte   $FF
        brk
        brk
        .byte   $B2
        .byte   $FF
        .byte   $10
LDA04:  brk
        .byte   $B6
LDA06:  .byte   $FF
        .byte   $1F
        brk
        lda     $2CFF,x
        brk
        .byte   $C7
        .byte   $FF
        and     LD400,y
        .byte   $FF
LDA13:  .byte   $43
        brk
        sbc     ($FF,x)
        lsr     a
        brk
        .byte   $F0
LDA1A:  .byte   $FF
        lsr     a:L0000
        brk
        bvc     LDA21
LDA21:  bpl     LDA23
LDA23:  lsr     $1F00
        brk
        lsr     a
        brk
        bit     $4300
        brk
        and     $3900,y
        brk
        .byte   $43
        brk
        bit     $4A00
        brk
        .byte   $1F
        brk
        lsr     $1000
        brk
        bvc     LDA3F
LDA3F:  brk
        brk
        lsr     LF000
        .byte   $FF
        lsr     a
        brk
        sbc     ($FF,x)
        .byte   $43
        brk
        .byte   $D4
        .byte   $FF
        and     LC700,y
        .byte   $FF
        bit     LBD00
        .byte   $FF
        .byte   $1F
        brk
        ldx     $FF,y
        bpl     LDA5B
LDA5B:  .byte   $B2
        .byte   $FF
        brk
        brk
        .byte   $B0
LDA60:  .byte   $FF
        .byte   $F0
LDA62:  .byte   $FF
        .byte   $B2
        .byte   $FF
        sbc     ($FF,x)
        ldx     $FF,y
        .byte   $D4
        .byte   $FF
        lda     LC7FF,x
        .byte   $FF
        .byte   $C7
        .byte   $FF
        lda     LD4FF,x
        .byte   $FF
        ldx     $FF,y
        sbc     ($FF,x)
        .byte   $B2
        .byte   $FF
        .byte   $F0
LDA7C:  .byte   $FF
        ldx     $FF
        brk
        brk
        tay
        .byte   $FF
        .byte   $12
        brk
        lda     $22FF
        brk
        lda     $FF,x
        .byte   $32
        brk
        cpy     #$FF
        rti

        brk
        dec     $4BFF
        brk
        dec     $53FF,x
        brk
        inc     $58FF
        brk
        brk
        brk
        .byte   $5A
        brk
        .byte   $12
        brk
        cli
        brk
        .byte   $22
        brk
        .byte   $53
        brk
        .byte   $32
        brk
        .byte   $4B
        brk
        rti

        brk
        rti

        brk
        .byte   $4B
        brk
        .byte   $32
        brk
        .byte   $53
        brk
        .byte   $22
        brk
        cli
        brk
        .byte   $12
        brk
        .byte   $5A
        brk
        brk
        brk
        cli
        brk
        inc     $53FF
        brk
        dec     $4BFF,x
        brk
        dec     $40FF
        brk
        cpy     #$FF
        .byte   $32
        brk
        lda     $FF,x
        .byte   $22
        brk
        lda     $12FF
        brk
        lda     a:$FF
        brk
        ldx     $FF
        inc     LADFF
        .byte   $FF
        dec     LADFF,x
        .byte   $FF
        dec     LB5FF
        .byte   $FF
        cpy     #$FF
        cpy     #$FF
        lda     $FF,x
        dec     LADFF
        .byte   $FF
        dec     LA8FF,x
        .byte   $FF
        inc     L9CFF
        .byte   $FF
        brk
        brk
        .byte   $9E
        .byte   $FF
        .byte   $13
        brk
        ldy     $FF
        rol     L0000
        lda     $38FF
        brk
        lda     $47FF,y
        brk
        iny
        .byte   $FF
        .byte   $53
        brk
        .byte   $DA
        .byte   $FF
        .byte   $5C
LDB18:  brk
        sbc     $62FF
        brk
        brk
        brk
        .byte   $64
        brk
        .byte   $13
        brk
        .byte   $62
        brk
        rol     L0000
        .byte   $5C
        brk
        sec
        brk
        .byte   $53
        brk
        .byte   $47
        brk
        .byte   $47
        brk
        .byte   $53
        brk
        sec
        brk
        .byte   $5C
        brk
        rol     L0000
        .byte   $62
        brk
        .byte   $13
        brk
        .byte   $64
        brk
        brk
        brk
        .byte   $62
        brk
        sbc     $5CFF
        brk
        .byte   $DA
        .byte   $FF
        .byte   $53
        brk
        iny
        .byte   $FF
        .byte   $47
        brk
        lda     $38FF,y
        brk
        lda     $26FF
        brk
        ldy     $FF
        .byte   $13
        brk
        .byte   $9E
        .byte   $FF
        brk
        brk
        .byte   $9C
        .byte   $FF
        sbc     L9EFF
        .byte   $FF
        .byte   $DA
        .byte   $FF
        ldy     $FF
        iny
        .byte   $FF
        lda     LB9FF
        .byte   $FF
        lda     LADFF,y
        .byte   $FF
        iny
        .byte   $FF
        ldy     $FF
        .byte   $DA
        .byte   $FF
        .byte   $9E
        .byte   $FF
        sbc     L92FF
        .byte   $FF
        brk
        brk
        sty     $FF,x
        ora     L0000,x
        txs
        .byte   $FF
        rol     a
        brk
        lda     $FF
        and     LB200,x
        .byte   $FF
        lsr     LC300
        .byte   $FF
        .byte   $5B
        brk
        dec     $FF,x
        ror     L0000
        .byte   $EB
        .byte   $FF
        jmp     (L0000)

        brk
        ror     L1500
        brk
        jmp     (L2A00)

        brk
        ror     L0000
        and     $5B00,x
        brk
        lsr     $4E00
        brk
        .byte   $5B
        brk
        and     $6600,x
        brk
        rol     a
        brk
        jmp     (L1500)

        brk
        ror     a:L0000
        brk
        jmp     (LEB00)

        .byte   $FF
        ror     L0000
        dec     $FF,x
        .byte   $5B
        brk
        .byte   $C3
        .byte   $FF
        lsr     LB200
        .byte   $FF
        and     LA500,x
        .byte   $FF
        rol     a
        brk
        txs
        .byte   $FF
        .byte   $15
LDBDA:  brk
        sty     $FF,x
        brk
        brk
        .byte   $92
        .byte   $FF
        .byte   $EB
        .byte   $FF
        sty     $FF,x
        dec     $FF,x
        txs
        .byte   $FF
        .byte   $C3
        .byte   $FF
        lda     $FF
        .byte   $B2
        .byte   $FF
        .byte   $B2
        .byte   $FF
        lda     $FF
        .byte   $C3
        .byte   $FF
        txs
        .byte   $FF
        dec     $FF,x
        sty     $FF,x
        .byte   $EB
        .byte   $FF
        dey
        .byte   $FF
        brk
        brk
        txa
        .byte   $FF
        .byte   $17
        brk
        sta     ($FF),y
        rol     L9C00
        .byte   $FF
        .byte   $43
        brk
        .byte   $AB
        .byte   $FF
        eor     L0000,x
        lda     $64FF,x
        brk
        .byte   $D2
        .byte   $FF
        .byte   $6F
        brk
        sbc     #$FF
        ror     L0000,x
        brk
        brk
        sei
        brk
        .byte   $17
        brk
        ror     L0000,x
        rol     $6F00
        brk
        .byte   $43
        brk
        .byte   $64
        brk
        eor     L0000,x
        eor     L0000,x
        .byte   $64
        brk
        .byte   $43
        brk
        .byte   $6F
        brk
        rol     $7600
        brk
        .byte   $17
        brk
        sei
        brk
        brk
        brk
        ror     L0000,x
        sbc     #$FF
        .byte   $6F
        brk
        .byte   $D2
        .byte   $FF
        .byte   $64
        brk
        lda     $55FF,x
        brk
        .byte   $AB
        .byte   $FF
        .byte   $43
        brk
        .byte   $9C
        .byte   $FF
        rol     L9100
        .byte   $FF
        .byte   $17
        brk
        txa
        .byte   $FF
        brk
        brk
        dey
        .byte   $FF
        sbc     #$FF
        txa
        .byte   $FF
        .byte   $D2
        .byte   $FF
        sta     ($FF),y
        lda     L9CFF,x
        .byte   $FF
        .byte   $AB
        .byte   $FF
        .byte   $AB
        .byte   $FF
        .byte   $9C
        .byte   $FF
        lda     L91FF,x
        .byte   $FF
        .byte   $D2
        .byte   $FF
        txa
        .byte   $FF
        sbc     #$FF
LDC7D:  .byte   $99
LDC7E:  brk
        .byte   $B3
        brk
        cpy     LE600
        brk
        brk
        .byte   $01
LDC87:  ora     ($01,x)
        .byte   $02
        .byte   $02
        .byte   $03
        .byte   $03
LDC8D:  jsr     L1A1D
        .byte   $17
        .byte   $14
LDC92:  .byte   $02
        .byte   $02
        .byte   $03
        .byte   $03
        .byte   $03
LDC97:  ora     ($01,x)
        .byte   $02
LDC9A:  .byte   $02
        .byte   $03
LDC9C:  .byte   $FF
        .byte   $FF
        .byte   $FF
LDC9F:  brk
        brk
        brk
        ora     ($01,x)
        ora     ($01,x)
        .byte   $02
        .byte   $02
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $02
        .byte   $02
        ora     ($01,x)
        ora     ($01,x)
        brk
        brk
LDCB9:  brk
        .byte   $FF
        .byte   $FF
LDCBC:  .byte   $FF
        .byte   $FF
        inc     LFFF8,x
LDCC1:  inc     LE6F8,x
        .byte   $FC
        .byte   $FC
        beq     LDC9C
        sed
        sed
        cpx     #$C2
        .byte   $F4
        beq     LDC9F
        bcs     LDCC1
        cpx     #$C0
LDCD3:  ldy     #$E8
        bne     LDC87
        bcc     LDCB9
        cpy     #$A0
        .byte   $80
LDCDC:  .byte   $FB
        sbc     LFDFB,x
        .byte   $FB
        .byte   $FD
LDCE2:  .byte   $0B
        asl     $0B
        asl     $0B
        .byte   $06
LDCE8:  .byte   $FA
        .byte   $FC
        .byte   $FA
        .byte   $FC
        .byte   $FA
        .byte   $FC
LDCEE:  asl     $04
        asl     $04
        asl     $04
        .byte   $80
        brk
        .byte   $C3
        brk
        .byte   $1B
        cmp     LE3E0,x
        inc     $E0
        .byte   $E3
        inc     L0000
        asl     a
        .byte   $E7
        cmp     LE3E0,x
        nop
        .byte   $EB
        .byte   $F7
        .byte   $E3
        .byte   $E7
        cmp     $16ED,x
        .byte   $F7
        .byte   $E3
        .byte   $E7
        .byte   $FA
        sbc     L8516,x
        brk
        .byte   $1B
        dec     LE4E1,x
        brk
        sbc     ($E4,x)
        brk
        brk
        sbc     ($E4,x)
        dec     LE4E1,x
        sbc     ($E4,x)
        dec     a:L0000,x
        dec     $17EE,x
        dec     a:L0000,x
        .byte   $FB
        .byte   $F3
        .byte   $17
        sta     L0000
        .byte   $1B
        dec     LE4E1,x
        brk
        sbc     ($E5,x)
        .byte   $E7
        brk
        sbc     ($E5,x)
        .byte   $F2
        sbc     ($E4,x)
        sbc     ($E4,x)
        dec     a:L0000,x
        sed
        .byte   $EF
        .byte   $F4
        sed
        inc     L0000
        .byte   $FC
        dec     L8560,x
        brk
        asl     $DE,x
        sbc     ($E4,x)
        brk
        sbc     ($E4,x)
        brk
        brk
        sbc     ($E4,x)
        dec     LE4E1,x
        sbc     ($E4,x)
        dec     a:L0000,x
        dec     LF5F0,x
        .byte   $DE
LDD69:  .byte   $83
        brk
        ora     ($DE,x)
        stx     L0000
        .byte   $1A
        .byte   $DF
        .byte   $E2
        sbc     $E6
        .byte   $E2
        sbc     $E6
        brk
        inx
        cpx     $DF
        .byte   $E2
        sbc     $0B
        cpx     LE3F9
        .byte   $E7
        .byte   $DF
        sbc     ($F6),y
LDD85:  sbc     LE7E3,y
        brk
        .byte   $DF
        .byte   $80
        brk
        .byte   $EB
        brk
        ora     ($87,x)
        .byte   $8F
        dey
        ora     ($89,x)
        .byte   $8F
        brk
        ora     ($8A),y
        .byte   $9C
        clv
        .byte   $9C
        bne     LDD69
        cmp     ($D9,x)
        cmp     $D2
        .byte   $9C
        .byte   $C7
        .byte   $C1
LDDA4:  cmp     L9CC5
        .byte   $8B
        .byte   $8F
        brk
        ora     ($8A,x)
        .byte   $8F
        .byte   $9C
        ora     ($8B,x)
        .byte   $8F
        brk
        ora     ($8A),y
        .byte   $9C
        lda     LD09C,y
        cpy     LD9C1
        cmp     $D2
        .byte   $9C
        .byte   $C7
        cmp     ($CD,x)
        cmp     $9C
        .byte   $8B
        .byte   $8F
        brk
        ora     ($8C,x)
        .byte   $8F
        sta     L8E01
        lda     L0100
        .byte   $87
        .byte   $93
        dey
        ora     ($89,x)
        .byte   $8B
        brk
        ora     $8A,x
        .byte   $9C
        .byte   $9C
        .byte   $97
        .byte   $9C
        clv
        cpy     #$BF
        .byte   $BF
        .byte   $9C
        dec     LCEC9
        .byte   $D4
        cmp     $CE
        cpy     $CF
        .byte   $9C
        .byte   $9C
        .byte   $8B
        .byte   $8B
LDDED:  brk
        ora     ($8C,x)
        .byte   $93
        sta     L8E01
        sbc     L0000
        ldy     #$FF
        bcc     LDDA4
        bcc     LDE51
        .byte   $80
        brk
        .byte   $80
        brk
        .byte   $80
        brk
        .byte   $80
        brk
        .byte   $80
        brk
        .byte   $80
        brk
        .byte   $80
        brk
        .byte   $80
        brk
        brk
        cpy     L0100
        .byte   $87
        txa
        dey
        ora     ($89,x)
        sty     L0000,x
        .byte   $0C
        txa
        .byte   $D3
        cmp     $CC
        cmp     $C3
        .byte   $D4
        cmp     #$CF
        dec     L8BD3
        .byte   $8B
        brk
        ora     ($87,x)
        sta     $88
        .byte   $04
        .byte   $89
        brk
        brk
        sty     L8D8A
        ora     ($8E,x)
        .byte   $8B
        brk
        .byte   $07
        txa
        .byte   $D4
        cmp     $C1
        cmp     L8B9C
        sta     L0100,y
        sty     L8D85
        ora     ($8E,x)
        .byte   $B7
        brk
        ora     ($87,x)
        .byte   $9C
        dey
        .byte   $04
        .byte   $89
        brk
        brk
        txa
        .byte   $9C
LDE51:  .byte   $9C
        .byte   $04
        .byte   $8B
        brk
        brk
        txa
        .byte   $9C
        .byte   $9C
        .byte   $04
        .byte   $8B
        brk
        brk
        txa
        .byte   $9C
        .byte   $9C
        .byte   $04
        .byte   $8B
        brk
        brk
        txa
        .byte   $9C
        .byte   $9C
        .byte   $04
        .byte   $8B
        brk
        brk
        txa
        .byte   $9C
        .byte   $9C
LDE6E:  .byte   $04
        .byte   $8B
        brk
        brk
        .byte   $87
        .byte   $83
        dey
        .byte   $02
        .byte   $89
        .byte   $87
        .byte   $83
        dey
        .byte   $02
        .byte   $89
        .byte   $87
        .byte   $83
        dey
        .byte   $02
        .byte   $89
        .byte   $87
        .byte   $83
        dey
        .byte   $02
        .byte   $89
        .byte   $87
        .byte   $83
        dey
        .byte   $02
        .byte   $89
        .byte   $87
        .byte   $83
        dey
        bit     $89
        brk
        brk
        txa
        cmp     $D3,x
        cmp     ($8B,x)
        txa
        .byte   $D3
        .byte   $D7
        cmp     $8B
        txa
        bne     LDE6E
        cpy     L8A8B
        .byte   $C3
        cmp     ($CE,x)
        .byte   $8B
        txa
        cmp     $D2,x
        .byte   $D3
        .byte   $8B
        txa
        .byte   $D4
        .byte   $C3
        iny
        .byte   $8B
        brk
        brk
        sty     L8D83
        .byte   $02
        .byte   $8E
        .byte   $8C
LDEB8:  .byte   $83
        sta     L8E02
        sty     L8D83
        .byte   $02
        stx     L838C
        sta     L8E02
        sty     L8D83
        .byte   $02
        stx     L838C
        sta     L8E01
        cpy     L0000
        ora     ($87,x)
        sta     $88
        ora     $89,x
        brk
        .byte   $87
        dey
        .byte   $89
        brk
        .byte   $87
LDEDE:  dey
        .byte   $89
        brk
        .byte   $87
        dey
        .byte   $89
        brk
        .byte   $87
        dey
        .byte   $89
        brk
        .byte   $87
        dey
        .byte   $89
        sta     L0000
LDEEE:  .byte   $1B
        txa
        .byte   $D3
        bne     LDEB8
        cmp     $C4
        .byte   $8B
        brk
        txa
        clv
        .byte   $8B
        brk
        txa
        lda     $8B,y
        txa
        tsx
        .byte   $8B
        brk
        txa
        .byte   $BB
        .byte   $8B
        brk
        txa
        ldy     L858B,x
        brk
        ora     ($8C,x)
        sta     $8D
        ora     $8E,x
        brk
        sty     L8E8D
        brk
        sty     L8E8D
        brk
        sty     L8E8D
        brk
        sty     L8E8D
        brk
        sty     L8E8D
        lda     L0000
        ora     ($87,x)
        sta     $88
        .byte   $03
        .byte   $89
        brk
        .byte   $87
        .byte   $83
        dey
        .byte   $04
        .byte   $89
        brk
        brk
        .byte   $87
        .byte   $83
        dey
        .byte   $04
        .byte   $89
        brk
        brk
        .byte   $87
LDF3E:  .byte   $83
        dey
        ora     ($89,x)
        sta     L0000
        .byte   $1B
        txa
        .byte   $D4
        cmp     #$CD
        cmp     $9C
        .byte   $8B
        brk
        txa
        .byte   $9C
        ldx     L8B9C,y
        brk
        brk
        txa
        clv
        .byte   $9C
        .byte   $B7
        .byte   $8B
        brk
        brk
        txa
        clv
        .byte   $9C
        ldy     L858B,x
        brk
        ora     ($8C,x)
        sta     $8D
        .byte   $03
        stx     L8C00
        .byte   $83
        sta     L8E04
        brk
        brk
        sty     L8D83
        .byte   $04
        stx     a:L0000
        sty     L8D83
        ora     ($8E,x)
        .byte   $80
        brk
        .byte   $02
        brk
        brk
        dey
        eor     $03,x
        tax
        tax
        ldx     $85
        lda     $88
        brk
        dey
        beq     LDF91
        .byte   $AF
        .byte   $AF
        .byte   $EF
LDF91:  sta     $FF
        .byte   $03
        tax
        tax
        inc     LFF85
        .byte   $03
        .byte   $FA
        .byte   $FA
        inc     LFF8D,x
        brk
        cpy     L0100
        .byte   $87
        stx     $88
        ora     ($89,x)
        tya
        brk
        php
        txa
        cpy     LCEC9
        cmp     $D5
        bne     LDF3E
        tya
        brk
        ora     ($8C,x)
        stx     $8D
        ora     ($8E,x)
        bne     LDFBD
LDFBD:  ora     ($87,x)
        stx     $88
        ora     ($89,x)
        dey
        brk
        ora     ($87,x)
        stx     $88
        ora     ($89,x)
        dey
        brk
        php
        txa
        .byte   $9C
        .byte   $9C
        .byte   $D4
        cmp     $C1
        cmp     L888B
        brk
        php
        txa
        .byte   $9C
        .byte   $9C
LDFDC:  .byte   $D4
        .byte   $C5
LDFDE:  cmp     ($CD,x)
        .byte   $8B
        stx     L0000
        .byte   $03
        .byte   $87
        dey
        sty     L8D86
        asl     a
        stx     L8888
        .byte   $89
        brk
        brk
        .byte   $87
        dey
        dey
        sty     L8D86
        .byte   $03
        stx     L8988
        sty     L0000
        ora     ($8A,x)
        .byte   $8B
        .byte   $9C
        .byte   $04
        .byte   $8B
        brk
        brk
        txa
        .byte   $8B
        .byte   $9C
        ora     ($8B,x)
        sty     L0000
        ora     ($8A,x)
        .byte   $8B
        .byte   $9C
        .byte   $04
        .byte   $8B
        brk
        brk
        txa
        .byte   $8B
        .byte   $9C
        ora     ($8B,x)
        sty     L0000
        ora     ($8A,x)
        .byte   $83
        .byte   $9C
        sty     $01
        sty     $9C
        .byte   $04
        .byte   $8B
        brk
        brk
        txa
        sty     $9C
        sty     $01
        .byte   $83
        .byte   $9C
        ora     ($8B,x)
        sty     L0000
        ora     ($8A,x)
        .byte   $83
        .byte   $9C
        .byte   $04
        ora     ($87,x)
        dey
        .byte   $89
        sty     $9C
        .byte   $04
        .byte   $8B
        brk
        brk
        txa
        sty     $9C
        .byte   $04
        .byte   $87
        dey
        .byte   $89
        ora     ($83,x)
        .byte   $9C
        ora     ($8B,x)
        sty     L0000
        .byte   $02
        txa
        .byte   $9C
        .byte   $83
        ora     ($13,x)
        txa
        lda     $018B,y
        ora     ($9C,x)
        .byte   $9C
        .byte   $8B
        brk
        brk
        txa
        .byte   $9C
        .byte   $9C
        ora     ($01,x)
        txa
        lda     $018B,y
        .byte   $83
        .byte   $9C
        ora     ($8B,x)
        sty     L0000
        .byte   $02
        txa
        .byte   $9C
        .byte   $83
        ora     ($13,x)
        .byte   $87
        dey
        .byte   $89
        dey
        .byte   $89
        .byte   $9C
        .byte   $9C
        .byte   $8B
        brk
        brk
        txa
        .byte   $9C
        .byte   $9C
        .byte   $87
        dey
        .byte   $87
        dey
        .byte   $89
        ora     ($83,x)
        .byte   $9C
        ora     ($8B,x)
        sty     L0000
        ora     ($8A,x)
        .byte   $83
        .byte   $9C
        .byte   $14
        ora     ($8A,x)
        cmp     $8B
        clv
        .byte   $8B
        .byte   $9C
        .byte   $9C
        .byte   $8B
        brk
        brk
        txa
        .byte   $9C
        .byte   $9C
        txa
        clv
        txa
        cmp     $8B
        ora     ($83,x)
        .byte   $9C
        ora     ($8B,x)
        sty     L0000
        ora     ($8A,x)
        .byte   $83
        .byte   $9C
        .byte   $14
        ora     ($8A,x)
        dec     L8D8B
        stx     L9C9C
        .byte   $8B
        brk
        brk
        txa
        .byte   $9C
        .byte   $9C
        sty     L8A8D
        dec     $018B
        .byte   $83
        .byte   $9C
        ora     ($8B,x)
        sty     L0000
        php
        txa
        .byte   $9C
        ora     ($87,x)
        dey
        txa
        cpy     $8B
        sty     $9C
        .byte   $04
        .byte   $8B
        brk
        brk
        txa
        sty     $9C
        php
        txa
        cpy     $8B
        dey
        .byte   $89
        ora     ($9C,x)
        .byte   $8B
        sty     L0000
        php
        txa
        .byte   $9C
        ora     ($8A,x)
        tsx
        txa
        .byte   $9C
        .byte   $8B
        sty     $9C
        .byte   $04
        .byte   $8B
        brk
        brk
        txa
        sty     $9C
        php
        txa
        .byte   $9C
        .byte   $8B
        tsx
        .byte   $8B
        ora     ($9C,x)
        .byte   $8B
        sty     L0000
        php
        txa
        .byte   $9C
        ora     ($8C,x)
        sta     L8D8C
        stx     L9C84
        .byte   $04
        .byte   $8B
        brk
        brk
        txa
        sty     $9C
        php
        sty     L8E8D
        sta     $018E
        .byte   $9C
        .byte   $8B
        sty     L0000
        .byte   $02
        txa
        .byte   $9C
        .byte   $83
        ora     ($03,x)
        txa
        .byte   $BB
        .byte   $8B
        sty     $9C
        .byte   $04
        .byte   $8B
        brk
        brk
        txa
        sty     $9C
        .byte   $03
        txa
        .byte   $BB
        .byte   $8B
        .byte   $83
        ora     ($02,x)
        .byte   $9C
        .byte   $8B
        sty     L0000
        ora     ($8A,x)
        .byte   $83
        .byte   $9C
        .byte   $04
        ora     ($8C,x)
        sta     L848E
        .byte   $9C
        .byte   $04
        .byte   $8B
        brk
        brk
        txa
        sty     $9C
        .byte   $04
        sty     L8E8D
        ora     ($83,x)
        .byte   $9C
        ora     ($8B,x)
        sty     L0000
        ora     ($8A,x)
        .byte   $83
        .byte   $9C
        sty     $01
        sty     $9C
        .byte   $04
        .byte   $8B
        brk
        brk
        txa
        sty     $9C
        sty     $01
        .byte   $83
        .byte   $9C
        ora     ($8B,x)
        sty     L0000
        ora     ($8A,x)
        .byte   $8B
        .byte   $9C
        .byte   $04
        .byte   $8B
        brk
        brk
        txa
        .byte   $8B
        .byte   $9C
        ora     ($8B,x)
        sty     L0000
        ora     ($8A,x)
        .byte   $8B
        .byte   $9C
        .byte   $04
        .byte   $8B
        brk
        brk
        txa
        .byte   $8B
        .byte   $9C
        ora     ($8B,x)
        sty     L0000
        ora     ($8A,x)
        .byte   $8B
        .byte   $9C
        .byte   $04
        .byte   $8B
        brk
        brk
        txa
        .byte   $8B
        .byte   $9C
        ora     ($8B,x)
        sty     L0000
        ora     ($8C,x)
        .byte   $8B
        sta     L8E04
        brk
        brk
        sty     L8D8B
        ora     ($8E,x)
        .byte   $C2
        brk
        dey
        eor     $88,x
        lda     $1F
        brk
        asl     a
        asl     a
        brk
        brk
        asl     a
        asl     a
        brk
        brk
        .byte   $54
        eor     (L0000),y
        brk
        .byte   $54
        ora     (L0000),y
        brk
        .byte   $54
        ora     L0000,x
        brk
        eor     $51
        brk
        brk
        eor     $11
        brk
        brk
        .byte   $44
        ora     $91,x
        brk
        brk
        lda     $03
        .byte   $8B
        .byte   $02
        asl     $08
        ora     #$08
        ora     #$AC
        ldy     L8883
        .byte   $02
        .byte   $89
        .byte   $87
        sta     $88
        stx     $03
        bpl     LE1EF
        ora     $06
        .byte   $07
        php
LE1EF:  ora     #$08
        ora     #$08
        ora     #$D6
        cld
        cld
        lda     a:L0000
        .byte   $83
        .byte   $9C
        .byte   $02
        .byte   $8B
        txa
        sta     $9C
        sta     $03
        .byte   $0B
        bpl     LE217
        .byte   $12
        .byte   $13
        .byte   $14
        ora     $14,x
        ora     $14,x
        ora     $14,x
        sty     $AF
        .byte   $02
        ldx     L83AE
        .byte   $8D
        .byte   $02
LE217:  stx     L858C
        sta     $0384
        .byte   $07
        .byte   $1C
        ora     $1F1E,x
        jsr     LB100
        sta     $0200
        lda     ($85),y
        .byte   $83
        brk
        .byte   $03
        bvs     LE22F
LE22F:  adc     ($83),y
        .byte   $03
        .byte   $04
        rol     $27
        plp
        and     #$83
        brk
        ora     ($B1,x)
        sta     $0200
        lda     ($85),y
        .byte   $83
        brk
        .byte   $03
        .byte   $B2
        ldy     $6A,x
        .byte   $83
        .byte   $03
        .byte   $03
        rol     $302F
        sty     L0000
        ora     ($B1,x)
        sta     L0000
        .byte   $03
        ror     $77,x
        ror     $85,x
        brk
        .byte   $02
        lda     ($85),y
        sty     L0000
        .byte   $02
        .byte   $B3
        .byte   $74
        .byte   $83
        .byte   $03
        .byte   $02
        .byte   $34
        and     $85,x
        brk
        ora     ($B1,x)
        sty     L0000
        ora     $78
        adc     $7900,y
        .byte   $7B
        sty     L0000
        .byte   $02
        lda     ($85),y
        sta     L0000
        ora     ($6A,x)
        .byte   $83
        .byte   $03
        .byte   $02
        sec
        and     $85,y
        ora     ($B1,x)
        .byte   $83
        brk
        .byte   $02
        .byte   $7C
        rti

        .byte   $83
        brk
        .byte   $02
        adc     L837C,x
        brk
        .byte   $02
        lda     ($85),y
        sta     L0000
        ora     ($6A,x)
        .byte   $83
        .byte   $03
        ora     ($3C,x)
        stx     L0000
        ora     ($B1,x)
        .byte   $83
        brk
        .byte   $07
        ror     $7F00,x
        .byte   $80
        sta     (L0000,x)
        ror     a:$83,x
        .byte   $03
        lda     ($85),y
        .byte   $80
        sty     L0000
        ora     ($6A,x)
        .byte   $83
        .byte   $03
        ora     ($3C,x)
        stx     L0000
        ora     ($B1,x)
        .byte   $83
        brk
        .byte   $02
        .byte   $82
        .byte   $A7
        .byte   $83
        brk
        .byte   $02
        .byte   $83
        .byte   $82
        .byte   $83
        brk
        .byte   $02
        lda     ($85),y
        sta     L0000
        ora     ($6A,x)
        .byte   $83
        .byte   $03
        ora     ($3C,x)
        stx     L0000
        asl     a
        lda     ($86),y
        sty     $73
        brk
        .byte   $7B
        ror     L0000,x
        ror     $78,x
        sty     L0000
        .byte   $02
        lda     ($85),y
        sta     L0000
        ora     ($6A,x)
        .byte   $83
        .byte   $03
        ora     ($3C,x)
        sta     L0000
        asl     a
        .byte   $8F
        bcc     LE2F1
LE2F1:  brk
        sta     L0000
        brk
        adc     $7977,y
        sta     L0000
        .byte   $02
        lda     ($85),y
        sta     L0000
        ora     ($6A,x)
        .byte   $83
        .byte   $03
        ora     ($3C,x)
        sta     L0000
        ora     $93
        sty     L0000,x
        brk
        sta     $8A
        brk
        .byte   $02
        lda     ($85),y
        sty     L0000
        .byte   $02
        .byte   $64
        adc     $83
        .byte   $03
        ora     ($3C,x)
        sty     L0000
        asl     $85
        tya
        sta     L0000,y
        sta     $8A
        brk
        .byte   $02
        lda     ($85),y
        .byte   $83
        brk
        .byte   $03
        pla
        tay
        ror     a
        .byte   $83
        .byte   $03
        ora     ($3C,x)
        sta     L0000
        ora     $9D
        sta     L0000,y
        sta     $8A
        brk
        .byte   $02
        lda     ($85),y
        .byte   $83
        brk
        .byte   $03
        adc     $6E00
        .byte   $83
        .byte   $03
        ora     ($3C,x)
        sta     L0000
        ora     $9F
        sta     L0000,y
        lda     ($8A),y
        brk
        .byte   $02
        lda     ($85),y
        .byte   $83
        brk
        .byte   $03
        bvs     LE35C
LE35C:  .byte   $71
LE35D:  .byte   $83
        .byte   $03
        ora     ($3C,x)
        sty     L0000
        asl     $85
        lda     ($99,x)
        brk
        brk
        lda     ($8A),y
        brk
        .byte   $02
        lda     ($85),y
        .byte   $83
        brk
        .byte   $03
        .byte   $B2
        ldy     $6A,x
        .byte   $83
        .byte   $03
        ora     ($3C,x)
        sta     L0000
        ora     $A3
        ldy     L0000
        brk
        lda     ($8A),y
        brk
        .byte   $02
        lda     ($85),y
        sty     L0000
        .byte   $02
        .byte   $B3
        .byte   $74
        .byte   $83
        .byte   $03
        ora     ($3C,x)
        stx     L0000
        ora     #$85
        brk
        brk
        lda     (L0000),y
        brk
        ror     $77,x
        ror     $85,x
        brk
        .byte   $02
        lda     ($85),y
        sta     L0000
        ora     ($6A,x)
        .byte   $83
        .byte   $03
        ora     ($3C,x)
        stx     L0000
        asl     a
        lda     ($84),y
        stx     $69
        brk
        bcs     LE35D
        brk
        adc     L847B,y
        brk
        .byte   $02
        lda     ($85),y
        sta     L0000
        ora     ($6A,x)
        .byte   $83
        .byte   $03
        ora     ($3C,x)
        stx     L0000
        ora     ($B1,x)
        .byte   $83
        brk
        .byte   $02
        .byte   $7C
        rti

        .byte   $83
        brk
        .byte   $02
        rti

        .byte   $7C
        .byte   $83
        brk
        .byte   $02
        lda     ($85),y
        sta     L0000
        ora     ($6A,x)
        .byte   $83
        .byte   $03
        ora     ($3E,x)
        stx     L0000
        .byte   $01
LE3E0:  lda     ($83),y
        brk
        .byte   $07
        ror     $7F00,x
        .byte   $80
        sta     (L0000,x)
        .byte   $7A
        .byte   $83
        brk
        .byte   $03
        lda     ($85),y
        .byte   $80
        sty     L0000
        ora     ($6A,x)
        .byte   $83
        .byte   $03
        .byte   $02
        .byte   $42
LE3F9:  .byte   $43
        sta     L0000
        ora     ($B1,x)
        .byte   $83
        brk
        .byte   $02
        .byte   $82
        .byte   $A7
        .byte   $83
        brk
        .byte   $02
        .byte   $83
        .byte   $3F
        .byte   $83
        brk
        .byte   $02
        lda     ($85),y
        sta     L0000
        ora     ($6A,x)
        .byte   $83
        .byte   $03
        .byte   $02
        lsr     $47
        sta     L0000
        ora     ($B1,x)
        sty     L0000
        ora     $7B
        ror     L0000,x
        ror     $78,x
        sty     L0000
        .byte   $02
        lda     ($85),y
        sta     L0000
        ora     ($6A,x)
        sty     $03
        .byte   $02
        lsr     a
        .byte   $4B
        sty     L0000
        ora     ($B1,x)
        sta     L0000
        .byte   $03
        adc     $7977,y
        sta     L0000
        .byte   $02
        lda     ($85),y
        sta     L0000
        ora     ($6A,x)
        sty     $03
        .byte   $03
        lsr     $504F
        .byte   $83
        brk
        ora     ($B1,x)
        .byte   $83
        brk
        asl     $6A
        adc     ($C6,x)
        .byte   $CB
        .byte   $DA
        inc     a:$84,x
        .byte   $02
        lda     ($85),y
        sta     L0000
        ora     ($6A,x)
        sta     $03
        asl     $54
        eor     $56,x
        .byte   $57
        brk
        lda     ($8D),y
        brk
        .byte   $02
        lda     ($85),y
        sta     L0000
        ora     ($6A,x)
        .byte   $87
        .byte   $03
        ora     $5D5C,y
        lsr     $5E5F,x
        .byte   $5F
        lsr     $5E5F,x
        .byte   $5F
        lsr     $5E5F,x
        .byte   $5F
        lsr     $5E5F,x
        .byte   $5F
        lsr     $5E5F,x
        .byte   $5F
        lsr     $5E5F,x
        ldy     #$03
        sty     $AA
        .byte   $02
        asl     a
        txa
LE494:  .byte   $83
        tax
        .byte   $2F
        rol     a
        cpy     $7040
        brk
LE49C:  .byte   $33
        .byte   $CF
        tax
        brk
        cpy     LDFDC
        ora     ($3F),y
        cpy     a:$AA
        eor     $33,x
        ora     $3300
        .byte   $FC
        tax
        brk
        eor     $11,x
        bvs     LE4B4
LE4B4:  .byte   $33
        .byte   $CF
        tax
        brk
        cpy     LF5CD
        and     ($F3),y
        cpy     LA2AA
        cpy     LFDCC
        brk
        .byte   $33
        .byte   $FC
        dey
        tax
        .byte   $87
        cmp     ($01),y
        .byte   $02
        tya
        cmp     ($85),y
        dey
        .byte   $02
        .byte   $89
        .byte   $87
        .byte   $83
        dey
        asl     $AC
        ldy     $0908
        php
        ora     #$89
        .byte   $02
        .byte   $87
        cmp     ($85),y
LE4E1:  .byte   $9C
        .byte   $02
        .byte   $8B
        txa
        .byte   $83
        .byte   $9C
        bpl     LE4E9
LE4E9:  brk
        dec     $D8,x
        cld
        lda     $0908
        php
        ora     #$08
        ora     #$0C
        ora     $0F0E
        stx     $D1
        sta     $8D
        .byte   $02
        stx     L838C
        sta     LAE02
        ldx     LAF84
        .byte   $0B
        ora     $14,x
        ora     $14,x
        ora     $14,x
        ora     $18,x
        ora     $1B1A,y
        sta     $D1
        .byte   $03
        .byte   $72
        brk
        bvs     LE49C
        brk
        .byte   $02
        lda     ($85),y
        sta     $0700
        sta     L0000
        and     ($22,x)
        .byte   $23
        bit     $25
        sty     $D1
        .byte   $03
        .byte   $6B
        .byte   $73
        pla
LE52D:  .byte   $83
        brk
        .byte   $02
        lda     ($85),y
        sta     L0100
        sta     $83
        brk
        .byte   $04
        rol     a
        .byte   $2B
        bit     L832D
        cmp     ($02),y
        adc     $B5,x
        sty     L0000
        .byte   $02
        lda     ($85),y
        sta     L0000
        .byte   $03
        ldx     $77,y
        ldx     $85,y
        brk
        ora     ($85,x)
        sty     L0000
        .byte   $03
        and     ($32),y
        .byte   $33
        .byte   $83
        cmp     ($01),y
        .byte   $6B
        sta     L0000
        .byte   $02
        lda     ($85),y
        sty     L0000
        ora     $78
        .byte   $AB
        brk
        .byte   $AB
        .byte   $7B
        sty     L0000
        ora     ($85,x)
        sta     L0000
        .byte   $02
        rol     $37,x
        .byte   $83
        cmp     ($01),y
        .byte   $6B
        sta     L0000
        .byte   $02
        lda     ($85),y
        .byte   $83
        brk
        .byte   $02
        .byte   $7C
        rti

        .byte   $83
        brk
        .byte   $02
        rti

        .byte   $7C
        .byte   $83
        brk
        ora     ($85,x)
        sta     L0000
        .byte   $02
        .byte   $3A
        .byte   $3B
        .byte   $83
        cmp     ($01),y
        .byte   $6B
        sty     L0000
        .byte   $03
        .byte   $80
        lda     ($85),y
        .byte   $83
        brk
        .byte   $07
        ror     $7F00,x
        .byte   $80
        sta     (L0000,x)
        ror     a:$83,x
        ora     ($85,x)
        stx     L0000
        ora     ($3D,x)
        .byte   $83
        cmp     ($01),y
        .byte   $6B
        sta     L0000
        .byte   $02
        lda     ($85),y
        .byte   $83
        brk
        .byte   $02
        .byte   $82
        .byte   $A7
        .byte   $83
        brk
        .byte   $02
        .byte   $A7
        .byte   $82
        .byte   $83
        brk
        ora     ($B1,x)
        stx     L0000
        ora     ($3D,x)
        .byte   $83
        cmp     ($01),y
LE5C7:  .byte   $6B
        sta     L0000
        .byte   $02
        lda     ($85),y
        sty     L0000
        asl     a
        .byte   $7B
        ldx     L0000,y
        ror     $B0,x
        brk
        ldy     $84,x
        sty     $B1
        stx     L0000
        ora     ($3D,x)
        .byte   $83
        cmp     ($01),y
        .byte   $6B
        sta     L0000
        .byte   $02
        lda     ($85),y
        sta     L0000
        asl     a
        adc     LAB77,y
        brk
        brk
        lda     (L0000),y
        brk
        sta     ($92),y
        sta     L0000
        ora     ($3D,x)
        .byte   $83
        cmp     ($02),y
        ror     $67
        sty     L0000
        .byte   $02
LE600:  lda     ($85),y
        txa
        brk
        ora     $B1
        brk
        brk
        sta     $96,x
        sta     L0000
        ora     ($3D,x)
        .byte   $83
        cmp     ($03),y
        .byte   $6B
        adc     #$6C
        .byte   $83
        brk
        .byte   $02
        lda     ($85),y
        txa
        brk
        asl     $B1
        brk
        brk
        txs
        .byte   $9B
        lda     ($84),y
        brk
        ora     ($3D,x)
        .byte   $83
        cmp     ($03),y
        .byte   $6F
        brk
        lda     #$83
        brk
        .byte   $02
        lda     ($85),y
        txa
        brk
        ora     $B1
        brk
        brk
        txs
        .byte   $9E
        sta     L0000
        ora     ($3D,x)
        .byte   $83
        cmp     ($03),y
        .byte   $72
        brk
        bvs     LE5C7
        brk
        .byte   $02
        sta     $B1
        txa
        brk
        ora     $85
        brk
        brk
        txs
        ldy     #$85
        brk
        ora     ($3D,x)
        .byte   $83
        cmp     ($03),y
        .byte   $6B
        .byte   $73
        pla
        .byte   $83
        brk
        .byte   $02
        sta     $B1
        txa
        brk
        asl     $85
        brk
        brk
        txs
        ldx     #$B1
        sty     L0000
        ora     ($3D,x)
        .byte   $83
        cmp     ($02),y
        adc     $B5,x
        sty     L0000
        .byte   $02
        sta     $B1
        txa
        brk
        ora     $85
        brk
        brk
        lda     $A6
        sta     L0000
        ora     ($3D,x)
        .byte   $83
        cmp     ($01),y
        .byte   $6B
        sta     L0000
        .byte   $02
        sta     $B1
        sta     L0000
        ora     #$76
        .byte   $77
        ldx     L0000,y
        brk
        sta     L0000
        brk
        lda     ($86),y
        brk
        ora     ($3D,x)
        .byte   $83
        cmp     ($01),y
        .byte   $6B
        sta     L0000
        .byte   $02
        sta     $B1
        sty     L0000
        asl     a
        sei
        .byte   $AB
        brk
        .byte   $AB
        .byte   $7B
        brk
        adc     #$84
        stx     $B1
        stx     L0000
        ora     ($3D,x)
        .byte   $83
        cmp     ($01),y
        .byte   $6B
        sta     L0000
        .byte   $02
        sta     $B1
        .byte   $83
        brk
        .byte   $02
        .byte   $7C
        adc     a:$83,x
        .byte   $02
        rti

        .byte   $7C
        .byte   $83
        brk
        ora     ($B1,x)
        stx     L0000
        ora     ($3D,x)
        .byte   $83
        cmp     ($01),y
        .byte   $6B
        sty     L0000
        .byte   $03
        .byte   $80
        sta     $B1
        .byte   $83
        brk
        .byte   $07
        ror     $7F00,x
        .byte   $80
        sta     (L0000,x)
        .byte   $7A
        .byte   $83
        brk
        ora     ($B1,x)
        stx     L0000
        ora     ($41,x)
        .byte   $83
        cmp     ($01),y
        .byte   $6B
        sta     L0000
        .byte   $02
        sta     $B1
        .byte   $83
        brk
        .byte   $02
LE6F8:  .byte   $82
        .byte   $A7
        .byte   $83
        brk
        .byte   $02
        .byte   $83
        .byte   $3F
        .byte   $83
        brk
        ora     ($B1,x)
        sta     L0000
        .byte   $02
        .byte   $44
        eor     $83
        cmp     ($01),y
        .byte   $6B
        sta     L0000
        .byte   $02
        sta     $B1
        sty     L0000
        ora     $7B
        ldx     L0000,y
        ldx     $78,y
        sty     L0000
        ora     ($B1,x)
        sta     L0000
        .byte   $02
        pha
        eor     #$83
        cmp     ($01),y
        .byte   $6B
        sta     L0000
        .byte   $02
        sta     $B1
        sta     L0000
        .byte   $03
        .byte   $AB
        .byte   $77
        .byte   $AB
        sta     L0000
        ora     ($B1,x)
        sty     L0000
        .byte   $02
        jmp     L844D

        cmp     ($01),y
        .byte   $6B
        sta     L0000
        .byte   $02
        sta     $B1
        .byte   $83
        brk
        asl     $6A
        adc     ($C6,x)
        .byte   $CB
        .byte   $DA
        inc     a:$84,x
        ora     ($B1,x)
        .byte   $83
        brk
        .byte   $03
        eor     ($52),y
        .byte   $53
        sty     $D1
        ora     ($6B,x)
        sta     L0000
        .byte   $02
        sta     $B1
        sta     $0600
        lda     (L0000),y
        cli
        eor     $5B5A,y
        sta     $D1
        ora     $5E5F,y
        .byte   $5F
        lsr     $5E5F,x
        .byte   $5F
        lsr     $5E5F,x
        .byte   $5F
        lsr     $5E5F,x
        .byte   $5F
        lsr     $5E5F,x
        .byte   $5F
        lsr     $5E5F,x
        .byte   $5F
        .byte   $62
        .byte   $63
        .byte   $A7
        cmp     ($83),y
        tax
        ora     (L000A,x)
        sty     $AA
        .byte   $2F
        .byte   $37
        cpy     LD000
        bpl     LE7C6
        txa
        tax
        .byte   $33
        .byte   $CF
        cpy     $51FF
        .byte   $13
        brk
        tax
        .byte   $F3
        cpy     $0500
        cpy     a:$55
        tax
        .byte   $37
        .byte   $44
        brk
        beq     LE7EE
        eor     L0000,x
        tax
        .byte   $33
        .byte   $74
        cpy     $3DFD
        ora     (L0000),y
        tax
        .byte   $F3
        .byte   $44
        cpy     #$F7
        .byte   $33
        ora     ($A8),y
        .byte   $89
        tax
        brk
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
LE7C6:  .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
LE7E3:  .byte   $FF
        .byte   $FF
        .byte   $FF
LE7E6:  .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
LE7EE:  .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
LE7F9:  adc     ($55,x)
        stx     $AA
        clc
        brk
        brk
        .byte   $33
        .byte   $54
        eor     $66,x
        .byte   $33
        .byte   $54
        eor     $66,x
        .byte   $33
        .byte   $54
        eor     $66,x
        .byte   $33
        .byte   $54
        eor     $66,x
        .byte   $CB
        cmp     LEEEE,x
        .byte   $CB
        sbc     LEEED
        .byte   $CB
        cmp     LDEEE,x
        .byte   $CB
        cmp     LEEDE,x
        .byte   $43
        eor     $66,x
        ror     $43
        adc     $66
        lsr     $43,x
        eor     $66,x
        ror     $43
        adc     $65
        ror     $BB
        .byte   $DC
        cmp     LBBEE,x
        .byte   $DC
        cmp     LBBEE,x
        .byte   $DC
        cmp     LBBEE,x
        .byte   $DC
        cmp     $33EE,x
        .byte   $44
        eor     $66,x
        .byte   $33
        .byte   $44
        eor     $66,x
        .byte   $33
        .byte   $44
        eor     $66,x
        .byte   $33
        .byte   $44
        eor     $66,x
        .byte   $BB
        .byte   $DC
        cmp     LBBED,x
        cpy     LDDED
        .byte   $BB
        .byte   $DC
        cmp     LBBDD,x
        .byte   $DB
        dec     $33ED,x
        .byte   $44
        eor     $55,x
        .byte   $33
        .byte   $53
        lsr     $65,x
        .byte   $33
        .byte   $54
        adc     $55
        .byte   $33
        .byte   $54
        eor     $65,x
        .byte   $BB
        cpy     LEFDD
        .byte   $BB
        cpy     LFEEC
        .byte   $BB
        .byte   $DC
        cmp     LBBEE,x
        cpy     LEEDD
        .byte   $33
        .byte   $44
        .byte   $54
        ror     $33
        .byte   $54
        eor     $56,x
        .byte   $33
        .byte   $43
        adc     $56
        .byte   $33
        .byte   $44
        eor     $66,x
        .byte   $BB
        .byte   $DC
        sbc     LBBDE
        .byte   $DB
        cmp     LBBEE,x
        cpy     LDEDE
        .byte   $BB
        .byte   $DC
        cmp     $33EE,x
        .byte   $54
        adc     $65
        .byte   $33
        .byte   $53
        eor     $66,x
        .byte   $33
        .byte   $54
        lsr     $56,x
        .byte   $33
        .byte   $44
        eor     $66,x
        .byte   $BB
        cpy     LEEDD
        .byte   $BB
        cpy     LFEDE
        .byte   $BB
        .byte   $CB
        cmp     LBBEE,x
        cpy     LEFFD
        .byte   $22
        bpl     LE8E5
        .byte   $43
        bpl     LE8F8
        .byte   $32
        .byte   $34
        .byte   $22
        bpl     LE8FD
        .byte   $34
        bpl     LE900
        .byte   $33
        .byte   $44
        txs
        tax
        tsx
        .byte   $CB
        tax
        .byte   $BB
        .byte   $CB
        .byte   $DC
        tax
        lda     LCEBB,y
        tay
        lda     #$BA
        .byte   $CB
        .byte   $12
        .byte   $22
        .byte   $33
        .byte   $54
        .byte   $32
LE8E5:  .byte   $22
        .byte   $43
        lsr     $32
        and     ($43,x)
        lsr     $22,x
        .byte   $22
        .byte   $43
        .byte   $44
        tay
        tax
        tax
        .byte   $CB
        tay
        tax
        .byte   $AB
        .byte   $CC
LE8F8:  sta     LBAAA,y
        .byte   $CB
        tsx
LE8FD:  lda     #$AA
        .byte   $DC
LE900:  .byte   $33
        brk
        .byte   $23
        .byte   $43
        .byte   $22
        brk
        .byte   $32
        .byte   $54
        ora     ($32),y
        .byte   $23
        .byte   $43
        bpl     LE940
        .byte   $32
        .byte   $44
        .byte   $BB
        tsx
        tax
        cmp     LABBB
        .byte   $AB
        .byte   $EB
        .byte   $BB
        .byte   $AB
        tsx
        dec     LBBBB
        tax
        cpy     $3233
        .byte   $22
        .byte   $63
        .byte   $33
        .byte   $33
        .byte   $33
        lsr     $33
        .byte   $32
        .byte   $42
        .byte   $53
        .byte   $33
        .byte   $33
        .byte   $23
        .byte   $43
        .byte   $BB
        tsx
        .byte   $AB
        cpy     LBBBB
        dex
        sbc     LB9BB
        .byte   $AB
        .byte   $CB
        .byte   $BB
        .byte   $BB
        tsx
        .byte   $CD
LE940:  and     ($32,x)
        .byte   $33
        .byte   $64
        lda     #$BA
        .byte   $32
        .byte   $53
        lda     #$BA
        .byte   $43
        .byte   $44
        lda     #$BA
        .byte   $34
        .byte   $53
        and     ($32,x)
        .byte   $BB
        .byte   $DC
        lda     #$BA
        tsx
        cpx     LBAA9
        .byte   $AB
        dec     LBAA9
        dex
        .byte   $DB
        bpl     LE994
        .byte   $33
        .byte   $54
        and     ($33,x)
        .byte   $34
        ror     $21
        .byte   $23
        .byte   $33
        .byte   $54
        tya
        lda     #$42
        eor     $21
        .byte   $32
        tax
        cpx     $3221
        tsx
        .byte   $CB
        and     ($32,x)
        .byte   $AB
        cpx     LBAA9
        tsx
        .byte   $DB
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        .byte   $07
        ora     ($07,x)
        .byte   $01
LE994:  .byte   $03
        .byte   $04
        ora     $0C
        .byte   $03
        .byte   $04
        ora     #$0C
        .byte   $04
        ora     $04
        ora     $06
        asl     $06
        asl     $01
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($03,x)
        .byte   $0B
        .byte   $0C
        ora     L0F0F
        .byte   $0F
        .byte   $0F
        asl     $06
        asl     $06
        asl     $06
        asl     $06
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($08,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     $030C
        ora     $0F
        .byte   $0F
        .byte   $0F
        .byte   $0F
        asl     $06
        asl     $06
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        .byte   $03
        ora     $07
        .byte   $0C
        .byte   $04
        ora     #$09
        .byte   $0C
        .byte   $04
        ora     $04
        ora     $01
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($07,x)
        ora     (L000A,x)
        asl     $0A03
        ora     $0C
        .byte   $03
        asl     a
        ora     #$0C
        .byte   $04
        ora     $04
        ora     $06
        asl     $06
        asl     $01
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     (L000A,x)
        asl     $0101
        asl     a
        asl     a
        asl     a
        brk
        php
        ora     #$08
        ora     #$06
        asl     $06
        asl     $06
        asl     $06
        asl     $01
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        php
        asl     a
        asl     a
        ora     ($01,x)
        brk
        asl     a
        asl     a
        asl     a
        .byte   $0F
        ora     #$08
        ora     #$06
        asl     $06
        asl     $01
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        asl     $0E0E
        asl     a
        asl     $0C07
        .byte   $04
        ora     #$09
        .byte   $0C
        .byte   $04
        ora     $04
        ora     $01
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($07,x)
        ora     ($07,x)
        ora     ($03,x)
        .byte   $04
        ora     $0C
        .byte   $03
        .byte   $04
        ora     #$0C
        .byte   $04
        ora     $04
        ora     $06
        asl     $06
        asl     $01
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($03,x)
        .byte   $0B
        .byte   $0C
        ora     $050C
        .byte   $04
        .byte   $0F
        asl     $06
        asl     $06
        asl     $06
        asl     $06
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($08,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     $030C
        ora     $0F
        ora     $04
        .byte   $0C
        asl     $06
        asl     $06
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
LEAEE:  ora     ($01,x)
        ora     ($01,x)
        ora     ($01,x)
        .byte   $03
        ora     $07
        .byte   $0C
        .byte   $04
        ora     #$09
        .byte   $0C
        .byte   $04
        ora     $04
        .byte   $05
LEB00:  .byte   $03
        .byte   $07
        .byte   $07
        .byte   $0C
        .byte   $03
        .byte   $07
        .byte   $0C
        .byte   $0C
        .byte   $03
        .byte   $04
        ora     #$0C
        .byte   $04
        ora     $09
        brk
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        ora     $06
        ora     $06
        .byte   $03
        brk
        .byte   $03
        brk
        .byte   $03
        .byte   $04
        brk
        .byte   $04
        .byte   $04
        ora     $06
        .byte   $0C
        .byte   $04
        .byte   $04
        .byte   $04
        ora     $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        asl     $06
        asl     $06
        ora     $05
        asl     $06
        .byte   $03
        brk
        .byte   $03
        brk
        .byte   $03
        .byte   $04
        .byte   $03
        brk
        .byte   $04
        ora     $06
        .byte   $0C
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        asl     $06
        asl     $06
        ora     $07
        ora     $0C
        .byte   $03
        .byte   $07
        .byte   $03
        .byte   $0C
        .byte   $04
        ora     $09
        .byte   $0C
        .byte   $04
        ora     $09
        brk
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $03
        .byte   $07
        .byte   $07
        brk
        .byte   $03
        .byte   $07
        .byte   $0C
        brk
        .byte   $03
        .byte   $04
        ora     #$00
        .byte   $04
        ora     $09
        ora     #$02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        ora     $06
        ora     $06
        .byte   $03
        .byte   $03
        .byte   $0C
        brk
        .byte   $03
        .byte   $04
        .byte   $04
        brk
        .byte   $04
        ora     $06
        brk
        .byte   $04
        .byte   $04
        .byte   $04
        ora     $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        asl     $06
        asl     $06
        ora     $05
        asl     $06
        .byte   $03
        .byte   $0C
        .byte   $03
        brk
        .byte   $03
        .byte   $04
        .byte   $03
        brk
        .byte   $04
        ora     $06
        brk
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        asl     $06
        asl     $06
        ora     $07
        ora     L0000
        .byte   $03
        .byte   $07
        .byte   $03
        brk
        .byte   $04
        ora     $09
        brk
        .byte   $04
        ora     $09
        brk
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $03
        .byte   $07
        .byte   $07
LEC03:  .byte   $0C
        .byte   $03
        .byte   $07
LEC06:  .byte   $0C
        .byte   $0C
        .byte   $03
        .byte   $04
        ora     #$0C
        .byte   $04
        ora     $09
        ora     #$02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
LEC15:  .byte   $02
        .byte   $02
        .byte   $02
LEC18:  .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        ora     $06
LEC22:  ora     $06
        .byte   $03
        .byte   $0C
        .byte   $03
        ora     $0403
        .byte   $0C
        .byte   $04
        .byte   $04
        ora     $06
        .byte   $0C
        .byte   $04
        .byte   $04
        .byte   $04
        ora     $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        asl     $06
        asl     $06
        ora     $05
        asl     $06
LEC44:  .byte   $03
        .byte   $0C
        .byte   $03
        ora     $0403
        .byte   $03
        .byte   $0C
        .byte   $04
        ora     $06
        .byte   $0C
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        asl     $06
        asl     $06
        ora     $07
        ora     $0C
        .byte   $03
        .byte   $07
        .byte   $03
        .byte   $0C
        .byte   $04
        ora     $09
        .byte   $0C
        .byte   $04
        ora     $09
        .byte   $0C
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        .byte   $02
        bmi     LEC03
        .byte   $14
        bvc     LEC06
        asl     $0780,x
        .byte   $07
        .byte   $07
        .byte   $80
        ora     #$09
LEC8D:  ora     #$80
        .byte   $07
        .byte   $80
        ora     #$80
        bvs     LEC15
        bvs     LEC18
        .byte   $0F
        .byte   $80
        .byte   $44
        .byte   $44
        .byte   $80
        bvs     LECCE
        ora     ($D0,x)
        bcc     LEC22
        jmp     L804C

        .byte   $22
        .byte   $02
        rol     LEEE0
        cpx     #$2E
        .byte   $80
        bmi     LECB0
        .byte   $D0
LECB0:  .byte   $80
        sta     ($14,x)
        .byte   $80
        sta     ($28,x)
        .byte   $80
        .byte   $53
        bvc     LEC8D
        .byte   $0C
        cmp     LD3C0,x
        .byte   $80
        rol     $0A81
        bne     LEC44
        .byte   $8F
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
LECCE:  .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
LED00:  lda     $057D
        beq     LED0A
        dec     $057D
        bpl     LED1F
LED0A:  ldx     $057E
        cpx     #$03
        beq     LED1F
        lda     #$78
        sta     L000A
        lda     #$ED
        sta     $0B
        lda     $057F
        jsr     L8359
LED1F:  ldx     #$02
LED21:  txa
        pha
        lda     $0581,x
        asl     a
        asl     a
        sta     L000A
        txa
        ora     L000A
        tay
        lda     #$26
        sta     L000A
        lda     LED62,x
        sta     $0B
        lda     LED65,x
        sta     $CF
        lda     LED68,y
        tay
        jsr     LC0F5
        pla
        tax
        dex
        bpl     LED21
        jsr     L8730
        bcc     LED61
        lda     L0000
        ror     a
        lda     #$97
        bcs     LED56
        lda     #$A7
LED56:  sta     $DC
        lda     #$50
        sta     $DF
        .byte   $A2
LED5D:  php
        jsr     L8517
LED61:  rts

LED62:  clv
        dex
        .byte   $DC
LED65:  brk
        ora     ($03,x)
LED68:  asl     $46
        stx     L0000
        .byte   $1C
        .byte   $5C
        .byte   $9C
        brk
        asl     $56,x
        stx     L0000,y
        .byte   $1C
        .byte   $5C
        .byte   $9C
        brk
        .byte   $82
        sbc     LED9C
        .byte   $C3
        sbc     LEDD2
        cpx     $ED
        inc     $057F
        inc     $0581,x
        lda     #$22
        sta     $0585
        lda     LED99,x
        sta     $0587
        lda     #$10
        sta     $0580
        rts

LED99:  bcs     LED5D
        .byte   $D4
LED9C:  dec     $0580
        beq     LEDA2
        rts

LEDA2:  lda     #$04
        sta     $0580
        inc     $0581,x
        inc     $057F
LEDAD:  lda     $0585
        sta     $DC
        lda     $0587
        sta     $DF
        lda     #$FE
        sta     $DD
        lda     #$03
        sta     $DE
        jsr     L8AD8
        rts

        dec     $0580
        bne     LEDCE
        inc     $0581,x
        inc     $057F
LEDCE:  jsr     LEDAD
        rts

LEDD2:  lda     #$1E
        sta     $058A
        lda     #$19
        sta     $058C
        lda     #$0C
        sta     $058D
        inc     $057F
        ldx     #$04
LEDE6:  lda     $0584,x
        sta     $D1,x
        dex
        bpl     LEDE6
        lda     $058A
        ldy     $058C
        jsr     LCF4E
        ldx     #$04
LEDF9:  lda     $D1,x
        sta     $0584,x
        dex
        bpl     LEDF9
        jsr     LEDAD
        lda     $0589
        sbc     #$18
        sta     $0589
        lda     $058A
        sbc     #$00
        sta     $058A
        lda     $0587
        cmp     #$10
        bcc     LEE28
        dec     $058D
        bne     LEE30
        dec     $058C
        dec     $058D
        bne     LEE30
LEE28:  inc     $057E
        lda     #$00
        sta     $057F
LEE30:  rts

        jsr     L837D
        rts

        and     $65EE,x
        inc     LEEA1
        ldx     LEAEE
        nop
        nop
        nop
        nop
        lda     $06FF
        bmi     LEE60
        cmp     #$3F
        bne     LEE60
        ora     #$80
        sta     $06FF
        lda     #$00
        sta     $FD
        sta     $FC
        sta     $FE
        lda     #$80
        sta     $0E
        inc     $09
        bne     LEE64
LEE60:  lda     #$03
        sta     $09
LEE64:  rts

        ldx     #$1F
LEE67:  lda     LEE81,x
        sta     $03D6,x
        dex
        bpl     LEE67
        inc     $0C
        lda     #$1E
        sta     $FE
        lda     #$04
        sta     $043E
        sta     $043F
        inc     $09
        rts

LEE81:  jsr     L0F0F
        .byte   $0F
        jsr     L0F0F
        .byte   $0F
        jsr     L0F0F
        .byte   $0F
        jsr     L0F0F
        .byte   $0F
        jsr     L0F0F
        .byte   $0F
        jsr     L0F0F
        .byte   $0F
        jsr     L0F0F
        .byte   $0F
        jsr     L0F0F
        .byte   $0F
LEEA1:  dec     $043E
        bne     LEEAD
        dec     $043F
        bne     LEEAD
        inc     $09
LEEAD:  rts

        lda     #$01
        sta     $04A9
        rts

LEEB4:  lda     #$20
        sta     $2006
        lda     #$00
        sta     $2006
        ldx     #$04
        ldy     #$00
        lda     #$9C
LEEC4:  sta     $2007
        dey
        bne     LEEC4
        dex
        bne     LEEC4
        ldx     #$00
LEECF:  lda     LEEEE,x
        sta     $2006
        lda     LEEED,x
        sta     $2006
        inx
        inx
LEEDD:  .byte   $BD
LEEDE:  .byte   $ED
        .byte   $EE
LEEE0:  beq     LEEEC
        inx
        cmp     #$FE
        beq     LEECF
        sta     $2007
        bne     LEEDD
LEEEC:  rts

LEEED:  tay
LEEEE:  .byte   $20
LEEEF:  .byte   $C3
        .byte   $CF
        dec     LD2C7
        cmp     ($D4,x)
        cmp     $CC,x
        cmp     ($D4,x)
        cmp     #$CF
        dec     LDCD3
        inc     $2104,x
        .byte   $D4
        .byte   $D2
        cmp     LD49C,y
        iny
        cmp     #$D3
        .byte   $9C
        .byte   $D3
        cmp     $C3
        .byte   $D2
        cmp     $D4
        .byte   $9C
        .byte   $D4
        .byte   $D2
        cmp     #$C3
        .byte   $FF
        inc     $2164,x
        bne     LEEEE
        cmp     $D3
        .byte   $D3
        .byte   $9C
        cmp     ($9C,x)
        cmp     ($CE,x)
        .byte   $C4
LEF25:  .byte   $9C
        .byte   $C2
        .byte   $9C
        .byte   $C2
        cmp     $D4,x
        .byte   $D4
        .byte   $CF
        dec     L9CD3
        .byte   $CF
        dec     LA4FE
        and     ($C3,x)
        .byte   $CF
        dec     LD2D4
        .byte   $CF
        cpy     LC5CC
        .byte   $D2
        .byte   $D3
        .byte   $9C
        clv
        .byte   $9C
        cmp     ($CE,x)
        cpy     $9C
        lda     LD79C,y
        iny
        cmp     #$CC
        cmp     $FE
        cpx     $21
        bne     LEF25
        cmp     $D3
        .byte   $D3
        cmp     #$CE
        .byte   $C7
        .byte   $9C
        .byte   $D3
        .byte   $D4
        cmp     ($D2,x)
        .byte   $D4
        .byte   $9C
        cpy     $D5
LEF62:  .byte   $D2
        cmp     #$CE
        .byte   $C7
        .byte   $9C
        .byte   $D4
        iny
        cmp     $FE
        bit     $22
        .byte   $D4
        cmp     #$D4
        cpy     L9CC5
        .byte   $CF
        .byte   $D2
        .byte   $9C
        .byte   $D3
        cmp     $CC
        cmp     $C3
        .byte   $D4
        cmp     #$CF
        dec     LD39C
        .byte   $C3
        .byte   $D2
        cmp     $C5
        dec     LC8FE
        .byte   $22
        .byte   $D3
        .byte   $CF
        cmp     LD4C5
        iny
        cmp     #$CE
        .byte   $C7
        .byte   $9C
        .byte   $D7
        cmp     #$CC
        cpy     LC89C
        cmp     ($D0,x)
        bne     LEF62
        dec     LFF00
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
LEFC2:  .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
LEFDB:  .byte   $FF
        .byte   $FF
LEFDD:  .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
LEFF5:  .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
LEFFD:  .byte   $FF
        .byte   $FF
        .byte   $FF
LF000:  php
        .byte   $0B
        bpl     LF017
        clc
        asl     $201F,x
LF008:  asl     a
        .byte   $0F
        .byte   $12
        .byte   $17
        ora     $1F1E,x
LF00F:  .byte   $22
LF010:  php
        .byte   $0C
        ora     ($14),y
        .byte   $1A
        .byte   $1E
        .byte   $1F
LF017:  .byte   $21
LF018:  .byte   $13
LF019:  .byte   $1A
LF01A:  .byte   $21
LF01B:  plp
LF01C:  plp
LF01D:  .byte   $2F
LF01E:  rol     $36,x
        .byte   $3A
        eor     ($48,x)
        .byte   $4F
        lsr     $5D,x
        .byte   $64
        rol     $6B,x
        .byte   $72
        adc     L9820,y
        beq     LEFDB
        cli
        brk
        brk
        bpl     LEFC2
        sbc     ($19),y
        ora     $0101
        bpl     LF00F
        .byte   $F2
        eor     L0020
        ora     ($01,x)
        bpl     LEFF5
        sbc     ($5B),y
        and     a:L0000
        brk
        and     $5BF2,x
        rol     a:L0000
        php
        .byte   $EF
        beq     LF052
LF052:  jsr     LF340
        ora     a:$07
        brk
        jsr     LF34F
        adc     $41,y
        brk
        jsr     LF401
        .byte   $4B
        and     a:L0000
        brk
        .byte   $72
        .byte   $F4
        plp
        .byte   $12
        ora     ($01,x)
        brk
        .byte   $AF
        .byte   $F4
        ror     a
        rol     $01,x
        ora     (L0000,x)
        .byte   $63
        sbc     $87,x
        .byte   $44
        ora     ($01,x)
        brk
        rol     $54F6
        .byte   $27
        ora     ($01,x)
        php
        lda     ($F6),y
        eor     $24
        ora     ($01,x)
        php
        .byte   $0C
        .byte   $F7
        .byte   $64
        and     $0101,x
        php
        sty     $F7,x
        ror     $3F
        ora     ($01,x)
        sta     $3E
        sta     ($40,x)
        sta     $42
        sta     ($44,x)
        .byte   $87
        lsr     $48
        lsr     a
        sty     $4C
        lsr     $5250
        .byte   $54
        .byte   $54
        sta     ($56,x)
        ror     $7E56,x
        .byte   $87
        sec
        ror     L8238,x
        sec
        .byte   $87
        bmi     LF0ED
        sec
        .byte   $3A
        ror     L833A,x
        sec
        .byte   $87
        bmi     LF0F6
        rol     $38,x
        .byte   $3A
        rol     $4287,x
        ror     L8242,x
        .byte   $42
        stx     $7E
        .byte   $87
        jmp     L7E46

        .byte   $42
        .byte   $82
        rol     $4687,x
        jmp     L8256

        .byte   $52
        bvc     LF129
        pha
        stx     $46
        .byte   $87
        rol     $5050,x
        jmp     L4886

        .byte   $87
        rol     $4242,x
        lsr     $82
LF0ED:  pha
        pha
        brk
        sta     $3A
        sta     ($38,x)
        sta     $36
LF0F6:  sta     ($32,x)
        .byte   $87
        .byte   $34
        rol     $38,x
        sty     $3A
        .byte   $3C
        rol     $4240,x
        .byte   $42
        sta     ($48,x)
        ror     $2E87,x
        .byte   $34
        rol     $7E26,x
        rol     $82
        rol     $87
        jsr     L2622
        rol     a
        ror     L832A,x
        rol     $87
        jsr     L2422
        rol     $2A
        rol     $7E34
        .byte   $34
        .byte   $82
        .byte   $34
        stx     $7E
        .byte   $87
        .byte   $3E
        .byte   $34
LF129:  ror     L8330,x
        rol     $3282
        stx     $34
        .byte   $87
        sec
        .byte   $82
        .byte   $3A
        .byte   $3A
        .byte   $3A
        .byte   $87
        .byte   $3A
        .byte   $3A
        .byte   $3A
        .byte   $82
        sec
        .byte   $87
        .byte   $3A
        .byte   $3A
        .byte   $3A
        .byte   $82
        sec
        sec
        .byte   $82
        ror     $2687,x
        rol     L8226,x
        ror     $2687,x
        rol     L8726,x
        rol     $4240,x
        sty     $44
        lsr     $48
        lsr     a
        jmp     L824C

        lsr     $87,x
        rol     $2634,x
        .byte   $82
        bmi     LF192
        rol     a
        .byte   $87
        rol     $2E
        .byte   $34
        .byte   $82
        bmi     LF19A
        rol     a
        .byte   $87
        rol     $7E
        rol     $3C82,x
        .byte   $3C
        .byte   $3A
        .byte   $3A
        sec
        sec
        rol     a
        stx     $2E
        .byte   $87
        .byte   $32
        .byte   $82
        .byte   $34
        stx     $38
        .byte   $87
        .byte   $3A
        .byte   $82
        rol     $3026,x
        .byte   $87
        .byte   $3A
        sec
        .byte   $34
        .byte   $82
        bmi     LF1BE
        .byte   $80
        .byte   $3E
LF190:  pha
        .byte   $50
LF192:  .byte   $54
        jmp     L4842

        .byte   $52
        .byte   $5A
        .byte   $87
        .byte   $5E
LF19A:  brk
        .byte   $80
        .byte   $34
        sec
        rol     $3C42,x
        bmi     LF1DB
        .byte   $42
        pha
        .byte   $87
        rti

        .byte   $80
        pha
        ror     $3448,x
        ror     $3A34,x
        ror     L873A,x
        sec
        sta     ($30,x)
        .byte   $80
        bmi     LF1E8
        rol     a
        bmi     LF1F5
        bmi     LF1F7
        .byte   $42
LF1BE:  .byte   $3A
        .byte   $42
        sta     ($34,x)
        .byte   $80
        .byte   $34
        .byte   $34
        rol     $3E34
        .byte   $34
        rol     $3E46,x
        lsr     $42
        .byte   $3A
        pha
        .byte   $42
        .byte   $52
LF1D2:  pha
        lsr     $3E
        jmp     L5646

        jmp     L5E81

LF1DB:  lsr     L875E,x
        .byte   $62
        brk
        sta     ($2A,x)
        .byte   $80
        rol     a
        rol     a
        .byte   $22
        rol     a
        .byte   $30
LF1E8:  rol     a
        bmi     LF225
        bmi     LF227
        sta     ($2E,x)
        .byte   $80
        rol     $262E
        .byte   $2E
        .byte   $2E
LF1F5:  rol     $2E
LF1F7:  .byte   $34
        rol     $3A34
        bmi     LF23F
        .byte   $3A
        pha
        .byte   $42
        rol     $4634,x
        rol     $464C,x
        jmp     L4648

        rol     $2E34,x
        .byte   $87
        .byte   $50
LF20E:  sta     ($3A,x)
        .byte   $80
        .byte   $3A
        .byte   $3A
        bmi     LF24F
        .byte   $42
        .byte   $3A
LF217:  .byte   $42
        pha
        .byte   $42
        pha
        sta     ($3A,x)
        .byte   $80
LF21E:  .byte   $3A
        .byte   $3A
        .byte   $34
        .byte   $3A
        rol     $3E3A,x
LF225:  .byte   $3E
LF226:  .byte   $46
LF227:  jmp     L4248

        .byte   $52
        pha
        .byte   $5A
        .byte   $52
        jmp     L5646

        jmp     L565E

        .byte   $80
        rol     $4834,x
        lsr     $3E
        .byte   $34
        .byte   $87
        .byte   $42
        .byte   $82
        .byte   $50
LF23F:  .byte   $52
        sta     $56
        sta     ($60,x)
        .byte   $82
        ror     $3087,x
        sta     ($5A,x)
        .byte   $82
        lsr     $81,x
        .byte   $52
        .byte   $85
LF24F:  bvc     LF1D2
        rts

        ror     $6885,x
        ror     a
        sta     ($68,x)
        .byte   $82
        ror     L8564,x
        ror     L8160
        .byte   $64
        pla
        sta     $6A
        pla
        sta     ($64,x)
        .byte   $87
        rts

        .byte   $80
        ror     L8300,x
        ror     $3882,x
        sec
        sta     ($38,x)
        sec
        .byte   $34
        sec
        ror     L823A,x
        .byte   $3A
        .byte   $3A
        .byte   $3A
        rol     L813E,x
        rol     $3E82,x
        sta     ($3E,x)
        ror     L8242,x
        .byte   $42
        .byte   $42
        .byte   $42
        sta     $46
        bvc     LF20E
        .byte   $52
        lsr     $85,x
        .byte   $5A
        lsr     $81,x
        .byte   $52
        .byte   $87
        bvc     LF217
        ror     $7E83,x
        .byte   $82
        bmi     LF21E
        pha
        rol     $26
        rol     $48
        bmi     LF226
        .byte   $34
LF2A5:  .byte   $81
LF2A6:  pha
LF2A7:  rol     $26
        rol     $48
        .byte   $34
        .byte   $82
        sec
        sta     ($48,x)
        rol     $26
        rol     $48
        sec
        .byte   $82
        .byte   $34
        sta     ($48,x)
        rol     $26
        rol     $3A82,x
        .byte   $82
        sec
        sta     ($38,x)
        sec
        rol     a
        rol     a
LF2C5:  rol     L8230
        .byte   $34
        sta     ($3A,x)
        .byte   $3C
        .byte   $82
        rol     $4681,x
LF2D0:  .byte   $87
        pha
        .byte   $80
        ror     $3E80,x
        pha
        bvc     LF32F
        ror     L8550,x
        lsr     $80,x
        .byte   $42
        jmp     L5A54

        ror     L8554,x
        .byte   $5A
        .byte   $80
        pha
        .byte   $52
        .byte   $5A
        rts

        ror     L865A,x
        rts

        rts

        .byte   $87
        ror     a
        ror     RESET,x
        bmi     LF32F
        rol     $7E48,x
        rol     $3E38,x
        pha
        bvc     LF37E
        pha
        .byte   $34
        .byte   $3C
        .byte   $42
        jmp     L427E

        .byte   $3C
        .byte   $42
        jmp     L7E54

        jmp     L4842

        .byte   $52
        .byte   $5A
        ror     L8652,x
        bvc     LF366
        .byte   $87
        .byte   $5A
        ror     $3085,x
        sta     ($7E,x)
        .byte   $80
        bmi     LF2A6
        bmi     LF2A7
        bmi     LF2A5
        ror     $3080,x
        .byte   $86
LF328:  bmi     $F2AA
        .byte   $22
        rol     a
LF32C:  bmi     LF368
        .byte   $7E
LF32F:  .byte   $34
        stx     $30
        sta     ($34,x)
        .byte   $80
        sec
        .byte   $80
        .byte   $3A
        bmi     LF364
        .byte   $22
        rol     a
        bmi     LF2C5
        .byte   $3A
        .byte   $7E
LF340:  .byte   $87
        sec
        stx     $3A
        .byte   $87
        .byte   $3C
        brk
        .byte   $87
        bmi     LF2D0
        .byte   $34
        .byte   $87
        rol     $83,x
        .byte   $7E
LF34F:  stx     $3E
LF351:  .byte   $87
        rol     $2687,x
        bmi     LF395
        stx     $46
        .byte   $87
        .byte   $42
        .byte   $87
        rol     L863A,x
        rol     L7E87,x
        .byte   $3E
        .byte   $2E
LF364:  bmi     LF3A4
LF366:  stx     $46
LF368:  .byte   $87
        pha
        .byte   $87
        ror     L867E,x
        lsr     $87,x
        ror     $3E56,x
        pha
        lsr     $86,x
        lsr     L875A,x
        cli
        .byte   $5A
        stx     $60
        .byte   $87
LF37E:  lsr     $525A,x
        pha
        stx     $50
        jmp     L7E87

        stx     $56
        .byte   $87
        ror     $3E56,x
        pha
        lsr     L0000,x
        stx     $34
        .byte   $82
        sec
        .byte   $87
LF395:  ror     $2E82,x
        .byte   $87
        ror     $7E84,x
        .byte   $32
        .byte   $82
        .byte   $34
        .byte   $87
        bmi     LF328
        .byte   $2E
        .byte   $87
LF3A4:  bmi     LF32C
        rol     L843A,x
        ror     L824A,x
        jmp     L4887

        .byte   $82
        ror     $5486,x
        .byte   $82
        .byte   $54
        .byte   $52
        .byte   $87
        .byte   $52
        .byte   $87
        .byte   $52
        pha
        .byte   $42
        stx     $3A
        .byte   $87
        .byte   $3A
        sta     ($7E,x)
        .byte   $84
LF3C3:  rol     $83,x
        sec
        sty     $7E
        sta     ($30,x)
        .byte   $7E
        .byte   $86
LF3CC:  pha
        .byte   $87
        bmi     LF351
        .byte   $34
        ror     L4886,x
        .byte   $87
        .byte   $34
        sta     ($38,x)
        ror     L4886,x
        .byte   $87
        sec
        sta     ($3A,x)
        ror     L4886,x
        .byte   $87
        .byte   $3A
        sta     ($38,x)
        ror     L4886,x
        .byte   $87
        sec
        sta     ($36,x)
        ror     L4886,x
        .byte   $87
        rol     $81,x
        .byte   $34
        ror     $7E3A,x
        rol     $267E,x
        ror     $7E30,x
        stx     $48
        .byte   $87
        .byte   $30
LF401:  stx     $5E
        .byte   $87
        .byte   $5A
        .byte   $87
        lsr     $52,x
        stx     $56
        .byte   $87
        ror     $5656,x
        rts

        pla
        stx     $6E
        .byte   $87
        ror     a
        stx     $68
        .byte   $87
        .byte   $64
        .byte   $82
        pla
        stx     $60
        .byte   $87
        pla
        stx     $6A
        .byte   $87
        pla
        stx     $64
        .byte   $82
        rts

        .byte   $87
        lsr     $5A,x
        lsr     $52,x
        stx     $50
        brk
        .byte   $83
        .byte   $3A
        rol     $4282,x
        .byte   $87
        rti

        pha
        cli
        .byte   $82
        lsr     $86,x
        bvc     LF3C3
        lsr     $86,x
        .byte   $5A
        .byte   $87
        lsr     $86,x
        .byte   $52
        bvc     LF3CC
        lsr     $484C
        lsr     $42
        stx     $3E
        sta     ($34,x)
        ror     L4886,x
        .byte   $87
        .byte   $34
        sta     ($38,x)
        ror     L4886,x
        .byte   $87
        sec
        .byte   $82
        .byte   $3A
        .byte   $3C
        sta     ($3E,x)
        ror     $7E3E,x
        stx     $3E
        .byte   $87
        .byte   $42
        stx     $46
        .byte   $82
        pha
        .byte   $87
        sec
        .byte   $3A
        sec
        .byte   $34
        sta     ($30,x)
        ror     $7E82,x
        rol     $3A,x
        rol     L8142,x
        .byte   $42
        .byte   $44
        ror     $4844,x
        .byte   $7E
        .byte   $87
LF480:  pha
        .byte   $82
        ror     L8200,x
        ror     $2A26,x
        bit     L8130
        bmi     LF4C1
        .byte   $7E
LF48E:  .byte   $34
        .byte   $3A
        ror     $3A83,x
        .byte   $80
        .byte   $3C
        rol     $3A81,x
        rol     $30,x
        .byte   $82
LF49B:  ror     $3430,x
        rol     $36,x
        sta     ($36,x)
        .byte   $3A
        ror     $3E3A,x
        ror     $263E,x
        bit     $3630
        bmi     LF4DA
        rol     L7E81
LF4B1:  .byte   $44
        .byte   $82
        .byte   $42
        .byte   $44
        .byte   $81
LF4B6:  .byte   $42
        .byte   $44
        ror     L8244,x
        .byte   $42
        .byte   $3A
        sta     ($3E,x)
        .byte   $83
        .byte   $42
LF4C1:  .byte   $87
        rol     L7E81,x
        .byte   $82
        .byte   $3A
        .byte   $3E
        sec
LF4C9:  sta     ($7E,x)
        .byte   $44
        .byte   $82
        .byte   $42
        .byte   $44
        sta     ($42,x)
        .byte   $44
        ror     L8244,x
        .byte   $42
        sta     ($44,x)
        pha
        .byte   $4C
LF4DA:  .byte   $83
        jmp     L4887

        sta     ($7E,x)
        .byte   $82
        .byte   $3A
        rol     a:$38,x
        sta     ($7E,x)
        .byte   $34
        .byte   $82
        bmi     LF51F
        sta     ($30,x)
        .byte   $34
        ror     L8234,x
        bmi     LF51D
        sta     ($2C,x)
        .byte   $83
        bmi     LF524
        sta     ($2A,x)
        .byte   $82
        bit     $2C2A
        rol     $81
        ror     L8234,x
        bmi     LF539
        sta     ($30,x)
        .byte   $34
        ror     L8234,x
        bmi     LF48E
        .byte   $34
        sec
        .byte   $3A
        .byte   $83
        .byte   $3A
        .byte   $3A
        sta     $38
        .byte   $82
        .byte   $34
        sec
        bmi     LF49B
        bmi     LF54C
        .byte   $82
LF51D:  pha
        .byte   $81
LF51F:  bmi     LF551
        .byte   $82
        pha
        .byte   $81
LF524:  bmi     LF556
        pha
        bmi     LF5A7
        sta     $30
        sta     ($30,x)
        bmi     LF4B1
        pha
        sta     ($30,x)
        bmi     LF4B6
        pha
        sta     ($30,x)
        pha
        .byte   $26
LF539:  rol     $442C,x
        rol     L8146
        bmi     LF571
        .byte   $82
        pha
        sta     ($30,x)
        bmi     LF4C9
        pha
        sta     ($30,x)
        bmi     LF594
LF54C:  bmi     LF5CC
        sta     $30
        .byte   $81
LF551:  bmi     LF583
        .byte   $82
        pha
        .byte   $81
LF556:  bmi     LF588
        .byte   $82
        pha
        sta     ($30,x)
        pha
        bmi     LF5A7
        bmi     LF5A9
        bit     L8344
        pha
        sta     ($52,x)
        lsr     L854C
        lsr     $4482
        sta     ($40,x)
        sta     $44
LF571:  .byte   $82
        pha
        pha
        sta     ($52,x)
        lsr     $524C
        .byte   $82
        .byte   $5C
        .byte   $5C
        sta     ($5C,x)
        .byte   $5C
        .byte   $80
        lsr     $58,x
        .byte   $5C
LF583:  lsr     $82,x
        .byte   $5A
        .byte   $42
        .byte   $81
LF588:  jmp     L4648

        sta     $48
        .byte   $82
        rol     $3081,x
        .byte   $34
        sec
        .byte   $82
LF594:  bit     $81
        bit     $82
        bit     $24
        sta     ($24,x)
        .byte   $82
        plp
LF59E:  sta     ($28,x)
        .byte   $82
        plp
        plp
        sta     ($2A,x)
        .byte   $2E
        brk
LF5A7:  .byte   $83
        .byte   $36
LF5A9:  sta     ($44,x)
        .byte   $44
        .byte   $44
        sta     $44
        .byte   $82
        .byte   $3A
        .byte   $81
LF5B2:  .byte   $3A
        rol     $3680,x
        .byte   $3A
        rol     L8236,x
        rol     $36,x
        sta     ($44,x)
        .byte   $44
        .byte   $44
        .byte   $44
        .byte   $82
        .byte   $52
        lsr     $4C81
        sta     $4E
        .byte   $82
        jmp     L8134

LF5CC:  .byte   $3E
LF5CD:  rol     L853E,x
        rol     $3482,x
        sta     ($3E,x)
        rol     L823E,x
        sec
        sta     ($38,x)
        .byte   $82
        sec
        sec
        sta     ($38,x)
        .byte   $82
        sec
        sta     ($38,x)
        .byte   $82
        sec
        sec
        sta     ($38,x)
        sec
        sta     ($2A,x)
        rol     a
        .byte   $42
        rol     a
        plp
LF5F0:  plp
        rti

        plp
        rol     $26
        rol     $2626,x
        rol     $3E
        rol     $81
        rol     a
        rol     a
        .byte   $42
        rol     a
        plp
        plp
        rti

        plp
        rol     $26
        rol     $2626,x
        rol     $3E
        rol     $24
        bit     $3C
        bit     $22
        .byte   $22
        .byte   $3A
        .byte   $22
        jsr     L3820
        jsr     L2E2A
        bmi     LF59E
        .byte   $34
        sta     ($34,x)
        .byte   $82
        .byte   $34
        .byte   $34
        sta     ($34,x)
        .byte   $82
        sec
        sta     ($38,x)
        .byte   $82
        sec
        sec
        sta     ($3C,x)
        rti

        .byte   $83
        bmi     LF5B2
        ror     $2E30,x
        rol     $2C85
        .byte   $83
        bit     L7E81
        rol     a
        .byte   $34
        bmi     LF67D
        pha
        jmp     L5687

        .byte   $83
        ror     L7E81,x
        .byte   $52
        .byte   $82
        bvc     LF69D
        sta     ($50,x)
        .byte   $52
        ror     L8252,x
        bvc     LF69B
LF653:  pha
        brk
        .byte   $83
        rol     $81
        ror     $2426,x
        bit     $85
        .byte   $22
        .byte   $83
        jsr     L7E81
        sta     (L0020,x)
        rol     a
        rol     $34
        rol     L8542,x
        pha
        sta     ($22,x)
        .byte   $82
        rol     $2A
        sta     ($2C,x)
        rol     L7E81
        .byte   $42
        .byte   $82
        rol     L8142,x
        rol     $7E42,x
LF67D:  .byte   $42
        .byte   $82
        rol     $3A3A,x
        sta     ($2A,x)
        rol     a
        rol     a
        rol     a
        rol     a
        rol     a
        plp
        plp
        rol     $26
        rol     $24
        bit     $24
        bit     $3C
        sta     $3A
        sec
        .byte   $34
LF697:  sta     ($34,x)
        .byte   $82
        sec
LF69B:  .byte   $3A
        .byte   $81
LF69D:  .byte   $3C
        .byte   $82
        rol     $3E81,x
        .byte   $82
        lsr     $3E,x
LF6A5:  sta     ($56,x)
        rol     $3E7E,x
        lsr     $3E,x
        .byte   $82
        rti

        sta     ($44,x)
        lsr     $81
        sec
        .byte   $80
        .byte   $3E
        .byte   $81
LF6B6:  pha
        .byte   $80
        sec
        rol     $3848,x
        sta     ($3A,x)
        pha
        .byte   $80
        sec
        .byte   $3A
        pha
        sta     ($3C,x)
        .byte   $80
        .byte   $42
        stx     $48
        .byte   $80
        jmp     L804E

        bvc     LF721
        bvc     LF653
        jmp     L7E80

        brk
        sta     ($30,x)
        .byte   $80
        .byte   $34
        .byte   $81
LF6DA:  sec
        .byte   $80
        bmi     LF712
        sec
        .byte   $34
        sta     ($30,x)
        .byte   $3A
        .byte   $80
        .byte   $34
        bmi     LF721
        sta     ($30,x)
        .byte   $80
        .byte   $3C
        stx     $3C
        sta     ($3C,x)
        .byte   $3C
        .byte   $80
        .byte   $3A
        .byte   $82
        .byte   $3A
        .byte   $80
        ror     $3081,x
        pha
        bmi     LF743
        .byte   $34
        pha
        .byte   $34
        pha
        rol     $48,x
        rol     $48,x
        .byte   $3A
        .byte   $80
        .byte   $3C
        sta     ($3E,x)
        .byte   $80
        rol     L4642,x
        sta     ($3E,x)
        .byte   $80
        pha
        bvc     LF768
LF712:  bvc     LF75C
        bvc     LF697
        .byte   $52
        jmp     L4642

        sta     ($3E,x)
        .byte   $80
        pha
        bvc     LF776
        .byte   $50
LF721:  pha
        bvc     LF6A5
        .byte   $5A
        .byte   $52
        .byte   $80
        .byte   $42
        rti

        rol     L813A,x
        rol     $4880,x
        bvc     LF787
        bvc     LF77B
        bvc     LF6B6
        .byte   $52
        jmp     L4642

        sta     ($48,x)
        .byte   $80
        pha
        jmp     L4881

        .byte   $80
        pha
        .byte   $4C
LF743:  sta     ($48,x)
        pha
        .byte   $82
        ror     L8100,x
        ror     $7E38,x
        bmi     LF7CD
        bmi     LF7CF
        rol     L7E81
        sec
        ror     $7E30,x
        bmi     LF6DA
        pha
        .byte   $46
LF75C:  .byte   $44
        .byte   $42
        sta     ($38,x)
        sec
        ror     $7E30,x
        bmi     LF7E4
        .byte   $2E
        .byte   $81
LF768:  .byte   $42
        ror     $7E3E,x
        .byte   $3A
        sec
        .byte   $82
        ror     L4881,x
        lsr     $42,x
        bvc     LF7B0
LF776:  .byte   $52
        rol     L8152,x
        pha
LF77B:  lsr     $42,x
        bvc     LF7B9
        .byte   $52
        rol     L8152,x
        pha
        lsr     $42,x
        .byte   $50
LF787:  .byte   $3A
        .byte   $52
        rol     L8152,x
        .byte   $52
        ror     $7E50,x
        jmp     L8248

        ror     $4681,x
        .byte   $80
        bvc     LF7F1
        lsr     $5058,x
        cli
        sta     ($5A,x)
        .byte   $54
        lsr     a
        lsr     $4681
        .byte   $80
        bvc     LF7FF
        lsr     $5058,x
        cli
        sta     ($62,x)
        .byte   $5A
        .byte   $80
        lsr     a
LF7B0:  pha
        lsr     $42
        sta     ($46,x)
        .byte   $80
        bvc     LF810
        .byte   $5E
LF7B9:  cli
        bvc     LF814
        sta     ($5A,x)
        .byte   $54
        lsr     a
        lsr     $5081
        .byte   $80
        bvc     LF81A
        sta     ($50,x)
        .byte   $80
        bvc     LF81F
        sta     ($56,x)
LF7CD:  .byte   $80
        .byte   $56
LF7CF:  .byte   $5A
        .byte   $82
        lsr     L0000,x
        sta     ($7E,x)
        rti

        ror     $7E38,x
        sec
        ror     L8136,x
        ror     $7E40,x
        sec
        ror     L8038,x
LF7E4:  bvc     LF834
        jmp     L8148

        rti

        rti

        ror     $7E38,x
        sec
        .byte   $7E
        .byte   $36
LF7F1:  sta     ($3E,x)
        ror     $7E42,x
        pha
        ror     $4682,x
        sta     ($50,x)
        lsr     $584A,x
LF7FF:  .byte   $42
LF800:  .byte   $5A
        lsr     $5A
        sta     ($50,x)
        lsr     $584A,x
        .byte   $42
        .byte   $5A
        lsr     $5A
        sta     ($50,x)
        .byte   $5E
        lsr     a
LF810:  cli
        .byte   $42
        .byte   $5A
        .byte   $46
LF814:  .byte   $5A
        sta     ($48,x)
        ror     $7E4C,x
LF81A:  .byte   $52
        .byte   $7E
LF81C:  lsr     $3E,x
LF81E:  .byte   $FF
LF81F:  .byte   $FF
        .byte   $FF
LF821:  .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
LF834:  .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
LF849:  .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
LF863:  .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
LF870:  clv
LF871:  .byte   $1A
        sec
        ora     $17CC,y
        sei
        asl     $34,x
        ora     $04,x
        .byte   $14
        cpx     $12
        .byte   $D4
        ora     ($D4),y
        bpl     LF863
        .byte   $0F
        .byte   $FC
        asl     $0E24
LF888:  bcc     LF81A
        bcc     LF81C
        bcc     LF81E
        bcc     LF821
        sta     ($92),y
        .byte   $92
        .byte   $93
        .byte   $93
        sty     $94,x
        sty     $95,x
        sta     $96,x
        stx     $96,y
        .byte   $97
        .byte   $97
LF89F:  sta     ($91),y
        sta     ($91),y
        sta     ($91),y
        sta     ($91),y
        sta     ($92),y
        .byte   $92
        .byte   $93
        .byte   $93
        sty     $94,x
        sty     $95,x
        sta     $96,x
        stx     $96,y
        .byte   $97
        .byte   $97
LF8B6:  bcc     LF849
        sta     ($91),y
        sta     ($91),y
        sta     ($91),y
LF8BE:  sta     ($91),y
        sta     ($91),y
        .byte   $92
        .byte   $92
        .byte   $92
        .byte   $93
        .byte   $93
        .byte   $93
        .byte   $93
        .byte   $93
        .byte   $93
        sty     $94,x
        sty     $94,x
        sty     $94,x
        sty     $94,x
        sta     $95,x
        sta     $95,x
        sta     $95,x
        stx     $96,y
        stx     $96,y
        stx     $96,y
        stx     $96,y
        stx     $96,y
        stx     $96,y
        stx     $96,y
        stx     $96,y
        stx     $96,y
        stx     $96,y
        stx     $96,y
        stx     $96,y
        stx     $96,y
        stx     $96,y
        stx     $96,y
        stx     $96,y
        stx     $97,y
        .byte   $97
        .byte   $97
        .byte   $97
        .byte   $FF
        .byte   $FF
LF900:  lda     #$FF
        sta     $4017
        lda     #$0F
        sta     $4015
        lda     $E9
        bne     LF915
        lda     $0305
        cmp     #$01
        bne     LF971
LF915:  lda     $0315
        bne     LF93F
        lda     $0305
        beq     LF985
        sta     $0315
        sta     $E9
        lda     #$00
        sta     $4015
        sta     $0310
        sta     $0311
        sta     $0312
        lda     #$0F
        sta     $4015
        lda     #$2A
        sta     $E7
LF93B:  lda     #$68
        bne     LF94F
LF93F:  lda     $E7
        cmp     #$24
        beq     LF94D
        cmp     #$1E
        beq     LF93B
        cmp     #$18
        bne     LF956
LF94D:  lda     #$60
LF94F:  ldx     #$84
        ldy     #$7F
        jsr     LFF7E
LF956:  dec     $E7
        bne     LF985
        lda     #$00
        sta     $4015
        lda     $0315
        cmp     #$02
        bne     LF96A
        lda     #$00
        sta     $E9
LF96A:  lda     #$00
        sta     $0315
        beq     LF985
LF971:  jsr     LFC41
        jsr     LFB40
        jsr     LFA71
        jsr     LFCFB
        lda     #$00
        sta     $0303
        sta     $0304
LF985:  lda     #$00
        sta     $0305
        sta     $0300
        sta     $0301
        sta     $0302
LF993:  rts

        plp
        .byte   $27
        rol     $25
        bit     $23
        bit     $25
        rol     $25
        bit     $23
        bit     $25
        .byte   $26
LF9A3:  .byte   $27
        sta     ($92),y
        .byte   $93
        sty     $95,x
        stx     $95,y
        sty     $93,x
        sty     $95,x
        sta     $94,x
        .byte   $93
        .byte   $93
LF9B3:  .byte   $92
        .byte   $7C
        ror     $78,x
        .byte   $6E
        .byte   $64
LF9B9:  .byte   $72
        .byte   $76
LF9BB:  .byte   $92
        .byte   $92
        .byte   $92
        .byte   $92
        .byte   $92
        .byte   $93
        sty     $95,x
        stx     $97,y
        tya
        sta     L9B9A,y
        .byte   $9C
        sta     L9F9E,x
        .byte   $9F
        .byte   $9F
        .byte   $9E
        sta     L9B9C,x
LF9D3:  sty     $0310
        lda     #$60
        sta     $032A
        lda     #$38
        ldx     #$92
        ldy     #$7F
        jsr     LFFD0
        lda     #$32
        ldx     #$92
        ldy     #$7F
        jmp     LFA4E

LF9ED:  lda     $032A
        lsr     a
        lsr     a
        tay
        lda     LF9BB,y
        sta     $4000
        sta     $4004
        jmp     LFA51

LF9FF:  sty     $0310
        lda     #$10
        sta     $032A
        lda     #$12
        ldx     #$82
        ldy     #$AC
        jmp     LFA4E

LFA10:  sty     $0310
        lda     #$04
        sta     $EB
        bne     LFA2A
LFA19:  lda     $032A
        cmp     #$01
        bne     LFA36
        dec     $EB
        beq     LFA5D
        lda     $EB
        cmp     #$01
        beq     LFA31
LFA2A:  lda     #$0A
        bne     LFA33
LFA2E:  sty     $0310
LFA31:  lda     #$14
LFA33:  sta     $032A
LFA36:  lda     $032A
        and     #$01
        tay
        lda     LF9B9,y
        ldy     $032A
        cpy     #$04
        bcc     LFA4A
        ldx     #$41
        bne     LFA4C
LFA4A:  ldx     #$53
LFA4C:  ldy     #$7F
LFA4E:  jsr     LFF7E
LFA51:  dec     $032A
        bne     LFA70
        lda     $0310
        cmp     #$01
        bne     LFA61
LFA5D:  ldx     #$0C
        bne     LFA63
LFA61:  ldx     #$0E
LFA63:  stx     $4015
        ldx     #$0F
        stx     $4015
        ldx     #$00
        stx     $0310
LFA70:  rts

LFA71:  ldy     $0300
        beq     LFAA3
        bmi     LFAD5
        lsr     $0300
        bcs     LFAC0
        lda     $0310
        bmi     LFADD
        cmp     #$08
        beq     LFACF
        cmp     #$10
        beq     LFAC9
        lsr     $0300
        bcs     LFABD
        lsr     $0300
        bcs     LFAF3
        lsr     $0300
        bcs     LFACC
        lsr     $0300
        bcs     LFAC6
        lsr     $0300
        bcs     LFB09
LFAA3:  lda     $0310
        bmi     LFADD
        beq     LFABC
        lsr     a
        bcs     LFAC3
        lsr     a
        bcs     LFA51
        lsr     a
        bcs     LFAFF
        lsr     a
        bcs     LFACF
        lsr     a
        bcs     LFAC9
        lsr     a
        bcs     LFB19
LFABC:  rts

LFABD:  jmp     LF9FF

LFAC0:  jmp     LF9D3

LFAC3:  jmp     LF9ED

LFAC6:  jmp     LFA10

LFAC9:  jmp     LFA19

LFACC:  jmp     LFA2E

LFACF:  jmp     LFA36

LFAD2:  jmp     LFA51

LFAD5:  sty     $0310
        lda     #$28
        sta     $032A
LFADD:  lda     $032A
        ldx     #$03
LFAE2:  lsr     a
        bcs     LFAD2
        dex
        bne     LFAE2
        tay
        lda     LF9B3,y
        ldx     #$81
        ldy     #$7F
        jmp     LFA4E

LFAF3:  sty     $0310
        lda     #$02
        .byte   $8D
LFAF9:  rol     a
        .byte   $03
        lda     #$66
        bne     LFB02
LFAFF:  jmp     LFA51

LFB02:  ldy     #$99
        ldx     #$88
        jmp     LFA4E

LFB09:  lda     $0313
        cmp     #$04
        bne     LFB11
        rts

LFB11:  sty     $0310
        lda     #$20
        sta     $032A
LFB19:  lda     $032A
        lsr     a
        tay
        lda     LF993,y
        sta     $4002
        ldx     LF9A3,y
        ldy     #$7F
        jsr     LFF70
        lda     #$08
        sta     $4003
        .byte   $4C
        .byte   $51
LFB33:  .byte   $FA
        .byte   $47
        eor     #$42
        lsr     a
        .byte   $43
LFB39:  .byte   $4B
        ldy     L0000
        sta     $BA,y
        .byte   $BE
LFB40:  lda     $0311
        bne     LFB53
        ldy     $0301
        bne     LFB4B
        rts

LFB4B:  sty     $0311
        lda     #$06
        sta     $0328
LFB53:  lda     $0328
        tay
        lda     $0311
        bmi     LFB63
        lda     LFB39,y
        bne     LFB66
        beq     LFB6B
LFB63:  lda     LFB33,y
LFB66:  sta     $400A
        lda     #$18
LFB6B:  sta     $4008
        sta     $400B
        dec     $0328
        bne     LFB7B
        lda     #$00
        sta     $0311
LFB7B:  rts

LFB7C:  .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $04
        .byte   $04
        .byte   $04
        ora     $06
        .byte   $07
        php
        ora     #$0A
        .byte   $0B
        .byte   $0C
        ora     $0E0E
        .byte   $0F
        brk
        .byte   $04
        asl     $08
        .byte   $0B
        .byte   $0D
        .byte   $0F
LFB9C:  .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        ora     #$06
        ora     $0703
        .byte   $0C
        .byte   $03
        .byte   $07
        ora     $0303
        ora     #$04
        brk
        php
        asl     $0808
        asl     a
        .byte   $09
LFBBC:  .byte   $1F
        asl     $191C,x
        ora     $1E,x
        .byte   $1F
LFBC3:  asl     $0C0D
        ora     $0F0E
        .byte   $0F
LFBCA:  bpl     LFBE0
        ora     $16,x
        ora     $14,x
        .byte   $13
LFBD1:  php
        ora     #$09
        asl     a
        asl     a
        .byte   $0E
        .byte   $0F
LFBD8:  sty     $0312
        lda     #$06
        sta     $0327
LFBE0:  ldy     $0327
        ldx     LFBC3,y
        lda     LFBBC,y
        bne     LFBFC
LFBEB:  sty     $0312
        lda     #$06
        sta     $0327
LFBF3:  ldy     $0327
        ldx     LFBD1,y
        lda     LFBCA,y
LFBFC:  sta     $400C
        .byte   $8E
        .byte   $0E
LFC01:  rti

        lda     #$18
        sta     $400F
LFC07:  dec     $0327
        bne     LFC11
        lda     #$00
        sta     $0312
LFC11:  rts

LFC12:  sty     $0312
        lda     #$18
        sta     $0327
LFC1A:  ldy     $0327
        lda     $0312
        lsr     a
        bcc     LFC27
        lda     #$0A
        bne     LFC2C
LFC27:  lda     LFB9C,y
        ora     #$04
LFC2C:  sta     $400E
        lda     LFB7C,y
        ora     #$10
        sta     $400C
        lda     #$1F
        sta     $400F
        bne     LFC07
LFC3E:  jmp     LFCAE

LFC41:  ldy     $0302
        beq     LFC61
        bmi     LFCA1
        lsr     $0302
        bcs     LFC12
        lsr     $0302
        bcs     LFC12
        lda     $0312
        bmi     LFC3E
        lsr     $0302
        bcs     LFBEB
        lsr     $0302
        bcs     LFC73
LFC61:  lda     $0312
        bmi     LFC3E
        lsr     a
        bcs     LFC1A
        lsr     a
        bcs     LFC1A
        lsr     a
        bcs     LFBF3
        lsr     a
        bcs     LFC76
        rts

LFC73:  jmp     LFBD8

LFC76:  jmp     LFBE0

LFC79:  .byte   $22
        .byte   $22
        .byte   $22
        .byte   $22
        .byte   $22
        .byte   $22
        .byte   $22
        .byte   $22
        .byte   $22
        .byte   $33
        .byte   $44
        lsr     $78,x
        txs
        ldy     LBBCC,x
        tax
        sta     $7788,y
        .byte   $77
        .byte   $89
        .byte   $AB
        cpy     LBABB
        lda     #$98
        .byte   $87
        ror     $65,x
        .byte   $54
        .byte   $44
        .byte   $43
        .byte   $33
        .byte   $22
        .byte   $22
        ora     ($11),y
LFCA1:  sty     $0312
        lda     #$03
        sta     $032F
        lda     #$88
        sta     $0327
LFCAE:  lda     $0327
        cmp     #$21
        bne     LFCC4
        dec     $032F
        beq     LFCE1
        lda     #$20
        sta     $0300
        lda     #$88
        sta     $0327
LFCC4:  lsr     a
        lsr     a
        tay
        lda     LFC79,y
        bcs     LFCD0
        lsr     a
        lsr     a
        lsr     a
        lsr     a
LFCD0:  and     #$0F
        ora     #$10
        sta     $400C
        lda     #$0C
        sta     $400E
        lda     #$18
        sta     $400F
LFCE1:  jmp     LFC07

LFCE4:  cmp     #$0F
        bcc     LFCF7
        lsr     a
        lsr     a
        lsr     a
        bcs     LFCF2
        txa
        adc     #$01
        bne     LFCF6
LFCF2:  txa
        sec
        sbc     #$01
LFCF6:  tax
LFCF7:  rts

LFCF8:  jmp     LFD9B

LFCFB:  lda     $0303
        bne     LFD48
        .byte   $AD
LFD01:  .byte   $04
        .byte   $03
        bne     LFD0E
        lda     $0313
        ora     $0314
        bne     LFCF8
        rts

LFD0E:  sta     $0314
        ldy     #$00
        sty     $0313
        ldy     #$FF
LFD18:  iny
        lsr     a
        bcc     LFD18
        lda     LF000,y
        sta     $031D
        lda     LF008,y
        clc
        adc     #$02
        sta     $031E
        lda     LF010,y
        sta     $031F
        lda     $031D
LFD34:  sta     $031B
LFD37:  inc     $031B
        ldy     $031B
        cpy     $031E
        bne     LFD54
        lda     $031F
        jmp     LFD34

LFD48:  sta     $0313
        ldy     #$00
        sty     $0314
LFD50:  iny
        lsr     a
        bcc     LFD50
LFD54:  lda     LF017,y
        tay
        lda     LF018,y
        sta     $0306
        lda     LF019,y
        sta     $E0
        lda     LF01A,y
        sta     $E1
        lda     LF01B,y
        sta     $0309
        lda     LF01C,y
        sta     $0308
        lda     LF01D,y
        sta     $E4
        lda     LF01E,y
        sta     $E5
        lda     $0312
        lda     #$01
        sta     $030C
        sta     $030E
        sta     $0317
        lda     #$00
        sta     $0307
        lda     #$0B
        sta     $4015
        lda     #$0F
        sta     $4015
LFD9B:  dec     $030C
        bne     LFE10
        ldy     $0307
        inc     $0307
        lda     ($E0),y
        beq     LFDAE
        bpl     LFDE3
        bne     LFDD5
LFDAE:  lda     $0314
        bne     LFDCF
        lda     $0313
        and     #$46
        beq     LFDBE
        lda     #$02
        bne     LFDD2
LFDBE:  lda     #$00
        sta     $0313
        sta     $0314
        sta     $4015
        ldx     #$0F
        .byte   $8E
LFDCC:  ora     $40,x
        rts

LFDCF:  jmp     LFD37

LFDD2:  jmp     LFD0E

LFDD5:  jsr     LFF0A
        sta     $030B
        ldy     $0307
        inc     $0307
        lda     ($E0),y
LFDE3:  tax
        lda     $0310
        and     #$01
        bne     LFE05
        txa
        jsr     LFFD6
        tay
        bne     LFDF7
        lda     $E4
        jmp     LFDFF

LFDF7:  lda     $030B
        .byte   $A6
LFDFB:  cpx     L0020
        ora     $FF,x
LFDFF:  sta     $030D
        jsr     LFF77
LFE05:  lda     $030B
        sta     $030C
        lda     #$00
        sta     $032D
LFE10:  lda     $0310
        and     #$01
        bne     LFE42
        inc     $032D
        ldy     $030D
        beq     LFE22
        dec     $030D
LFE22:  lda     $030B
        ldx     $E4
        jsr     LFF24
        sta     $4004
        ldx     #$7F
        stx     $4005
        lda     $0313
        bne     LFE42
        lda     $032D
        ldx     $EA
        jsr     LFCE4
        stx     $4006
LFE42:  ldy     $0308
        beq     LFEC1
        dec     $030E
        bne     LFE8C
        ldy     $0308
        inc     $0308
        lda     ($E0),y
        bpl     LFE64
        jsr     LFF0A
        sta     $031C
        ldy     $0308
        inc     $0308
        lda     ($E0),y
LFE64:  ldy     $0310
        bne     LFE81
        jsr     LFF84
        bne     LFE73
        lda     $E4
        jmp     LFE7B

LFE73:  lda     $031C
        ldx     $E5
        jsr     LFF15
LFE7B:  sta     $030F
        jsr     LFF70
LFE81:  lda     $031C
        sta     $030E
        lda     #$00
        sta     $032E
LFE8C:  lda     $0310
        bne     LFEAE
        inc     $032E
        ldy     $030F
        beq     LFE9C
        dec     $030F
LFE9C:  lda     $031C
        ldx     $E5
        jsr     LFF24
        ora     #$C0
        sta     $4000
        lda     #$7F
        sta     $4001
LFEAE:  lda     $0313
        ora     $0310
        bne     LFEC1
        lda     $032E
        ldx     $E6
        jsr     LFCE4
        stx     $4002
LFEC1:  lda     $0309
        beq     LFF03
        dec     $0317
        bne     LFF03
        ldy     $0309
        inc     $0309
        lda     ($E0),y
        beq     LFF00
        bpl     LFEEC
        jsr     LFF0A
        sta     $0316
        .byte   $A9
LFEDE:  .byte   $1F
        sta     $4008
        ldy     $0309
        inc     $0309
        lda     ($E0),y
        beq     LFF00
LFEEC:  jsr     LFFDA
        ldx     $0316
        stx     $0317
        txa
        cmp     #$1E
        bcs     LFEFE
        lda     #$18
        .byte   $D0
LFEFD:  .byte   $02
LFEFE:  lda     #$6F
LFF00:  sta     $4008
LFF03:  rts

        tax
        ror     a
        txa
        rol     a
        rol     a
        rol     a
LFF0A:  and     #$07
        clc
        adc     $0306
        tay
        lda     LFF40,y
        rts

LFF15:  cmp     #$19
        bcc     LFF1D
        lda     #$3F
        bne     LFF1F
LFF1D:  lda     #$16
LFF1F:  ldx     #$82
        ldy     #$7F
        rts

LFF24:  beq     LFF33
        cmp     #$19
        bcc     LFF2F
        lda     LF8BE,y
        bne     LFF32
LFF2F:  lda     LF89F,y
LFF32:  rts

LFF33:  cmp     #$19
        bcc     LFF3C
        lda     LF8B6,y
        bne     LFF3F
LFF3C:  lda     LF888,y
LFF3F:  rts

LFF40:  .byte   $04
        php
        bpl     LFF64
        .byte   $04
        clc
        .byte   $0C
        bmi     LFF4E
        asl     a
        .byte   $14
        plp
        .byte   $04
        .byte   $1E
LFF4E:  .byte   $0F
        .byte   $3C
        asl     $0C
        clc
        bmi     LFFB5
        bit     $12
        pha
        asl     a
        .byte   $14
        plp
        bvc     LFEFD
        .byte   $3C
        php
        sei
        asl     $0C
        clc
        .byte   $30
LFF64:  .byte   $04
        bit     $10
        php
        .byte   $02
        php
        ora     $080A
        bmi     LFFAF
        .byte   $30
LFF70:  sty     $4001
        stx     $4000
        rts

LFF77:  stx     $4004
        sty     $4005
        rts

LFF7E:  stx     $4000
        sty     $4001
LFF84:  .byte   $A2
LFF85:  brk
LFF86:  cmp     #$7E
        bne     LFF92
        lda     #$10
        .byte   $9D
LFF8D:  brk
        rti

        lda     #$00
        rts

LFF92:  ldy     #$01
        sty     $0323
        pha
        tay
        bmi     LFFA3
LFF9B:  inc     $0323
        sec
        sbc     #$18
        bpl     LFF9B
LFFA3:  clc
        adc     #$18
        tay
        lda     LF870,y
        sta     $E2
        lda     LF871,y
LFFAF:  sta     $E3
LFFB1:  lsr     $E3
        ror     $E2
LFFB5:  dec     $0323
        bne     LFFB1
        pla
        cmp     #$38
        bcc     LFFC1
        dec     $E2
LFFC1:  lda     $E2
        sta     $4002,x
        sta     $E6,x
        lda     $E3
        ora     #$08
        sta     $4003,x
        rts

LFFD0:  stx     $4004
        sty     $4005
LFFD6:  ldx     #$04
        bne     LFF86
LFFDA:  ldx     #$08
        bne     LFF86
        .byte   $FF
        .byte   $FF
LFFE0:  and     ($32),y
        .byte   $2F
        .byte   $32
        .byte   $33
        .byte   $2F
        eor     #$43
        eor     L0020
        pha
        .byte   $4F
        .byte   $43
        .byte   $4B
        eor     $59
        adc     $35CA,x
        and     a:L0020,x
        ora     ($09,x)
LFFF8:  ora     ($63,x)
        .byte   $5A
        .byte   $80
        brk
        .byte   $80
        brk
        .byte   $80
