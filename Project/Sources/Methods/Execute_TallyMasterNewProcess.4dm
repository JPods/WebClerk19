//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/08/12, 09:10:29
// ----------------------------------------------------
// Method: Execute_TallyMasterNewProcess
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $2; $4; $packedVariables)
C_LONGINT:C283($3)
$securitylevel:=1
$packedVariables:=""
If (Count parameters:C259>1)
	If (Count parameters:C259>2)
		$securitylevel:=$3
		If (Count parameters:C259>3)
			$packedVariables:=$4
		End if 
	End if 
	$childProcess:=New process:C317("Execute_TallyMasterProcess"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-"+$1; $1; $2; $securitylevel; $packedVariables)  //;$1)
End if 