doQuickQuote:=1
QUERY:C277([Service:6])
If (OK=1)
	CLEAR SET:C117("Pareto")
	CREATE SET:C116([Service:6]; "Pareto")
	Case of 
		: (b1=1)
			viRecordsInTable:=Size of array:C274(<>aProcesses)
		: (b2=1)
			viRecordsInTable:=Size of array:C274(aAttributes)
		: (b3=1)
			viRecordsInTable:=Size of array:C274(aCauses)
	End case 
	viRecordsInSelection:=Records in selection:C76([Service:6])
End if 
doQuickQuote:=0