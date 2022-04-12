Parse_Str2Ray(<>vCR; ->[WorkOrder:66]description:3; ->aText1)
C_LONGINT:C283($cntWOSteps; $incWOSteps)
$cntWOSteps:=Size of array:C274(aText1)
If ($cntWOSteps>0)
	For ($incWOSteps; 1; $cntWOSteps)
		If (aText1{$incWOSteps}#"")
			CREATE RECORD:C68([WorkOrderTask:67])
			
			[WorkOrderTask:67]action:3:=aText1{$incWOSteps}
			[WorkOrderTask:67]woNum:10:=[WorkOrder:66]woNum:29
			[WorkOrder:66]seq:26:=$incWOSteps
			SAVE RECORD:C53([WorkOrderTask:67])
		End if 
	End for 
	ARRAY TEXT:C222(aText1; 0)
	QUERY:C277([WorkOrderTask:67]; [WorkOrderTask:67]woNum:10=[WorkOrder:66]woNum:29)
	WoTasksFillArrays(Records in selection:C76([WorkOrderTask:67]))
	//  --  CHOPPED  AL_UpdateArrays(eWOTasks; -2)
End if 