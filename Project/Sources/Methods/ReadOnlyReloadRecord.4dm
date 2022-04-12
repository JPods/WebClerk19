//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/26/06, 23:31:24
// ----------------------------------------------------
// Method: ReadOnlyReloadRecord
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
$recNum:=Record number:C243($1->)
C_LONGINT:C283($recNum)
If ($recNum>-1)
	UNLOAD RECORD:C212($1->)
	READ ONLY:C145($1->)
	GOTO RECORD:C242($1->; $recNum)
End if 