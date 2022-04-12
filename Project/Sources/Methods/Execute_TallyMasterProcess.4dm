//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/08/12, 09:15:53
// ----------------------------------------------------
// Method: Execute_TallyMasterProcess
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $2; $name; $purpose; $4; $packedvariables)
C_LONGINT:C283($3; $securitylevel)
$securitylevel:=1
Process_InitLocal
If (Count parameters:C259>1)
	If (Count parameters:C259>2)
		$securitylevel:=$3
		If (Count parameters:C259>3)
			TextToArray($4; ->aText11)
		End if 
	End if 
	Execute_TallyMaster($1; $2; $securitylevel)
End if 