//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-01-23T00:00:00, 12:56:02
// ----------------------------------------------------
// Method: Util_ExchangeValues
// Description
// Modified: 01/23/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $2; $3)
C_BOOLEAN:C305($4; $forceNewRecord)
If (Count parameters:C259=4)
	$forceNewRecord:=$4
	$ptTable:=Table:C252(Table:C252($1))  // point to the field to change
	ARRAY TEXT:C222($aOldValues; 0)
	ARRAY TEXT:C222($aReplaceValues; 0)
	ARRAY TEXT:C222($aNewValues; 0)
	//
	C_LONGINT:C283($i; $k)
	$k:=Records in selection:C76($ptTable->)
	READ WRITE:C146($ptTable->)
	FIRST RECORD:C50($ptTable->)
	For ($i; 1; $k)
		$w:=Find in array:C230($aOldValues; $1->)
		If ($w>0)  // found the old value
			$1->:=$aReplaceValues{$w}
			SAVE RECORD:C53($ptTable->)
		Else 
			If ($forceNewRecord)
				$w:=Find in array:C230($aReplaceValues; $1->)
				If ($w<0)  // is not already there
					APPEND TO ARRAY:C911($aNewValues; $aReplaceValues{$w})
				End if 
			End if 
		End if 
		NEXT RECORD:C51($ptTable->)
	End for 
End if 

