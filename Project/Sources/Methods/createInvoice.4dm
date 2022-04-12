//%attributes = {"publishedWeb":true}
//Method: createInvoice
If (False:C215)
	//Date: 03/5/02
	//Who: Dan Bentson, Arkware
	//Description: added process, aert, fax, e-mail to be set
	
	//Date: 05/17/02
	//Who: Pete Fleming, Arkware
	//Description: Added transfer of fields
	//[Order]UPSResidential, [Order]UPSBillingOption, [Order]UPSReceiverAcct
	//to Invoice UPS fields
	VERSION_960
End if 
$forceInventory:=False:C215
If (Count parameters:C259=1)  // must be set to true to use the LoadItems to fill Invoice
	$forceInventory:=$1
End if 

C_REAL:C285($invPortion)
[Invoice:26]amount:14:=0  //initialize to assure printing alignment
[Invoice:26]total:18:=0
[Invoice:26]shipTotal:20:=0
[Invoice:26]salesTax:19:=0

[Invoice:26]siteID:86:=DSSetSiteID

If ([Invoice:26]invoiceNum:2=0)
	[Invoice:26]invoiceNum:2:=CounterNew(->[Invoice:26])
End if 
[Invoice:26]orderNum:1:=[Order:3]orderNum:2
[Invoice:26]customerID:3:=[Order:3]customerID:1
[Invoice:26]idNumTask:78:=[Order:3]idNumTask:85
[Invoice:26]contractDetailTag:114:=[Order:3]contractDetailTag:151
[Order:3]primaryForm:111:=Replace string:C233([Proposal:42]primaryForm:80; "Order"; "Invoice")
If ([Invoice:26]customerID:3#[Customer:2]customerID:1)
	QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Invoice:26]customerID:3)
	QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Invoice:26]customerID:3)
End if 
[Invoice:26]typeSale:49:=[Order:3]typeSale:22
[Invoice:26]taxJuris:33:=[Order:3]taxJuris:43
[Invoice:26]taxExemptid:91:=[Order:3]taxExemptid:122
//TaxFindSales (->sTaxRate;->[Invoice]TaxJuris;->[Customer]TaxExemptID;->doTax)
[Invoice:26]customerPO:29:=[Order:3]customerPO:3
[Invoice:26]dateShipped:4:=Invc_DateShippd
[Invoice:26]dateInvoiced:35:=Current date:C33
[Invoice:26]packedBy:30:=Current user:C182
[Invoice:26]shipVia:5:=[Order:3]shipVia:13
[Invoice:26]zone:6:=[Order:3]zone:14
[Invoice:26]company:7:=[Order:3]company:15
[Invoice:26]bill2Company:69:=[Order:3]billToCompany:76
[Invoice:26]address1:8:=[Order:3]address1:16
[Invoice:26]address2:9:=[Order:3]address2:17
[Invoice:26]city:10:=[Order:3]city:18
[Invoice:26]state:11:=[Order:3]state:19
[Invoice:26]zip:12:=[Order:3]zip:20
[Invoice:26]country:13:=[Order:3]country:21
[Invoice:26]phone:54:=[Order:3]phone:67
[Invoice:26]attention:38:=[Order:3]attention:44
[Invoice:26]fob:39:=[Order:3]fob:45
[Invoice:26]shipInstruct:40:=[Order:3]shipInstruct:46
[Invoice:26]commentProcess:73:=[Order:3]commentProcess:12
[Invoice:26]alertMessage:74:=[Order:3]alertMessage:80
[Invoice:26]fax:75:=[Order:3]fax:81
[Invoice:26]email:76:=[Order:3]email:82
[Invoice:26]repID:22:=[Order:3]repID:8
[Invoice:26]salesNameID:23:=[Order:3]salesNameID:10
[Invoice:26]contactShipTo:72:=[Order:3]contactShipTo:78
[Invoice:26]contactBillTo:79:=[Order:3]contactBillTo:87
[Invoice:26]amountForceValue:90:=[Order:3]amountForceValue:112
//chek if OK from Control file
//If (vHere<2)//multiples from Orders output layout
vComRep:=CM_FindRate(->[Invoice:26]repID:22; -><>aReps; -><>aRepRate)
vComSales:=CM_FindRate(->[Invoice:26]salesNameID:23; -><>aComNameID; -><>aEmpRate)
//End if 
[Invoice:26]terms:24:=[Order:3]terms:23
[Invoice:26]division:41:=[Customer:2]division:70
[Invoice:26]comment:43:=[Order:3]comment:33
[Invoice:26]adSource:52:=[Order:3]adSource:41
[Invoice:26]labelCount:25:=[Order:3]labelCount:32
[Invoice:26]exchangeRate:61:=[Order:3]exchangeRate:68
[Invoice:26]currency:62:=[Order:3]currency:69
[Invoice:26]consignment:63:=[Order:3]consignment:70
[Invoice:26]producedBy:65:=[Order:3]actionBy:55
[Invoice:26]autoFreight:32:=[Order:3]autoFreight:40
//ConsoleMessage ("TEST: createOrdInvRay "+String($i))

