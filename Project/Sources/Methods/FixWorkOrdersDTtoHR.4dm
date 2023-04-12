//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 04/28/19, 09:55:22
// ----------------------------------------------------
// Method: FixWorkOrdersDTtoHR
// Description
//   Adjust to human readable fields
//
// Parameters
// ----------------------------------------------------


ALL RECORDS:C47([WorkOrder:66])
$k:=Records in selection:C76([WorkOrder:66])
FIRST RECORD:C50([WorkOrder:66])
C_LONGINT:C283($i; $k)

For ($i; 1; $k)
	DateTime_DTFrom([WorkOrder:66]dtBeginPlanned:107; ->[WorkOrder:66]dateBegin:106; ->[WorkOrder:66]timeBegin:109)
	DateTime_DTFrom([WorkOrder:66]dtEndPlanned:69; ->[WorkOrder:66]dateEnd:108; ->[WorkOrder:66]timeEnd:110)
	
	SAVE RECORD:C53([WorkOrder:66])
	NEXT RECORD:C51([WorkOrder:66])
End for 
UNLOAD RECORD:C212([WorkOrder:66])