//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/22/13, 09:54:08
// ----------------------------------------------------
// Method: Prs_unlockedRecords
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($timeout; $0)
C_POINTER:C301($1)
$timeout:=Milliseconds:C459+<>unloaddelay
While ((Locked:C147(<>ptCurTable->)) & (Milliseconds:C459<$timeout))
	DELAY PROCESS:C323(Current process:C322; 2)
End while 
If (Locked:C147(<>ptCurTable->))
	$0:=0
Else 
	$0:=1
End if 