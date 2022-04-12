//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/22/19, 21:09:01
// ----------------------------------------------------
// Method: arraySellectAll
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $aptPrimary; $ptaSelect)
C_LONGINT:C283($inc; $cnt)
$aptPrimary:=$1
$ptaSelect:=$2
$cnt:=Size of array:C274($aptPrimary->)
ARRAY LONGINT:C221($ptaSelect->; $cnt)
For ($inc; 1; $cnt)
	$ptaSelect->{$inc}:=$inc
End for 