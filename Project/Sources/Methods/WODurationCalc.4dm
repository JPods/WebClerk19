//%attributes = {}
If (False:C215)
	Version_0602
	WODurationCalc
End if 

C_TIME:C306($timeMod)
If (([WorkOrder:66]DTCompleted:6#0) & ([WorkOrder:66]DTCompleted:6>[WorkOrder:66]DTAction:5))
	$seconds:=[WorkOrder:66]DTCompleted:6-[WorkOrder:66]DTAction:5
	C_REAL:C285($dayDuration; $hourDuration; $minuteDuration; $secDuration)
	$dayDuration:=vdWOAction-vdWoPlan
	$hourDuration:=$seconds/3600
	$minuteDuration:=$seconds/60
	[WorkOrder:66]DurationActual:11:=Round:C94($hourDuration; 1)
	//Time(String($hourDuration)+":"+String($minuteDuration)+":00")
	//[WorkOrder]DurationActual:=Time(Time string($timeMod))//+($dayDuration*24)
Else 
	[WorkOrder:66]DurationActual:11:=0
End if 