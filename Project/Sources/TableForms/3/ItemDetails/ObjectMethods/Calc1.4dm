// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/29/06, 04:22:03
// ----------------------------------------------------
// Method: Object Method: bItemDetailExecute
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($w)
$w:=Find in array:C230(<>aExecuteNames; "3_ItemDetails")
If ($w>0)
	ExecuteText(0; <>aExecuteScripts{$w})
End if 