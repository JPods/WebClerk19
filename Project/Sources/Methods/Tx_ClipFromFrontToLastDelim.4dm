//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-04-24T00:00:00, 19:13:05
// ----------------------------------------------------
// Method: Tx_ClipFromFrontToLastDelim
// Description
// Modified: 04/24/17
// 
// 
// This trim the tail to the delimiter
//  It DOES NOT clip retain the tail
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $2; $0)

C_LONGINT:C283($lengthString; $incString)
C_BOOLEAN:C305($foundLast)
$incString:=Position:C15($2; $1)
If ($incString=0)
	$0:=$1  // no delimiter, return the value
Else 
	$foundLast:=False:C215
	$incString:=Length:C16($1)
	Repeat 
		If ($1[[$incString]]=$2)
			$foundLast:=True:C214
		Else 
			$incString:=$incString-1
		End if 
	Until ($foundLast)
	$0:=Substring:C12($1; 1; $incString-1)
End if 