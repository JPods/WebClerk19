TRACE:C157
If (vHere=2)
	If (srWO>0)
		If (Modified record:C314([WorkOrder:66]))  //NO CANCEL
			myCycle:=6
			jAcceptButton
		End if 
		$recNum:=Record number:C243([WorkOrder:66])
		QUERY:C277([WorkOrder:66]; [WorkOrder:66]woNum:29=srWO)
		If (Records in selection:C76([WorkOrder:66])=1)
			booPreNext:=True:C214
		Else 
			GOTO RECORD:C242([WorkOrder:66]; $recNum)
		End if 
	End if 
	srWO:=[WorkOrder:66]woNum:29
Else 
	PUSH RECORD:C176([WorkOrder:66])
	QUERY:C277([WorkOrder:66]; [WorkOrder:66]woNum:29=srWO)
	If (Records in selection:C76([WorkOrder:66])>0)
		curTableNum:=Table:C252(->[WorkOrder:66])
		ProcessTableOpen
	End if 
	POP RECORD:C177([WorkOrder:66])
End if 