//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 09/19/12, 08:56:03
// ----------------------------------------------------
// Method: createOrderProp
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (False:C215)
	//Date: 03/5/02
	//Who: Dan Bentson, Arkware
	//Description: added process, aert to be set
	VERSION_960
End if 

C_LONGINT:C283($myOK; $i; $e)
C_REAL:C285($discntPrc)

//TRACE
[Order:3]phone:67:=[Proposal:42]phone:24
[Order:3]fax:81:=[Proposal:42]fax:67
[Order:3]email:82:=[Proposal:42]email:68
[Order:3]idNumTask:85:=[Proposal:42]idNumTask:70
[Order:3]customerID2nd:140:=[Proposal:42]customerID2nd:90
[Order:3]contractDetailTag:151:=[Proposal:42]contractDetailTag:97

If (allowAlerts_boo)
	// //  CHOPPED QA_LoOnEntry (eAnsListOrders;"";0;->[Order]taskID)
	//  CHOPPED QA_LoOnEntry(eAnsListOrders; Table(->[Order]); [Order]customerID; [Order]idNum; [Order]idNumTask)
End if 


If ([Proposal:42]customerID:1#[Customer:2]customerID:1)
	QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Proposal:42]customerID:1)
End if 
If (Not:C34(allowAlerts_boo))
	// ### bj ### 20200330_1000 
	// pass when coming from web
	$myOK:=1
Else 
	If (Records in selection:C76([Customer:2])=1)
		jLOADunLocked(->[Customer:2]; "Customer "+[Customer:2]company:2+" is temporarily locked."; ->unlocked)
		If (unLocked=0)
			CONFIRM:C162("The Customer card is locked.  Proceed without saving last order date.")
			If (OK=1)
				$myOK:=1
			Else 
				$myOK:=0
			End if 
		Else 
			$myOK:=OK
		End if 
		[Order:3]customerID:1:=[Proposal:42]customerID:1
	Else 
		CONFIRM:C162("No matching customer, proceed???")
		$myOK:=OK
		[Order:3]customerID:1:=""
	End if 
