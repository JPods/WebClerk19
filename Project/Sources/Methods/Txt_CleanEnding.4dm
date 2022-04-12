//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-04-30T00:00:00, 00:38:01
// ----------------------------------------------------
// Method: Txt_CleanEnding
// Description
// Modified: 04/30/17
// 
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $0; $2; $replaceBy)

$0:=Replace string:C233($1; Storage:C1525.char.crlf; "\r")
$0:=Replace string:C233($1; "\n"; "\r")
If (Count parameters:C259>1)
	$0:=Replace string:C233($1; "\n"; $2)
End if 