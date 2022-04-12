//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/03/21, 18:27:52
// ----------------------------------------------------
// Method: CurrentUser_Get
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($0)
If (Storage:C1525.user.currentName=Null:C1517)
	$0:=Storage:C1525.user.currentName
Else 
	$0:=Current user:C182
End if 