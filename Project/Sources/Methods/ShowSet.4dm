//%attributes = {}


// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 05/12/19, 11:50:45
// ----------------------------------------------------
// Method: Show_Set
// Description
// 
//
// Parameters
// ----------------------------------------------------


If ((aText4>0) & (aText4<=Size of array:C274(aText4)))
	$viSelected:=aText4
	
	$vtSetName:=aText5{$viSelected}
	$viTableNum:=aTmpLong1{$viSelected}
	$vtSetID:=aText4{$viSelected}
	
	// SetID is not a file
	If (($vtSetID="S_@") & ($vtSetID="@4ST"))
		
		Set_Action("file"; $vtSetName; $viTableNum; $vtSetID)
		
	Else   // open set from file
		
		Set_Action("show"; $vtSetName; $viTableNum; $vtSetID)
		
	End if 
	
Else 
	ALERT:C41("ERROR: No Set Selected")
End if 