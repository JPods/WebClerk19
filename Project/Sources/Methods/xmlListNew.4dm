//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/29/10, 10:34:27
// ----------------------------------------------------
// Method: xmlListNew
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $listPtr)

$listPtr:=$1

If (Is a list:C621($listPtr->))
	CLEAR LIST:C377($listPtr->; *)
End if 

$listPtr->:=New list:C375