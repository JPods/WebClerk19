TRACE:C157
Ord2MfgOrd


If (False:C215)
	
	// allowAlerts_boo:=false // if you do not want to see any errors
	
	SELECTION TO ARRAY:C260([Order:3]; aLongInt31)
	vi2:=Size of array:C274(aLongInt31)
	For (vi1; 1; vi2)
		GOTO RECORD:C242([Order:3]; aLongInt31{vi1})
		
		// Alert("OrderNum: "+string([Order]OrderNum))
		
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
		OrdLnFillRays
		setCustFinance
		booAccept:=True:C214
		Ord2MfgOrd
	End for 
	UNLOAD RECORD:C212([Order:3])
	UNLOAD RECORD:C212([Customer:2])
	UNLOAD RECORD:C212([OrderLine:49])
	UNLOAD RECORD:C212([Contact:13])
	
End if 