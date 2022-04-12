//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-01T06:00:00Z)
// Method: LBX_Order_Inc_LB
// Description 
// Parameters
// ----------------------------------------------------


If (Count parameters:C259>0)
	C_LONGINT:C283($win)
	
	var $fObject : Object
	$fObject:=New object:C1471
	$fObject.tableName:="Order"
	
	$win:=Open form window:C675("Order_Inc")
	DIALOG:C40("Order_Inc"; $fObject)
	
	CLOSE WINDOW:C154($win)
	
	Prs_ListActive
	
Else 
	var $name : Text
	var $processNum : Integer
	$processNum:=Process number:C372("LBX_Order_Inc_LB")
	If ($processNum>0)
		BRING TO FRONT:C326($processNum)
	Else 
		$processNum:=New process:C317("LBX_Order_Inc_LB"; 0; "LBX_Order_Inc_LB"; "launch")
	End if 
End if 