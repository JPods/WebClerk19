//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-11-30T00:00:00, 22:56:59
// ----------------------------------------------------
// Method: UniqueField
// Description
// Modified: 11/30/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_BOOLEAN:C305($bad)
C_POINTER:C301($1; $2; $3)
C_LONGINT:C283($i)
PUSH RECORD:C176($1->)
QUERY:C277($1->; $3->=$2->)
$bad:=(Records in selection:C76($1->)>0)
POP RECORD:C177($1->)
If ($bad)
	$2->:=$3->
	BEEP:C151
	GOTO OBJECT:C206($2->)
Else 
	$3->:=$2->
End if 
If (Count parameters:C259>3)
	For ($i; 4; Count parameters:C259)
		${$i}->:=$2->
	End for 
End if 