//%attributes = {"publishedWeb":true}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-11-30T00:00:00, 22:56:24
// ----------------------------------------------------
// Method: Unique_Reset
// Description
// Modified: 11/30/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_POINTER:C301($1; $2; $3)
C_LONGINT:C283($0; $err)
$err:=-2
If ((vHere>1) & (ptCurTable=$1))
	$err:=-1
	PUSH RECORD:C176($1->)
	QUERY:C277($1->; $2->=$3->)
	If (Records in selection:C76($1->)=0)
		$err:=0
	End if 
	POP RECORD:C177($1->)
	If ($err=0)
		$2->:=$3->
	End if 
End if 
If ($err#0)
	BEEP:C151
	BEEP:C151
End if 