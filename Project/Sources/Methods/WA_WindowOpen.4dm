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
	POST OUTSIDE CALL:C329(Storage:C1525.process.processList)
	$obWindows:=WindowCountToShow
	$form_t:="WebArea"
	var $new_o : Object
	$new_o:=New object:C1471
	$new_o.window:=Open form window:C675($form_t; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
	$new_o.parentProcess:=Current process:C322
	
	DIALOG:C40($form_t; $new_o)
	POST OUTSIDE CALL:C329(Storage:C1525.process.processList)
	
End if 
