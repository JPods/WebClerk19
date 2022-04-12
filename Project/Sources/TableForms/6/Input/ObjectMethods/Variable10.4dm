Case of 
	: (([Service:6]docType:31="TM_@") | ([Service:6]docReference:32="TM_@"))
		KeyModifierCurrent
		If (OptKey=0)
			QUERY:C277([TallyMaster:60]; [TallyMaster:60]name:8=[Service:6]docReference:32)
		Else 
			QUERY:C277([TallyMaster:60]; [TallyMaster:60]tableNum:1=Table:C252(->[Service:6]))
		End if 
		ProcessTableOpen(Table:C252(->[TallyMaster:60])*-1)
	Else 
		AE_LaunchDoc([Service:6]docReference:32)
End case 