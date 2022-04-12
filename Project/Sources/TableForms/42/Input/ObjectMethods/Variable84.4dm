If (bNewRec=0)
	//  UNLOAD RECORD([Customer])
	jSrchCustLoad(->[Customer:2]; ->[Customer:2]phone:13; ->srPhone)
	ProposalLoadCus
	OBJECT SET ENABLED:C1123(b21; True:C214)
	//  ShipAddrRay_Set 
	setCustFinance
	//  Put  the formating in the form  jFormatPhone(->[Proposal]phone)
	//  CHOPPED DivD_SetFieldColor(->[Customer]division)
	//  CHOPPED DivD_SetFieldColor(->srAcct)
Else 
	[Customer:2]phone:13:=srPhone
	Copy_NewEntry(->[Customer:2]; ->[Customer:2]phone:13; ->[Proposal:42]phone:24)
	//  Put  the formating in the form  jFormatPhone(Self; ->[Proposal]phone; ->[Customer]phone)
End if 