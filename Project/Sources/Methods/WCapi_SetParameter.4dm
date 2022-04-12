//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/12/21, 11:10:23
// ----------------------------------------------------
// Method: WCapi_SetParameter
// Description
// 
//
// Parameters
// ----------------------------------------------------
//WCapi_GetParameter
C_TEXT:C284($0; $1; $2)
C_LONGINT:C283($p; <>vlWildSrch)
$readText:=0
C_OBJECT:C1216($voParameters)
If (voState.request.parameters#Null:C1517)
	voState.request.parameters[$1]:=$2
End if 