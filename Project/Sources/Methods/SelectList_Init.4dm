//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 04/22/21, 21:59:13
// ----------------------------------------------------
// Method: SelectList_Init
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_OBJECT:C1216($obRec; $obSel)

C_COLLECTION:C1488($cTest; $cDistinct)
C_POINTER:C301($ptArray; $ptName)
ON ERR CALL:C155("OEC_Web")
$cTest:=New collection:C1472
C_TEXT:C284($1; $vtNameArray)
If (Count parameters:C259=1)
	$vtNameArray:=$1
	$obSel:=ds:C1482.PopUp.query("arrayName = :1"; "<>"+$vtNameArray)
	If ($obSel=Null:C1517)
		SelectList_Create($vtNameArray)
	End if 
	$cTest:=SelectList_One($vtNameArray)
	
End if 
