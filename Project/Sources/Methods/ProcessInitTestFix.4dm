//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-05-01T00:00:00, 17:57:13
// ----------------------------------------------------
// Method: ProcessInitTestFix
// Description
// Modified: 05/01/17
// 
// 
//
// Parameters
// ----------------------------------------------------
//Begin Example:  Procedure or Menu Call directly into a new process
C_LONGINT:C283($newProcess)
$newProcess:=0
If (Undefined:C82(vHere))  // for interpretted only. Only a problem in interpretted.
	$newProcess:=1
Else 
	If (vHere=0)
		$newProcess:=1
	End if 
End if 

If (($newProcess=1) | (<>prcControl=1))
	Process_InitLocal
	<>prcControl:=0
	WindowOpenTaskOffSets
	ptCurTable:=(->[Control:1])
End if 

// end example