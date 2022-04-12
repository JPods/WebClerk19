//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/10/18, 14:18:01
// ----------------------------------------------------
// Method: WebTech
// Description
// 
//
// Parameters
// ----------------------------------------------------

ALERT:C41("Hello world")


C_REAL:C285(${1})  // receives n REAL type parameters
C_REAL:C285($0)  // returns a Real
C_LONGINT:C283($i; $n)
$n:=Count parameters:C259
For ($i; 1; $n)
	$0:=$0+${$i}
End for 