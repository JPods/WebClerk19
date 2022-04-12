//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-07-30T00:00:00, 20:58:13
// ----------------------------------------------------
// Method: Text_CRLF_to_CR
// Description
// Modified: 07/30/16
// Structure: CEv13_131005
// Utility
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($1; $0; $workingText; $endDelimiter)

$endDelimiter:="\r"
If (Count parameters:C259>0)
	$workingText:=$1
	If (Count parameters:C259>1)
		$endDelimiter:=$2
	End if 
Else 
	$workingText:=Get text from pasteboard:C524
End if 
$workingText:=Replace string:C233($workingText; Storage:C1525.char.crlf; $endDelimiter)
$workingText:=Replace string:C233($workingText; "\n"; $endDelimiter)
If ($endDelimiter#"\r")
	$workingText:=Replace string:C233($workingText; "\r"; $endDelimiter)
End if 
$0:=$workingText

If (False:C215)
	If (Count parameters:C259=0)
		SET TEXT TO PASTEBOARD:C523($workingText)
	End if 
End if 