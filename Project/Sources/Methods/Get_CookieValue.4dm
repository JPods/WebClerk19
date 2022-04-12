//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 03/15/16, 12:52:57
// ----------------------------------------------------
// Method: Get_CookieValue
// Description
// $1 = name of cookie
// $0 = value of cookie
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $name; $0; $value)

$name:=$1
$value:=""

$p:=Find in array:C230(aCookieName; $name)
If ($p>0)
	$value:=aCookieValue{$p}
End if 
$0:=$value
