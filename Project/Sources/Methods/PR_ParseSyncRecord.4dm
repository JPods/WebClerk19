//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/19/19, 18:49:00
// ----------------------------------------------------
// Method: PR_ParseSyncRecord
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_POINTER:C301($1; $ptObect)
If (Count parameters:C259>0)
	$ptObect:=$1
Else 
	READ ONLY:C145([SyncRelation:103])
	QUERY:C277([SyncRelation:103]; [SyncRelation:103]Name:8="ParseSyncRecord")
	$ptObect->:=[SyncRecord:109]ObGeneral:16  // testing
End if 

C_OBJECT:C1216($obSync)



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

