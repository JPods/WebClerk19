If (False:C215)
	//Date: 03/25/02
	//Who: Dan Bentson, Arkware
	//Description: Took out <>allowZip
	VERSION_960
End if 

If (bNewRec=0)
	//  UNLOAD RECORD([Customer])
	jSrchCustLoad(->[Customer:2]; ->[Customer:2]zip:8; ->srZip)
	ProposalLoadCus
	OBJECT SET ENABLED:C1123(b21; True:C214)
	//  ShipAddrRay_Set 
	setCustFinance
	//  CHOPPED DivD_SetFieldColor(->[Customer]division)
	//  CHOPPED DivD_SetFieldColor(->srAcct)
Else 
	[Customer:2]zip:8:=srZip
	Find Ship Zone(->[Customer:2]zip:8; ->[Customer:2]zone:57; ->[Customer:2]shipVia:12; ->[Customer:2]country:9; ->[Customer:2]siteID:106)
	[Proposal:42]zone:19:=[Customer:2]zone:57
	Copy_NewEntry(->[Customer:2]; ->[Customer:2]zip:8; ->[Proposal:42]zip:16)
	//  
	Tt_FindByZip(->[Customer:2]zip:8; ->[Customer:2]salesNameID:59; ->[Customer:2]repID:58; ->[Proposal:42]salesNameID:9; ->[Proposal:42]repID:7)
	
	//If (<>allowZip)
	Zip_LoadCitySt(->[Customer:2]city:6; ->[Customer:2]state:7; ->[Customer:2]zip:8; ->[Customer:2]country:9)
	Copy_NewEntry(->[Customer:2]; ->[Customer:2]city:6; ->[Proposal:42]city:14)
	Copy_NewEntry(->[Customer:2]; ->[Customer:2]state:7; ->[Proposal:42]state:15)
	Copy_NewEntry(->[Customer:2]; ->[Customer:2]country:9; ->[Proposal:42]country:17)
	//End if 
End if 