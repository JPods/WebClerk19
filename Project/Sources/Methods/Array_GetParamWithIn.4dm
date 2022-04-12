//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/20/08, 00:14:51
// ----------------------------------------------------
// Method: Array_GetParamWithIn
// Description
// 
//
// Parameters
C_POINTER:C301($1; $array)
C_TEXT:C284($2; $theValue)
C_LONGINT:C283($3; $startPoint; $4; $lessThan; $0; $foundMatch)
// ----------------------------------------------------
$startPoint:=0
$lessThan:=Size of array:C274($1->)
If (Count parameters:C259>2)
	$startPoint:=$3
	If (Count parameters:C259>3)
		$lessThan:=$4
	End if 
End if 

$foundMatch:=Find in array:C230($1->; $2; $startPoint)
If (($foundMatch>0) & ($foundMatch<=$4))
	$0:=$foundMatch
Else 
	$0:=-1
End if 



