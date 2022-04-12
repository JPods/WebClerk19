//%attributes = {"publishedWeb":true}
//Procedure: Invc_ShipInPeri
jBetweenDates("Invoices Shipped.")
If (OK=1)
	QUERY:C277([Invoice:26]; [Invoice:26]dateShipped:4>=vdDateBeg; *)
	QUERY:C277([Invoice:26];  & [Invoice:26]dateShipped:4<=vdDateEnd)
	ProcessTableOpen(->[Invoice:26])
End if 