//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/13/20, 16:17:56
// ----------------------------------------------------
// Method: arrayToText
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $ptArray; $2; $ptText)
C_LONGINT:C283($incRay; $cntRay)
C_TEXT:C284($3; $fieldDelimit)
C_TEXT:C284($4; $lineDelimit)
$fieldDelimit:="\t"
$lineDelimit:="\r"
If (Count parameters:C259>2)
	$fieldDelimit:=$3
	If (Count parameters:C259>3)
		$lineDelimit:=$4
	End if 
End if 
$ptArray:=$1
$ptText:=$2
$cntRay:=Size of array:C274($ptArray->)-1
If ($cntRay>0)
	If ($ptText->#"")
		$ptText->:=$ptText->+$lineDelimit
	End if 
	For ($incRay; 1; $cntRay)
		$ptText->:=$ptText->+$ptArray->{$incRay}+$fieldDelimit
	End for 
	$ptText->:=$ptText->+$ptArray->{$cntRay+1}
End if 

