//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/25/21, 23:30:56
// ----------------------------------------------------
// Method: Date_yyyy_mm_dd_hh_mm
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_DATE:C307($1; $vdDate)
C_TIME:C306($2; $vtTime)
C_TEXT:C284($0; $vtWorking; $vtTimeString)
If (Count parameters:C259=0)
	$vdDate:=Current date:C33
	$vtTime:=Current time:C178
Else 
	$vdDate:=$1
	If (Count parameters:C259=2)
		$vtTime:=$2
		$vtWorking:=String:C10($vdDate; ISO date:K1:8; $vtTime)
	Else 
		$vtWorking:=String:C10($vdDate; ISO date:K1:8)
	End if 
	$vtWorking:=Replace string:C233($vtWorking; "T"; " ")
	$0:=Substring:C12($vtWorking; 1; Length:C16($vtWorking)-3)
End if 
