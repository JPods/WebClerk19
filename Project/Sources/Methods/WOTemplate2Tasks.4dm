//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/27/06, 05:50:45
// ----------------------------------------------------
// Method: WOTemplate2Tasks
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1)
C_TEXT:C284($2)
QUERY:C277([WOTemplate:69]; [WOTemplate:69]idNum:13=$2)
If (Records in selection:C76([WOTemplate:69])=1)
	[WorkOrder:66]description:3:=[WOTemplate:69]description:3
	[WorkOrder:66]durationPlanned:10:=[WOTemplate:69]duration:6
	[WorkOrder:66]itemNum:12:=[Item:4]itemNum:1
	[WorkOrder:66]ideTemplate:57:=[WOTemplate:69]idNum:13
	[WorkOrder:66]comment:17:=[WOTemplate:69]comment:4
	Parse_Str2Ray("\r"; ->[WOTemplate:69]opSteps:14; ->aText1)
	C_LONGINT:C283($cntWOSteps; $incWOSteps)
	$cntWOSteps:=Size of array:C274(aText1)
	If ($cntWOSteps>0)
		For ($incWOSteps; 1; $cntWOSteps)
			If (aText1{$incWOSteps}#"")
				CREATE RECORD:C68([WorkOrderTask:67])
				
				[WorkOrderTask:67]action:3:=aText1{$incWOSteps}
				[WorkOrderTask:67]woNum:10:=$1
				[WorkOrderTask:67]seq:2:=$incWOSteps
				SAVE RECORD:C53([WorkOrderTask:67])
			End if 
		End for 
		ARRAY TEXT:C222(aText1; 0)
	End if 
End if 