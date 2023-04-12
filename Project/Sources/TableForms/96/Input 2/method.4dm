C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore)
C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
If ($formEvent=On Unload:K2:2)
	UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
	READ WRITE:C146(ptCurTable->)
Else 
	If ($formEvent=On Load:K2:1)
		If (vHere>1)  //coming from another table's input layout
			If (Is new record:C668([QQQZipCode:96]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
			End if 
		End if 
	End if 
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[QQQZipCode:96])
	//
	$doMore:=False:C215
	Case of 
		: (iLoReturningToLayout)  //set in iLoProcedure only once, returning from other table
			
			$doMore:=True:C214
		: (iLoRecordNew)  //set in iLoProcedure only once, new record
			
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once, existing record
			
			$doMore:=True:C214
	End case 
	If ($doMore)  //action for the form regardless of new or existing record
		
		
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
		
		
		
		Before_New(ptCurTable)  //last thing to do
	End if 
	//every cycle
	
	booAccept:=True:C214
End if 