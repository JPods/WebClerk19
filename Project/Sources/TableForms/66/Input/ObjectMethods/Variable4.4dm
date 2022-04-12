C_DATE:C307($startDate)
C_TIME:C306(v1Time)
KeyModifierCurrent
If (OptKey=0)
	//  CHOPPED  TM_GetTime(ePopTime; "vtWoAction")
	[WorkOrder:66]actionTime:111:=vtWoAction
	$doChange:=True:C214
	If ((Old:C35([WorkOrder:66]dtAction:5)#0) & (Old:C35([WorkOrder:66]dtAction:5)#[WorkOrder:66]dtAction:5))
		$doChange:=False:C215
		$theReason:=Request:C163("Enter Reason for reschedule.")
		If (OK=1)
			CREATE RECORD:C68([WorkOrderEvent:121])
			[WorkOrderEvent:121]timeOrig:2:=vtWoAction
			[WorkOrderEvent:121]woNum:5:=[WorkOrder:66]woNum:29
			[WorkOrderEvent:121]action:4:=$theReason
			SAVE RECORD:C53([WorkOrderEvent:121])
			$doChange:=True:C214
			QUERY:C277([WorkOrderEvent:121]; [WorkOrderEvent:121]woNum:5=[WorkOrder:66]woNum:29)
			WOEvents_FillArrays(Records in selection:C76([WorkOrderEvent:121]))
			//  --  CHOPPED  AL_UpdateArrays(eWOEvents; -2)
		End if 
	End if 
	If ($doChange)
		[WorkOrder:66]dtAction:5:=DateTime_Enter(vdWOAction; vtWoAction)
	End if 
Else 
	//  CHOPPED  TM_GetTime(ePopTime; "iLoDate6")
	[WorkOrder:66]dtComplete:6:=DateTime_Enter(iLoDate6; iLoTime6)
End if 
REDRAW WINDOW:C456

WODurationCalc