//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/22/20, 00:56:39
// ----------------------------------------------------
// Method: GanttDateDTsImport
// Description
// 
//
// Parameters
// ----------------------------------------------------
CONFIRM:C162("Recalculate End Date")
If (OK=1)
	C_LONGINT:C283($i; $k)
	$k:=Records in selection:C76([WorkOrder:66])
	FIRST RECORD:C50([WorkOrder:66])
	For ($i; 1; $k)
		[WorkOrder:66]dateEnd:108:=[WorkOrder:66]dateBegin:106+[WorkOrder:66]durationPlanned:10
		[WorkOrder:66]dtBeginPlanned:107:=DateTime_DTTo([WorkOrder:66]dateBegin:106; [WorkOrder:66]timeBegin:109)
		[WorkOrder:66]dtEndPlanned:69:=DateTime_DTTo([WorkOrder:66]dateEnd:108; [WorkOrder:66]timeEnd:110)
		SAVE RECORD:C53([WorkOrder:66])
		NEXT RECORD:C51([WorkOrder:66])
	End for 
	UNLOAD RECORD:C212([WorkOrder:66])
End if 