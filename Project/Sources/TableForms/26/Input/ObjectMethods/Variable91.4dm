C_TEXT:C284(srAcct)
If ([Invoice:26]jrnlComplete:48=False:C215)
	If (bNewRec=0)
		//  UNLOAD RECORD([Customer])
		jSrchCustLoad(->[Customer:2]; ->[Customer:2]customerID:1; ->srAcct)
		LoadCustomersInvoices
		booWarn:=False:C215
	Else 
		UniqueField(->[Customer:2]; ->srAcct; ->[Customer:2]customerID:1; ->[Order:3]customerID:1)
	End if 
	//  CHOPPED DivD_SetFieldColor(->[Customer]division)
	//  CHOPPED DivD_SetFieldColor(->srAcct)
Else 
	jAlertMessage(10007)
	srCustomer:=[Customer:2]company:2
End if 