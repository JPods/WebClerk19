//%attributes = {}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/22/18, 23:20:11
// ----------------------------------------------------
// Method: JSONStringifyClean
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $0)

C_TEXT:C284($working)
error:=0
ON ERR CALL:C155("OEC_Web")
$working:=JSON Stringify:C1217($1)
$working:=Replace string:C233($working; "\\r"; "")
$working:=Replace string:C233($working; "\\t"; "")
$working:=Replace string:C233($working; "\\n"; "")
$working:=Replace string:C233($working; "\n"; "")
$working:=Replace string:C233($working; "\n"; "")
$working:=Replace string:C233($working; "\r"; "")
$working:=Replace string:C233($working; "\t"; "")
$0:=$working
If (error#0)
	ALERT:C41("Error: "+String:C10(error))
End if 
ON ERR CALL:C155("")
