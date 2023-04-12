$rayCnt:=Size of array:C274(aWoStepLns)
If ($rayCnt>0)
	C_LONGINT:C283($index; $rayCnt)
	KeyModifierCurrent
	READ WRITE:C146([WorkOrder:66])
	For ($index; 1; $rayCnt)
		Case of 
			: (optKey=1)
				CONFIRM:C162("Mark these open.")
				If (ok=1)
					aWoTimeCmp{aWoStepLns{$index}}:=0
					aWoDateCmp{aWoStepLns{$index}}:=!00-00-00!
					GOTO RECORD:C242([WorkOrder:66]; aWoRecNum{aWoStepLns{$index}})
					[WorkOrder:66]dtComplete:6:=0
					SAVE RECORD:C53([WorkOrder:66])
					UNLOAD RECORD:C212([WorkOrder:66])
				End if 
			: (cmdKey=1)
				CONFIRM:C162("Update close date.")
				If (ok=1)
					aWoTimeCmp{aWoStepLns{$index}}:=Current time:C178*1
					aWoDateCmp{aWoStepLns{$index}}:=Current date:C33
					GOTO RECORD:C242([WorkOrder:66]; aWoRecNum{aWoStepLns{$index}})
					[WorkOrder:66]dtComplete:6:=DateTime_DTTo(Current date:C33; Current time:C178)
					SAVE RECORD:C53([WorkOrder:66])
					UNLOAD RECORD:C212([WorkOrder:66])
				End if 
			: (aWoDateCmp{aWoStepLns{$index}}#!00-00-00!)
			Else 
				CONFIRM:C162("Mark these closed.")
				If (ok=1)
					GOTO RECORD:C242([WorkOrder:66]; aWoRecNum{aWoStepLns{$index}})
					[WorkOrder:66]dtComplete:6:=DateTime_DTTo(Current date:C33; Current time:C178)
					aWoTimeCmp{aWoStepLns{$index}}:=Current time:C178*1
					aWoDateCmp{aWoStepLns{$index}}:=Current date:C33
					SAVE RECORD:C53([WorkOrder:66])
					UNLOAD RECORD:C212([WorkOrder:66])
				End if 
		End case 
	End for 
	vMod:=True:C214
	//  --  CHOPPED  AL_UpdateArrays(eOrdWos; -2)
	READ ONLY:C145([WorkOrder:66])
End if 