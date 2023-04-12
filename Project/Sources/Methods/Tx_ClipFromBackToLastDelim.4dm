//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-08-22T00:00:00, 23:03:15
// ----------------------------------------------------
// Method: Tx_ClipFromBackToLastDelim
// Description
// Modified: 08/22/17
// To Find the last segment of a file path
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $vtString; $2; $vtDelimiter; $0)
C_LONGINT:C283($viLengthString; $viIncString)
C_BOOLEAN:C305($vbFoundLast)

$vtString:=$1
$vtDelimiter:=$2

$viLengthString:=Length:C16($vtString)

If ($viLengthString>0)  // protection against empty string
	
	// CHECK TO SEE IF THE LAST CHARACTER IS A SEPARATOR,
	// AND REMOVE IF THAT IS THE CASE.
	
	If ($vtString[[$viLengthString]]=$vtDelimiter)
		$vtString:=Substring:C12($vtString; 1; $viLengthString-1)
	End if 
	
	// WALK THROUGH THE STRING TO FIND THE LAST INSTANCE OF THE
	// SPECIFIED DELIMITER, THEN GRAB THE 
	
	$viIncString:=Position:C15($vtDelimiter; $vtString)
	
	If ($viIncString=0)
		$0:=$vtString  // no delimiter, return the value
	Else 
		$vbFoundLast:=False:C215
		$viIncString:=Length:C16($vtString)
		Repeat 
			If ($vtString[[$viIncString]]=$vtDelimiter)
				$vbFoundLast:=True:C214
			Else 
				$viIncString:=$viIncString-1
			End if 
		Until ($vbFoundLast)
		$0:=Substring:C12($vtString; $viIncString+1)
	End if 
Else 
	$0:=$1  // Empty String ""
	ConsoleLog("vWCDocumentURI is an empty String \rRequestURI = "+vWCRequestURI)
End if 
