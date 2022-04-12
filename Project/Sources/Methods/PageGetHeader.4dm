//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-09-03T00:00:00, 13:50:59
// ----------------------------------------------------
// Method: PageGetHeader
// Description
// Modified: 09/03/17
// 
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($1; $2; $0; $name; $defaultValue; $value)
C_LONGINT:C283($index)

$name:=$1
If (Count parameters:C259>=2)
	$defaultValue:=$2
End if 

$index:=Find in array:C230(aHeaderNameIn; $name)
If ($index#-1)
	$value:=aHeaderValueIn{$index}
Else 
	$value:=$defaultValue
End if 

$0:=$value