//%attributes = {}

C_TEXT:C284($vtID)
$vtID:=WCapi_GetParameter("tableName")
If ($vtID="")
	$vtID:=ds:C1482.Order.query("orderNum = :1"; 3031).first().id
End if 


C_OBJECT:C1216($obOrder; $obCustomer; $obInvoice)
$obOrder:=ds:C1482.Order.query("id = :1"; $vtID).first()
If ($obOrder#Null:C1517)
	$obCustomer:=ds:C1482.Customer.query("customerID = :1"; $obOrder.customerID).first()
	$obInvoice:=ds:C1482.InvoiceLine.new()
	$obInvoice.invoiceNum:=CounterNew(->[Invoice:26])
	$obInvoice.save()
	$obInvoice.amount:=0  //initialize to assure printing alignment
	$obInvoice.total:=0
	$obInvoice.shipTotal:=0
	$obInvoice.salesTax:=0
	
	$obInvoice.siteID:=DSSetSiteID
	
	$obInvoice.orderNum:=$obOrder.orderNum
	$obInvoice.customerID:=$obOrder.customerID
	$obInvoice.idNumTask:=$obOrder.idNumTask
	$obInvoice.contractDetail:=$obOrder.contractDetail
	$obInvoice.contractDetailTag:=$obOrder.contractDetailTag
	$obInvoice.primaryForm:=Replace string:C233($obOrder.primaryForm; "Order"; "Invoice")
	$obInvoice.typeSale:=$obOrder.typeSale
	$obInvoice.taxJuris:=$obOrder.taxJuris
	$obInvoice.taxExemptid:=$obOrder.taxExemptid
	//TaxFindSales (->sTaxRate;->$obInvoice.TaxJuris;->[Customer]TaxExemptID;->doTax)
	$obInvoice.customerPO:=$obOrder.customerPO
	If (<>tcOtoIShipD)
		$obInvoice.dateShipped:=$obOrder.dateShipOn  // Invc_DateShippd
	Else 
		$obInvoice.dateShipped:=Current date:C33
	End if 
	$obInvoice.dateInvoiced:=Current date:C33
	$obInvoice.packedBy:=Current user:C182
	$obInvoice.shipVia:=$obOrder.shipVia
	$obInvoice.zone:=$obOrder.zone
	$obInvoice.company:=$obOrder.company
	$obInvoice.bill2Company:=$obOrder.billToCompany
	$obInvoice.address1:=$obOrder.address1
	$obInvoice.address2:=$obOrder.address2
	$obInvoice.city:=$obOrder.city
	$obInvoice.state:=$obOrder.state
	$obInvoice.zip:=$obOrder.zip
	$obInvoice.country:=$obOrder.country
	$obInvoice.phone:=$obOrder.phone
	$obInvoice.attention:=$obOrder.attention
	$obInvoice.fob:=$obOrder.fob
	$obInvoice.shipInstruct:=$obOrder.shipInstruct
	$obInvoice.commentProcess:=$obOrder.commentProcess
	$obInvoice.alertMessage:=$obOrder.alertMessage
	$obInvoice.fax:=$obOrder.fax
	$obInvoice.email:=$obOrder.email
	$obInvoice.repID:=$obOrder.repID
	$obInvoice.salesNameID:=$obOrder.salesNameID
	$obInvoice.contactShipTo:=$obOrder.contactShipTo
	$obInvoice.contactBillTo:=$obOrder.contactBillTo
	$obInvoice.amountForceValue:=$obOrder.amountForceValue
	//chek if OK from Control file
	//If (vHere<2)//multiples from Orders output layout
	C_OBJECT:C1216($obRep; $obEmployee)
	vComRep:=0
	$obRep:=ds:C1482.Rep.query("repID = :1"; $obInvoice.repID).first()
	If ($obRep#Null:C1517)
		vComRep:=$obRep.comRate
	End if 
	vComSales:=0
	$obEmployee:=ds:C1482.Employee.query("nameID = :1"; $obInvoice.salesNameID).first()
	If ($obEmployee#Null:C1517)
		vComRep:=$obEmployee.comRate
	End if 
	//vComRep:=CM_FindRate($obInvoice.repID; -><>aReps; -><>aRepRate)
	//vComSales:=CM_FindRate($obInvoice.salesNameID; -><>aComNameID; -><>aEmpRate)
	//End if 
	$obInvoice.terms:=$obOrder.terms
	$obInvoice.division:=$obCustomer.division
	$obInvoice.comment:=$obOrder.comment
	$obInvoice.adSource:=$obOrder.adSource
	$obInvoice.labelCount:=$obOrder.labelCount
	$obInvoice.exchangeRate:=$obOrder.exchangeRate
	$obInvoice.currency:=$obOrder.currency
	$obInvoice.consignment:=$obOrder.consignment
	$obInvoice.producedBy:=$obOrder.actionBy
	$obInvoice.autoFreight:=$obOrder.autoFreight
	//Console_Log ("TEST: createOrdInvRay "+String($i))
	
	$obInvoice.obGeneral:=$obOrder.obGeneral
	// ### bj ### 20190104_1416
	// look at mechanism of transferring Line ObGeneral
	
	
	C_BOOLEAN:C305($bypass)
	
	If (False:C215)  // look at this later
		//
		Case of 
			: (vPackingProcess="PK")
				LT_FillArrayLoadItems(0)  //invoices
			: (vbForceShip=True:C214)  //load planning window
			: (($obInvoice.autoFreight=False:C215) & ($obInvoice.orderNum>1))
				//skip shipping for commission invoices and other not shipped orders
			: ((<>vLoadPlanning) & ($obInvoice.orderNum>1) & (False:C215))
				//TRACE
				LT_InvoiceShipments  //invoices
				// Why is this here and subrecords
			Else 
				LT_FillArrayLoadItems(0)  //invoices
		End case 
	End if 
	//
	
	Case of 
		: (($obInvoice.orderNum#1) & ($obOrder.complete=1) & (<>tcNoCodHand))  //do nothing, do in (P) calcInvoice
		: ($obInvoice.orderNum#1)  //&(Not($obInvoice.AutoFreight)))
			If ($obOrder.amount=0)  //April 25, 1995   removed partial shipping costs 
				$invPortion:=1  //based on Chris's thoughts
			Else 
				If (allowAlerts_boo)
					MESSAGE:C88("Review partial shipping costs Invoice "+String:C10($obInvoice.invoiceNum; "0000-0000")+".")
				End if 
				$invPortion:=1  //($obInvoice.Amount/$obOrder.Amount)
			End if 
			$obInvoice.shipAdjustments:=Round:C94($obOrder.shipAdjustments*$invPortion; <>tcDecimalTt)
			$obInvoice.shipFreightCost:=Round:C94($obOrder.shipFreightCost*$invPortion; <>tcDecimalTt)
			$obInvoice.shipMiscCosts:=Round:C94($obOrder.shipMiscCosts*$invPortion; <>tcDecimalTt)
			$obInvoice.autoFreight:=False:C215
			OBJECT SET ENTERABLE:C238($obInvoice.shipMiscCosts; True:C214)
			OBJECT SET ENTERABLE:C238($obInvoice.shipFreightCost; True:C214)
			//else
			//$obInvoice.ShipAdjustments:=Round($obOrder.ShipAdjustments*$invPortion
			//;TOTPREC)
	End case 
	$obInvoice.division:=$obOrder.division
	$obInvoice.idNumProject:=$obOrder.idNumProject
	//
	Case of 
		: ($obOrder.addressBillTo#"")
			$obInvoice.addressBillTo:=$obOrder.addressBillTo
		: ($obCustomer.addrAltBillTo#"")
			$obInvoice.addressBillTo:=$obCustomer.addrAltBillTo
	End case 
	$obInvoice.addressShipFrom:=$obOrder.addressShipFrom
	If (($obOrder.mfrID#"") & ($obOrder.profile1=""))
		$obInvoice.profile1:=$obOrder.mfrOrdNum
	Else 
		$obInvoice.profile1:=$obOrder.profile1
	End if 
	$obInvoice.profile2:=$obOrder.profile2
	$obInvoice.profile3:=$obOrder.profile3
	$obInvoice.profile4:=$obOrder.profile4
	$obInvoice.profile5:=$obOrder.profile5
	$obInvoice.profile6:=$obOrder.profile6
	//
	$obInvoice.upsResidential:=$obOrder.upsResidential  //Date: 05/17/02 Pete Fleming
	$obInvoice.upsBillingOption:=$obOrder.upsBillingOption  //Date: 05/17/02 Pete Fleming
	$obInvoice.upsReceiverAcct:=$obOrder.upsReceiverAcct  //Date: 05/17/02 Pete Fleming
	$obInvoice.upsInsureShipping:=$obOrder.upsInsureShipping
End if 

C_OBJECT:C1216($obOrderlineSel; $obOrderLineRec; $obInvoiceLine)
$obOrderlines:=ds:C1482.Orderline.query("orderNum = :1 "; $obOrder.orderNum)
C_COLLECTION:C1488($cInvoiceLines)
For each ($obOrderLineRec; $obOrderlineSel)
	//$obInvoiceLine:=DS_OrderLinesToInvoiceLines($obOrderLineRec; )
End for each 

createOrdInvRay
vMod:=calcInvoice(vMod)