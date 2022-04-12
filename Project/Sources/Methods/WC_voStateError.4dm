//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/10/21, 11:51:11
// ----------------------------------------------------
// Method: WC_voStateError
// Description
// 
// Parameters
// ----------------------------------------------------

var $1 : Text
var $length_i : Integer
If (voState.error=Null:C1517)
	voState.error:=New object:C1471
End if 
$length_i:=voState.error.length
voState.error[String:C10($length_i)]:=$1

