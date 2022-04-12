If ([Invoice:26]jrnlComplete:48=False:C215)
	If (bNewRec=0)
		//  UNLOAD RECORD([Customer])
		jSrchCustLoad(->[Customer:2]; ->[Customer:2]phone:13; ->srPhone)
		LoadCustomersInvoices
		booWarn:=False:C215
		//  CHOPPED DivD_SetFieldColor(->[Customer]division)
		//  CHOPPED DivD_SetFieldColor(->srAcct)
	Else 
		[Customer:2]phone:13:=srPhone
		[Invoice:26]phone:54:=srPhone
		//  Put  the formating in the form  jFormatPhone(->[Customer]phone; ->srPhone; ->[Invoice]phone)
	End if 
Else 
	jAlertMessage(10007)
	srCustomer:=[Customer:2]company:2
End if 