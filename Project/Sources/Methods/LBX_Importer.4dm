//%attributes = {}


// Modified by: Bill James (2022-12-27T06:00:00Z)
// Method: LBX_Importer
// Description 
// Parameters
// ----------------------------------------------------


If (Count parameters:C259>0)
	C_LONGINT:C283($win)
	
	$win:=Open form window:C675("ImportDB")
	
	var process_o : Object
	process_o:=$1
	DIALOG:C40("ImportDB"; $1)
	CLOSE WINDOW:C154($win)
	
	//QQZZQQ must fix  add destructor
	// process_o.destructor()
	DELAY PROCESS:C323(Current process:C322; 30)
	CALL WORKER:C1389("Processes"; "Process_ListActive")
	
Else 
	var $name : Text
	var $processNum : Integer
	$processNum:=Process number:C372("ImportDB")
	If ($processNum>0)
		BRING TO FRONT:C326($processNum)
	Else 
		var $o : Object
		$o:=New object:C1471("dataClassName"; "Item"; "data"; New object:C1471)
		$processNum:=New process:C317("LBX_Importer"; 0; "ImportDB"; $o)
	End if 
End if 