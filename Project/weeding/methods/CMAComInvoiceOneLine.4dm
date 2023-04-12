//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/30/11, 17:22:01
// ----------------------------------------------------
// Method: CMAComInvoiceOneLine
// Description
// 


//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $createLineItem)
C_REAL:C285($2; $3; $3; $4; $backlog)
C_TEXT:C284($5)
C_DATE:C307($6; $dateInvoiced)
If (Count parameters:C259>5)  //will crash if more parameters are used than are passed.
	$dateInvoiced:=$6
Else 
	$dateInvoiced:=Current date:C33
End if 
$createLineItem:=$1
CREATE RECORD:C68([Invoice:26])
viInvcLnCnt:=0
[Invoice:26]idNumOrder:1:=srOrd
[Invoice:26]amount:14:=0  //initialize to assure printing alignment
[Invoice:26]total:18:=0
[Invoice:26]shipTotal:20:=0
[Invoice:26]salesTax:19:=0
[Invoice:26]idNum:2:=CounterNew(->[Invoice:26])
[Invoice:26]customerID:3:=[Order:3]mfrID:52

[Invoice:26]batchReference:100:=variable12

Case of 
	: ($createLineItem=1)  //only one parameter is passed. 
		[Invoice:26]typeSale:49:=v2
		[Invoice:26]taxJuris:33:=[Order:3]taxJuris:43
		[Invoice:26]profile1:53:=v6  //aText2{2}
		[Order:3]remoteRecordID:132:=v6  //aText2{2}
		[Invoice:26]profile2:66:=v7  //aText2{1}
		[Invoice:26]remoteRecordID:98:=v7  //aText2{1}
		sTaxRate:=0
		// setSalesTax (sTaxRate;[Invoice]TaxJuris;[Customer]TaxExemptID;doTax)
		[Invoice:26]customerPO:29:=[Order:3]customerPO:3
		[Invoice:26]dateShipped:4:=Invc_DateShippd(vDate6)
		[Invoice:26]dateDocument:35:=Current date:C33
		[Invoice:26]packedBy:30:=Current user:C182
		[Invoice:26]shipVia:5:=[Order:3]shipVia:13
		[Invoice:26]zone:6:=[Order:3]zone:14
		[Invoice:26]company:7:=[Order:3]company:15
		[Invoice:26]address1:8:=[Order:3]address1:16
		[Invoice:26]address2:9:=[Order:3]address2:17
		[Invoice:26]city:10:=[Order:3]city:18
		[Invoice:26]state:11:=[Order:3]state:19
		[Invoice:26]zip:12:=[Order:3]zip:20
		[Invoice:26]country:13:=[Order:3]country:21
		[Invoice:26]attention:38:=[Order:3]attention:44
		[Invoice:26]fob:39:=[Order:3]fob:45
		[Invoice:26]shipInstruct:40:=[Order:3]shipInstruct:46
		[Invoice:26]repID:22:=[Order:3]repID:8
		[Invoice:26]salesNameID:23:=[Order:3]salesNameID:10
		//
		[Invoice:26]bill2Company:69:=[Order:3]mfrName:91
		If ([Invoice:26]bill2Company:69="")
			[Invoice:26]bill2Company:69:=[Order:3]mfrID:52
			If ([Invoice:26]bill2Company:69="")
				[Invoice:26]bill2Company:69:=[Customer:2]company:2
			End if 
		End if 
		
		//    $totolCom:=Round(vR5*vR4;TOTPREC)
		[Invoice:26]repCommission:28:=Round:C94(vR5*vR4*0.01; <>tcDecimalTt)  //Round(vR6*vR2*vR4;TOTPREC)
		[Invoice:26]salesCommission:36:=Round:C94(vR5-[Invoice:26]repCommission:28; <>tcDecimalTt)  //Round(vR6*vR2*(1-vR4);TOTPREC)
		If ([Order:3]idNum:2>9)
			QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2; *)
			QUERY:C277([OrderLine:49];  & [OrderLine:49]itemNum:4="Com"+[Order:3]mfrID:52+"@")
			// Modified by: Bill James (2015-01-14T00:00:00 There were two "Com"+mfrID records)
			Case of 
				: (Records in selection:C76([OrderLine:49])>1)
					QUERY SELECTION:C341([OrderLine:49]; [OrderLine:49]qty:6=1)  // get the off-set line
					[OrderLine:49]itemNum:4:="OS_"+[OrderLine:49]itemNum:4
					SAVE RECORD:C53([OrderLine:49])
					QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2; *)
					QUERY:C277([OrderLine:49];  & [OrderLine:49]itemNum:4="Com"+[Order:3]mfrID:52+"@")
					If (Records in selection:C76([OrderLine:49])#1)
						ALERT:C41("Multiple Commission OrderLines Records.")
					End if 
				: (Records in selection:C76([OrderLine:49])=0)
					ALERT:C41("No Commission OrderLines Record.")
			End case 
		End if 
		CREATE RECORD:C68([InvoiceLine:54])
		
		[InvoiceLine:54]orderLineNum:48:=[OrderLine:49]idNum:50
		[InvoiceLine:54]lineNum:3:=[OrderLine:49]lineNum:3
		[InvoiceLine:54]idNumInvoice:1:=[Invoice:26]idNum:2
		If ([OrderLine:49]itemNum:4#"")
			[InvoiceLine:54]itemNum:4:=[OrderLine:49]itemNum:4
		Else 
			[InvoiceLine:54]itemNum:4:="Com"+[Order:3]mfrID:52
		End if 
		Case of 
			: (((vR6<=vAmount) & (vAmount>=0)) | ((vR6>=vAmount) & (vAmount<0)))
				[InvoiceLine:54]qtyOrderedAtInvoice:63:=[OrderLine:49]qty:6  //vR6
				[InvoiceLine:54]qtyRemain:6:=[OrderLine:49]qty:6-[OrderLine:49]qtyShipped:7
				[InvoiceLine:54]qty:7:=vR6
				[InvoiceLine:54]qtyBackLogged:8:=[InvoiceLine:54]qtyRemain:6-vR6
				[OrderLine:49]qtyBackLogged:8:=[OrderLine:49]qty:6-[OrderLine:49]qtyShipped:7-vR6
				[OrderLine:49]qtyShipped:7:=[OrderLine:49]qty:6-[OrderLine:49]qtyBackLogged:8
				[Order:3]amountBackLog:54:=[OrderLine:49]qtyBackLogged:8
				[Customer:2]balanceOpenOrders:78:=[Customer:2]balanceOpenOrders:78-vR6
			Else 
				[OrderLine:49]qty:6:=[OrderLine:49]qty:6+vR6-vAmount
				[InvoiceLine:54]qtyOrderedAtInvoice:63:=[OrderLine:49]qty:6  //vR6
				[InvoiceLine:54]qtyRemain:6:=[OrderLine:49]qty:6-[OrderLine:49]qtyShipped:7
				[InvoiceLine:54]qty:7:=vR6
				[InvoiceLine:54]qtyBackLogged:8:=0
				[OrderLine:49]qtyBackLogged:8:=0
				[OrderLine:49]qtyShipped:7:=[OrderLine:49]qty:6
				[OrderLine:49]extendedPrice:11:=[OrderLine:49]qty:6
				[Order:3]total:27:=[OrderLine:49]qty:6
				[Order:3]amount:24:=[Order:3]total:27
				vR1:=Round:C94([Order:3]amount:24*vR2; <>tcDecimalTt)
				vR3:=Round:C94(vR1*vR4; <>tcDecimalTt)
				[OrderLine:49]commRep:16:=Round:C94(vR3; <>tcDecimalTt)
				[OrderLine:49]commSales:17:=Round:C94(vR1-vR3; <>tcDecimalTt)
				[OrderLine:49]commRateSales:29:=Round:C94(vR2*(1-vR4)*100; 1)
				[OrderLine:49]commRateRep:18:=Round:C94((vR2*100)-[OrderLine:49]commRateSales:29; 1)
				[Order:3]repCommission:9:=[OrderLine:49]commRep:16
				[Order:3]salesCommission:11:=[OrderLine:49]commSales:17
				If (allowAlerts_boo)
					If ((Size of array:C274(aOrdTotal)>0) & (aOrdRecNum<=Size of array:C274(aOrdTotal)))
						aOrdTotal{aOrdRecNum}:=[Order:3]total:27
					End if 
				End if 
				vR7:=[Order:3]total:27
		End case 
		vAmount:=[OrderLine:49]qtyBackLogged:8
		vR8:=Round:C94(vAmount*vR2*0.01; <>tcDecimalTt)
		If ([OrderLine:49]qtyBackLogged:8=0)
			[OrderLine:49]complete:48:=True:C214
		End if 
		SAVE RECORD:C53([OrderLine:49])
		SAVE RECORD:C53([Customer:2])
		[InvoiceLine:54]unitWt:20:=0
		[InvoiceLine:54]extendedWt:21:=0
		[InvoiceLine:54]description:5:="Commission"
		[InvoiceLine:54]unitPrice:9:=vR2*0.01
		[InvoiceLine:54]discount:10:=0
		[InvoiceLine:54]location:22:=[OrderLine:49]location:22
		[InvoiceLine:54]extendedPrice:11:=vR5
		[InvoiceLine:54]taxJuris:14:=""
		[InvoiceLine:54]salesTax:15:=0
		[InvoiceLine:54]unitofMeasure:19:="Comm"
		[InvoiceLine:54]unitCost:12:=0
		[InvoiceLine:54]extendedCost:13:=0
		//
		[InvoiceLine:54]commRateRep:18:=vR4
		[InvoiceLine:54]commRateSales:23:=100-[InvoiceLine:54]commRateRep:18
		[InvoiceLine:54]commRep:16:=[Invoice:26]repCommission:28
		[InvoiceLine:54]commSales:17:=[Invoice:26]salesCommission:36
		
		[Invoice:26]terms:24:=v8
		[Invoice:26]division:41:=[Customer:2]division:70
		[Invoice:26]comment:43:=[Order:3]comment:33
		[Invoice:26]adSource:52:=[Order:3]adSource:41
		[Invoice:26]labelCount:25:=[Order:3]labelCount:32
		doNewInv:=False:C215
		//    
		[Invoice:26]weightEstimate:42:=0
		[Invoice:26]amount:14:=vR5
		[Invoice:26]salesTax:19:=0
		[Invoice]shipAuto:=False:C215
		[Invoice:26]shipAdjustments:17:=0
		[Invoice:26]shipFreightCost:15:=0
		[Invoice:26]shipMiscCosts:16:=0
		[Invoice:26]shipTotal:20:=0
		[Invoice:26]total:18:=[Invoice:26]amount:14  //+[Invoice]SalesTax+[Invoice]Freight
		[Invoice:26]balanceDue:44:=[Invoice:26]total:18
		
		
		SAVE RECORD:C53([InvoiceLine:54])
		SAVE RECORD:C53([Invoice:26])
		
		doSearch:=3
		
		
		// VoidSetOrderDt 
		[OrderLine:49]backOrdAmount:26:=[OrderLine:49]qtyBackLogged:8
		vAmount:=[OrderLine:49]qtyBackLogged:8
		vR8:=Round:C94(vAmount*vR2*0.01; <>tcDecimalTt)
		[Order:3]amountBackLog:54:=[OrderLine:49]backOrdAmount:26
		If ([Order:3]amountBackLog:54#Old:C35([Order:3]amountBackLog:54))
			[Customer:2]balanceOpenOrders:78:=[Order:3]amountBackLog:54-Old:C35([Order:3]amountBackLog:54)
		End if 
		Accept_CalcStat(->[Order:3]; False:C215; ->[OrderLine:49]qtyShipped:7; ->[OrderLine:49]qtyBackLogged:8)
		If (allowAlerts_boo)
			C_LONGINT:C283(eListOrders)
			If (eListOrders>0)  // ignor if not in CommOrder Window
				If ((Size of array:C274(aOrdDtCmp)>0) & (aOrdRecNum<=Size of array:C274(aOrdDtCmp)))
					// if(FALSE)
					aOrdDtCmp{aOrdRecNum}:=[Order:3]dateInvoiceComp:6
					aOrdAmt{aOrdRecNum}:=[Order:3]amountBackLog:54
					// End if 
				End if 
			End if 
		End if 
		
		Ledger_InvSave
		
		SAVE RECORD:C53([Order:3])
		SAVE RECORD:C53([Customer:2])
		
	: ($createLineItem=2)
		[Invoice:26]typeSale:49:=[Order:3]typeSale:22
		[Invoice:26]taxJuris:33:=[Order:3]taxJuris:43
		[Invoice:26]profile1:53:=[Order:3]profile1:61
		//[Order]remoteRecordID:=v6
		[Invoice:26]profile2:66:=[Order:3]profile2:62
		[Invoice:26]remoteRecordID:98:=[Order:3]remoteRecordID:132
		
		sTaxRate:=0
		// setSalesTax (sTaxRate;[Invoice]TaxJuris;[Customer]TaxExemptID;doTax)
		[Invoice:26]customerPO:29:=[Order:3]customerPO:3
		[Invoice:26]dateShipped:4:=$dateInvoiced
		[Invoice:26]dateDocument:35:=Current date:C33
		[Invoice:26]packedBy:30:=Current user:C182
		[Invoice:26]shipVia:5:=[Order:3]shipVia:13
		[Invoice:26]zone:6:=[Order:3]zone:14
		[Invoice:26]company:7:=[Order:3]company:15
		[Invoice:26]address1:8:=[Order:3]address1:16
		[Invoice:26]address2:9:=[Order:3]address2:17
		[Invoice:26]city:10:=[Order:3]city:18
		[Invoice:26]state:11:=[Order:3]state:19
		[Invoice:26]zip:12:=[Order:3]zip:20
		[Invoice:26]country:13:=[Order:3]country:21
		[Invoice:26]attention:38:=[Order:3]attention:44
		[Invoice:26]fob:39:=[Order:3]fob:45
		[Invoice:26]shipInstruct:40:=[Order:3]shipInstruct:46
		[Invoice:26]repID:22:=[Order:3]repID:8
		[Invoice:26]salesNameID:23:=[Order:3]salesNameID:10
		[Invoice:26]terms:24:=""
		[Invoice:26]division:41:=[Customer:2]division:70
		[Invoice:26]comment:43:=[Order:3]comment:33
		[Invoice:26]adSource:52:=[Order:3]adSource:41
		[Invoice:26]labelCount:25:=[Order:3]labelCount:32
		[Invoice:26]profile1:53:=[Order:3]profile1:61  //v6//
		//[Order]remoteRecordID:=v6//aText2{2}
		[Invoice:26]profile2:66:=[Order:3]profile2:62
		[Invoice:26]remoteRecordID:98:=[Order:3]profile5:104  //v7//
		[Invoice:26]remotecustomerID:99:=[Order:3]customerID:1
		
		[Invoice:26]bill2Company:69:=iLoText5
		
		
		//    $totolCom:=Round(vR5*vR4;TOTPREC)
		//$InvoiceTotal:=
		$rateTotal:=$3+$4
		$salesRate:=Round:C94($3/$rateTotal*100; 4)
		$repRate:=Round:C94($4/$rateTotal*100; 4)
		[Invoice:26]repCommission:28:=Round:C94($2*$salesRate*0.01; <>tcDecimalTt)  //Round(vR6*vR2*vR4;TOTPREC)
		[Invoice:26]salesCommission:36:=Round:C94($2*$repRate*0.01; <>tcDecimalTt)
		CREATE RECORD:C68([InvoiceLine:54])
		
		[InvoiceLine:54]orderLineNum:48:=[OrderLine:49]idNum:50
		[InvoiceLine:54]itemNum:4:="Com"+vText3
		[InvoiceLine:54]description:5:=$5
		[InvoiceLine:54]qtyOrderedAtInvoice:63:=[OrderLine:49]qty:6  //vR6
		[InvoiceLine:54]qtyRemain:6:=0
		[InvoiceLine:54]qty:7:=[OrderLine:49]qtyShipped:7
		If ([OrderLine:49]qty:6>[OrderLine:49]qtyShipped:7)
			[InvoiceLine:54]qtyBackLogged:8:=[OrderLine:49]qty:6-[OrderLine:49]qtyShipped:7
		Else 
			[InvoiceLine:54]qtyBackLogged:8:=0
		End if 
		[InvoiceLine:54]unitPrice:9:=Round:C94($rateTotal*0.01; 2)
		[InvoiceLine:54]commRateRep:18:=$repRate
		[InvoiceLine:54]commRateSales:23:=$salesRate
		[InvoiceLine:54]commRep:16:=[Invoice:26]repCommission:28
		[InvoiceLine:54]commSales:17:=[Invoice:26]salesCommission:36
		[InvoiceLine:54]extendedPrice:11:=Round:C94([OrderLine:49]extendedPrice:11*[InvoiceLine:54]unitPrice:9; 2)
		
		[Invoice:26]amount:14:=[InvoiceLine:54]extendedPrice:11
		[Invoice:26]total:18:=[Invoice:26]amount:14
		//
		
		
		
		[Invoice:26]weightEstimate:42:=0
		[Invoice:26]salesTax:19:=0
		[Invoice]shipAuto:=False:C215
		[Invoice:26]shipAdjustments:17:=0
		[Invoice:26]shipFreightCost:15:=0
		[Invoice:26]shipMiscCosts:16:=0
		[Invoice:26]shipTotal:20:=0
		[Invoice:26]total:18:=[Invoice:26]amount:14  //+[Invoice]SalesTax+[Invoice]Freight
		[Invoice:26]balanceDue:44:=[Invoice:26]total:18
		
		
		SAVE RECORD:C53([InvoiceLine:54])
		SAVE RECORD:C53([Invoice:26])
		ADD TO SET:C119([Invoice:26]; "CurrentInvoices")
		Ledger_InvSave
		
		QUERY:C277([MfrCustomerXRef:110]; [MfrCustomerXRef:110]mfrAccountNum:37=[Order:3]profile3:63; *)  //aText2{6}
		QUERY:C277([MfrCustomerXRef:110];  & [MfrCustomerXRef:110]mfrID:3=vText3)
		If (Records in selection:C76([MfrCustomerXRef:110])<1)
			MfrXRefCreate
			[MfrCustomerXRef:110]statusRelationship:12:="violation"
			SAVE RECORD:C53([MfrCustomerXRef:110])
		End if 
End case 

