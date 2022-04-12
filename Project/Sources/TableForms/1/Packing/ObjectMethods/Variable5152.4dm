$k:=Size of array:C274(aInvoiceRecSel)
If ($k>0)
	GOTO RECORD:C242([Invoice:26]; aInvRecs{aInvoiceRecSel{1}})
	DB_ShowCurrentSelection(->[Invoice:26]; ""; 1; "Packing")
	DELAY PROCESS:C323(Current process:C322; 120)
Else 
	ALERT:C41("Select an Invoice.")
End if 