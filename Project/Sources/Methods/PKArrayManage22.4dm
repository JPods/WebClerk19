//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: PKArrayManage
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_LONGINT:C283($1; $2; $3; $incRay; $sizeRay; $diff; $p; $w; $k; $i)
Case of 
	: ($1=0)
		ARRAY LONGINT:C221(aPKUniqueID22; $1)
		ARRAY LONGINT:C221(aPKContainerType22; $1)
		ARRAY LONGINT:C221(aPKUniqueIDSuperior22; $1)
		ARRAY TEXT:C222(aPKtrackID22; $1)
		ARRAY TEXT:C222(aPKStatus22; $1)
		ARRAY TEXT:C222(aPKCarrierID22; $1)
		ARRAY REAL:C219(aPKWeightExtended22; $1)
		ARRAY REAL:C219(aPKWeightPallet22; $1)
		ARRAY REAL:C219(aPKValue22; $1)
		ARRAY TEXT:C222(aPKInsuranceID22; $1)
		ARRAY LONGINT:C221(aPKDTShipOn22; $1)
		ARRAY LONGINT:C221(aPKDTReceiveExpected22; $1)
		ARRAY LONGINT:C221(aPKDTAssembly22; $1)
		ARRAY LONGINT:C221(aPKDTCustoms22; $1)
		ARRAY TEXT:C222(aPKTagComments22; $1)
		ARRAY TEXT:C222(aPKTagOptions22; $1)
		ARRAY TEXT:C222(aPKCustomerVendorID22; $1)
		ARRAY LONGINT:C221(aPKdocumentID22; $1)
		ARRAY LONGINT:C221(aPKInvoiceNum22; $1)
		ARRAY LONGINT:C221(aPKTransactionType22; $1)
		//
		ARRAY REAL:C219(aPKCost22; $1)
		ARRAY REAL:C219(aPKCostOther22; $1)
		ARRAY TEXT:C222(aPKHazzard22; $1)
		// 
		ARRAY LONGINT:C221(aPalletSel; 0)
	: ($1>0)
		SELECTION TO ARRAY:C260([LoadTag:88]idNum:1; aPKUniqueID22; [LoadTag:88]containerType:26; aPKContainerType22; [LoadTag:88]ideSuperior:27; aPKUniqueIDSuperior22; [LoadTag:88]trackingid:7; aPKtrackID22; [LoadTag:88]status:6; aPKStatus22; [LoadTag:88]carrierid:8; aPKCarrierID22; [LoadTag:88]weightExtended:2; aPKWeightExtended22; [LoadTag:88]value:24; aPKValue22; [LoadTag:88]insuranceid:16; aPKInsuranceID22; [LoadTag:88]invoiceNum:19; aPKInvoiceNum22)
		SELECTION TO ARRAY:C260([LoadTag:88]dtShipOn:10; aPKDTShipOn22; [LoadTag:88]dtReceiveExpected:12; aPKDTReceiveExpected22; [LoadTag:88]dtAssembly:9; aPKDTAssembly22; [LoadTag:88]dtCustoms:11; aPKDTCustoms22; [LoadTag:88]comment:22; aPKTagComments22; [LoadTag:88]tagOptions:28; aPKTagOptions22; [LoadTag:88]customerID:23; aPKCustomerVendorID22; [LoadTag:88]documentid:17; aPKdocumentID22; [LoadTag:88]transactionType:25; aPKTransactionType22)
		SELECTION TO ARRAY:C260([LoadTag:88]costShipment:13; aPKCost22; [LoadTag:88]costOther:33; aPKCostOther22; [LoadTag:88]hazardClass:20; aPKHazzard22; [LoadTag:88]weightPalletContainer:35; aPKWeightPallet22)
		ARRAY LONGINT:C221(aPalletSel; 1)
		aPalletSel{1}:=1
	: ($1=-1)  //delete an element
		DELETE FROM ARRAY:C228(aPKUniqueID22; $2; $3)
		DELETE FROM ARRAY:C228(aPKContainerType22; $2; $3)
		DELETE FROM ARRAY:C228(aPKUniqueIDSuperior22; $2; $3)
		DELETE FROM ARRAY:C228(aPKtrackID22; $2; $3)
		DELETE FROM ARRAY:C228(aPKStatus22; $2; $3)
		DELETE FROM ARRAY:C228(aPKCarrierID22; $2; $3)
		DELETE FROM ARRAY:C228(aPKWeightExtended22; $2; $3)
		DELETE FROM ARRAY:C228(aPKWeightPallet22; $2; $3)
		DELETE FROM ARRAY:C228(aPKValue22; $2; $3)
		DELETE FROM ARRAY:C228(aPKInsuranceID22; $2; $3)
		DELETE FROM ARRAY:C228(aPKDTShipOn22; $2; $3)
		DELETE FROM ARRAY:C228(aPKDTReceiveExpected22; $2; $3)
		DELETE FROM ARRAY:C228(aPKDTAssembly22; $2; $3)
		DELETE FROM ARRAY:C228(aPKDTCustoms22; $2; $3)
		DELETE FROM ARRAY:C228(aPKTagComments22; $2; $3)
		DELETE FROM ARRAY:C228(aPKTagOptions22; $2; $3)
		DELETE FROM ARRAY:C228(aPKCustomerVendorID22; $2; $3)
		DELETE FROM ARRAY:C228(aPKdocumentID22; $2; $3)
		DELETE FROM ARRAY:C228(aPKTransactionType22; $2; $3)
		DELETE FROM ARRAY:C228(aPKInvoiceNum22; $2; $3)
		
		DELETE FROM ARRAY:C228(aPKCost22; $2; $3)
		DELETE FROM ARRAY:C228(aPKCostOther22; $2; $3)
		DELETE FROM ARRAY:C228(aPKHazzard22; $2; $3)
		If (Size of array:C274(aPKUniqueID22)>0)
			ARRAY LONGINT:C221(aPalletSel; 1)
			If ($2=1)
				aPalletSel{1}:=1
			Else 
				aPalletSel{1}:=$2-1
			End if 
		End if 
	: ($1=-3)  //insert an element    
		INSERT IN ARRAY:C227(aPKUniqueID22; $2; $3)
		INSERT IN ARRAY:C227(aPKContainerType22; $2; $3)
		INSERT IN ARRAY:C227(aPKUniqueIDSuperior22; $2; $3)
		INSERT IN ARRAY:C227(aPKtrackID22; $2; $3)
		INSERT IN ARRAY:C227(aPKStatus22; $2; $3)
		INSERT IN ARRAY:C227(aPKCarrierID22; $2; $3)
		INSERT IN ARRAY:C227(aPKWeightExtended22; $2; $3)
		INSERT IN ARRAY:C227(aPKWeightPallet22; $2; $3)
		INSERT IN ARRAY:C227(aPKValue22; $2; $3)
		INSERT IN ARRAY:C227(aPKInsuranceID22; $2; $3)
		INSERT IN ARRAY:C227(aPKDTShipOn22; $2; $3)
		INSERT IN ARRAY:C227(aPKDTReceiveExpected22; $2; $3)
		INSERT IN ARRAY:C227(aPKDTAssembly22; $2; $3)
		INSERT IN ARRAY:C227(aPKDTCustoms22; $2; $3)
		INSERT IN ARRAY:C227(aPKTagComments22; $2; $3)
		INSERT IN ARRAY:C227(aPKTagOptions22; $2; $3)
		INSERT IN ARRAY:C227(aPKCustomerVendorID22; $2; $3)
		INSERT IN ARRAY:C227(aPKdocumentID22; $2; $3)
		INSERT IN ARRAY:C227(aPKTransactionType22; $2; $3)
		INSERT IN ARRAY:C227(aPKInvoiceNum22; $2; $3)
		//
		INSERT IN ARRAY:C227(aPKCost22; $2; $3)
		INSERT IN ARRAY:C227(aPKCostOther22; $2; $3)
		INSERT IN ARRAY:C227(aPKHazzard22; $2; $3)
		
		ARRAY LONGINT:C221(aPalletSel; $3)
		aPalletSel{1}:=$2
		
		
	: ($1=-4)  //Fill a record
		If ((aPKUniqueID22{$2}>0) & (Not:C34(Is new record:C668([LoadTag:88]))))
			QUERY:C277([LoadTag:88]; [LoadTag:88]idNum:1=aPKUniqueID22{$2})
			If (Records in selection:C76([LoadTag:88])=0)
				CREATE RECORD:C68([LoadTag:88])
				[LoadTag:88]idNum:1:=aPKUniqueID22{$2}
			End if 
		Else 
			CREATE RECORD:C68([LoadTag:88])
			//[LoadTag]UniqueID:=j  CounterNew (->[LoadTag])
			aPKUniqueID22{$2}:=[LoadTag:88]idNum:1
		End if 
		[LoadTag:88]containerType:26:=aPKContainerType22{$2}
		[LoadTag:88]ideSuperior:27:=aPKUniqueIDSuperior22{$2}
		[LoadTag:88]trackingid:7:=aPKtrackID22{$2}
		[LoadTag:88]status:6:=aPKStatus22{$2}
		[LoadTag:88]carrierid:8:=aPKCarrierID22{$2}
		[LoadTag:88]weightExtended:2:=aPKWeightExtended22{$2}
		[LoadTag:88]weightPalletContainer:35:=aPKWeightPallet22{$2}
		[LoadTag:88]value:24:=aPKValue22{$2}
		[LoadTag:88]insuranceid:16:=aPKInsuranceID22{$2}
		[LoadTag:88]dtShipOn:10:=aPKDTShipOn22{$2}
		[LoadTag:88]dtReceiveExpected:12:=aPKDTReceiveExpected22{$2}
		[LoadTag:88]dtAssembly:9:=aPKDTAssembly22{$2}
		[LoadTag:88]dtCustoms:11:=aPKDTCustoms22{$2}
		[LoadTag:88]comment:22:=aPKTagComments22{$2}
		[LoadTag:88]tagOptions:28:=aPKTagOptions22{$2}
		[LoadTag:88]customerID:23:=aPKCustomerVendorID22{$2}
		[LoadTag:88]documentid:17:=aPKdocumentID22{$2}
		[LoadTag:88]transactionType:25:=aPKTransactionType22{$2}
		[LoadTag:88]invoiceNum:19:=aPKInvoiceNum22{$2}
		[LoadTag:88]trackThis:31:=1
		[LoadTag:88]callTag:32:=False:C215
		
		//
		[LoadTag:88]costShipment:13:=aPKCost22{$2}
		[LoadTag:88]costOther:33:=aPKCostOther22{$2}
		[LoadTag:88]hazardClass:20:=aPKHazzard22{$2}
		Case of 
			: (aPKTransactionType22{$2}=3)
				If (([LoadTag:88]documentid:17=0) & ([LoadTag:88]orderNum:29#0))
					TRACE:C157
				End if 
				If ([LoadTag:88]orderNum:29=0)
					[LoadTag:88]orderNum:29:=[LoadTag:88]documentid:17
				End if 
				[LoadTag:88]upsInsureShipping:30:=[Order:3]upsInsureShipping:128
			: (aPKTransactionType22{$2}=39)
				[LoadTag:88]poNum:18:=[LoadTag:88]documentid:17
				[LoadTag:88]upsInsureShipping:30:=True:C214
		End case 
		SAVE RECORD:C53([LoadTag:88])
		
	: ($1=-5)  //array to selection
		// ### bj ### 20181212_2142
		// not called but get rid of this
		COPY ARRAY:C226(aPKdocumentID; aTmpLong1)
		ARRAY TO SELECTION:C261(aPKUniqueID22; [LoadTag:88]idNum:1; aPKContainerType22; [LoadTag:88]containerType:26; aPKUniqueIDSuperior22; [LoadTag:88]ideSuperior:27; aPKtrackID22; [LoadTag:88]trackingid:7; aPKStatus22; [LoadTag:88]status:6; aPKCarrierID22; [LoadTag:88]carrierid:8; aPKWeightExtended22; [LoadTag:88]weightExtended:2; aPKValue22; [LoadTag:88]value:24; aPKInsuranceID22; [LoadTag:88]insuranceid:16; aTmpLong122; [LoadTag:88]orderNum:29; aPKInvoiceNum22; [LoadTag:88]invoiceNum:19)
		ARRAY TO SELECTION:C261(aPKDTShipOn22; [LoadTag:88]dtShipOn:10; aPKDTReceiveExpected22; [LoadTag:88]dtReceiveExpected:12; aPKDTAssembly22; [LoadTag:88]dtAssembly:9; aPKDTCustoms22; [LoadTag:88]dtCustoms:11; aPKTagComments22; [LoadTag:88]comment:22; aPKTagOptions22; [LoadTag:88]tagOptions:28; aPKCustomerVendorID22; [LoadTag:88]customerID:23; aPKdocumentID22; [LoadTag:88]documentid:17; aPKTransactionType22; [LoadTag:88]transactionType:25)
		ARRAY TO SELECTION:C261(aPKCost22; [LoadTag:88]costShipment:13; aPKCostOther22; [LoadTag:88]costOther:33; aPKHazzard22; [LoadTag:88]hazardClass:20; aPKWeightPallet22; [LoadTag:88]weightPalletContainer:35)
		
		
		// [LoadTag]UniqueID:=aPKUniqueID22{$incRay}
		// [LoadTag]ContainerType:=aPKContainerType22{$incRay}
		// [LoadTag]UniqueIDSuperior:=aPKUniqueIDSuperior22{$incRay}
		// [LoadTag]TrackingID:=aPKtrackID22{$incRay}
		// [LoadTag]Status:=aPKStatus22{$incRay}
		// [LoadTag]CarrierID:=aPKCarrierID22{$incRay}
		// [LoadTag]WeightExtended:=aPKWeightExtended22{$incRay}
		// [LoadTag]Value:=aPKValue22{$incRay}
		// [LoadTag]InsuranceID:=aPKInsuranceID22{$incRay}
		// [LoadTag]OrderNum:=aTmpLong122{$incRay}
		// [LoadTag]InvoiceNum):=aPKInvoiceNum22{$incRay}
		// [LoadTag]DTShipOn:=aPKDTShipOn22{$incRay}
		// [LoadTag]DTReceiveExpected:=aPKDTReceiveExpected22{$incRay}
		// [LoadTag]DTAssembly:=aPKDTAssembly22{$incRay}
		// [LoadTag]DTCustoms:=aPKDTCustoms22{$incRay}
		// [LoadTag]Comment:=aPKTagComments22{$incRay}
		// [LoadTag]TagOptions:=aPKTagOptions22{$incRay}
		// [LoadTag]customerID:=aPKCustomerVendorID22{$incRay}
		// [LoadTag]documentID:=aPKdocumentID22{$incRay}
		// [LoadTag]TransactionType):=aPKTransactionType22{$incRay}
		// [LoadTag]CostShipment:=aPKCost22{$incRay}
		// [LoadTag]CostOther:=aPKCostOther22{$incRay}
		// [LoadTag]HazardClass:=aPKHazzard22{$incRay}
		// [LoadTag]WeightPalletContainer):=aPKWeightPallet22{$incRay}
		
		
		
		//
	: ($1=-6)  //Update an array
		aPKUniqueID22{$2}:=[LoadTag:88]idNum:1
		aPKContainerType22{$2}:=[LoadTag:88]containerType:26
		//aPKUniqueIDSuperior22{$2}:=[LoadTag]UniqueIDSuperior//make no changes
		aPKtrackID22{$2}:=iLo20String1
		aPKStatus22{$2}:=[LoadTag:88]status:6
		aPKCarrierID22{$2}:=[LoadTag:88]carrierid:8
		aPKWeightExtended22{$2}:=[LoadTag:88]weightExtended:2
		aPKValue22{$2}:=[LoadTag:88]value:24
		aPKInsuranceID22{$2}:=[LoadTag:88]insuranceid:16
		aPKDTShipOn22{$2}:=[LoadTag:88]dtShipOn:10
		aPKDTReceiveExpected22{$2}:=[LoadTag:88]dtReceiveExpected:12
		aPKDTAssembly22{$2}:=[LoadTag:88]dtAssembly:9
		aPKDTCustoms22{$2}:=[LoadTag:88]dtCustoms:11
		aPKTagComments22{$2}:=[LoadTag:88]comment:22
		aPKTagOptions22{$2}:=[LoadTag:88]tagOptions:28
		aPKCustomerVendorID22{$2}:=[LoadTag:88]customerID:23
		aPKdocumentID22{$2}:=[LoadTag:88]documentid:17
		aPKTransactionType22{$2}:=[LoadTag:88]transactionType:25
		aPKInvoiceNum22{$2}:=[LoadTag:88]invoiceNum:19
		//
		aPKCost22{$2}:=[LoadTag:88]costShipment:13
		aPKCostOther22{$2}:=[LoadTag:88]costOther:33
		aPKHazzard22{$2}:=[LoadTag:88]hazardClass:20
	: ($1=-7)
		aPKtrackID22{$2}:=iLo20String1  //[LoadTag]TrackingID
		aPKStatus22{$2}:=iLo20String2  //[LoadTag]Status
		aPKInsuranceID22{$2}:=iLo20String3  //[LoadTag]InsuranceID    
		aPKContainerType22{$2}:=iLoLongInt1  //[LoadTag]ContainerType
		aPKWeightExtended22{$2}:=iLoReal1  //[LoadTag]WeightExtended
		aPKWeightPallet22{$2}:=iLoReal5  //[LoadTag]WeightPalletContainer
		aPKValue22{$2}:=iLoReal2  //[LoadTag]Value
		aPKCost22{$2}:=iLoReal3  //[LoadTag]CostShipment
		aPKCostOther22{$2}:=iLoReal4  //[LoadTag]CostOther
	: ($1=-8)
		iLo20String1:=aPKtrackID22{$2}  //[LoadTag]TrackingID
		iLo20String2:=aPKStatus22{$2}  //[LoadTag]Status
		iLo20String3:=aPKInsuranceID22{$2}  //[LoadTag]InsuranceID
		iLoLongInt1:=aPKContainerType22{$2}  //[LoadTag]ContainerType
		iLoReal1:=aPKWeightExtended22{$2}  //[LoadTag]WeightExtended
		iLoReal5:=aPKWeightPallet22{$2}  //[LoadTag]WeightPalletContainer
		iLoReal2:=aPKValue22{$2}  //[LoadTag]Value
		iLoReal3:=aPKCost22{$2}  //[LoadTag]CostShipment
		iLoReal4:=aPKCostOther22{$2}  //[LoadTag]CostOther   
	: ($1=-9)
		iLo20String1:=""  //[LoadTag]TrackingID
		iLo20String2:=""  //[LoadTag]Status
		iLo20String3:=""  //[LoadTag]InsuranceID
		iLoLongInt1:=1  //[LoadTag]ContainerType
		iLoReal1:=0  //[LoadTag]WeightExtended
		iLoReal2:=0  //[LoadTag]Value
		iLoReal3:=0  //[LoadTag]CostShipment
		iLoReal4:=0  //[LoadTag]CostOther     
		iLoReal5:=0  //[LoadTag]WeightPalletContainer 
End case 