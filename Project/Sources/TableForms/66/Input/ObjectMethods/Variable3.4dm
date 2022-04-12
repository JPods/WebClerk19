C_DATE:C307($startDate)
KeyModifierCurrent
If (OptKey=0)
	//  CHOPPED   MM_GetDate(ePopDate2; vdWoAction)
	$doChange:=True:C214
	[WorkOrder:66]actionDate:105:=vdWoAction
	[WorkOrder:66]dtAction:5:=DateTime_Enter([WorkOrder:66]actionDate:105; [WorkOrder:66]actionTime:111)
	WOEventReschedule([WorkOrder:66]actionDate:105; [WorkOrder:66]actionTime:111)
Else 
	//  CHOPPED   MM_GetDate(ePopDate2; iLoDate6)
	[WorkOrder:66]dtComplete:6:=DateTime_Enter(iLoDate6; iLoTime6)
End if 
REDRAW WINDOW:C456
WODurationCalc
