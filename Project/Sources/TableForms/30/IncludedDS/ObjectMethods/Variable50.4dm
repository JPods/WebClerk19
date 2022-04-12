If ([Ledger:30]tableNum:3=26)
	QUERY:C277([Invoice:26]; [Invoice:26]invoiceNum:2=[Ledger:30]docRefid:4)
	curTableNum:=26
	ProcessTableOpen
Else 
	If (Abs:C99([Ledger:30]tableNum:3)=28)
		QUERY:C277([Payment:28]; [Payment:28]idNum:8=[Ledger:30]docRefid:4)
		curTableNum:=28
		ProcessTableOpen
	Else 
		ALERT:C41("Error: unknown Creating Doc Type.")
	End if 
End if 