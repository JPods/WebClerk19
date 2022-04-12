If (pShipOrdSt="WOLink@")
	QUERY:C277([WorkOrder:66]; [WorkOrder:66]woNum:29=pLocation)
	If (Records in selection:C76([WorkOrder:66])=1)
		DB_ShowCurrentSelection(->[WorkOrder:66]; ""; 1; "")
	Else 
		BEEP:C151
	End if 
Else 
	BEEP:C151
End if 