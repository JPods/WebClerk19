//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/15/11, 10:47:27
// ----------------------------------------------------
// Method: WC_ShowMonitor
// Description
// 
//
// Parameters
// ----------------------------------------------------

// (PM) WC_ShowMonitor
// $1 = Dummy parameter used for launching new process
// Process_ListActive
If (Count parameters:C259=0)  //startup the process
	C_LONGINT:C283($fia)
	//<>aPrsName
	$fia:=Find in array:C230(<>aPrsNum; <>webMonitorProcess)
	If ($fia>0)
		C_LONGINT:C283($tasks; $prsNum; $state; $tics)
		C_TEXT:C284($name)
		PROCESS PROPERTIES:C336(<>webMonitorProcess; $name; $state; $tics)
		If ($state>=0)
			BRING TO FRONT:C326(<>webMonitorProcess)
		Else 
			<>webMonitorProcess:=New process:C317("WC_ShowMonitor"; 128*1024; "WebClerk"; 1; *)
			BRING TO FRONT:C326(<>webMonitorProcess)
		End if 
	Else 
		<>webMonitorProcess:=New process:C317("WC_ShowMonitor"; 128*1024; "WebClerk"; 1; *)
		BRING TO FRONT:C326(<>webMonitorProcess)
	End if 
Else 
	If (True:C214)
		<>prcControl:=0
		$doPrcWind:=True:C214
		Process_InitLocal
		ControlRecCheck
		
		jSetMenuNums(1; 5; 6)
		// WindowOpenTaskOffSets
		var $obWindows : Object
		$obWindows:=WindowCountToShow
		
		$window:=Open form window:C675([Base:1]; "WebClerkMonitor"; Plain form window:K39:10; On the left:K39:2; At the top:K39:5)
		DIALOG:C40([Base:1]; "WebClerkMonitor")
		CLOSE WINDOW:C154($window)
		
	End if 
End if 

