If (bNewRec=0)
	//  UNLOAD RECORD([Customer])
	jSrchCustLoad(->[Customer:2]; ->[Customer:2]customerID:1; ->srAcct)
	ProposalLoadCus
	OBJECT SET ENABLED:C1123(b21; True:C214)
	//  ShipAddrRay_Set 
	setCustFinance
	//  CHOPPED DivD_SetFieldColor(->[Customer]division)
	//  CHOPPED DivD_SetFieldColor(->srAcct)
Else 
	UniqueField(->[Customer:2]; ->srAcct; ->[Customer:2]customerID:1; ->[Proposal:42]customerID:1)
End if 