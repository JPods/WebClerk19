//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/23/13, 16:06:20
// ----------------------------------------------------
// Method: Prc_Execute
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $processName; $2; $title; $3; $script1; $4; $script2; $5; $script3; $6; $script4; $7; $script5; $8; $script6; $9; $script7)
$script1:=$3
If (Count parameters:C259>3)
	$script2:=$4
	If (Count parameters:C259>4)
		$script3:=$5
		If (Count parameters:C259>5)
			$script4:=$6
			If (Count parameters:C259>6)
				$script5:=$7
				If (Count parameters:C259>7)
					$script6:=$8
					If (Count parameters:C259>8)
						$script7:=$9
					End if 
				End if 
			End if 
		End if 
	End if 
End if 

$childProcess:=New process:C317("Prs_ExecuteProcedures"; <>tcPrsMemory; $processName; Current process:C322; $title; $script1; $script2; $script3; $script4; $script5; $script6; $script7)
APPEND TO ARRAY:C911(aChildProcesses; $childProcess)
vLastProcessLaunched:=$childProcess