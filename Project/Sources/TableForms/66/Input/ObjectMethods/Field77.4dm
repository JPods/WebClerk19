[WorkOrder:66]dtBeginPlanned:107:=DateTime_Enter([WorkOrder:66]dateBegin:106; [WorkOrder:66]timeBegin:109)
If ([WorkOrder:66]dateEnd:108<[WorkOrder:66]dateBegin:106)
	[WorkOrder:66]dateEnd:108:=[WorkOrder:66]dateBegin:106
	[WorkOrder:66]dtEndPlanned:69:=DateTime_Enter([WorkOrder:66]dateEnd:108; [WorkOrder:66]timeEnd:110)
End if 
[WorkOrder:66]durationPlanned:10:=[WorkOrder:66]dateEnd:108-[WorkOrder:66]dateBegin:106