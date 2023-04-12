//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/12/11, 16:04:44
// ----------------------------------------------------
// Method: acceptInvoice
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_REAL:C285($IvcDelta)
C_BOOLEAN:C305($1)

If (Count parameters:C259=1)
	booAccept:=$1
	vMod:=$1
End if 
//TRACE
If (booAccept)
	// ### bj ### 20181102_0819
	// Tasha reports this is causing too many problems. 
	// To prevent it from Journalling now requires it to start with "Consign@"
	// I think this can be cut without much risk of accidential entry that prevents Journalling
	//If (([Invoice]Consignment="Consign@") & ([Invoice]Consignment#"@*@"))
	//CONFIRM("Are you sure you wish to consign this Invoice. It will not Journal.")
	//If (OK=0)
	//[Invoice]Consignment:=""
	//End if 
	// End if 
	error:=0
	If ((<>tcMONEYCHAR#strCurrency) & ([Invoice:26]exchangeRate:61#1) & ([Invoice:26]exchangeRate:61#0))
		vMod:=True:C214
		bExchange:=1
		Exch_FillRays
	End if 
	If (Is new record:C668([Customer:2]))
		TallyCreate(Table:C252(->[AdSource:35]); Field:C253(->[AdSource:35]newResponces:28); [Customer:2]adSource:62; 0; 1)
		
		Data_ArchiveOld
		//Data_ArchiveOld(process_o.oldCustomer)
		//acceptFilePt ($unLoad;->[Customer];->[Contact];->[Service];->[ReferencesTable];->[CallReport])
		//acceptFilePt ($unLoad;->[OrderLine];->[Order];->[Invoice];->[Proposal];->[InvoiceLine])
	End if 
	If (Modified record:C314([Customer:2]))
		SAVE RECORD:C53([Customer:2])
	End if 
	<>aLastRecNum{2}:=Record number:C243([Customer:2])
	If ((Modified record:C314([Invoice:26])) | (vMod))
		$okToSave:=OrderInvoiceLineMisMatch
		If ($okToSave)
			IVNT_dRayInit
			Case of 
				: (([Invoice:26]currency:62#"") & ([Invoice:26]jrnlComplete:48=True:C214))
					//CONFIRM("Do test")
					//$myTest:=(OK=1)
					//TRACE
					//If ($myTest)
					vMod:=calcInvoice(True:C214)
					InvoiceLinesCalc
					//End if 
				: (Not:C34([Invoice:26]jrnlComplete:48))
					If (([Invoice:26]dtRevenue:64=0) & (([Invoice:26]consignment:63="") | ([Invoice:26]consignment:63="Completed")))
						[Invoice:26]dtRevenue:64:=DateTime_DTTo
					End if 
					If ([Invoice:26]dateDocument:35=!00-00-00!)
						[Invoice:26]dateDocument:35:=Current date:C33
					End if 
					vMod:=calcInvoice(True:C214)
					InvoiceLinesCalc
					If ([Invoice:26]idNumOrder:1>9)  // Modified by: williamjames (110512) Changed from #1
						
						If (([Invoice:26]idNumOrder:1#[Order:3]idNum:2) & (ptCurTable#(->[Base:1])))
							QUERY:C277([Order:3]; [Order:3]idNum:2=[Invoice:26]idNumOrder:1)
						End if 
						
						//?????????   ZZZZZZZ
						//  this should be calc from arrays on only one in the program Query "[Order]Total:=" to correct
						Accept_CalcStat(->[Order:3]; False:C215; ->[OrderLine:49]qtyShipped:7; ->[OrderLine:49]qtyBackLogged:8)
						//needed if lines were added or overshipped
						//[Order]BackLogAmount     in the above procedure
						//if (vHere=2)
						C_LONGINT:C283($cntOrdLines; $incOrdLines)
						// queried in Accept_CalcStat  // 
						// query([OrderLine];[OrderLine]OrderNum=[Order]OrderNum)
						$cntOrdLines:=Records in selection:C76([OrderLine:49])
						FIRST RECORD:C50([OrderLine:49])
						$vrWeightEstimate:=0
						$vrAmount:=0
						$vrTotalCost:=0
						$vrSalesTax:=0
						$vrRepCommission:=0
						$vrSalesCommission:=0
						For ($incOrdLines; 1; $cntOrdLines)
							$vrWeightEstimate:=$vrWeightEstimate+[OrderLine:49]extendedWt:21
							$vrAmount:=$vrAmount+[OrderLine:49]extendedPrice:11
							$vrTotalCost:=$vrTotalCost+[OrderLine:49]extendedCost:13
							$vrSalesTax:=$vrSalesTax+[OrderLine:49]salesTax:15
							$vrRepCommission:=$vrRepCommission+[OrderLine:49]commRep:16
							$vrSalesCommission:=$vrSalesCommission+[OrderLine:49]commSales:17
							NEXT RECORD:C51([OrderLine:49])
						End for 
						UNLOAD RECORD:C212([OrderLine:49])
						[Order:3]weightEstimate:49:=$vrWeightEstimate
						[Order:3]amount:24:=Round:C94($vrAmount; <>tcDecimalTt)
						[Order:3]totalCost:42:=Round:C94($vrTotalCost; <>tcDecimalTt)
						[Order:3]salesTax:28:=Round:C94($vrSalesTax; <>tcDecimalTt)
						[Order:3]repCommission:9:=Round:C94($vrRepCommission; <>tcDecimalTt)
						[Order:3]salesCommission:11:=Round:C94($vrSalesCommission; <>tcDecimalTt)
						If ([Order:3]shipAuto:40)
							ShippingCost(->[Order:3]shipVia:13; ->[Order:3]zone:14; ->[Order:3]weightEstimate:49; ->[Order:3]shipFreightCost:38; ->[Order:3]shipMiscCosts:25; ->[Order:3]shipAdjustments:26; ->[Order:3]terms:23; ->[Order:3]amount:24; ->[Order:3]labelCount:32)
						End if 
						If ([Order:3]amount:24>0)
							[Order:3]grossMargin:47:=Trunc:C95(([Order:3]amount:24-[Order:3]totalCost:42)/[Order:3]amount:24*100; 1)
						Else 
							[Order:3]grossMargin:47:=0
						End if 
						[Order:3]shipTotal:30:=Round:C94([Order:3]shipMiscCosts:25+[Order:3]shipAdjustments:26+[Order:3]shipFreightCost:38+0.001; <>tcDecimalTt)
						[Order:3]total:27:=Round:C94([Order:3]amount:24+[Order:3]salesTax:28+[Order:3]shipTotal:30; <>tcDecimalTt)
						C_REAL:C285($ordChange; $amountBackLog)
						If (Record number:C243([Order:3])>-1)
							$amountBackLog:=Sum:C1([OrderLine:49]backOrdAmount:26)
						End if 
						[Order:3]amountBackLog:54:=Round:C94($amountBackLog; <>tcDecimalTt)
						$ordChange:=Round:C94([Order:3]amountBackLog:54-Old:C35([Order:3]amountBackLog:54); <>tcDecimalTt)
						If ($ordChange#0)
							[Customer:2]balanceOpenOrders:78:=Round:C94([Customer:2]balanceOpenOrders:78+$ordChange; <>tcDecimalTt)
						End if 
						If (allowAlerts_boo)
							Pro_FillArray(-5; 3; [Order:3]idNum:2; "")
						End if 
						//End if 
						SAVE RECORD:C53([Order:3])
						<>aLastRecNum{3}:=Record number:C243([Order:3])
					End if 
			End case 
			C_REAL:C285($deltaCost; $IvcDelta; $deltaBal)
			$IvcDelta:=[Invoice:26]amount:14-Old:C35([Invoice:26]amount:14)
			$deltaCost:=[Invoice:26]totalCost:37-Old:C35([Invoice:26]totalCost:37)
			$deltaBal:=[Invoice:26]balanceDue:44-Old:C35([Invoice:26]balanceDue:44)
			If (($IvcDelta#0) | ($deltaCost#0))
				If ([Customer:2]lastSaleDate:49=!00-00-00!)
					TallyCreate(Table:C252(->[AdSource:35]); Field:C253(->[AdSource:35]newResponces:28); [Invoice:26]adSource:52; 0; 1)
					TallyCreate(Table:C252(->[AdSource:35]); Field:C253(->[AdSource:35]num1stOrd:25); [Invoice:26]adSource:52; 0; 1)
					TallyCreate(Table:C252(->[AdSource:35]); Field:C253(->[AdSource:35]value1stOrd:27); [Invoice:26]adSource:52; 0; [Invoice:26]amount:14)
				End if 
				[Customer:2]lastSaleAmount:50:=[Invoice:26]total:18
				[Customer:2]salesYTD:47:=[Customer:2]salesYTD:47+$IvcDelta
				[Customer:2]salesMTD:46:=[Customer:2]salesMTD:46+$IvcDelta
				[Customer:2]costsYTD:75:=[Customer:2]costsYTD:75+$deltaCost
				[Customer:2]costsMTD:76:=[Customer:2]costsMTD:76+$deltaCost
			End if 
			If ($deltaBal#0)
				[Customer:2]tallyStatus:74:=True:C214
			End if 
			If (Is new record:C668([Invoice:26]))
				[Customer:2]lastSaleDate:49:=Current date:C33
			End if 
			If (([Invoice:26]balanceDue:44=0) & ([Invoice:26]datePaid:26=!00-00-00!))
				[Invoice:26]datePaid:26:=Current date:C33
			End if 
			Ledger_InvSave
			//
			If (False:C215)  //added this to build load tags manually.
				//kills the process for the automated scales.
				LT_FillArrayLoadTags(-15)
			End if 
			//
			[Invoice:26]shipAuto:32:=False:C215
			SAVE RECORD:C53([Invoice:26])
			vrOldValue:=[Invoice:26]amount:14
			newInv:=False:C215
			<>aLastRecNum{26}:=Record number:C243([Invoice:26])
			
			INVT_dInvtApply
			IVNT_dRayInit
			
			If (Modified record:C314([Order:3]))
				SAVE RECORD:C53([Order:3])
			End if 
		End if 
		// ??? check which fields have been modified
		If (Modified record:C314([Customer:2]))
			SAVE RECORD:C53([Customer:2])
		End if 
		TallyInventory
		<>aLastRecNum{2}:=Record number:C243([Customer:2])
	End if 
	vMod:=False:C215
	// Modified by: William James (2014-02-12T00:00:00 Subrecord eliminated)
	TransactionValidate
End if 
