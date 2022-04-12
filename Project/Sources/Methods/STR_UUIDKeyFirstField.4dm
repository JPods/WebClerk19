//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/11/21, 22:52:56
// ----------------------------------------------------
// Method: STR_UUIDKeyFirstField
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_POINTER:C301($1)
C_LONGINT:C283($viFound)

$viFound:=Find in array:C230($1->; "id")
If ($viFound>0)
	DELETE FROM ARRAY:C228($1->; $viFound)
End if 
INSERT IN ARRAY:C227($1->; 1; 1)
$1->{1}:="id"
