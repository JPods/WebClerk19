//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/26/21, 11:18:07
// ----------------------------------------------------
// Method: VAR_TO_BLOB
// Description
// 
// Parameters
// ----------------------------------------------------



C_POINTER:C301(${1})
C_LONGINT:C283($vlParam)

For ($vlParam; 2; Count parameters:C259)
	VARIABLE TO BLOB:C532(${$vlParam}->; $1->; *)
End for 