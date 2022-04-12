//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/31/11, 07:28:01
// ----------------------------------------------------
// Method: UTWorkingTextFromArray
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1; $ptText; $2; $ptArray)
C_LONGINT:C283($3; $length2check)
$ptText:=$1
$ptArray:=$2
$length2check:=$3
If ((Size of array:C274($ptArray->)>0) & (Length:C16($ptText->)<$length2check))
	$ptText->:=$ptText->+$ptArray->{1}
	DELETE FROM ARRAY:C228($ptArray->; 1; 1)
End if 