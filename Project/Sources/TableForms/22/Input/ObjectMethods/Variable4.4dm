C_TEXT:C284($vPart)
C_TEXT:C284($vDesc)
C_LONGINT:C283($CurRec)
TRACE:C157
//CREATE SET([ItemXRef];"Temp")
//$CurRec:=Selected record number([ItemXRef])
PUSH RECORD:C176([ItemXRef:22])
diaItemXRef(->[ItemXRef:22]ItemNumMaster:1; ->[ItemXRef:22]DescriptionMaster:8; ""; 0)
POP RECORD:C177([ItemXRef:22])
TRACE:C157
//USE SET("Temp")
//CLEAR SET("Temp")
//GOTO SELECTED RECORD([ItemXRef];$CurRec)