[Invoice:26]obGeneral:109:=[Order:3]obGeneral:147
// ### bj ### 20190104_1416
// look at mechanism of transferring Line ObGeneral


createOrdInvRay


C_BOOLEAN:C305($bypass)


//
Case of 
	: (vPackingProcess="PK")
		LT_FillArrayLoadItems(0)  //invoices
	: (vbForceShip=True:C214)  //load planning window
	: (([Invoice:26]autoFreight:32=False:C215) & ([Invoice:26]orderNum:1>1))
		//skip shipping for commission invoices and other not shipped orders
	: ((<>vLoadPlanning) & ([Invoice:26]orderNum:1>1) & (False:C215))
		//TRACE
		LT_InvoiceShipments  //invoices
		// Why is this here and subrecords
	Else 
		LT_FillArrayLoadItems(0)  //invoices
End case 
//
vMod:=calcInvoice(vMod)
Case of 
	: (([Invoice:26]orderNum:1#1) & ([Order:3]complete:83=1) & (<>tcNoCodHand))  //do nothing, do in (P) calcInvoice
	: ([Invoice:26]orderNum:1#1)  //&(Not([Invoice]AutoFreight)))
		If ([Order:3]amount:24=0)  //April 25, 1995   removed partial shipping costs 
			$invPortion:=1  //based on Chris's thoughts
		Else 
			If (allowAlerts_boo)
				MESSAGE:C88("Review partial shipping costs Invoice "+String:C10([Invoice:26]invoiceNum:2; "0000-0000")+".")
			End if 
			$invPortion:=1  //([Invoice]Amount/[Order]Amount)
		End if 
		[Invoice:26]shipAdjustments:17:=Round:C94([Order:3]shipAdjustments:26*$invPortion; <>tcDecimalTt)
		[Invoice:26]shipFreightCost:15:=Round:C94([Order:3]shipFreightCost:38*$invPortion; <>tcDecimalTt)
		[Invoice:26]shipMiscCosts:16:=Round:C94([Order:3]shipMiscCosts:25*$invPortion; <>tcDecimalTt)
		[Invoice:26]autoFreight:32:=False:C215
		OBJECT SET ENTERABLE:C238([Invoice:26]shipMiscCosts:16; True:C214)
		OBJECT SET ENTERABLE:C238([Invoice:26]shipFreightCost:15; True:C214)
		//else
		//[Invoice]ShipAdjustments:=Round([Order]ShipAdjustments*$invPortion
		//;TOTPREC)
End case 
[Invoice:26]division:41:=[Order:3]division:48
[Invoice:26]projectNum:50:=[Order:3]projectNum:50
//
Case of 
	: ([Order:3]addressBillTo:71#"")
		[Invoice:26]addressBillTo:67:=[Order:3]addressBillTo:71
	: ([Customer:2]addrAltBillTo:77#"")
		[Invoice:26]addressBillTo:67:=[Customer:2]addrAltBillTo:77
End case 
[Invoice:26]addressShipFrom:68:=[Order:3]addressShipFrom:72
If (([Order:3]mfrID:52#"") & ([Order:3]profile1:61=""))
	[Invoice:26]profile1:53:=[Order:3]mfrOrdNum:51
Else 
	[Invoice:26]profile1:53:=[Order:3]profile1:61
End if 
[Invoice:26]profile2:66:=[Order:3]profile2:62
[Invoice:26]profile3:70:=[Order:3]profile3:63
[Invoice:26]profile4:83:=[Order:3]profile4:103
[Invoice:26]profile5:84:=[Order:3]profile5:104
[Invoice:26]profile6:85:=[Order:3]profile6:105
//
[Invoice:26]upsResidential:80:=[Order:3]upsResidential:88  //Date: 05/17/02 Pete Fleming
[Invoice:26]upsBillingOption:81:=[Order:3]upsBillingOption:89  //Date: 05/17/02 Pete Fleming
[Invoice:26]upsReceiverAcct:82:=[Order:3]upsReceiverAcct:90  //Date: 05/17/02 Pete Fleming
[Invoice:26]upsInsureShipping:97:=[Order:3]upsInsureShipping:128
//
vMod:=True:C214
skipReCost:=False:C215
UNLOAD RECORD:C212([Item:4])
REDRAW WINDOW:C456