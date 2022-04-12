//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-08-27T00:00:00, 16:59:24
// ----------------------------------------------------
// Method: jNavPalletPop
// Description
// Modified: 08/27/17
// 
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1; $2; $3; $4; $5; $6; $7; $8; $9; $10; $11; $12; $13; $14; $15; $16; $17; $18; $19; $20)
C_LONGINT:C283(vPagePopUpCount; $inc; $cnt)
$cnt:=Count parameters:C259
If ($cnt>20)
	ALERT:C41("Add more pages.")
End if 
ARRAY TEXT:C222(aPages; 0)
For ($inc; 1; $cnt)
	APPEND TO ARRAY:C911(aPages; ${$inc})
End for 

C_LONGINT:C283(<>viHelpSet)
APPEND TO ARRAY:C911(aPages; "id to Console")
APPEND TO ARRAY:C911(aPages; "Help")

aPages:=1
