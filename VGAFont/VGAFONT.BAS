DEFINT A-Z
CONST CHARACTERSIZE = 34
CONST STEPX = 8
CONST STEPY = 16

DECLARE SUB DisplayText (Text AS STRING, x AS INTEGER, y AS INTEGER, Verb AS STRING)
DECLARE SUB Initialize ()
DECLARE SUB LoadFontData ()
DECLARE SUB Main ()
DECLARE SUB Quit ()

DIM SHARED FontData(0 TO 8703) AS INTEGER

Initialize
LoadFontData
CALL Main
Quit

SUB DisplayText (Text AS STRING, x AS INTEGER, y AS INTEGER, Verb AS STRING)
DIM Index AS INTEGER
DIM Length AS INTEGER

 Length = LEN(Text)

 SELECT CASE UCASE$(LTRIM$(RTRIM$(Verb)))
  CASE "OR"
   FOR Index = 1 TO Length
    PUT (x, y), FontData(ASC(MID$(Text, Index, 1)) * CHARACTERSIZE), OR

    IF x + STEPX > 632 THEN
     x = 0
     y = y + STEPY
    ELSE
     x = x + STEPX
    END IF
   NEXT Index
  CASE "PRESET"
   FOR Index = 1 TO Length
    PUT (x, y), FontData(ASC(MID$(Text, Index, 1)) * CHARACTERSIZE), PRESET

    IF x + STEPX > 632 THEN
     x = 0
     y = y + STEPY
    ELSE
     x = x + STEPX
    END IF
   NEXT Index

  CASE "PSET"
   FOR Index = 1 TO Length
    PUT (x, y), FontData(ASC(MID$(Text, Index, 1)) * CHARACTERSIZE), PSET

    IF x + STEPX > 632 THEN
     x = 0
     y = y + STEPY
    ELSE
     x = x + STEPX
    END IF
   NEXT Index
  CASE ELSE
   ERROR 5
 END SELECT
END SUB

SUB Initialize ()
 SCREEN 12
 PALETTE
 CLS
END SUB

SUB LoadFontData ()
 DEF SEG = VARSEG(FontData(0))
 BLOAD "VGAFont.dat", VARPTR(FontData(0))
END SUB

SUB Main ()
DIM Banner AS STRING

 Banner = "V G A  F O N T  -  B Y :  P E T E R  S W I N K E L S , -  * * * 2 0 2 5 * * *"
 DisplayText Banner, 8, 16, "PSET"
 DisplayText Banner, 9, 17, "OR"
 DisplayText " Press any key to exit. ", 18, 45, "PRESET"

 DO
 LOOP WHILE INKEY$ = ""
END SUB

SUB Quit ()
 SCREEN 0
 WIDTH 80, 25
 COLOR 7, 0
 CLS
 SYSTEM
END SUB

