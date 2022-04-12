//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/28/06, 12:19:17
// ----------------------------------------------------
// Method: WOEventReschedule
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_DATE:C307($1)
C_TIME:C306($2)
If ((Old:C35([WorkOrder:66]dtAction:5)#0) & (Old:C35([WorkOrder:66]dtAction:5)#[WorkOrder:66]dtAction:5))
	$doChange:=False:C215
	$reWriteReSchedule:=False:C215
	$theReason:=Request:C163("Enter Reason for reschedule.")
	If (OK=1)
		CREATE RECORD:C68([WorkOrderEvent:121])
		
		[WorkOrderEvent:121]dateOrig:3:=$1
		[WorkOrderEvent:121]timeOrig:2:=$2
		[WorkOrderEvent:121]woNum:5:=[WorkOrder:66]woNum:29
		[WorkOrderEvent:121]action:4:=$theReason
		SAVE RECORD:C53([WorkOrderEvent:121])
		$doChange:=True:C214
		If (eWOEvents>0)
			QUERY:C277([WorkOrderEvent:121]; [WorkOrderEvent:121]woNum:5=[WorkOrder:66]woNum:29)
			WOEvents_FillArrays(Records in selection:C76([WorkOrderEvent:121]))
			UNLOAD RECORD:C212([WorkOrderEvent:121])
			//  --  CHOPPED  AL_UpdateArrays(eWOEvents; -2)
		End if 
	End if 
End if 