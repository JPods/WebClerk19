//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/24/11, 23:17:04
// ----------------------------------------------------
// Method: HFS_HardName
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $0)
C_LONGINT:C283($i; $found)
For ($i; Length:C16($1); 1; -1)
	If ($1[[$i]]=".")
		$found:=$i-1
		$i:=0
	End if 
End for 
If ($found>1)
	$0:=Substring:C12($1; 1; $found)
Else 
	$0:=$1
End if 