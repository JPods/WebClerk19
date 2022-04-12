//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-11-14T00:00:00, 09:47:04
// ----------------------------------------------------
// Method: LoadCustOrder
// Description
// Modified: 11/14/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20150109_1141 changed DateNeeded to Date Ordered
// ### jwm ### 20161018_2102 Orders siteID set to Customer siteID if not Empty

If (False:C215)
	//Date: 05/17/02
	//Who: Peter Fleming, Arkware
	//Description: Added new UPS fields
	
	//Date: 05/24/02
	//Who: Janani, Arkware
	//Description: added the prepaid option to UPSBillingOption 
	VERSION_960
End if 

C_LONGINT:C283(vHere)
C_BOOLEAN:C305(allowAlerts_boo)

$doStandard:=True:C214  //### wdj ### 070707 
If (Count parameters:C259=1)  //This does not seem to be passed anywhere
	$doStandard:=False:C215
	C_POINTER:C301($1; $ptTable)
	$ptTable:=$1
End if 

Case of 
	: (<>salesRepSpreadSheet)
		AddressOrderFill("billtofromCustomer")
		
	: ($doStandard)
		
		setCustFinance
		
		If ([Customer:2]siteID:106#"")
			[Order:3]siteID:106:=[Customer:2]siteID:106  // ### jwm ### 20161018_2102 set Default siteID
		End if 
		
		[Order:3]action:150:=[Customer:2]action:60
		[Order:3]actionBy:55:=[Customer:2]actionBy:139
		[Order:3]actionDate:149:=[Customer:2]actionDate:61
		[Order:3]actionTime:37:=[Customer:2]actionTime:71
		
		[Order:3]customerID:1:=[Customer:2]customerID:1
		[Order:3]typeSale:22:=[Customer:2]typeSale:18  //ititialize values     
		[Order:3]sector:138:=[Customer:2]sector:124  //ititialize values  
		[Order:3]addressBillTo:71:=[Customer:2]addrAltBillTo:77
		[Order:3]contactBillTo:87:=[Customer:2]contactBillTo:92
		[Order:3]contactShipTo:78:=[Customer:2]contactShipTo:93
		[Order:3]shipPartial:121:=[Customer:2]shipPartial:109
		[Order:3]taxExemptid:122:=[Customer:2]taxExemptid:56
		[Order:3]terms:23:=[Customer:2]terms:33
		[Order:3]fob:45:=Storage:C1525.default.fob
		[Order:3]adSource:41:=[Customer:2]adSource:62
		[Order:3]takenBy:36:=Current user:C182
		[Order:3]repID:8:=[Customer:2]repID:58
		[Order:3]salesNameID:10:=[Customer:2]salesNameID:59
		vComRep:=CM_FindRate(->[Order:3]repID:8; -><>aReps; -><>aRepRate)
		vComSales:=CM_FindRate(->[Order:3]salesNameID:10; -><>aComNameID; -><>aEmpRate)
		//ShipAddrRay_Set 
		vMod:=calcOrder(True:C214)
		//TaxDoReCalc (->sTaxRate;->[Order]TaxJuris;->[Customer]TaxExemptID;->doTax;->[Order]SalesTax;->aOSaleTax;->aOTaxable;->aOExtPrice)
		If (allowAlerts_boo)
			//  Put  the formating in the form  jFormatPhone(->[Customer]phone; ->[Customer]fax; ->srPhone; ->[Order]phone)
		End if 
		<>aLastRecNum{2}:=Record number:C243([Customer:2])
		[Order:3]dateNeeded:5:=Current date:C33+<>tcNeedDelay
		[Order:3]dateShipOn:31:=ShipOnDate([Order:3]dateNeeded:5; [Customer:2]shippingDays:22)
		If ((<>tcbManyType) & ([Customer:2]customerID:1#""))
			//DscntSetPrice ([Order]TypeSale;[Order]DateNeeded)
			DscntSetPrice([Order:3]typeSale:22; [Order:3]dateDocument:4)  // ### jwm ### 20150109_1141 changed from DateNeeded to Date Ordered
		Else 
			DscntSpecialClr([Order:3]typeSale:22)
		End if 
		pCCDateStr:=Date_StrMMYY([Customer:2]creditCardExpir:54)
		pCreditCard:=[Customer:2]creditCardNum:53
		pCVV:=[Customer:2]creditCardCVV:114
		//Format_CreditCd (->[Customer]CreditCardNum)
		//
		//TRACE
		C_LONGINT:C283($w; $bill2Me)
		$bill2Me:=-1
		If ([Customer:2]contactBillTo:92>0)
			QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Customer:2]customerID:1; *)
			QUERY:C277([Contact:13];  & [Contact:13]idNum:28=[Customer:2]contactBillTo:92)
			
			//If (($w>0) & ([Order]ContactBillTo>0))
			//GOTO SELECTED RECORD([Contact];aContactsRecordNum{$w})//shipToMe)
			//QUERY([Contact];[Contact]UniqueID=aContactsUniqueID{$w})  //xxxwdj###070627
		Else 
			REDUCE SELECTION:C351([Contact:13]; 0)
		End if 
		If (Records in selection:C76([Contact:13])=1)
			AddressOrderFill("billtofromContact")
		Else 
			AddressOrderFill("billtofromCustomer")
		End if 
		
		bAltBillBox:=Num:C11([Order:3]addressBillTo:71#"")
		
		C_LONGINT:C283($w)
		// $w:=Find in array(aContactsUniqueID;[Order]ContactShipTo)
		//If (($w>0) & ([Order]ContactShipTo>0))  //
		If ([Customer:2]contactShipTo:93>0)
			QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Customer:2]customerID:1; *)
			QUERY:C277([Contact:13];  & [Contact:13]idNum:28=[Customer:2]contactShipTo:93)
			
			//If (($w>0) & ([Order]ContactBillTo>0))
			//GOTO SELECTED RECORD([Contact];aContactsRecordNum{$w})//shipToMe)
			//QUERY([Contact];[Contact]UniqueID=aContactsUniqueID{$w})  //xxxwdj###070627
		Else 
			REDUCE SELECTION:C351([Contact:13]; 0)
		End if 
		If (Records in selection:C76([Contact:13])=1)
			AddressOrderFill("shiptofromContact")
		Else 
			AddressOrderFill("shiptofromCustomer")
		End if 
		
		If (<>vbEmptyShip2)
			Cust2OrdAddress(1)
		End if 
		
	Else 
		Case of 
			: ($ptTable=(->[Contact:13]))
				AddressOrderFill("shiptofromContact")
			: ($ptTable=(->[Customer:2]))
				AddressOrderFill("shiptofromCustomer")
		End case 
End case 
[Order:3]upsInsureShipping:128:=[Customer:2]upsInsureShipping:113
