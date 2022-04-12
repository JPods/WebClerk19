If (False:C215)
	//Date: 03/25/02
	//Who: Dan Bentson, Arkware
	//Description: Took out <>allowZip
	VERSION_960
End if 

C_TEXT:C284(srZip)
If ([Invoice:26]jrnlComplete:48=False:C215)
	If (bNewRec=0)
		//  UNLOAD RECORD([Customer])
		jSrchCustLoad(->[Customer:2]; ->[Customer:2]zip:8; ->srZip)
		LoadCustomersInvoices
		booWarn:=False:C215
		//  CHOPPED DivD_SetFieldColor(->[Customer]division)
		//  CHOPPED DivD_SetFieldColor(->srAcct)
	Else 
		[Customer:2]zip:8:=srZip
		Find Ship Zone(->[Customer:2]zip:8; ->[Customer:2]zone:57; ->[Customer:2]shipVia:12; ->[Customer:2]country:9; ->[Customer:2]siteID:106)
		[Invoice:26]zone:6:=[Customer:2]zone:57
		Copy_NewEntry(->[Customer:2]; ->[Customer:2]zip:8; ->[Invoice:26]zip:12)
		//
		Tt_FindByZip(->[Customer:2]zip:8; ->[Customer:2]salesNameID:59; ->[Customer:2]repID:58; ->[Invoice:26]salesNameID:23; ->[Invoice:26]repID:22)
		//If (<>allowZip)
		Zip_LoadCitySt(->[Customer:2]city:6; ->[Customer:2]state:7; ->[Customer:2]zip:8; ->[Customer:2]country:9)
		Copy_NewEntry(->[Customer:2]; ->[Customer:2]city:6; ->[Invoice:26]city:10)
		Copy_NewEntry(->[Customer:2]; ->[Customer:2]state:7; ->[Invoice:26]state:11)
		Copy_NewEntry(->[Customer:2]; ->[Customer:2]country:9; ->[Invoice:26]country:13)
		//End if 
	End if 
Else 
	jAlertMessage(10007)
	srCustomer:=[Customer:2]company:2
End if 