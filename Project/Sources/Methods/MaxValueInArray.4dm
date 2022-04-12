//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-20T00:00:00, 12:50:50
// ----------------------------------------------------
// Method: MaxValueInArray
// Description
// Modified: 01/20/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
// aiLineNum; aoLineNum; aPLineNum; aPoLineNum

C_REAL:C285($0; $lastMax)
C_LONGINT:C283($rayCnt; $rayInc)
C_POINTER:C301($1)
//  maybe add a negative option at some point
If (Count parameters:C259>1)  // option for setting a start value
	$lastMax:=$2
Else 
	$lastMax:=0
End if 
$rayCnt:=Size of array:C274($1->)
If ($rayCnt=0)
	$0:=0
Else 
	For ($rayInc; 1; $rayCnt)
		If ($lastMax<$1->{$rayInc})
			$lastMax:=$1->{$rayInc}
		End if 
	End for 
End if 
$0:=$lastMax