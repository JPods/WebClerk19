//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/27/20, 22:07:03
// ----------------------------------------------------
// Method: LatLngFromString
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $working)
C_POINTER:C301($2; $3)
C_LONGINT:C283($p)
If ($1="")
	$2->:=""
	$3->:=""
Else 
	$p:=Position:C15(","; $1)
	If ($p<1)
		$2->:=""
		$3->:=""
	Else 
		$2->:=Substring:C12($1; 1; $p-1)
		$3->:=Substring:C12($1; 1; $p+1)
	End if 
End if 


