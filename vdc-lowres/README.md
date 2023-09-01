#CGA-VDC Disk Image
cga-vdc.d64 contains the following files:

CGALORES.PRG:  first version of the CGA-VDC converter. Writes VDCLORES.DAT to disk (which already exists in this image)
CGALORES2.PRG: second version, with more efficient setup of Screen-RAM. Writes VDCLORES2.DAT to disk (which already exists in this image)
CGALORES3.PRG: like second version, including lookup-tables. Reduces the processing time a lot. Writes the same output as CGALORES2.DAT
CGALORES.DAT:  contains the CGA graphics data.

VDCLORES.PRG:  loads VDCLORES.DAT and copies 16 kB to Screen-RAM and 8 kB to Attribute-RAM.
VDCLORES2.PRG: loads VDCLORES2.DAT, does Screen-RAM preparation with 0x0F and copies 8 kB to Attribute-RAM
VDCLORES.DAT:  24 kB dump of Screen-RAM and Attribute-RAM. Written by CGALORES.PRG and read by VDCLORES.PRG
VDCLORES2.DAT: 8 kB dump of Attribute-RAM. Written by CGALORES2.PRG and CGALORES3.PRG and read by VDCLORES2.PRG

VDCBASICAC6.BIN: VDC-Basic Binary that was compiled to 0x0AC6
