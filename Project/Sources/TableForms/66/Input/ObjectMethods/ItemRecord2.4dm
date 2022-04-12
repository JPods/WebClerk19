If (([WorkOrder:66]ItemNum:12#"") & (vHere<4))
	C_TEXT:C284($script)
	$script:="QUERY([Item];[Item]itemnum="+[WorkOrder:66]ItemNum:12+")"
	
	ReadOnlyReloadRecord(->[Item:4])
	//ReadOnlyReloadRecord (->[WorkOrderTask])
	ProcessTableOpen(Table:C252(->[Item:4]); $script; "WO: "+String:C10([WorkOrder:66]woNum:29))
Else 
	BEEP:C151
	BEEP:C151
End if 