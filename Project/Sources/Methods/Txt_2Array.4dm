//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-06-13T00:00:00, 22:05:22
// ----------------------------------------------------
// Method: Txt_2Array
// Description
// Modified: 06/13/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $theText; $3; $delimiter)
C_POINTER:C301($2)
C_BOOLEAN:C305($4; $doEmpty)

Case of 
	: (Count parameters:C259=2)
		TextToArray($1; $2)
	: (Count parameters:C259=3)
		TextToArray($1; $2; $3)
	: (Count parameters:C259=4)
		TextToArray($1; $2; $3; $4)
End case 
