//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/23/07, 14:01:07
// ----------------------------------------------------
// Method: ExecuteArray
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $theRecName)
If (Count parameters:C259=1)
	C_LONGINT:C283($w)
	$w:=Find in array:C230(<>aExecuteNames; $1)
	If ($w>0)
		vResponse:=""
		ExecuteText(0; <>aExecuteScripts{$w})
	End if 
End if 