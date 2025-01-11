DEFINT A-Z
CONST CHARACTERSIZE = 34
DIM FontData(0 TO 8703) AS INTEGER
DIM Index AS INTEGER
DIM Offset AS INTEGER

 SCREEN 12
 CLS
 COLOR 15
 
 LOCATE 2, 2
 PRINT "Font Generator - By: Peter Swinkels, ***2025***"
 PRINT " Generating font..."
 
 Offset = 0
 FOR Index = 0 TO 255
  LOCATE 1, 1
  SELECT CASE Index
   CASE 7, 8, 9, 10, 12, 13
    PRINT " ";
   CASE ELSE
    PRINT CHR$(Index);
  END SELECT
  GET (0, 0)-STEP(7, 15), FontData(Offset)
  Offset = Offset + CHARACTERSIZE
 NEXT Index

 DEF SEG = VARSEG(FontData(0))
 BSAVE "VGAFont.dat", VARPTR(FontData(0)), 17408

 LOCATE 4, 2
 PRINT "Done."

