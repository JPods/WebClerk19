//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/27/18, 22:49:20
// ----------------------------------------------------
// Method: MatchObjectLoad
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($jsonPattern)
$jsonPattern:=[TallyMaster:60]template:29
C_OBJECT:C1216($objPattern)
$objPattern:=JSON Parse:C1218($jsonPattern)
ARRAY TEXT:C222($atNames; 0)
ARRAY LONGINT:C221($aiTypes; 0)
OB GET PROPERTY NAMES:C1232($objPattern; $atNames; $aiTypes)

C_OBJECT:C1216($objHead)
C_OBJECT:C1216($objLocal)
C_OBJECT:C1216($objForeign)

ARRAY TEXT:C222($atNamesHead; 0)
ARRAY LONGINT:C221($aiTypesHead; 0)

ARRAY TEXT:C222($atNamesLocal; 0)
ARRAY LONGINT:C221($aiTypesLocal; 0)

ARRAY TEXT:C222($atNamesForeign; 0)
ARRAY LONGINT:C221($aiTypesForeign; 0)

$objHead:=OB Get:C1224($objPattern; "head")
$objLocal:=OB Get:C1224($objPattern; "local")
$objForeign:=OB Get:C1224($objPattern; "foreign")

OB GET PROPERTY NAMES:C1232($objHead; $atNamesHead; $aiTypesHead)
OB GET PROPERTY NAMES:C1232($objLocal; $atNamesLocal; $aiTypesLocal)
OB GET PROPERTY NAMES:C1232($objForeign; $atNamesForeign; $aiTypesForeign)

C_TEXT:C284($tableName)
C_LONGINT:C283($tableNum)
$tableName:=OB Get:C1224($objHead; "TableName")
$tableNum:=STR_GetTableNumber($tableName)
If ($tableNum<1)
	ALERT:C41("Not a valid import tempate.")
Else 
	
	curTableNum:=$tableNum
	StructureFields(curTableNum)
	If (eExportFlds>0)
		//  --  CHOPPED  AL_UpdateArrays(eExportFlds; -2)
		// -- AL_SetSort(eExportFlds; 1)
		//
		// //  --  CHOPPED  AL_UpdateArrays (eMatchList;-2)
	End if 
	
	
	// Arrays for choosing between
	// ARRAY TEXT(theFields;0)
	// ARRAY TEXT(theTypes;0)
	// ARRAY TEXT(theUniques;0)
	// ARRAY LONGINT(theFldNum;0)
	
	ARRAY TEXT:C222(aMatchField; 0)
	ARRAY TEXT:C222(aMatchType; 0)
	ARRAY LONGINT:C221(aMatchNum; 0)
	ARRAY LONGINT:C221(aCntMatFlds; 0)
	
	
	C_TEXT:C284($fieldName)
	C_LONGINT:C283($fieldNum)
	C_LONGINT:C283($i; $k; $viTest; $w)
	$k:=Size of array:C274($atNamesLocal)
	ARRAY LONGINT:C221($aOrderBy; 0)
	For ($i; 1; $k)
		$viTest:=Num:C11($atNamesLocal{$i})
		If ($viTest>0)
			APPEND TO ARRAY:C911($aOrderBy; $viTest)
		End if 
	End for 
	SORT ARRAY:C229($aOrderBy)
	$k:=Size of array:C274($aOrderBy)
	For ($i; 1; $k)
		$fieldName:=OB Get:C1224($objLocal; String:C10($aOrderBy{$i}))
		$fieldNum:=STR_GetFieldNumber($tableName; $fieldName)
		MatchArraysAdd($tableNum; $fieldNum)
	End for 
	$k:=Size of array:C274(aMatchNum)
	ARRAY LONGINT:C221(aCntMatFlds; $k)
	For ($i; 1; $k)
		aCntMatFlds{$i}:=$i
	End for 
End if 