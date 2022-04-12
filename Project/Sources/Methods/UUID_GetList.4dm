//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/26/21, 22:27:30
// ----------------------------------------------------
// Method: UUID_GetList
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($obRec; $obSel)
C_TEXT:C284($vtUUIDs)
C_LONGINT:C283($viInc; $viCnt)
If (Count parameters:C259=0)
	$viCnt:=10
Else 
	$viCnt:=$1
End if 

TRACE:C157
$obSel:=ds:C1482.Item.all()

C_BOOLEAN:C305($vbContinue)
$vbContinue:=True:C214
For each ($obRec; $obSel) While ($vbContinue)
	$viInc:=$viInc+1
	$vtUUIDs:=$vtUUIDs+$obRec.id+"\r"
	$vbContinue:=($viInc<$viCnt)
End for each 
SET TEXT TO PASTEBOARD:C523($vtUUIDs)