//%attributes = {}

// Modified by: Bill James (2021-12-18T06:00:00Z)
// Method: LBX_DemoDynamic_00
// Description 
// Parameters
// ----------------------------------------------------


//$w:=Find in array(Current process; <>aPrsNum)
//If ($w>0)
//<>aPrsName{$w}:="LBXDynamicDemo"
//End if 
If (Count parameters:C259>0)
	C_LONGINT:C283($win)
	
	$win:=Open form window:C675("LBXDynamicDemo")
	
	var process_o : Object
	process_o:=$1
	// formData:=DIALOG("LBXDynamicDemo")
	DIALOG:C40("LBXDynamicDemo"; $o)
	
	If (False:C215)  // my testing
		$win:=Open form window:C675("Order_Inc")
		DIALOG:C40("Order_Inc")
	End if 
	
	CLOSE WINDOW:C154($win)
	
	Process_ListActive
	
Else 
	var $name : Text
	var $processNum : Integer
	$processNum:=Process number:C372("DynamicDemo")
	If ($processNum>0)
		BRING TO FRONT:C326($processNum)
	Else 
		var $o : Object
		$o:=cs:C1710.cProcess_o.new("LBXDynamicDemo"; "Customer")
		$processNum:=New process:C317("LBX_DemoDynamic_00"; 0; "LBXDynamicDemo"; $o)
	End if 
End if 
