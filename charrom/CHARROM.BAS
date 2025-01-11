DEFINT A-Z
DECLARE SUB DisplayText (Text AS STRING, x AS INTEGER, y AS INTEGER, ColorV AS INTEGER, Transparent AS INTEGER)

SCREEN 13
CLS

DisplayText "Character ROM", 8, 0, 1, 0
DisplayText "Character ROM", 9, 1, 9, -1
DisplayText "By: Peter Swinkels,", 24, 18, 15, 0
DisplayText "***2024***", 56, 33, 7, 0
DisplayText " This program copies character data      directly from the video ROM.", 0, 56, 10, 0

DEFSNG A-Z
SUB DisplayText (Text AS STRING, x AS INTEGER, y AS INTEGER, ColorV AS INTEGER, Transparent AS INTEGER)
DIM Column AS INTEGER
DIM Index AS INTEGER
DIM Pixel AS INTEGER
DIM PixelOn AS INTEGER
DIM Pixels AS LONG
DIM Row AS INTEGER
DIM Source AS INTEGER
DIM Target AS INTEGER

 FOR Index = 1 TO LEN(Text)
  Source = &HE + (ASC(MID$(Text, Index, 1)) * &H8)
  Target = (y * 320) + x

  FOR Row = 0 TO 7
   DEF SEG = &HFFA6

   Pixels = PEEK(Source)
   Source = Source + 1
   DEF SEG = &HA000
   FOR Column = 0 TO 7
    PixelOn = (Pixels AND &H80) / &H80
    IF Transparent THEN
     IF PixelOn THEN POKE Target, ColorV
    ELSE
     IF PixelOn THEN POKE Target, ColorV ELSE POKE Target, 0
    END IF
    Pixels = Pixels * 2
    Target = Target + 1
   NEXT Column

   Target = Target + 312
  NEXT Row
  IF x + 8 >= 320 THEN
   x = 0
   y = y + 8
  ELSE
   x = x + 8
  END IF
 NEXT Index
END SUB

