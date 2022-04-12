KeyModifierCurrent
Case of 
	: (optKey=1)
		CONFIRM:C162("Mark these open.")
		If (ok=1)
			[WorkOrder:66]dtComplete:6:=0
			vdWOAction:=!00-00-00!
			vtWoAction:=?00:00:00?
			SAVE RECORD:C53([WorkOrder:66])
		End if 
	: (cmdKey=1)
		CONFIRM:C162("Update close date.")
		If (ok=1)
			vdWOAction:=Current date:C33
			vtWoAction:=Current time:C178
			[WorkOrder:66]dtComplete:6:=DateTime_Enter(Current date:C33; Current time:C178)
			SAVE RECORD:C53([WorkOrder:66])
		End if 
	Else 
		CONFIRM:C162("Mark these closed.")
		If (ok=1)
			vdWOAction:=Current date:C33
			vtWoAction:=Current time:C178
			[WorkOrder:66]dtComplete:6:=DateTime_Enter(Current date:C33; Current time:C178)
			SAVE RECORD:C53([WorkOrder:66])
			UNLOAD RECORD:C212([WorkOrder:66])
		End if 
End case 
vMod:=True:C214