C_TEXT:C284(srCustomer)
If ([Invoice:26]jrnlComplete:48=False:C215)
	If (bNewRec=0)
		//  UNLOAD RECORD([Customer])
		jSrchCustLoad(->[Customer:2]; ->[Customer:2]company:2; ->srCustomer)
		LoadCustomersInvoices
		booWarn:=False:C215
		//  should we care -- //  CHOPPED DivD_SetFieldColor(->[Customer]division)
		//  should we care -- //  CHOPPED DivD_SetFieldColor(->srAcct)
	Else 
		// zzzqqq jCapitalize1st(->srCustomer)
		[Customer:2]company:2:=srCustomer
		[Invoice:26]company:7:=srCustomer
		[Invoice:26]bill2Company:69:=[Customer:2]company:2
	End if 
Else 
	jAlertMessage(10007)
	srCustomer:=[Customer:2]company:2
End if 