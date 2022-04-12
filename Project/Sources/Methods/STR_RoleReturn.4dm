//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/11/21, 22:38:35
// ----------------------------------------------------
// Method: STR_RoleReturn
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($0)
If (Records in selection:C76([QQQRemoteUser:57])=1)
	$0:=[QQQRemoteUser:57]role:25
Else 
	$0:="min"
End if 
