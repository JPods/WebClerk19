//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-09-11T00:00:00, 11:52:39
// ----------------------------------------------------
// Method: WCapi_GetParameter
// Description
// Modified: 09/11/17
// Structure: CE11zx_01
// 
//
// Parameters
// ----------------------------------------------------


// $1 -> param to get
// $2 -> default value
// $0 <- result

C_TEXT:C284($0; $1; $2)
C_LONGINT:C283($p; <>vlWildSrch)
$readText:=0
C_OBJECT:C1216($voParameters)
If (voState.request.parameters[$1]#Null:C1517)
	$0:=voState.request.parameters[$1]
Else 
	If (Count parameters:C259=2)
		$0:=$2  // ### jwm ### 20160218_0903
	Else 
		$0:=""
		
		// Modified by: Bill James (2022-12-15T06:00:00Z)
		// look at augmenting with FC
	End if 
End if 