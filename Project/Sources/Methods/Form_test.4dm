//%attributes = {}

// Modified by: Bill James (2022-01-01T06:00:00Z)
// Method: Form_test
// Description 
// Parameters
// ----------------------------------------------------
// https://4dmethod.com/2020/06/25/june-30-meeting-modularizing-collection-and-entity-selection-list-boxes-kirk-brooks-guy-algot/

If (Count parameters:C259>0)
	C_LONGINT:C283($win)
	
	$win:=Open form window:C675("Order_Inc")
	
	var $fObject : Object
	$fObject:=New object:C1471
	$fObject.tableName:="Customer"
	
	// formData:=DIALOG("LBXDynamicDemo")
	//DIALOG("LBXDynamicDemo"; $fObject)
	
	
	$win:=Open form window:C675("Order_Inc")
	DIALOG:C40("Order_Inc")
	
	
	CLOSE WINDOW:C154($win)
	
	Process_ListActive
	
Else 
	var $name : Text
	var $processNum : Integer
	$processNum:=Process number:C372("Form_test")
	If ($processNum>0)
		BRING TO FRONT:C326($processNum)
	Else 
		$processNum:=New process:C317("Form_test"; 0; "Form_test"; "launch")
	End if 
End if 
