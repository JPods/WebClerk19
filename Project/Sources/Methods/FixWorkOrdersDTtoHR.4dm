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
	jDateTimeRecov([WorkOrder:66]DTBeginPlanned:107; ->[WorkOrder:66]DateBegin:106; ->[WorkOrder:66]TimeBegin:109)
	jDateTimeRecov([WorkOrder:66]DTEndPlanned:69; ->[WorkOrder:66]DateEnd:108; ->[WorkOrder:66]TimeEnd:110)
	
	SAVE RECORD:C53([WorkOrder:66])
	NEXT RECORD:C51([WorkOrder:66])
End for 
UNLOAD RECORD:C212([WorkOrder:66])