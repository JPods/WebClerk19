C_LONGINT:C283(bprojectNum)
C_TEXT:C284($vScript)
// get the project
$vScript:="QUERY([Project];[Project]projectNum="+String:C10([WorkOrder:66]projectNum:80)+")"
ProcessTableOpen(Table:C252(->[Project:24]); $vScript; "Parent of WO: "+String:C10([WorkOrder:66]woNum:29))

If ([WorkOrder:66]flowDepends:89#"")
	ARRAY TEXT:C222($atFlowDepends; 0)
	TextToArray([WorkOrder:66]flowDepends:89; ->$atFlowDepends; ",")
	C_LONGINT:C283($i; $k)
	$k:=Size of array:C274($atFlowDepends)
	
	// Get the parent workorder. Try to shift from sequence # to WONums
	$vScript:=""
	For ($i; 1; $k)
		If ($i=1)
			$vScript:=$vScript+"QUERY([WorkOrder];[WorkOrder]Sequence="+$atFlowDepends{$i}+";*)"+<>vCR
		Else 
			$vScript:=$vScript+"QUERY([WorkOrder]; | ;[WorkOrder]Sequence="+$atFlowDepends{$i}+";*)"+<>vCR
		End if 
	End for 
	$vScript:=$vScript+"QUERY([WorkOrder]; & ;[WorkOrder]projectNum="+String:C10([WorkOrder:66]projectNum:80)+")"
	ProcessTableOpen(Table:C252(->[WorkOrder:66]); $vScript; "Parent of WO: "+String:C10([WorkOrder:66]woNum:29))
End if 

