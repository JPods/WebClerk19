//%attributes = {}

// Modified by: Bill James (2022-07-03T05:00:00Z)
// Method: LBX_DataBrowser
// Description 
// Parameters
// ----------------------------------------------------
#DECLARE($o : Object)
If (Count parameters:C259>0)
	C_LONGINT:C283($win_i)
	
	var process_o : cs:C1710.cProcess
	process_o:=$o
	
	process_o.window_i:=Open form window:C675("DataBrowser")
	
	DIALOG:C40("DataBrowser"; process_o)
	CLOSE WINDOW:C154(process_o.window_i)
	
	process_o.destructor()
	DELAY PROCESS:C323(Current process:C322; 30)
	CALL WORKER:C1389("Processes"; "Process_ListActive")
	
Else 
	var $name : Text
	var $processNum : Integer
	$processNum:=Process number:C372("DynamicDemo")
	If ($processNum>0)
		BRING TO FRONT:C326($processNum)
	Else 
		var $o : Object
		$o:=New object:C1471("dataClassName"; "Customer"; "data"; New object:C1471)
		$processNum:=New process:C317("LBX_DataBrowser"; 0; "DataBrowser"; $o)
	End if 
End if 