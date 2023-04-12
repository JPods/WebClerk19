//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/17/11, 15:38:37
// ----------------------------------------------------
// Method: acceptOrders
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_BOOLEAN:C305($1)
C_LONGINT:C283($0)
C_REAL:C285($ordChange)
If (booAccept=True:C214)
	//TRACE
	If ((<>tcMONEYCHAR#strCurrency) & (<>tcMONEYCHAR#"") & ([Order:3]exchangeRate:68#1) & ([Order:3]exchangeRate:68#0))
		vMod:=True:C214
		Exch_FillRays
	End if 
	If (Is new record:C668([Customer:2]))
		TallyCreate(Table:C252(->[AdSource:35]); Field:C253(->[AdSource:35]newResponces:28); [Customer:2]adSource:62; 0; 1)
		//Data_ArchiveOld(process_o.oldCustomer)
		Data_ArchiveOld
		//acceptFilePt ($unLoad;->[Customer];->[Contact];->[Service];->[ReferencesTable];->[CallReport])
		//acceptFilePt ($unLoad;->[OrderLine];->[Order];->[Invoice];->[Proposal];->[InvoiceLine])
	End if 
	If (Modified record:C314([Customer:2]))
		SAVE RECORD:C53([Customer:2])
	End if 
	<>aLastRecNum{2}:=Record number:C243([Customer:2])
	//If (vbdWos)
	//WO_FillArrays (-5)
	//End if 
	If ((Modified record:C314([Order:3])) | (vMod))
		$okToSave:=OrderInvoiceLineMisMatch
		If ($okToSave)
			IVNT_dRayInit
			Accept_CalcStat(->[Order:3]; True:C214; ->aOQtyShip; ->aOQtyBL)
			
			vMod:=calcOrder(True:C214)
			OrdLineCalc
			//  
			If (allowAlerts_boo)
				Pro_FillArray(-5; 3; [Order:3]idNum:2; "")
			End if 
			//
			INVT_dInvtApply
			If (newOrd)
				If ([Customer:2]lastSaleDate:49=!00-00-00!)
					TallyCreate(Table:C252(->[AdSource:35]); Field:C253(->[AdSource:35]newResponces:28); [Order:3]adSource:41; 0; 1)
					TallyCreate(Table:C252(->[AdSource:35]); Field:C253(->[AdSource:35]num1stOrd:25); [Order:3]adSource:41; 0; 1)
					TallyCreate(Table:C252(->[AdSource:35]); Field:C253(->[AdSource:35]value1stOrd:27); [Order:3]adSource:41; 0; [Order:3]amount:24)
				End if 
				If (Not:C34(Locked:C147([Customer:2])))
					[Customer:2]lastSaleDate:49:=Current date:C33
					[Customer:2]lastSaleAmount:50:=[Order:3]amount:24
				End if 
			End if 
			
			$ordChange:=Round:C94([Order:3]amountBackLog:54-Old:C35([Order:3]amountBackLog:54); <>tcDecimalTt)
			If ([Order:3]idNum:2=0)
				TRACE:C157
				// ### bj ### 20210217_1550
				// This should never happen
				CREATE RECORD:C68([TallyResult:73])
				[TallyResult:73]name:1:="ZeroOrder"
				[TallyResult:73]purpose:2:="Error"
				[TallyResult:73]dateCreated:53:=Current date:C33
				[TallyResult:73]dtReport:12:=DateTime_DTTo
				[Order:3]idNum:2:=CounterNew(->[Order:3])
				
				[Order:3]comment:33:="ZeroOrder"+"\r"+[Order:3]comment:33
				SAVE RECORD:C53([TallyResult:73])
				ConsoleLog("Error: zero orderNum converted to "+String:C10([Order:3]idNum:2))
			End if 
			SAVE RECORD:C53([Order:3])
			vrOldValue:=[Order:3]amount:24
			newOrd:=False:C215
			IVNT_dRayInit
			
			TallyInventory
		End if 
		If ($ordChange#0)
			[Customer:2]balanceOpenOrders:78:=Round:C94([Customer:2]balanceOpenOrders:78+$ordChange; <>tcDecimalTt)
		End if 
		
	End if 
	If (Modified record:C314([Customer:2]))
		SAVE RECORD:C53([Customer:2])
	End if 
	<>aLastRecNum{3}:=Record number:C243([Order:3])
	<>aLastRecNum{2}:=Record number:C243([Customer:2])
	UNLOAD RECORD:C212([Item:4])
	vMod:=False:C215
	// Modified by: William James (2014-02-12T00:00:00 Subrecord eliminated)
	TransactionValidate
End if 
