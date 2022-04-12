//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 11/11/10, 10:36:02
// ----------------------------------------------------
// Method: Ship_LoadContac
// Description
// 11/11/10 added contacts email to inforamtion transfered
//
// Parameters
// ----------------------------------------------------

//Procedure: Ship_LoadContac
If (False:C215)
	//Date: 02/23/02
	//Who: Peter Fleming, Arkware
	//Description: Added new UPS fields
	VERSION_960
End if 
Case of 
	: (Table:C252($1)=Table:C252(->[PO:39]))
		[PO:39]shipToCompany:8:=[Contact:13]company:23
		[PO:39]address1:9:=[Contact:13]address1:6
		[PO:39]address2:10:=[Contact:13]address2:7
		[PO:39]city:11:=[Contact:13]city:8
		[PO:39]state:12:=[Contact:13]state:9
		[PO:39]zip:13:=[Contact:13]zip:11
		[PO:39]country:14:=[Contact:13]country:12
		[PO:39]attention:26:=[Contact:13]nameFirst:2+(" "*Num:C11([Contact:13]nameFirst:2#""))+[Contact:13]nameLast:4
		[PO:39]phone:15:=[Contact:13]phone:30
		//[PO]Email:=[Contact]Email//###_jwm_### 20101111
		[PO:39]fax:16:=[Contact:13]fax:31
		[PO:39]fob:32:=""
		If (<>vConfirmShipChange=0)
			[PO:39]shipVia:33:=[Contact:13]shipVia:26
		Else 
			CONFIRM:C162("Use Contact ShipVia: "+[Contact:13]shipVia:26)
			If (OK=1)
				[PO:39]shipVia:33:=[Contact:13]shipVia:26
			Else 
				Find Ship Zone(->[PO:39]zip:13; ->[PO:39]zone:28; ->[PO:39]shipVia:33; ->[PO:39]country:14; ->[PO:39]siteID:74)
			End if 
		End if 
		//[PO]ShipInstruction:=[Contact]ShippingInstruction 
		//  Put  the formating in the form  jFormatPhone(->[PO]phone; ->[PO]fax)
	: (Table:C252($1)=Table:C252(->[Order:3]))
		[Order:3]contactShipTo:78:=[Contact:13]idNum:28
		[Order:3]company:15:=[Contact:13]company:23
		[Order:3]address1:16:=[Contact:13]address1:6
		[Order:3]address2:17:=[Contact:13]address2:7
		[Order:3]city:18:=[Contact:13]city:8
		[Order:3]state:19:=[Contact:13]state:9
		[Order:3]zip:20:=[Contact:13]zip:11
		[Order:3]country:21:=[Contact:13]country:12
		[Order:3]attention:44:=[Contact:13]nameFirst:2+(" "*Num:C11([Contact:13]nameFirst:2#""))+[Contact:13]nameLast:4
		[Order:3]fax:81:=[Contact:13]fax:31
		[Order:3]phone:67:=[Contact:13]phone:30
		//[Order]Email:=[Contact]Email//###_jwm_### 20101110
		
		//###_jwm_### Do Not Override Freight Billing 20111129
		CONFIRM:C162("Change Freight Billing Option:"+"\r"+"\r"+"From: "+[Order:3]upsBillingOption:89+" "+[Order:3]upsReceiverAcct:90+"\r"+"\r"+"To:     "+[Contact:13]upsBillingOption:49+" "+[Contact:13]upsReceiverAcct:50; "Yes"; "No")
		
		If (ok=1)
			CONFIRM:C162("Confirm Change of Freight Billing Option:"+"\r"+"\r"+"From: "+[Order:3]upsBillingOption:89+" "+[Order:3]upsReceiverAcct:90+"\r"+"\r"+"To:     "+[Contact:13]upsBillingOption:49+" "+[Contact:13]upsReceiverAcct:50; "Confirm"; "Cancel")
			If (ok=1)
				[Order:3]upsResidential:88:=[Contact:13]upsResidential:48
				[Order:3]upsBillingOption:89:=[Contact:13]upsBillingOption:49
				[Order:3]upsReceiverAcct:90:=[Contact:13]upsReceiverAcct:50
			End if 
			
		End if 
		
		If (<>vConfirmShipChange=0)
			[Order:3]shipVia:13:=[Contact:13]shipVia:26
			[Order:3]zone:14:=[Contact:13]zone:27
		Else 
			CONFIRM:C162("Use Contact ShipVia: "+[Contact:13]shipVia:26)
			If (OK=1)
				[Order:3]shipVia:13:=[Contact:13]shipVia:26
				[Order:3]zone:14:=[Contact:13]zone:27
			Else 
				Find Ship Zone(->[Order:3]zip:20; ->[Order:3]zone:14; ->[Order:3]shipVia:13; ->[Order:3]country:21; ->[Order:3]siteID:106)
			End if 
		End if 
		UNLOAD RECORD:C212([Contact:13])
	: (Table:C252($1)=Table:C252(->[Proposal:42]))
		[Proposal:42]contactShipTo:63:=[Contact:13]idNum:28
		//Proposal_FillAddress("Contact")
		//[Proposal]Email:=[Contact]Email//###_jwm_### 20101111
		
		If (<>vConfirmShipChange=0)
			[Proposal:42]shipVia:18:=[Contact:13]shipVia:26
			[Proposal:42]zone:19:=[Contact:13]zone:27
		Else 
			CONFIRM:C162("Use Contact ShipVia: "+[Contact:13]shipVia:26)
			If (OK=1)
				[Proposal:42]shipVia:18:=[Contact:13]shipVia:26
				[Proposal:42]zone:19:=[Contact:13]zone:27
			Else 
				Find Ship Zone(->[Proposal:42]zip:16; ->[Proposal:42]zone:19; ->[Proposal:42]shipVia:18; ->[Proposal:42]country:17; ->[Proposal:42]siteID:77)
			End if 
		End if 
		UNLOAD RECORD:C212([Contact:13])
	: (Table:C252($1)=Table:C252(->[Invoice:26]))
		[Invoice:26]contactShipTo:72:=[Contact:13]idNum:28
		[Invoice:26]company:7:=[Contact:13]company:23
		[Invoice:26]address1:8:=[Contact:13]address1:6
		[Invoice:26]address2:9:=[Contact:13]address2:7
		[Invoice:26]city:10:=[Contact:13]city:8
		[Invoice:26]state:11:=[Contact:13]state:9
		[Invoice:26]zip:12:=[Contact:13]zip:11
		[Invoice:26]country:13:=[Contact:13]country:12
		[Invoice:26]attention:38:=[Contact:13]nameFirst:2+(" "*Num:C11([Contact:13]nameFirst:2#""))+[Contact:13]nameLast:4
		[Invoice:26]fax:75:=[Contact:13]fax:31
		[Invoice:26]phone:54:=[Contact:13]phone:30
		//[Invoice]Email:=[Contact]Email//###_jwm_### 20101111
		
		If (<>vConfirmShipChange=0)
			[Invoice:26]shipVia:5:=[Contact:13]shipVia:26
			[Invoice:26]zone:6:=[Contact:13]zone:27
		Else 
			CONFIRM:C162("Use Contact ShipVia: "+[Contact:13]shipVia:26)
			If (OK=1)
				[Invoice:26]shipVia:5:=[Contact:13]shipVia:26
				[Invoice:26]zone:6:=[Contact:13]zone:27
			Else 
				Find Ship Zone(->[Invoice:26]zip:12; ->[Invoice:26]zone:6; ->[Invoice:26]shipVia:5; ->[Invoice:26]country:13; ->[Invoice:26]siteID:86)
			End if 
		End if 
		//02/23/02.prf Added 3 fields for UPS export 
		[Invoice:26]upsResidential:80:=[Contact:13]upsResidential:48
		[Invoice:26]upsBillingOption:81:=[Contact:13]upsBillingOption:49
		[Invoice:26]upsReceiverAcct:82:=[Contact:13]upsReceiverAcct:50
		UNLOAD RECORD:C212([Contact:13])
End case 