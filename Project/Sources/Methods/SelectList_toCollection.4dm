//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/16/21, 12:45:21
// ----------------------------------------------------
// Method: SelectList_toCollection
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1)
C_LONGINT:C283($2; $startInc)
$startInc:=2
If (Count parameters:C259>1)
	$startInc:=$2
End if 
C_TEXT:C284($vtName)
C_POINTER:C301($ptLableName; $ptArray)
C_COLLECTION:C1488($cSelChoices)
$cSelChoices:=New collection:C1472
$ptArray:=Get pointer:C304($1)
If ($ptArray#Null:C1517)
	C_LONGINT:C283($inc; $cnt)
	$cnt:=Size of array:C274($ptArray->)
	For ($inc; $startInc; $cnt)  // skip the header
		$cSelChoices.push(New object:C1471("label"; $ptArray->{$inc}; "value"; $ptArray->{$inc}))
	End for 
	$0:=$cSelChoices
End if 