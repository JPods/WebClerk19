C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Activate:K2:9)
		FormEventOnActivate
	: ($formEvent=On Close Detail:K2:24)
		FormEventCloseDetail
	: ($formEvent=On Unload:K2:2)
		FormEventOnUnloadOLO
	: ($formEvent=On Display Detail:K2:22)
		FormEventOnDisplayDetail
	: ($formEvent=On Header:K2:17)
		FormEventOnHeader
	: ($formEvent=On Selection Change:K2:29)
		FormEventOnSelectionChange
	: ($formEvent=On Open Detail:K2:23)
		FormEventOnOpenDetail
	: ($formEvent=On Close Box:K2:21)
		FormEventOnCloseBox
	: (($formEvent=On Load:K2:1) & (vHere<<>outLayoutTrigger))  //In header
		If (False:C215)
			TCNavigationChange005
		End if 
		jsetInHeader(->[QQQZipCode:96])
		OLO_HereAndMenu
		
		
		// bill.james@jpods.com
		// Your Username is 525JIT005262
		// Your Password is 464MK72IW252
		
		
		//  Developers integrating Web Tools into a custom application:
		//  The following are the production URLs you will use to access the Web Tools Servers:
		//  - http://production.shippingapis.com/ShippingAPI.dll
		//  - https://secure.shippingapis.com/ShippingAPI.dll
		//  
		//  Step-by-Step Instructions for All USPS Web Tools (important information when getting started):
		//  - https://www.usps.com/business/web-tools-apis/general-api-developer-guide.pdf
		//  
		//  API User’s Guides (API specific technical/integration information):
		//  - https://www.usps.com/business/web-tools-apis/technical-documentation.htm
		//  
		//  USPS Web Tools website: (contains all these resources and more):
		//  - https://www.usps.com/business/web-tools-apis/welcome.htm
		
		
		
		//: ($formEvent=On Header)
	: ($formEvent=On Outside Call:K2:11)  // (Outside call)
		Prs_OutsideCall
End case 