End if 
If ($myOK=1)
	
	If ([Proposal:42]dateNeeded:4=!00-00-00!)
		If (<>tcNeedDelay>-1)
			[Order:3]dateNeeded:5:=Current date:C33+[Proposal:42]daysLeadTime:40+[Customer:2]shippingDays:22
			[Order:3]dateShipOn:31:=Current date:C33+[Proposal:42]daysLeadTime:40
		End if 
	Else 
		[Order:3]dateNeeded:5:=[Proposal:42]dateNeeded:4
		If ([Proposal:42]dateNeeded:4>(Current date:C33+[Proposal:42]daysLeadTime:40))
			[Order:3]dateShipOn:31:=Current date:C33-[Customer:2]shippingDays:22
		End if 
	End if 
	//[Order]BillToCompany:=[Proposal]Bill2Company
	// ### jwm ### 20180605_2053 which option should this be
	//  [Order]BillToCompany:=[Proposal]Bill2Company  Think it should be this qpq
	[Order:3]billToCompany:76:=[Customer:2]company:2
	[Order:3]projectNum:50:=[Proposal:42]idNumProject:22
	[Order:3]customerPO:3:=[Proposal:42]inquiryCode:6
	[Order:3]docType:64:=[Proposal:42]docType:49
	[Order:3]docReference:65:=[Proposal:42]docReference:50
	[Order:3]profile1:61:=[Proposal:42]profile1:51
	[Order:3]profile2:62:=[Proposal:42]profile2:52
	[Order:3]profile3:63:=[Proposal:42]profile3:53
	[Order:3]profile4:103:=[Proposal:42]profile4:74
	[Order:3]profile5:104:=[Proposal:42]profile5:75
	[Order:3]profile6:105:=[Proposal:42]profile6:76
	[Order:3]exchangeRate:68:=[Proposal:42]exchangeRate:54
	[Order:3]currency:69:=[Proposal:42]currency:55
	[Order:3]idNumTask:85:=[Proposal:42]idNumTask:70
	[Order:3]contractDetailTag:151:=[Proposal:42]contractDetailTag:97
	[Order:3]amountForceValue:112:=[Proposal:42]amountForceValue:81
	[Order:3]primaryForm:111:=Replace string:C233([Proposal:42]primaryForm:80; "Proposal"; "Order")
	[Order:3]shipPartial:121:=[Proposal:42]shipPartial:82
	[Order:3]taxExemptid:122:=[Proposal:42]taxExemptid:83
	[Order:3]obGeneral:147:=[Proposal:42]obGeneral:93
	// ### bj ### 20190104_1416
	// look at mechanism of transferring Line ObGeneral
	
	If ((allowAlerts_boo) & ([Order:3]idNumTask:85>0) & (eAnsListOrders>0))
		QUERY:C277([QA:70]; [QA:70]idNumTask:12=[Order:3]idNumTask:85)
		
	End if 
	QUERY:C277([Service:6]; [Service:6]idNumProposal:27=[Proposal:42]idNum:5)
	UniqueIDPassAlong(->[Service:6]; ->[Service:6]idNumOrder:22; ->[Order:3]idNum:2)
	If (<>tcNeedDelay>-1)
		Case of 
			: ([Proposal:42]dateNeeded:4=!00-00-00!)
				[Order:3]dateNeeded:5:=Current date:C33+<>tcNeedDelay
			: ([Proposal:42]dateNeeded:4<(Current date:C33+<>tcNeedDelay))
				[Order:3]dateNeeded:5:=Current date:C33+<>tcNeedDelay
		End case 
		[Order:3]dateShipOn:31:=ShipOnDate([Order:3]dateNeeded:5; [Customer:2]shippingDays:22)
	End if 
	[Order:3]dateInvoiceComp:6:=!00-00-00!
	[Order:3]complete:83:=0
	[Order:3]datePrinted:7:=!00-00-00!
	[Order:3]repID:8:=[Proposal:42]repID:7
	[Order:3]salesNameID:10:=[Proposal:42]salesNameID:9
	[Order:3]salesCommission:11:=[Proposal:42]salesCommission:10
	[Order:3]repCommission:9:=[Proposal:42]repCommission:8
	[Order:3]salesCommission:11:=[Proposal:42]salesCommission:10
	[Order:3]comment:33:=[Proposal:42]comment:36
	[Order:3]shipVia:13:=[Proposal:42]shipVia:18
	[Order:3]zone:14:=[Proposal:42]zone:19
	[Order:3]company:15:=[Proposal:42]company:11
	[Order:3]address1:16:=[Proposal:42]address1:12
	[Order:3]address2:17:=[Proposal:42]address2:13
	[Order:3]city:18:=[Proposal:42]city:14
	[Order:3]state:19:=[Proposal:42]state:15
	[Order:3]zip:20:=[Proposal:42]zip:16
	[Order:3]country:21:=[Proposal:42]country:17
	[Order:3]typeSale:22:=[Proposal:42]typeSale:20
	[Order:3]terms:23:=[Proposal:42]terms:21
	[Order:3]shipMiscCosts:25:=[Proposal:42]shipMiscCosts:29
	[Order:3]shipAdjustments:26:=[Proposal:42]shipAdjustments:28
	[Order:3]total:27:=[Proposal:42]total:32
	[Order:3]salesTax:28:=[Proposal:42]salesTax:27
	[Order:3]shipTotal:30:=[Proposal:42]shipTotal:31
	[Order:3]shipFreightCost:38:=[Proposal:42]shipFreightCost:30
	[Order:3]addressBillTo:71:=[Proposal:42]addressBillTo:71
	[Order:3]addressShipFrom:72:=[Proposal:42]addressShipFrom:72
	[Order:3]contactBillTo:87:=[Proposal:42]contactBillTo:73
	[Order:3]contactShipTo:78:=[Proposal:42]contactShipTo:63
	// added above 2017-11-06 bj [Order]customerID2nd :=[Proposal]customerID2nd
	
	
	//If ([Proposal]TakenBy="")
	//[Order]TakenBy:=Current user
	//Else 
	//[Order]TakenBy:=[Proposal]TakenBy
	//End if 
	[Order:3]orderedBy:66:=[Proposal:42]requestedBy:62
	[Order:3]autoFreight:40:=[Proposal:42]autoFreight:38
	If ([Proposal:42]adSource:47#"")
		[Order:3]adSource:41:=[Proposal:42]adSource:47
	Else 
		[Order:3]adSource:41:=[Customer:2]adSource:62
	End if 
	[Order:3]totalCost:42:=[Proposal:42]totalCost:23
	[Order:3]taxJuris:43:=[Proposal:42]taxJuris:33
	If ([Order:3]customerID:1#[Customer:2]customerID:1)
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
	End if 
	//TaxDoReCalc (->sTaxRate;->[Order]TaxJuris;->[Customer]TaxExemptID;->doTax;->[Order]SalesTax;->aOSaleTax;->aOTaxable;->aOExtPrice)
	[Order:3]fob:45:=[Proposal:42]fob:34
	[Order:3]attention:44:=[Proposal:42]attention:37
	[Order:3]shipInstruct:46:=[Proposal:42]shipInstruct:35
	[Order:3]alertMessage:80:=[Proposal:42]alertMessage:65
	[Order:3]commentProcess:12:=[Proposal:42]commentProcess:64
	
	//### jwm ### 20120919_0843 begin
	//set UPS shipping options based on Customer record
	[Order:3]upsBillingOption:89:=[Customer:2]upsBillingOption:96
	[Order:3]upsInsureShipping:128:=[Customer:2]upsInsureShipping:113
	[Order:3]upsReceiverAcct:90:=[Customer:2]upsReceiverAcct:97
	[Order:3]upsResidential:88:=[Customer:2]upsResidential:95
	//### jwm ### 20120919_0843 end
	
	// Modified by: William James (2014-01-17T00:00:00)
	
	
	If ([Order:3]idNum:2>10)  // adding to an existing order
		OrdLnFillRays
	End if 
	$i:=Records in selection:C76([OrderLine:49])
	//TRACE
	QUERY:C277([ProposalLine:43]; [ProposalLine:43]idNumProposal:1=[Proposal:42]idNum:5)
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
	
	
	// MustFixQQQZZZ: Bill James (2021-11-28T06:00:00Z)
	// just let it flow at this time.  Change so Proposals can be used as blanket Orders
	$askQty:=True:C214
	
	If (($askQty) & (allowAlerts_boo))
		//CONFIRM("Use Total verses Open Quantity."; " Total Qty "; " Open Qty")  // ### jwm ### 20170411_1147 added titles to buttons
		//$askQty:=(OK=1)
	End if 
	C_LONGINT:C283(viOrdLnCnt)
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
		TaxCalcLine(->[Order:3]taxJuris:43; [Customer:2]taxExemptid:56; aOTaxable{$i}; aOExtPrice{$i}; aOExtCost{$i}; $i; 2; ->aOSaleTax{$i}; ->aOTaxCost{$i})
		aOUnitCost{$i}:=aPUnitCost{aPPLnSelect{$e}}
		aOExtCost{$i}:=aPExtCost{aPPLnSelect{$e}}
		aOUnitWt{$i}:=aPUnitWt{aPPLnSelect{$e}}
		aOPQDIR{$i}:=-1
		aOSeq{$i}:=aPSeq{aPPLnSelect{$e}}
		aOPricePt{$i}:=aPPricePt{aPPLnSelect{$e}}
		aOSerialRc{$i}:=aPSerial{aPPLnSelect{$e}}
		//
		aoDateReq{$i}:=[Order:3]dateNeeded:5
		If ([Proposal:42]dateNeeded:4>=(Current date:C33+aPLeadTime{aPPLnSelect{$e}}))
			aoDateShipOn{$i}:=[Proposal:42]dateNeeded:4
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
		<>aReps:=Find in array:C230(<>aReps; [Order:3]repID:8)
		If (<>aReps>0)
			CM_ChangeRateByNameID(->[Order:3]repID:8; -><>aReps; ->[Rep:8]; ->vComRep; -><>aRepRate; <>tcSaleMar; ->aOExtPrice; ->aOExtCost; ->aORepRate; ->aORepComm; ->[Order:3]repCommission:9; ->aOQtyOrder; ->aoLineAction)
		End if 
	Else 
		vComRep:=CM_FindRate(->[Order:3]repID:8; -><>aReps; -><>aRepRate)
	End if 
	If (<>tcUpdateCommFromMaster)
		<>aComNameID:=Find in array:C230(<>aComNameID; [Order:3]salesNameID:10)
		If (<>aComNameID>0)
			CM_ChangeRateByNameID(->[Order:3]salesNameID:10; -><>aComNameID; ->[Employee:19]; ->vComSales; -><>aEmpRate; <>tcSaleMar; ->aOExtPrice; ->aOExtCost; ->aOSalesRate; ->aOSaleComm; ->[Order:3]salesCommission:11; ->aOQtyOrder; ->aoLineAction)
		End if 
	Else 
		vComSales:=CM_FindRate(->[Order:3]salesNameID:10; -><>aComNameID; -><>aEmpRate)
	End if 
	vMod:=calcInvoice(vMod)
	<>aLastRecNum{2}:=Record number:C243([Customer:2])
	[Proposal:42]idNumOrder:60:=[Order:3]idNum:2
	[Proposal:42]dateOrdered:66:=Current date:C33
	[Order:3]proposalNum:79:=[Proposal:42]idNum:5
	SAVE RECORD:C53([Proposal:42])
End if 
If (eOrdList#0)
	//  --  CHOPPED  AL_UpdateArrays(eOrdList; -2)
End if 