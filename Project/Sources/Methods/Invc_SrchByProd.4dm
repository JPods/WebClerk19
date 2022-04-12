//%attributes = {"publishedWeb":true}
vPartNum:=Request:C163("Enter Item Number.")
If (OK=1)
	QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]itemNum:4=vPartNum+"@")
	RELATE ONE SELECTION:C349([InvoiceLine:54]; [Invoice:26])
	ProcessTableOpen(->[Invoice:26])
End if 