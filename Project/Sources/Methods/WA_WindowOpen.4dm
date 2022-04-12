//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-02-09T00:00:00, 15:05:11
// ----------------------------------------------------
// Method: WA_WindowOpen
// Description
// Modified: 02/09/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


// WebClerkStore
If (Count parameters:C259=0)
	<>processAlt:=New process:C317("WA_WindowOpen"; <>tcPrsMemory; "WebClerk Store"; "launch")
	Repeat 
		DELAY PROCESS:C323(Current process:C322; 10)
	Until (<>prcControl=0)
	
Else 
	<>prcControl:=0
	Process_InitLocal
	
	C_LONGINT:C283($fia)
	$fia:=Find in array:C230(<>aPrsNum; Current process:C322)
	If ($fia>0)
		<>aPrsName{$fia}:="WebClerk Store"
	End if 
	POST OUTSIDE CALL:C329(<>theProcessList)
	//jCenter4DWindow (850;500;8;"Record Passing";"CancelCommand")
	$winid:=Open form window:C675([Control:1]; "WebClerkStore"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
	DIALOG:C40([Control:1]; "WebClerkStore")
	CLOSE WINDOW:C154($winid)
	POST OUTSIDE CALL:C329(<>theProcessList)
	
End if 
