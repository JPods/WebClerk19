Case of 
	: ([DCash:62]tableReceive:8=28)
		QUERY:C277([Payment:28]; [Payment:28]idNum:8=[DCash:62]docReceive:4)
		If (Records in selection:C76([Payment:28])>0)
			curTableNum:=[DCash:62]tableReceive:8
			ProcessTableOpen(-curTableNum)
		End if 
	: ([DCash:62]tableReceive:8=26)
		QUERY:C277([Invoice:26]; [Invoice:26]invoiceNum:2=[DCash:62]docReceive:4)
		If (Records in selection:C76([Invoice:26])>0)
			curTableNum:=[DCash:62]tableReceive:8
			ProcessTableOpen(-curTableNum)
		End if 
	Else 
		ALERT:C41("No Table Identified.")
End case 



