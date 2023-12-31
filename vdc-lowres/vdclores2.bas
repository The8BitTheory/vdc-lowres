#RetroDevStudio.MetaData.BASIC:7169,BASIC V7.0 VDC
#VDC-LORES

1 DEF FN W(ZZ)=PEEK(ZZ)+PEEK(ZZ+1)*256
2 BS=FN W(45)
3 BE=FN W(4624)
# DB=DATA BEGIN
# DE=DATA END
4 DB=BE+1:DE=DB+8000

5 PRINT "BASIC FROM "BS" TO "BE"."
6 PRINT "LEAVES "FRE(0)" BYTES FREE."
7 DD=PEEK(186)

#10 PRINT "INSERT DATADISK":GETKEY I$

20 BLOAD "VDCBASICAC6.BIN",B0,U(DD):SYS DEC("AC6")

30 PRINT "LOADING VDCLORES2.DAT ... ";
35 BLOAD "VDCLORES2.DAT",B0,P(DB),U(DD)
37 PRINT "DONE"

39 AP=16000

# 2 SCANLINES PER CHAR, 160 SCANLINES (EACH VAL +1)
40 RGW 0,127:RGW 4,155:RGW 6,100:RGW 7,140:RGW 9,1
41 RGO 25,128:REM BITMAP MODE ON
42 RGO 28,24:REM 64K VRAM
43 RGW 36,0

46 VMF 0,15,AP:REM SETUP PIXELS
47 VMF AP,0,8000: REM CLEAR ATTRIBUTE RAM
48 ATTR AP

100 RTV DB,AP,8000