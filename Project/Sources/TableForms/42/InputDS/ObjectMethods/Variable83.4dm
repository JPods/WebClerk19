If (bNewRec=0)
	//  UNLOAD RECORD([Customer])
	jSrchCustLoad(->[Customer:2]; ->[Customer:2]company:2; ->srCustomer)
	ProposalLoadCus
	OBJECT SET ENABLED:C1123(b21; True:C214)
	//  ShipAddrRay_Set 
	setCustFinance
	//  CHOPPED DivD_SetFieldColor(->[Customer]division)
	//  CHOPPED DivD_SetFieldColor(->srAcct)
Else 
	// zzzqqq jCapitalize1st(->srCustomer)
	[Customer:2]company:2:=srCustomer
	[Proposal:42]bill2Company:57:=[Customer:2]company:2
End if 