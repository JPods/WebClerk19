//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/19/12, 17:45:00
// ----------------------------------------------------
// Method: NxPvInvAccess
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_BOOLEAN:C305(vIvcDirect; $0)
C_LONGINT:C283($i; $k)
bNewRec:=0
IvcLnFillRays(0)
vrOldValue:=0



Case of   //coming from an order or add invoice menu, new invoice
	: (((ptTableLast=(->[Order:3])) & (vHere>1) & (Is new record:C668([Invoice:26]))) | ((myCycle>10) & (Record number:C243([Order:3])>-1)))  //coming from the order screen      or from add invoice dialog
		LOAD RECORD:C52([Order:3])
		If (Locked:C147([Order:3]))
			$0:=False:C215
			vnotLocked:=False:C215
		Else 
			$0:=True:C214
			Case of 
				: (myCycle=12)  //Coming from an commission order
					//keep until after the invoice has set the BillToCompany
				: (myCycle=11)  // coming from a product order 
					If ([Order:3]customerID:1#[Customer:2]customerID:1)
						QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
					End if 
					OrdLnFillRays
					<>aLastRecNum{3}:=Record number:C243([Order:3])
					<>aLastRecNum{2}:=Record number:C243([Customer:2])
					//          ShipAddrRay_Set 
					setCustFinance
					
				: (OptKey=1)
					OrdLnShowSub  //reduces aO Order line item arrays to a selected sub-set
			End case 
			
			createInvoice
			Case of 
				: (myCycle=12)  // coming from a commission order 
					[Invoice:26]bill2Company:69:=[Customer:2]company:2
				: (myCycle=11)  // coming from a product order 
					[Invoice:26]siteID:86:=[Order:3]siteID:106
			End case 
			
			newInv:=True:C214
			vMod:=True:C214
			FontSrchLabels(3)
			If (Record number:C243([Order:3])>-1)
				// QUERY([Payment];[Payment]OrderNum=[Order]OrderNum)
				// PayLoadShow (Records in selection([Payment]))
				QUERY:C277([Service:6]; [Service:6]idNumOrder:22=[Order:3]idNum:2)
				UniqueIDPassAlong(->[Service:6]; ->[Service:6]idNumInvoice:23; ->[Invoice:26]idNum:2)
			End if 
		End if 
	: (Is new record:C668([Invoice:26]))  //Invoice Direct
		$0:=True:C214
		// InvoiceNewNoOrder 
		InvoiceNewWithoutOrder
		
		If (Record number:C243([Customer:2])=<>overTheCntr)
			FontSrchLabels(1)
		End if 
		newInv:=True:C214
		vMod:=False:C215
		REDUCE SELECTION:C351([Payment:28]; 0)
		PayLoadShow(0)
		
		InitSalesVar
		invMod:=True:C214
		IvcLn_RaySize(0; 0; 0)  //No Lines at this time    
	: ((ptCurTable=(->[Order:3])) & (vHere>1) & (Locked:C147([Order:3])))
		$0:=False:C215
	Else 
		If (Record number:C243([Invoice:26])>-1)
			<>aLastRecNum{26}:=Record number:C243([Invoice:26])
		End if 
		HIGHLIGHT TEXT:C210(pPartNum; 1; 35)
		$0:=True:C214
		If ([Invoice:26]customerID:3#[Customer:2]customerID:1)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Invoice:26]customerID:3)
		End if   //no order or coming from the order
		
		If ([Invoice:26]idNumOrder:1<10)
			// Direct invoice
			// Modified by: Bill James (2016-08-08T00:00:00 simplify)
		Else 
			// ((ptCurTable=(->[Order])) & ([Invoice]OrderNum=[Order]OrderNum) & (vHere>1))))
			If ([Invoice:26]idNumOrder:1#[Order:3]idNum:2)
				QUERY:C277([Order:3]; [Order:3]idNum:2=[Invoice:26]idNumOrder:1)
			End if 
			OrdLnFillRays
			C_LONGINT:C283($lnTest)
			$lnTest:=MaxValueInArray(->aoLineNum)
			<>aLastRecNum{3}:=Record number:C243([Order:3])
			viInvcLnCnt:=$lnTest  //must be set for both types, orders may have changed, invoice to add
		End if 
		<>aLastRecNum{26}:=Record number:C243([Invoice:26])
		<>aLastRecNum{2}:=Record number:C243([Customer:2])
		If (<>doOrderLines)
			// QUERY([InvoiceLine];[InvoiceLine]InvoiceNum=[Invoice]InvoiceNum)
			IvcLnFillRays(1; 1)  //vLineCnt set inside procedure
		Else 
			IvcLnFillRays  //vLineCnt set if no order
		End if 
		newInv:=False:C215
		myOK:=0
		vMod:=False:C215
		// This is already done in RelatedRelease
		//QUERY([Payment];[Payment]InvoiceNum=[Invoice]InvoiceNum)
		// PayLoadShow (Records in selection([Payment]))
		FontSrchLabels(3)
		C_REAL:C285(vrOldValue)
		vrOldValue:=Old:C35([Invoice:26]amount:14)*Num:C11([Invoice:26]idNumOrder:1=1)
		RunningBalance(->vRunningBal; ->myTrap; [Customer:2]creditLimit:37; [Customer:2]balanceDue:42; 0; [Invoice:26]customerID:3)
End case 
myCycle:=0
