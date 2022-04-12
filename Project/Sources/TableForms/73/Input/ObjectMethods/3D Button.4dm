Case of 
	: ([TallyResult:73]tableNum:3=0)
		ALERT:C41("No TableNum defined.")
	: ([TallyResult:73]tableNum:3=2)
		If ([TallyResult:73]custVendid:30#"")
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[TallyResult:73]custVendid:30)
			If (Records in selection:C76([Customer:2])>0)
				ProcessTableOpen([TallyResult:73]tableNum:3; ""; " vCard Issue ")
			End if 
		End if 
	: ([TallyResult:73]tableNum:3=4)
		If ([TallyResult:73]itemNum:34#"")
			QUERY:C277([Item:4]; [Item:4]itemNum:1=[TallyResult:73]itemNum:34)
			If (Records in selection:C76([Item:4])>0)
				ProcessTableOpen([TallyResult:73]tableNum:3; ""; "")
			End if 
		End if 
End case 
