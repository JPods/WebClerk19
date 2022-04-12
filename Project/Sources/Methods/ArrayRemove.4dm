//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/14/20, 16:39:03
// ----------------------------------------------------
// Method: ArrayRemove
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $ptArray; $2; $ptValue)
$ptArray:=$1
$ptValue:=$2
C_LONGINT:C283($w)
Repeat 
	$w:=Find in array:C230($ptArray->; $ptValue->)
	If ($w>0)
		DELETE FROM ARRAY:C228($ptArray->; $w)
	End if 
Until ($w<1)
