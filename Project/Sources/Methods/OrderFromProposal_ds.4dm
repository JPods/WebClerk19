//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/15/21, 13:02:34
// ----------------------------------------------------
// Method: OrderFromProposal_ds
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_OBJECT:C1216($obOrder; $obProposal; $obCustomer)
C_TEXT:C284($idProposal)
$idProposal:=process_o.idProposal

$obProposal:=ds:C1482.Proposal.query("id = :1"; $idProposal).first()
If ($obProposal#Null:C1517)
	$obCustomer:=ds:C1482.Customer.query("customerID = :1"; $obProposal.customerID).first()
	$obOrder:=ds:C1482.Order.new()
	$obOrder.orderNum:=CounterNew(->[Order:3])
	$obOrder.save()  // save to capture the orderNum and id
	
	$obOrder.adSource:=$obCustomer.adSource
	
	$obOrder.billToCompany:=$obProposal.bill2Company
	$obOrder.addressBillTo:=$obProposal.addressBillTo
	$obOrder.addressShipFrom:=$obProposal.addressShipFrom
	If ($obCustomer#Null:C1517)
		$obOrder.upsBillingOption:=$obCustomer.upsBillingOption
		$obOrder.upsInsureShipping:=$obCustomer.upsInsureShipping
		$obOrder.upsReceiverAcct:=$obCustomer.upsReceiverAcct
		$obOrder.upsResidential:=$obCustomer.upsResidential
		
		If ($obProposal.dateNeeded=!00-00-00!)
			If (<>tcNeedDelay>-1)
				$obOrder.dateNeeded:=Current date:C33+$obProposal.daysLeadTime+$obCustomer.shippingDays
				$obOrder.dateShipOn:=Current date:C33+$obProposal.daysLeadTime
			End if 
		Else 
			$obOrder.dateNeeded:=$obProposal.dateNeeded
			If ($obProposal.dateNeeded>(Current date:C33+$obProposal.daysLeadTime))
				$obOrder.dateShipOn:=Current date:C33-$obCustomer.shippingDays
			End if 
		End if 
		If ($obOrder.billToCompany="")
			// $obOrder.billToCompany:=$obCustomer.company
			// use the default address for now
		End if 
		
	End if 
	$obOrder.phone:=$obProposal.phone
	$obOrder.phoneCell:=$obProposal.phoneCell
	$obOrder.fax:=$obProposal.fax
	$obOrder.email:=$obProposal.email
	$obOrder.idNumTask:=$obProposal.idNumTask
	$obOrder.customerID2nd:=$obProposal.customerID2nd
	
	$obOrder.contractDetailTag:=$obProposal.contractDetailTag
	$obOrder.contractDetail:=$obProposal.contractDetail
	
	
	$obOrder.idNumProject:=$obProposal.idNumProject
	$obOrder.customerPO:=$obProposal.inquiryCode
	$obOrder.docType:=$obProposal.docType
	$obOrder.docReference:=$obProposal.docReference
	$obOrder.profile1:=$obProposal.profile1
	$obOrder.profile2:=$obProposal.profile2
	$obOrder.profile3:=$obProposal.profile3
	$obOrder.profile4:=$obProposal.profile4
	$obOrder.profile5:=$obProposal.profile5
	$obOrder.profile6:=$obProposal.profile6
	$obOrder.exchangeRate:=$obProposal.exchangeRate
	$obOrder.currency:=$obProposal.currency
	$obOrder.idNumTask:=$obProposal.idNumTask
	$obOrder.contractDetail:=$obProposal.contractDetail
	$obOrder.amountForceValue:=$obProposal.amountForceValue
	$obOrder.primaryForm:=Replace string:C233($obProposal.primaryForm; "Proposal"; "Order")
	$obOrder.shipPartial:=$obProposal.shipPartial
	$obOrder.taxExemptid:=$obProposal.taxExemptid
	$obOrder.obGeneral:=$obProposal.obGeneral
	// ### bj ### 20190104_1416
	// look at mechanism of transferring Line ObGeneral
	
	C_OBJECT:C1216($obRecService; $obSelService)
	$obSelService:=ds:C1482.Service.query("proposalNum = :1"; $obProposal.proposalNum)
	For each ($obRecService; $obSelService)
		$obRecService.orderNum:=$obOrder.orderNum
		$obRecService.save()
	End for each 
	
	//UERY([Service]; [Service]proposalNum=$obProposal.proposalNum)
	// UniqueIDPassAlong(->[Service]; ->[Service]orderNum; ->$obOrder.orderNum)
	
	$obOrder.dateInvoiceComp:=!00-00-00!
	$obOrder.complete:=0
	$obOrder.datePrinted:=!00-00-00!
	$obOrder.repID:=$obProposal.repID
	$obOrder.salesNameID:=$obProposal.salesNameID
	$obOrder.salesCommission:=$obProposal.salesCommission
	$obOrder.repCommission:=$obProposal.repCommission
	$obOrder.salesCommission:=$obProposal.salesCommission
	$obOrder.comment:=$obProposal.comment
	$obOrder.shipVia:=$obProposal.shipVia
	$obOrder.zone:=$obProposal.zone
	$obOrder.company:=$obProposal.company
	$obOrder.address1:=$obProposal.address1
	$obOrder.address2:=$obProposal.address2
	$obOrder.city:=$obProposal.city
	$obOrder.state:=$obProposal.state
	$obOrder.zip:=$obProposal.zip
	$obOrder.country:=$obProposal.country
	$obOrder.typeSale:=$obProposal.typeSale
	$obOrder.terms:=$obProposal.terms
	$obOrder.shipMiscCosts:=$obProposal.shipMiscCosts
	$obOrder.shipAdjustments:=$obProposal.shipAdjustments
	$obOrder.total:=$obProposal.total
	$obOrder.salesTax:=$obProposal.salesTax
	$obOrder.shipTotal:=$obProposal.shipTotal
	$obOrder.shipFreightCost:=$obProposal.shipFreightCost
	$obOrder.addressBillTo:=$obProposal.addressBillTo
	$obOrder.addressShipFrom:=$obProposal.addressShipFrom
	$obOrder.contactBillTo:=$obProposal.contactBillTo
	$obOrder.contactShipTo:=$obProposal.contactShipTo
	// added above 2017-11-06 bj $obOrder.customerID2nd :=$obProposal.customerID2nd
	// KY
	
	$obOrder.orderedBy:=$obProposal.requestedBy
	$obOrder.autoFreight:=$obProposal.autoFreight
	If ($obProposal.adSource#"")
		$obOrder.adSource:=$obProposal.adSource
	End if 
	$obOrder.totalCost:=$obProposal.totalCost
	$obOrder.taxJuris:=$obProposal.taxJuris
	//TaxDoReCalc (->sTaxRate;->$obOrder.TaxJuris;->[Customer]TaxExemptID;->doTax;->$obOrder.SalesTax;->aOSaleTax;->aOTaxable;->aOExtPrice)
	$obOrder.fob:=$obProposal.fob
	$obOrder.attention:=$obProposal.attention
	$obOrder.shipInstruct:=$obProposal.shipInstruct
	$obOrder.alertMessage:=$obProposal.alertMessage
	$obOrder.commentProcess:=$obProposal.commentProcess
	
	
	If ($obOrder.orderNum>10)  // adding to an existing order
		OrdLnFillRays
	End if 
	$i:=Records in selection:C76([OrderLine:49])
	//TRACE
	QUERY:C277([ProposalLine:43]; [ProposalLine:43]idNumProposal:1=$obProposal.proposalNum)
	PpLnFillRays(Records in selection:C76([ProposalLine:43]))
	ARRAY LONGINT:C221(PPLnSelect; 0)
	$cnt:=Records in selection:C76([ProposalLine:43])
	For ($inc; 1; $cnt)
		APPEND TO ARRAY:C911(aPPLnSelect; $inc)
	End for 
	C_LONGINT:C283($cntPPLns)
	C_BOOLEAN:C305($askQty)
	$cntPPLns:=Size of array:C274(aPPLnSelect)
	For ($e; 1; $cntPPLns)
		If (aPQtyOrder{aPPLnSelect{$e}}#aPQtyOpen{aPPLnSelect{$e}})
			$askQty:=True:C214
			$e:=$cntPPLns
		End if 
	End for 
	
	If (($askQty) & (allowAlerts_boo))
		CONFIRM:C162("Use Total verses Open Quantity."; " Total Qty "; " Open Qty")  // ### jwm ### 20170411_1147 added titles to buttons
		$askQty:=(OK=1)
	End if 
	For ($e; 1; $cntPPLns)
		$i:=$i+1
		OrdLn_RaySize(1; $i; 1)
		aoLineAction{$i}:=-3  // new, + num notes unchanged selected rec, - num notes changed selected rec
		aOLineNum{$i}:=aPLineNum{aPPLnSelect{$e}}
		If (viOrdLnCnt<aPLineNum{aPPLnSelect{$e}})
			viOrdLnCnt:=aPLineNum{aPPLnSelect{$e}}
		End if 
		//
		aOItemNum{$i}:=aPItemNum{aPPLnSelect{$e}}
		aOAltItem{$i}:=aPAltItem{aPPLnSelect{$e}}
		aOQtyShip{$i}:=0
		If ($askQty)
			aOQtyOrder{$i}:=aPQtyOrder{aPPLnSelect{$e}}
			aOQtyBL{$i}:=aPQtyOrder{aPPLnSelect{$e}}
		Else 
			aOQtyOrder{$i}:=aPQtyOpen{aPPLnSelect{$e}}
			aOQtyBL{$i}:=aPQtyOpen{aPPLnSelect{$e}}
		End if 
		aODescpt{$i}:=aPDescpt{aPPLnSelect{$e}}
		aOUnitPrice{$i}:=aPUnitPrice{aPPLnSelect{$e}}
		aODiscnt{$i}:=aPDiscnt{aPPLnSelect{$e}}
		aOExtPrice{$i}:=aPExtPrice{aPPLnSelect{$e}}
		aoDscntUP{$i}:=aPDscntUP{aPPLnSelect{$e}}
		aOExtWt{$i}:=aPExtWt{aPPLnSelect{$e}}
		aOLocation{$i}:=aPLocation{aPPLnSelect{$e}}
		aOLocationBin{$i}:=aPLocationBin{aPPLnSelect{$e}}
		aOUnitMeas{$i}:=aPUnitMeas{aPPLnSelect{$e}}
		aOTaxable{$i}:=aPTaxable{aPPLnSelect{$e}}
		//aOSaleTax{$i}:=Round(aOExtPrice{$i}*sTaxRate*(Num(aOTaxable{$i}));2)
		//aOSaleTax{$i}:=//Round(aOExtPrice{$i}*sTaxRate*(Num(aOTaxable{$i}));2)
		TaxCalcLine(->[Order:3]taxJuris:43; Customer.taxExemptid; aOTaxable{$i}; aOExtPrice{$i}; aOExtCost{$i}; $i; 2; ->aOSaleTax{$i}; ->aOTaxCost{$i})
		aOUnitCost{$i}:=aPUnitCost{aPPLnSelect{$e}}
		aOExtCost{$i}:=aPExtCost{aPPLnSelect{$e}}
		aOUnitWt{$i}:=aPUnitWt{aPPLnSelect{$e}}
		aOPQDIR{$i}:=-1
		aOSeq{$i}:=aPSeq{aPPLnSelect{$e}}
		aOPricePt{$i}:=aPPricePt{aPPLnSelect{$e}}
		aOSerialRc{$i}:=aPSerial{aPPLnSelect{$e}}
		//
		aoDateReq{$i}:=$obOrder.dateNeeded
		If ($obProposal.dateNeeded>=(Current date:C33+aPLeadTime{aPPLnSelect{$e}}))
			aoDateShipOn{$i}:=$obProposal.dateNeeded
		Else 
			aoDateShipOn{$i}:=Current date:C33+aPLeadTime{aPPLnSelect{$e}}
		End if 
		aOSalesRate{$i}:=aPSalesRate{aPPLnSelect{$e}}
		aORepRate{$i}:=aPRepRate{aPPLnSelect{$e}}
		
		aoLineAction:=$i
		OrdLnExtend($i)
		aoProdBy{$i}:=aPProdBy{aPPLnSelect{$e}}
		aoLnComment{$i}:=aPLnComment{aPPLnSelect{$e}}
		aoProfile1{$i}:=aPProfile1{aPPLnSelect{$e}}
		aoProfile2{$i}:=aPProfile2{aPPLnSelect{$e}}
		aoProfile3{$i}:=aPProfile3{aPPLnSelect{$e}}
		aoPrintThis{$i}:=apPrintThis{aPPLnSelect{$e}}
	End for 
	If (<>tcUpdateCommFromMaster)
		<>aReps:=Find in array:C230(<>aReps; $obOrder.repID)
		If (<>aReps>0)
			CM_ChangeRateByNameID(->[Order:3]repID:8; -><>aReps; ->[Rep:8]; ->vComRep; -><>aRepRate; <>tcSaleMar; ->aOExtPrice; ->aOExtCost; ->aORepRate; ->aORepComm; ->[Order:3]repCommission:9; ->aOQtyOrder; ->aoLineAction)
		End if 
	Else 
		vComRep:=CM_FindRate(->[Order:3]repID:8; -><>aReps; -><>aRepRate)
	End if 
	If (<>tcUpdateCommFromMaster)
		<>aComNameID:=Find in array:C230(<>aComNameID; $obOrder.salesNameID)
		If (<>aComNameID>0)
			CM_ChangeRateByNameID(->[Order:3]salesNameID:10; -><>aComNameID; ->[Employee:19]; ->vComSales; -><>aEmpRate; <>tcSaleMar; ->aOExtPrice; ->aOExtCost; ->aOSalesRate; ->aOSaleComm; ->[Order:3]salesCommission:11; ->aOQtyOrder; ->aoLineAction)
		End if 
	Else 
		vComSales:=CM_FindRate(->[Order:3]salesNameID:10; -><>aComNameID; -><>aEmpRate)
	End if 
	vMod:=calcInvoice(vMod)
	$obProposal.orderNum:=$obOrder.orderNum
	$obProposal.dateOrdered:=Current date:C33
	$obOrder.proposalNum:=$obProposal.proposalNum
	$obProposal.save()
	$obOrder.save()
	vResponse:=JSON Stringify:C1217($obOrder.toObject())
End if 
