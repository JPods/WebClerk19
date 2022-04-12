//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-07-24T00:00:00, 04:07:37
// ----------------------------------------------------
// Method: LoadCustomersInvoices
// Description
// Modified: 07/24/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_BOOLEAN:C305($forceUpdate; $1)
$forceUpdate:=False:C215
If (Count parameters:C259=1)
	$forceUpdate:=$1
End if 

If (([Customer:2]customerID:1#[Invoice:26]customerID:3) | (Is new record:C668([Invoice:26])) | ($forceUpdate))
	[Invoice:26]repID:22:=[Customer:2]repID:58
	[Invoice:26]salesNameID:23:=[Customer:2]salesNameID:59
	vComRep:=CM_FindRate(->[Invoice:26]repID:22; -><>aReps; -><>aRepRate)
	vComSales:=CM_FindRate(->[Invoice:26]salesNameID:23; -><>aComNameID; -><>aEmpRate)
	[Invoice:26]division:41:=[Customer:2]division:70
	[Invoice:26]customerID:3:=[Customer:2]customerID:1
	[Invoice:26]terms:24:=[Customer:2]terms:33
	[Invoice:26]addressBillTo:67:=[Customer:2]addrAltBillTo:77
	[Invoice:26]bill2Company:69:=[Customer:2]company:2
	[Invoice:26]contactBillTo:79:=[Customer:2]contactBillTo:92
	[Invoice:26]contactShipTo:72:=[Customer:2]contactShipTo:93
	bAltBillBox:=Num:C11([Invoice:26]addressBillTo:67#"")
	setCustFinance
	[Invoice:26]typeSale:49:=[Customer:2]typeSale:18
	[Invoice:26]sector:102:=[Customer:2]sector:124
	C_LONGINT:C283($w)
	$w:=Find in array:C230(aContactsUniqueID; [Invoice:26]contactShipTo:72)
	If (($w>0) & ([Invoice:26]contactShipTo:72>0))  //(shipToMe>0)  
		QUERY:C277([Contact:13]; [Contact:13]idNum:28=aContactsUniqueID{$w})
		//GOTO SELECTED RECORD([Contact];aContactsRecordNum{$w})//;shipToMe)
		[Invoice:26]company:7:=[Contact:13]company:23
		[Invoice:26]address1:8:=[Contact:13]address1:6
		[Invoice:26]address2:9:=[Contact:13]address2:7
		[Invoice:26]city:10:=[Contact:13]city:8
		[Invoice:26]state:11:=[Contact:13]state:9
		[Invoice:26]zip:12:=[Contact:13]zip:11
		[Invoice:26]country:13:=[Contact:13]country:12
		[Invoice:26]attention:38:=[Contact:13]nameFirst:2+" "+[Contact:13]nameLast:4
		[Invoice:26]zone:6:=[Contact:13]zone:27
		[Invoice:26]shipVia:5:=[Contact:13]shipVia:26
		[Invoice:26]taxJuris:33:=[Contact:13]taxJuris:24
		[Invoice:26]contactShipTo:72:=[Contact:13]idNum:28
		If ([Contact:13]phone:30="")
			[Invoice:26]phone:54:=[Customer:2]phone:13
		Else 
			[Invoice:26]phone:54:=[Contact:13]phone:30
		End if 
		If ([Contact:13]fax:31="")
			[Invoice:26]fax:75:=[Customer:2]fax:66
		Else 
			[Invoice:26]fax:75:=[Contact:13]fax:31
		End if 
		If ([Contact:13]email:35="")
			[Invoice:26]email:76:=[Customer:2]email:81
		Else 
			[Invoice:26]email:76:=[Contact:13]email:35
		End if 
		//02/23/02.prf Added 3 fields for UPS export    
		//05/24/02 janani added the prepaid option to UPSBillingOption   
		TRACE:C157
		[Invoice:26]upsResidential:80:=[Contact:13]upsResidential:48
		[Invoice:26]upsBillingOption:81:=[Contact:13]upsBillingOption:49
		[Invoice:26]upsReceiverAcct:82:=[Contact:13]upsReceiverAcct:50
		
		If (Length:C16([Invoice:26]upsBillingOption:81)=0)
			ALERT:C41("The Ship Bill Option for the selected Contact is blank...setting the "+"Invoice to Prepaid")
			[Invoice:26]upsBillingOption:81:="Prepaid & Add"
		End if 
	Else 
		If (<>vbEmptyShip2)
			[Invoice:26]company:7:="NoPrimeShip2"
			[Invoice:26]address1:8:=""
			[Invoice:26]address2:9:=""
			[Invoice:26]city:10:=""
			[Invoice:26]state:11:=""
			[Invoice:26]zip:12:=""
			[Invoice:26]country:13:=""
			[Invoice:26]zone:6:=-1
			[Invoice:26]attention:38:=""
			[Invoice:26]shipVia:5:=[Customer:2]shipVia:12
			[Invoice:26]taxJuris:33:=[Customer:2]taxJuris:65
			[Invoice:26]phone:54:=[Customer:2]phone:13
			[Invoice:26]fax:75:=[Customer:2]fax:66
			[Invoice:26]email:76:=[Customer:2]email:81
			//02/23/02.prf Added 3 fields for UPS export 
			//05/24/02 janani added the prepaid option to UPSBillingOption    
			TRACE:C157
			[Invoice:26]upsResidential:80:=[Customer:2]upsResidential:95
			[Invoice:26]upsBillingOption:81:=[Customer:2]upsBillingOption:96
			[Invoice:26]upsReceiverAcct:82:=[Customer:2]upsReceiverAcct:97
			If (Length:C16([Invoice:26]upsBillingOption:81)=0)
				// ALERT("The Ship Bill Option for this Customer is blank...setting the Invoice to
				[Invoice:26]upsBillingOption:81:="Prepaid & Add"
			End if 
		Else 
			[Invoice:26]company:7:=[Customer:2]company:2
			[Invoice:26]address1:8:=[Customer:2]address1:4
			[Invoice:26]address2:9:=[Customer:2]address2:5
			[Invoice:26]city:10:=[Customer:2]city:6
			[Invoice:26]state:11:=[Customer:2]state:7
			[Invoice:26]zip:12:=[Customer:2]zip:8
			[Invoice:26]country:13:=[Customer:2]country:9
			[Invoice:26]zone:6:=[Customer:2]zone:57
			[Invoice:26]attention:38:=[Customer:2]nameFirst:73+(" "*Num:C11([Customer:2]nameFirst:73#""))+[Customer:2]nameLast:23
			[Invoice:26]shipVia:5:=[Customer:2]shipVia:12
			[Invoice:26]taxJuris:33:=[Customer:2]taxJuris:65
			[Invoice:26]phone:54:=[Customer:2]phone:13
			[Invoice:26]fax:75:=[Customer:2]fax:66
			[Invoice:26]email:76:=[Customer:2]email:81
			//02/23/02.prf Added 3 fields for UPS export 
			//05/24/02 janani added the prepaid option to UPSBillingOption    
			[Invoice:26]upsResidential:80:=[Customer:2]upsResidential:95
			[Invoice:26]upsBillingOption:81:=[Customer:2]upsBillingOption:96
			[Invoice:26]upsReceiverAcct:82:=[Customer:2]upsReceiverAcct:97
			If (Length:C16([Invoice:26]upsBillingOption:81)=0)
				// ALERT("The Ship Bill Option for this Customer is blank...setting the Invoice to
				[Invoice:26]upsBillingOption:81:="Prepaid & Add"
			End if 
		End if 
		
	End if 
	[Invoice:26]upsInsureShipping:97:=[Customer:2]upsInsureShipping:113
	//  ShipAddrRay_Set
	[Invoice:26]adSource:52:=[Customer:2]adSource:62
	[Invoice:26]typeSale:49:=[Customer:2]typeSale:18
	vMod:=calcInvoice(vMod)
	//TaxDoReCalc (->sTaxRate;->[Invoice]TaxJuris;->[Customer]TaxExemptID;->doTax;->[Invoice]SalesTax;->aiSaleTax;->aiTaxable;->aiExtPrice)
End if 
pCCDateStr:=Date_StrMMYY([Customer:2]creditCardExpir:54)
//[Customer]CreditCardNum
//  Put  the formating in the form  jFormatPhone(->[Customer]phone; ->[Customer]fax; ->srPhone; ->[Invoice]phone)
srCustomer:=[Customer:2]company:2
srPhone:=[Customer:2]phone:13
srAcct:=[Customer:2]customerID:1
srZip:=[Customer:2]zip:8
//February 13, 1995 - 10:18 AM, Added to correct for failing to change price struc
If ((<>tcbManyType) & ([Customer:2]customerID:1#""))
	DscntSetPrice([Invoice:26]typeSale:49; <>ptInvoiceDateFld->)
Else 
	DscntSpecialClr([Invoice:26]typeSale:49)
End if 