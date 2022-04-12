//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/24/09, 06:23:32
// ----------------------------------------------------
// Method: remoteUserIDNew
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $0)

$userName:=$1
QUERY:C277([RemoteUser:57]; [RemoteUser:57]userName:2=$userName)
OK:=1
Repeat 
	If (Records in selection:C76([RemoteUser:57])#0)
		$userName:=Request:C163("Replace not unique, "+$userName; $userName)
		If ((OK=1) & ($userName#""))
			QUERY:C277([RemoteUser:57]; [RemoteUser:57]userName:2=$userName)
		End if 
	End if 
Until ((OK=1) | (Records in selection:C76([RemoteUser:57])=0))
If ((OK=1) & (Records in selection:C76([RemoteUser:57])=0))
	$0:=$userName
Else 
	$0:=""
End if 