//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/28/18, 00:12:06
// ----------------------------------------------------
// Method: SyncParseStandard
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($jsonPattern)
C_OBJECT:C1216($objPattern)
$jsonPattern:=[SyncRecord:109]PackingNotes:14
$objPattern:=JSON Parse:C1218([SyncRecord:109]PackingNotes:14)




C_OBJECT:C1216($objPattern)
$objPattern:=JSON Parse:C1218($jsonPattern)
ARRAY TEXT:C222($atNames; 0)
ARRAY LONGINT:C221($aiTypes; 0)
OB GET PROPERTY NAMES:C1232($objPattern; $atNames; $aiTypes)


C_OBJECT:C1216($objHead)
C_OBJECT:C1216($objData)

ARRAY TEXT:C222($atNamesHead; 0)
ARRAY LONGINT:C221($aiTypesHead; 0)

ARRAY TEXT:C222($atNamesLocal; 0)
ARRAY LONGINT:C221($aiTypesLocal; 0)

ARRAY OBJECT:C1221($aObjHead; 0)
ARRAY OBJECT:C1221($aObjData; 0)

$objHead:=OB Get:C1224($objPattern; "head")
OB GET ARRAY:C1229($objHead; "SyncRecord"; $aObjHead)

$objSync:=$aObjHead{1}
// header value pairs

jsonParsingToFlat($objSync; "start")

$objData:=OB Get:C1224($objPattern; "data")

jsonParsingToFlat($objData; "start")

ARRAY TEXT:C222($atNamesData; 0)
ARRAY LONGINT:C221($aiTypesData; 0)
OB GET PROPERTY NAMES:C1232($objData; $atNamesData; $aiTypesData)


OB GET ARRAY:C1229($objData; "data"; $aObjData)

