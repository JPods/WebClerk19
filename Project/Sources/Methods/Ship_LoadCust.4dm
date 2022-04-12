//%attributes = {"publishedWeb":true}
//Procedure: Ship_LoadCust
If (False:C215)
	//Date: 02/23/02
	//Who: Peter Fleming, Arkware
	//Description: Added new UPS fields
	VERSION_960
End if 
C_POINTER:C301($1)
Case of 
	: ($1=(->[PO:39]))
		[PO:39]shipToCompany:8:=[Customer:2]company:2
		[PO:39]address1:9:=[Customer:2]address1:4
		[PO:39]address2:10:=[Customer:2]address2:5
		[PO:39]city:11:=[Customer:2]city:6
		[PO:39]state:12:=[Customer:2]state:7
		[PO:39]zip:13:=[Customer:2]zip:8
		[PO:39]country:14:=[Customer:2]country:9
		[PO:39]attention:26:=[Customer:2]nameFirst:73+(" "*Num:C11([Customer:2]nameFirst:73#""))+[Customer:2]nameLast:23
		[PO:39]phone:15:=[Customer:2]phone:13
		[PO:39]fax:16:=[Customer:2]fax:66
		[PO:39]fob:32:=""
		//[PO]Email:=[Customer]Email//###_jwm_### 20101021
		
		If (<>vConfirmShipChange=0)
			[PO:39]shipVia:33:=[Customer:2]shipVia:12
		Else 
			CONFIRM:C162("Use Contact ShipVia: "+[Contact:13]shipVia:26)
			If (OK=1)
				[PO:39]shipVia:33:=[Customer:2]shipVia:12
			Else 
				Find Ship Zone(->[PO:39]zip:13; ->[PO:39]zone:28; ->[PO:39]shipVia:33; ->[PO:39]country:14; ->[PO:39]siteID:74)
			End if 
		End if 
		[PO:39]shipInstruct:31:=[Customer:2]shipInstruct:24
		//  Put  the formating in the form  jFormatPhone(->[PO]phone; ->[PO]fax)
	: ($1=(->[Order:3]))
		[Order:3]company:15:=[Customer:2]company:2
		[Order:3]address1:16:=[Customer:2]address1:4
		[Order:3]address2:17:=[Customer:2]address2:5
		[Order:3]city:18:=[Customer:2]city:6
		[Order:3]state:19:=[Customer:2]state:7
		[Order:3]zip:20:=[Customer:2]zip:8
		[Order:3]country:21:=[Customer:2]country:9
		[Order:3]attention:44:=[Customer:2]nameFirst:73+(" "*Num:C11([Customer:2]nameFirst:73#""))+[Customer:2]nameLast:23
		//[Order]Phone:=[Customer]Phone//###_jwm_### 20101111
		//[Order]FAX:=[Customer]FAX//###_jwm_### 20101111
		//[Order]Email:=[Customer]Email//###_jwm_### 20101021
		
		//###_jwm_### Do Not Override Freight Billing
		CONFIRM:C162("Change Freight Billing Option:"+"\r"+"\r"+"From: "+[Order:3]upsBillingOption:89+" "+[Order:3]upsReceiverAcct:90+"\r"+"\r"+"To:     "+[Customer:2]upsBillingOption:96+" "+[Customer:2]upsReceiverAcct:97; "Yes"; "No")
		
		If (ok=1)
			CONFIRM:C162("Confirm Change of Freight Billing Option:"+"\r"+"\r"+"From: "+[Order:3]upsBillingOption:89+" "+[Order:3]upsReceiverAcct:90+"\r"+"\r"+"To:     "+[Customer:2]upsBillingOption:96+" "+[Customer:2]upsReceiverAcct:97; "Confirm"; "Cancel")
			If (ok=1)
				[Order:3]upsResidential:88:=[Customer:2]upsResidential:95
				[Order:3]upsBillingOption:89:=[Customer:2]upsBillingOption:96
				[Order:3]upsReceiverAcct:90:=[Customer:2]upsReceiverAcct:97
			End if 
			
		End if 
		
		
		If (<>vConfirmShipChange=0)
			[Order:3]shipVia:13:=[Customer:2]shipVia:12
			[Order:3]zone:14:=[Customer:2]zone:57
		Else 
			CONFIRM:C162("Use Contact ShipVia: "+[Customer:2]shipVia:12)
			If (OK=1)
				[Order:3]shipVia:13:=[Customer:2]shipVia:12
				[Order:3]zone:14:=[Customer:2]zone:57
			Else 
				Find Ship Zone(->[Order:3]zip:20; ->[Order:3]zone:14; ->[Order:3]shipVia:13; ->[Order:3]country:21; ->[Order:3]siteID:106)
			End if 
		End if 
		UNLOAD RECORD:C212([Customer:2])
	: ($1=(->[Proposal:42]))
		//  Proposal_FillAddress("Customer")
		[Proposal:42]attention:37:=[Customer:2]nameFirst:73+(" "*Num:C11([Customer:2]nameFirst:73#""))+[Customer:2]nameLast:23
		//[Proposal]Email:=[Customer]Email//###_jwm_### 20101021
		//[Proposal]Phone:=[Customer]Phone//###_jwm_### 20101111
		//[Proposal]FAX:=[Customer]FAX//###_jwm_### 20101111
		
		//[Proposal]UPSResidential:=[Customer]UPSResidential
		//[Proposal]UPSBillingOption:=[Customer]UPSBillingOption
		//[Proposal]UPSReceiverAcct:=[Customer]UPSReceiverAcct
		If (<>vConfirmShipChange=0)
			[Proposal:42]shipVia:18:=[Customer:2]shipVia:12
			[Proposal:42]zone:19:=[Customer:2]zone:57
		Else 
			CONFIRM:C162("Use Contact ShipVia: "+[Customer:2]shipVia:12)
			If (OK=1)
				[Proposal:42]shipVia:18:=[Customer:2]shipVia:12
				[Proposal:42]zone:19:=[Customer:2]zone:57
			Else 
				Find Ship Zone(->[Proposal:42]zip:16; ->[Proposal:42]zone:19; ->[Proposal:42]shipVia:18; ->[Proposal:42]country:17; ->[Proposal:42]siteID:77)
			End if 
		End if 
		UNLOAD RECORD:C212([Customer:2])
	: ($1=(->[Invoice:26]))
		[Invoice:26]company:7:=[Customer:2]company:2
		[Invoice:26]address1:8:=[Customer:2]address1:4
		[Invoice:26]address2:9:=[Customer:2]address2:5
		[Invoice:26]city:10:=[Customer:2]city:6
		[Invoice:26]state:11:=[Customer:2]state:7
		[Invoice:26]zip:12:=[Customer:2]zip:8
		[Invoice:26]country:13:=[Customer:2]country:9
		[Invoice:26]attention:38:=[Customer:2]nameFirst:73+(" "*Num:C11([Customer:2]nameFirst:73#""))+[Customer:2]nameLast:23
		//[Invoice]Email:=[Customer]Email//###_jwm_### 20101021
		//[Invoice]Phone:=[Customer]Phone//###_jwm_### 20101111
		//[Invoice]FAX:=[Customer]FAX//###_jwm_### 20101111
		
		If (<>vConfirmShipChange=0)
			[Invoice:26]shipVia:5:=[Customer:2]shipVia:12
			[Invoice:26]zone:6:=[Customer:2]zone:57
		Else 
			CONFIRM:C162("Use Contact ShipVia: "+[Contact:13]shipVia:26)
			If (OK=1)
				[Invoice:26]shipVia:5:=[Customer:2]shipVia:12
				[Invoice:26]zone:6:=[Customer:2]zone:57
			Else 
				Find Ship Zone(->[Invoice:26]zip:12; ->[Invoice:26]zone:6; ->[Invoice:26]shipVia:5; ->[Invoice:26]country:13; ->[Invoice:26]siteID:86)
			End if 
		End if 
		//02/23/02.prf Added 3 fields for UPS export 
		[Invoice:26]upsResidential:80:=[Customer:2]upsResidential:95
		[Invoice:26]upsBillingOption:81:=[Customer:2]upsBillingOption:96
		[Invoice:26]upsReceiverAcct:82:=[Customer:2]upsReceiverAcct:97
		UNLOAD RECORD:C212([Customer:2])
End case 