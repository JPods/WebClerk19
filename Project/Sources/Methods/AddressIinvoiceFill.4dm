//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-09-16T00:00:00, 01:06:32
// ----------------------------------------------------
// Method: AddressIinvoiceFill
// Description
// Modified: 09/16/13
// 
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $fillTo)


Case of 
	: ($1="shiptofromContact")
		
		[Invoice:26]contactShipTo:72:=[Contact:13]idNum:28
		[Invoice:26]attention:38:=$theName
		[Invoice:26]company:7:=[Contact:13]company:23
		[Invoice:26]address1:8:=[Contact:13]address1:6
		[Invoice:26]address2:9:=[Contact:13]address2:7
		[Invoice:26]city:10:=[Contact:13]city:8
		[Invoice:26]state:11:=[Contact:13]state:9
		[Invoice:26]zip:12:=[Contact:13]zip:11
		[Invoice:26]country:13:=[Contact:13]country:12
		[Invoice:26]phone:54:=[Contact:13]phone:30
		[Invoice:26]upsBillingOption:81:=[Contact:13]upsBillingOption:49
		[Invoice:26]upsReceiverAcct:82:=[Contact:13]upsReceiverAcct:50
		[Invoice:26]upsResidential:80:=False:C215
		If ([Invoice:26]taxJuris:33#[Contact:13]taxJuris:24)
			[Invoice:26]taxJuris:33:=[Contact:13]taxJuris:24
			$0:=True:C214
		End if 
		[Invoice:26]phone:54:=[Contact:13]phone:30
		//  Put  the formating in the form  jFormatPhone(->[Invoice]phone)
		[Invoice:26]shipVia:5:=[Contact:13]shipVia:26
		Find Ship Zone(->[Invoice:26]zip:12; ->[Invoice:26]zone:6; ->[Invoice:26]shipVia:5; ->[Invoice:26]country:13; ->[Invoice:26]siteID:86)
		//02/23/02.prf Added 3 fields for UPS export 
		[Invoice:26]upsResidential:80:=[Contact:13]upsResidential:48
		[Invoice:26]upsBillingOption:81:=[Contact:13]upsBillingOption:49
		[Invoice:26]upsReceiverAcct:82:=[Contact:13]upsReceiverAcct:50
		
		
		
		
End case 