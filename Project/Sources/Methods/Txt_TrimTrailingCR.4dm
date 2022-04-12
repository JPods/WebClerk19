//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/15/21, 18:39:41
// ----------------------------------------------------
// Method: Txt_TrimTrailingCR
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $0; $vtWorking)
If ($1[[Length:C16($1)]]="\n")
	$0:=Substring:C12($1; 1; Length:C16($1)-1)
Else 
	$0:=$1
End if 
If ($0[[Length:C16($0)]]="\r")
	$0:=Substring:C12($0; 1; Length:C16($0)-1)
End if 
