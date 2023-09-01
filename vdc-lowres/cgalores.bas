#RetroDevStudio.MetaData.BASIC:7169,BASIC V7.0 VDC
# CGA-LORES
# TAKEN FROM HTTPS://GITHUB.COM/MICHAELCMARTIN/BUMBERSHOOT/TREE/MASTER/DOS
# DISPLAYS A 16 COLOR IMAGE WITH RESOLUTION 160X100
# 
# ON CGA, THIS IS USING
# - TEXT MODE
# - BLINKING DISABLED
# - CHARACTER HEIGHT 2 SCANLINES
# - ALLOWING EVERY 8-PIXEL WIDE CHARACTER TO DISPLAY 2 DOTS (IE BIG PIXELS)

# THE VDC-CHIP CAN'T USE TEXT-MODE, BECAUSE THEN WE'D ONLY HAVE ONE GLOBAL BACKGROUNDCOLOR.
# ALSO, DISABLING BLINKING REQUIRES DISABLING ATTRIBUTE RAM, WHICH ELIMINATES COLORS
#
# SO WE'LL USE:
# - GRAPHICS MODE
# - ATTRIBUTE RAM ENABLED
# - DRAW 4X2 PIXELS FOR EACH NYBBLE THAT'S NOT BACKGROUND COLOR
#   - BACKGROUND COLOR FILLS A 8X2 PIXEL AREA
#   - FOREGROUND COLOR COULD BE PIXEL PRECISE, BUT 4X2 IS SUFFICIENT



1 DEF FN W(ZZ)=PEEK(ZZ)+PEEK(ZZ+1)*256

# BS:BASIC START
# BE:BASIC END
2 BS=FN W(45)
3 BE=FN W(4624)

# DB:DATA BEGIN
# DE:DATA END
4 DB=BE+1:DE=DB+8000

5 PRINT "BASIC FROM "BS" TO "BE"."
6 PRINT "LEAVES "FRE(0)" BYTES FREE."
7 DD=PEEK(186)

10 PRINT "INSERT DATADISK":GETKEY I$

20 BLOAD "VDCBASICAC6.BIN",B0,U(DD)
21 SYS DEC("AC6")

30 PRINT "LOADING CGALORES.DAT ... ";
35 BLOAD "CGALORES.DAT",B0,P(DB),U(DD)
37 PRINT "DONE"

39 AP=16000

40 RGW 0,126:RGW 4,159:RGW 6,100:RGW 7,140:RGW 9,1
41 RGO 25,27:REM BITMAP MODE ON

#42 VM=RGD(255)
#43 IF VM <> 1 THEN PRINT "THIS NEEDS 64K OF VRAM. ONLY 16 K FOUND.":END

44 RGO 28,24:REM 64K VRAM
45 RGW 36,0

46 VMF 0,0,24000:REM CLEAR SCREEN
48 ATTR AP


80 DIM CL(15)
81 CL(0)=0:CL(1)=2:CL(2)=4:CL(3)=6:CL(4)=8:CL(5)=10:CL(6)=12:CL(7)=14
82 CL(8)=1:CL(9)=3:CL(10)=5:CL(11)=7:CL(12)=9:CL(13)=11:CL(14)=13:CL(15)=15

# HN=HIGH NYBBLE
# LN=LOW NYBBLE
90 DEF FN HN(ZZ)=DEC(MID$(HEX$(ZZ),3,1))
92 DEF FN LN(ZZ)=DEC(RIGHT$(HEX$(ZZ),1))

# SET BACKGROUND COLOR TO HIGH-NYBBLE
# CHECK LOW-NYBBLE
# - SAME COLOR? DO NOTHING
# - DIFFERENT COLOR? DRAW 4 PIXELS IN THE CURRENT LINE, 4 PIXELS IN THE NEXT LINE

# VP:VRAM POSITION
# AP:ATTRIBUTE RAM POSITION
# B :BYTE (IE CURRENT BYTE) OF CGALORES.DAT
# BC:BACKGROUND COLOR
100 BANK 0:VP=0:PC=0
105 FAST:S=TI

110 FOR MP=DB TO DE

120  B=PEEK(MP)

130  BC=FN HN(B):FC=FN LN(B)

132  BC$=RIGHT$(HEX$(CL(BC)),1):FC$=RIGHT$(HEX$(CL(FC)),1)

140  VMW AP,DEC(BC$+FC$)

142  IF FC<>BC THEN VMW VP,15:VMW VP+80,15

150  AP=AP+1

160 NEXT


# S=TI-S

165 SLOW:PRINT S

# NOW, COPY VDC-RAM TO CPU-RAM
200 VTR 0,DB,24000
210 BSAVE "VDCLORES.DAT",B0,U(DD),P(DB) TO P(DB+24000)

220 BANK 15



