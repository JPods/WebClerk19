//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/23/18, 12:00:40
// ----------------------------------------------------
// Method: ConvertUnixChar
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($working; $1)
If (Count parameters:C259=0)
	$working:=Get text from pasteboard:C524
Else 
	$working:=$1
End if 
$working:=Replace string:C233($working; "%7B"; "{")


$working:=Replace string:C233($working; "%7B"; "{")
$working:=Replace string:C233($working; "%7D"; "}")
$working:=Replace string:C233($working; "%5B"; "[")
$working:=Replace string:C233($working; "%5D"; "]")
$working:=Replace string:C233($working; "%2C"; ",")
$working:=Replace string:C233($working; "%3A"; ":")
$working:=Replace string:C233($working; "+"; " ")
$working:=Replace string:C233($working; "%22"; "\"")

If (Count parameters:C259=0)
	SET TEXT TO PASTEBOARD:C523($working)
Else 
	$0:=$working
End if 
