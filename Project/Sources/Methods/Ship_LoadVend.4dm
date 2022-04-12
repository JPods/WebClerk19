//%attributes = {"publishedWeb":true}
//Procedure: Ship_LoadVend
Case of 
	: (Table:C252($1)=Table:C252(->[PO:39]))
		[PO:39]shipToCompany:8:=[Vendor:38]company:2
		[PO:39]address1:9:=[Vendor:38]address1:4
		[PO:39]address2:10:=[Vendor:38]address2:5
		[PO:39]city:11:=[Vendor:38]city:6
		[PO:39]state:12:=[Vendor:38]state:7
		[PO:39]zip:13:=[Vendor:38]zip:8
		[PO:39]country:14:=[Vendor:38]country:9
		[PO:39]attention:26:=[Vendor:38]attention:55
		[PO:39]phone:15:=[Vendor:38]phone:10
		[PO:39]fax:16:=[Vendor:38]fax:13
		[PO:39]fob:32:=""
		
		If (<>vConfirmShipChange=0)
			[PO:39]shipVia:33:=[Vendor:38]shipVia:63
		Else 
			CONFIRM:C162("Use Contact ShipVia: "+[Contact:13]shipVia:26)
			If (OK=1)
				[PO:39]shipVia:33:=[Vendor:38]shipVia:63
			Else 
				Find Ship Zone(->[PO:39]zip:13; ->[PO:39]zone:28; ->[PO:39]shipVia:33; ->[PO:39]country:14; ->[PO:39]siteID:74)
			End if 
		End if 
		[PO:39]shipInstruct:31:=[Vendor:38]shipInstruct:64
		//  Put  the formating in the form  jFormatPhone(->[PO]phone; ->[PO]fax)
	: (Table:C252($1)=Table:C252(->[Order:3]))
		[Order:3]company:15:=[Vendor:38]company:2
		[Order:3]address1:16:=[Vendor:38]address1:4
		[Order:3]address2:17:=[Vendor:38]address2:5
		[Order:3]city:18:=[Vendor:38]city:6
		[Order:3]state:19:=[Vendor:38]state:7
		[Order:3]zip:20:=[Vendor:38]zip:8
		[Order:3]country:21:=[Vendor:38]country:9
		[Order:3]attention:44:=[Vendor:38]attention:55
		
		If (<>vConfirmShipChange=0)
			[Order:3]shipVia:13:=[Vendor:38]shipVia:63
			[Order:3]zone:14:=[Vendor:38]zone:65
		Else 
			CONFIRM:C162("Use Contact ShipVia: "+[Customer:2]shipVia:12)
			If (OK=1)
				[Order:3]shipVia:13:=[Vendor:38]shipVia:63
				[Order:3]zone:14:=[Vendor:38]zone:65
			Else 
				Find Ship Zone(->[Order:3]zip:20; ->[Order:3]zone:14; ->[Order:3]shipVia:13; ->[Order:3]country:21; ->[Order:3]siteID:106)
			End if 
		End if 
		UNLOAD RECORD:C212([Vendor:38])
	: (Table:C252($1)=Table:C252(->[Proposal:42]))
		//Proposal_FillAddress("Vendor")
		If (<>vConfirmShipChange=0)
			[Proposal:42]shipVia:18:=[Vendor:38]shipVia:63
			[Proposal:42]zone:19:=[Vendor:38]zone:65
		Else 
			CONFIRM:C162("Use Contact ShipVia: "+[Customer:2]shipVia:12)
			If (OK=1)
				[Proposal:42]shipVia:18:=[Vendor:38]shipVia:63
				[Proposal:42]zone:19:=[Vendor:38]zone:65
			Else 
				Find Ship Zone(->[Proposal:42]zip:16; ->[Proposal:42]zone:19; ->[Proposal:42]shipVia:18; ->[Proposal:42]country:17; ->[Proposal:42]siteID:77)
			End if 
		End if 
		UNLOAD RECORD:C212([Vendor:38])
	: (Table:C252($1)=Table:C252(->[Invoice:26]))
		[Invoice:26]company:7:=[Vendor:38]company:2
		[Invoice:26]address1:8:=[Vendor:38]address1:4
		[Invoice:26]address2:9:=[Vendor:38]address2:5
		[Invoice:26]city:10:=[Vendor:38]city:6
		[Invoice:26]state:11:=[Vendor:38]state:7
		[Invoice:26]zip:12:=[Vendor:38]zip:8
		[Invoice:26]country:13:=[Vendor:38]country:9
		[Invoice:26]attention:38:=[Vendor:38]attention:55
		If (<>vConfirmShipChange=0)
			[Invoice:26]shipVia:5:=[Vendor:38]shipVia:63
			[Invoice:26]zone:6:=[Vendor:38]zone:65
		Else 
			CONFIRM:C162("Use Contact ShipVia: "+[Contact:13]shipVia:26)
			If (OK=1)
				[Invoice:26]shipVia:5:=[Vendor:38]shipVia:63
				[Invoice:26]zone:6:=[Vendor:38]zone:65
			Else 
				Find Ship Zone(->[Invoice:26]zip:12; ->[Invoice:26]zone:6; ->[Invoice:26]shipVia:5; ->[Invoice:26]country:13; ->[Invoice:26]siteID:86)
			End if 
		End if 
		UNLOAD RECORD:C212([Vendor:38])
End case 