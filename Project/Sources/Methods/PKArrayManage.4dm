//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/18/09, 17:37:17
// ----------------------------------------------------
// Method: PKArrayManage
// Description
// 
//// Modified by: williamjames (10/18/09)  Fixed Read Write being locked.
// Parameter
// Modified - 20100202  set [LoadTag]DateCreated to current date
// ----------------------------------------------------
// ### jwm ### 20141211_1132 add WeightTare and WeightProduct
// ### jwm ### 20150126_1514 added new weight arrays


C_LONGINT:C283($1; $2; $3; $incRay; $sizeRay; $diff; $p; $w; $k; $i)
//TRACE
READ WRITE:C146([LoadTag:88])
Case of 
	: ($1=0)
		ARRAY LONGINT:C221(aPKUniqueID; $1)
		ARRAY LONGINT:C221(aPKContainerType; $1)
		ARRAY LONGINT:C221(aPKUniqueIDSuperior; $1)
		ARRAY TEXT:C222(aPKtrackID; $1)
		ARRAY TEXT:C222(aPKStatus; $1)
		ARRAY TEXT:C222(aPKCarrierID; $1)
		ARRAY REAL:C219(aPKWeightExtended; $1)
		ARRAY REAL:C219(aPKValue; $1)
		ARRAY TEXT:C222(aPKInsuranceID; $1)
		ARRAY LONGINT:C221(aPKDTShipOn; $1)
		ARRAY LONGINT:C221(aPKDTReceiveExpected; $1)
		ARRAY LONGINT:C221(aPKDTAssembly; $1)
		ARRAY LONGINT:C221(aPKDTCustoms; $1)
		ARRAY TEXT:C222(aPKTagComments; $1)
		ARRAY TEXT:C222(aPKTagOptions; $1)
		ARRAY TEXT:C222(aPKCustomerVendorID; $1)
		ARRAY LONGINT:C221(aPKdocumentID; $1)
		ARRAY LONGINT:C221(aPKInvoiceNum; $1)
		ARRAY LONGINT:C221(aPKTransactionType; $1)
		//
		ARRAY REAL:C219(aPKCost; $1)
		ARRAY REAL:C219(aPKCostOther; $1)
		ARRAY TEXT:C222(aPKHazzard; $1)
		// ### jwm ### 20150126_1514 added new weight arrays
		ARRAY REAL:C219(aPKWeightProduct; $1)
		ARRAY REAL:C219(aPKWeightTare; $1)
		// 
		ARRAY LONGINT:C221(aShipSel; 0)
	: ($1>0)
		SELECTION TO ARRAY:C260([LoadTag:88]idNum:1; aPKUniqueID; [LoadTag:88]containerType:26; aPKContainerType; [LoadTag:88]ideSuperior:27; aPKUniqueIDSuperior; [LoadTag:88]trackingid:7; aPKtrackID; [LoadTag:88]status:6; aPKStatus; [LoadTag:88]carrierid:8; aPKCarrierID; [LoadTag:88]weightExtended:2; aPKWeightExtended; [LoadTag:88]value:24; aPKValue; [LoadTag:88]insuranceid:16; aPKInsuranceID; [LoadTag:88]idNumInvoice:19; aPKInvoiceNum)
		SELECTION TO ARRAY:C260([LoadTag:88]dtShipOn:10; aPKDTShipOn; [LoadTag:88]dtReceiveExpected:12; aPKDTReceiveExpected; [LoadTag:88]dtAssembly:9; aPKDTAssembly; [LoadTag:88]dtCustoms:11; aPKDTCustoms; [LoadTag:88]comment:22; aPKTagComments; [LoadTag:88]tagOptions:28; aPKTagOptions; [LoadTag:88]customerID:23; aPKCustomerVendorID; [LoadTag:88]documentID:17; aPKdocumentID; [LoadTag:88]transactionType:25; aPKTransactionType)
		SELECTION TO ARRAY:C260([LoadTag:88]costShipment:13; aPKCost; [LoadTag:88]costOther:33; aPKCostOther; [LoadTag:88]hazardClass:20; aPKHazzard; [LoadTag:88]weightProduct:51; aPKWeightProduct; [LoadTag:88]weightTare:50; aPKWeightTare)  // ### jwm ### 20150126_1514 added new weight arrays
		ARRAY LONGINT:C221(aShipSel; 1)
		UNLOAD RECORD:C212([LoadTag:88])
		aShipSel{1}:=1
	: ($1=-1)  //delete an element
		DELETE FROM ARRAY:C228(aPKUniqueID; $2; $3)
		DELETE FROM ARRAY:C228(aPKContainerType; $2; $3)
		DELETE FROM ARRAY:C228(aPKUniqueIDSuperior; $2; $3)
		DELETE FROM ARRAY:C228(aPKtrackID; $2; $3)
		DELETE FROM ARRAY:C228(aPKStatus; $2; $3)
		DELETE FROM ARRAY:C228(aPKCarrierID; $2; $3)
		DELETE FROM ARRAY:C228(aPKWeightExtended; $2; $3)
		DELETE FROM ARRAY:C228(aPKValue; $2; $3)
		DELETE FROM ARRAY:C228(aPKInsuranceID; $2; $3)
		DELETE FROM ARRAY:C228(aPKDTShipOn; $2; $3)
		DELETE FROM ARRAY:C228(aPKDTReceiveExpected; $2; $3)
		DELETE FROM ARRAY:C228(aPKDTAssembly; $2; $3)
		DELETE FROM ARRAY:C228(aPKDTCustoms; $2; $3)
		DELETE FROM ARRAY:C228(aPKTagComments; $2; $3)
		DELETE FROM ARRAY:C228(aPKTagOptions; $2; $3)
		DELETE FROM ARRAY:C228(aPKCustomerVendorID; $2; $3)
		DELETE FROM ARRAY:C228(aPKdocumentID; $2; $3)
		DELETE FROM ARRAY:C228(aPKTransactionType; $2; $3)
		DELETE FROM ARRAY:C228(aPKInvoiceNum; $2; $3)
		
		DELETE FROM ARRAY:C228(aPKCost; $2; $3)
		DELETE FROM ARRAY:C228(aPKCostOther; $2; $3)
		DELETE FROM ARRAY:C228(aPKHazzard; $2; $3)
		// ### jwm ### 20150126_1514 added new weight arrays
		DELETE FROM ARRAY:C228(aPKWeightProduct; $2; $3)
		DELETE FROM ARRAY:C228(aPKWeightTare; $2; $3)
		
		If (Size of array:C274(aPKUniqueID)>0)
			ARRAY LONGINT:C221(aShipSel; 1)
			If ($2=1)
				aShipSel{1}:=1
			Else 
				aShipSel{1}:=$2-1
			End if 
		End if 
	: ($1=-3)  //insert an element 
		INSERT IN ARRAY:C227(aPKUniqueID; $2; $3)
		INSERT IN ARRAY:C227(aPKContainerType; $2; $3)
		INSERT IN ARRAY:C227(aPKUniqueIDSuperior; $2; $3)
		INSERT IN ARRAY:C227(aPKtrackID; $2; $3)
		INSERT IN ARRAY:C227(aPKStatus; $2; $3)
		INSERT IN ARRAY:C227(aPKCarrierID; $2; $3)
		INSERT IN ARRAY:C227(aPKWeightExtended; $2; $3)
		INSERT IN ARRAY:C227(aPKValue; $2; $3)
		INSERT IN ARRAY:C227(aPKInsuranceID; $2; $3)
		INSERT IN ARRAY:C227(aPKDTShipOn; $2; $3)
		INSERT IN ARRAY:C227(aPKDTReceiveExpected; $2; $3)
		INSERT IN ARRAY:C227(aPKDTAssembly; $2; $3)
		INSERT IN ARRAY:C227(aPKDTCustoms; $2; $3)
		INSERT IN ARRAY:C227(aPKTagComments; $2; $3)
		INSERT IN ARRAY:C227(aPKTagOptions; $2; $3)
		INSERT IN ARRAY:C227(aPKCustomerVendorID; $2; $3)
		INSERT IN ARRAY:C227(aPKdocumentID; $2; $3)
		INSERT IN ARRAY:C227(aPKTransactionType; $2; $3)
		INSERT IN ARRAY:C227(aPKInvoiceNum; $2; $3)
		//
		INSERT IN ARRAY:C227(aPKCost; $2; $3)
		INSERT IN ARRAY:C227(aPKCostOther; $2; $3)
		INSERT IN ARRAY:C227(aPKHazzard; $2; $3)
		// ### jwm ### 20150126_1514 added new weight arrays
		INSERT IN ARRAY:C227(aPKWeightProduct; $2; $3)
		INSERT IN ARRAY:C227(aPKWeightTare; $2; $3)
		
		
		ARRAY LONGINT:C221(aShipSel; $3)
		aShipSel{1}:=$2
		
		
	: ($1=-4)  //Fill a record
		If ((aPKUniqueID{$2}>0) & (Not:C34(Is new record:C668([LoadTag:88]))))
			QUERY:C277([LoadTag:88]; [LoadTag:88]idNum:1=aPKUniqueID{$2})
			If (Records in selection:C76([LoadTag:88])=0)
				ALERT:C41("Creating LoadTags in abnormal process")
				CREATE RECORD:C68([LoadTag:88])
				aPKUniqueID{$2}:=[LoadTag:88]idNum:1
			End if 
		Else 
			If (aPKUniqueID{$2}#[LoadTag:88]idNum:1)
				ALERT:C41("Unique ID mismatch")
				//aPKUniqueID{$2}:=[LoadTag]UniqueID
			End if 
		End if 
		[LoadTag:88]containerType:26:=aPKContainerType{$2}
		[LoadTag:88]ideSuperior:27:=aPKUniqueIDSuperior{$2}
		[LoadTag:88]trackingid:7:=aPKtrackID{$2}
		[LoadTag:88]status:6:=aPKStatus{$2}
		[LoadTag:88]carrierid:8:=aPKCarrierID{$2}
		[LoadTag:88]weightExtended:2:=aPKWeightExtended{$2}
		// ### jwm ### 20141211_1132 add WeightTare and WeightProduct
		//[LoadTag]WeightTare:=vrWeightTare  // ### jwm ### 20141211_1123 capture tare weight
		//[LoadTag]WeightProduct:=vrWeightProduct  // ### jwm ### 20141211_1124 capture product weight
		
		// ### jwm ### 20150126_1514 added new weight arrays
		[LoadTag:88]weightProduct:51:=aPKWeightProduct{$2}  // ### jwm ### 20150126_1514 capture product weight
		[LoadTag:88]weightTare:50:=aPKWeightTare{$2}  // ### jwm ### 20150126_1514 capture tare weight
		
		[LoadTag:88]value:24:=aPKValue{$2}
		[LoadTag:88]insuranceid:16:=aPKInsuranceID{$2}
		[LoadTag:88]dtShipOn:10:=aPKDTShipOn{$2}
		If ([LoadTag:88]dtShipOn:10=0)
			[LoadTag:88]dtShipOn:10:=DateTime_Enter
		End if 
		[LoadTag:88]dtReceiveExpected:12:=aPKDTReceiveExpected{$2}
		[LoadTag:88]dtAssembly:9:=aPKDTAssembly{$2}
		If ([LoadTag:88]dtAssembly:9=0)
			[LoadTag:88]dtAssembly:9:=DateTime_Enter
		End if 
		If ([LoadTag:88]dateDocument:39=!00-00-00!)  //###_jwm_### 20100202 Set Date Created
			[LoadTag:88]dateDocument:39:=Current date:C33
		End if 
		[LoadTag:88]dtCustoms:11:=aPKDTCustoms{$2}
		[LoadTag:88]comment:22:=aPKTagComments{$2}
		[LoadTag:88]tagOptions:28:=aPKTagOptions{$2}
		[LoadTag:88]customerID:23:=aPKCustomerVendorID{$2}
		[LoadTag:88]documentID:17:=aPKdocumentID{$2}
		[LoadTag:88]transactionType:25:=aPKTransactionType{$2}
		[LoadTag:88]idNumInvoice:19:=aPKInvoiceNum{$2}
		[LoadTag:88]trackThis:31:=1
		[LoadTag:88]callTag:32:=False:C215
		[LoadTag:88]upsInsureShipping:30:=[Order:3]upsInsureShipping:128
		//
		[LoadTag:88]costShipment:13:=aPKCost{$2}
		[LoadTag:88]costOther:33:=aPKCostOther{$2}
		[LoadTag:88]hazardClass:20:=aPKHazzard{$2}
		// bug hunting on losing [LoadTag]OrderNum in Packing window
		Case of 
			: (aPKTransactionType{$2}=3)
				If (([LoadTag:88]documentID:17=0) & ([LoadTag:88]idNumOrder:29#0))
					TRACE:C157
					[LoadTag:88]documentID:17:=[LoadTag:88]idNumOrder:29
					SAVE RECORD:C53([LoadTag:88])
				End if 
				If ([LoadTag:88]idNumOrder:29=0)  // bug hunting
					[LoadTag:88]idNumOrder:29:=[LoadTag:88]documentID:17
				End if 
			: (aPKTransactionType{$2}=39)
				If (([LoadTag:88]documentID:17=0) & ([LoadTag:88]idNumPO:18#0))
					TRACE:C157
					[LoadTag:88]documentID:17:=[LoadTag:88]idNumPO:18
					SAVE RECORD:C53([LoadTag:88])
				End if 
				If ([LoadTag:88]idNumPO:18=0)
					[LoadTag:88]idNumPO:18:=[LoadTag:88]documentID:17
				End if 
		End case 
		//debug_jwm_20091008
		If (Locked:C147([LoadTag:88]))
			jMessageWindow("LoadTag Record is locked")
		End if 
		SAVE RECORD:C53([LoadTag:88])
		
	: ($1=-5)  //array to selection
		COPY ARRAY:C226(aPKdocumentID; aTmpLong1)
		C_LONGINT:C283($incRay; $cntRay)
		$cntRay:=Size of array:C274(aPKUniqueID)
		For ($incRay; 1; $cntRay)
			If (aPKUniqueID{$incRay}>9)
				QUERY:C277([LoadTag:88]; [LoadTag:88]idNum:1=aPKUniqueID{$incRay})
			Else 
				CREATE RECORD:C68([LoadTag:88])
				aPKUniqueID{$incRay}:=[LoadTag:88]idNum:1
			End if 
			[LoadTag:88]containerType:26:=aPKContainerType{$incRay}
			[LoadTag:88]ideSuperior:27:=aPKUniqueIDSuperior{$incRay}
			[LoadTag:88]trackingid:7:=aPKtrackID{$incRay}
			[LoadTag:88]status:6:=aPKStatus{$incRay}
			[LoadTag:88]carrierid:8:=aPKCarrierID{$incRay}
			[LoadTag:88]weightExtended:2:=aPKWeightExtended{$incRay}
			[LoadTag:88]value:24:=aPKValue{$incRay}
			[LoadTag:88]insuranceid:16:=aPKInsuranceID{$incRay}
			[LoadTag:88]idNumOrder:29:=aTmpLong1{$incRay}
			[LoadTag:88]idNumInvoice:19:=aPKInvoiceNum{$incRay}
			[LoadTag:88]dtShipOn:10:=aPKDTShipOn{$incRay}
			[LoadTag:88]dtReceiveExpected:12:=aPKDTReceiveExpected{$incRay}
			[LoadTag:88]dtAssembly:9:=aPKDTAssembly{$incRay}
			[LoadTag:88]dtCustoms:11:=aPKDTCustoms{$incRay}
			[LoadTag:88]comment:22:=aPKTagComments{$incRay}
			[LoadTag:88]tagOptions:28:=aPKTagOptions{$incRay}
			[LoadTag:88]customerID:23:=aPKCustomerVendorID{$incRay}
			[LoadTag:88]documentID:17:=aPKdocumentID{$incRay}
			[LoadTag:88]transactionType:25:=aPKTransactionType{$incRay}
			[LoadTag:88]costShipment:13:=aPKCost{$incRay}
			[LoadTag:88]costOther:33:=aPKCostOther{$incRay}
			[LoadTag:88]hazardClass:20:=aPKHazzard{$incRay}
			[LoadTag:88]weightProduct:51:=aPKWeightProduct{$incRay}
			[LoadTag:88]weightTare:50:=aPKWeightTare{$incRay}
			SAVE RECORD:C53([LoadTag:88])
		End for 
		// RRAY TO SELECTION(aPKUniqueID;[LoadTag]UniqueID;aPKContainerType;[LoadTag]ContainerType;aPKUniqueIDSuperior;[LoadTag]UniqueIDSuperior;aPKtrackID;[LoadTag]TrackingID;aPKStatus;[LoadTag]Status;aPKCarrierID;[LoadTag]CarrierID;aPKWeightExtended;[LoadTag]WeightExtended;aPKValue;[LoadTag]Value;aPKInsuranceID;[LoadTag]InsuranceID;aTmpLong1;[LoadTag]OrderNum;aPKInvoiceNum;[LoadTag]InvoiceNum)
		// RRAY TO SELECTION(aPKDTShipOn;[LoadTag]DTShipOn;aPKDTReceiveExpected;[LoadTag]DTReceiveExpected;aPKDTAssembly;[LoadTag]DTAssembly;aPKDTCustoms;[LoadTag]DTCustoms;aPKTagComments;[LoadTag]Comment;aPKTagOptions;[LoadTag]TagOptions;aPKCustomerVendorID;[LoadTag]customerID;aPKdocumentID;[LoadTag]documentID;aPKTransactionType;[LoadTag]TransactionType)
		// RRAY TO SELECTION(aPKCost;[LoadTag]CostShipment;aPKCostOther;[LoadTag]CostOther;aPKHazzard;[LoadTag]HazardClass;aPKWeightProduct;[LoadTag]WeightProduct;aPKWeightTare;[LoadTag]WeightTare)  // ### jwm ### 20150126_1514 added new weight arrays
		
		
		
		ARRAY LONGINT:C221(aShipSel; 1)
		
		
		//
	: ($1=-6)  //Update an array
		aPKUniqueID{$2}:=[LoadTag:88]idNum:1
		aPKContainerType{$2}:=[LoadTag:88]containerType:26
		//aPKUniqueIDSuperior{$2}:=[LoadTag]UniqueIDSuperior//make no changes
		aPKtrackID{$2}:=iLo40String1
		aPKStatus{$2}:=[LoadTag:88]status:6
		aPKCarrierID{$2}:=[LoadTag:88]carrierid:8
		aPKWeightExtended{$2}:=[LoadTag:88]weightExtended:2
		aPKValue{$2}:=[LoadTag:88]value:24
		aPKInsuranceID{$2}:=[LoadTag:88]insuranceid:16
		aPKDTShipOn{$2}:=[LoadTag:88]dtShipOn:10
		aPKDTReceiveExpected{$2}:=[LoadTag:88]dtReceiveExpected:12
		aPKDTAssembly{$2}:=[LoadTag:88]dtAssembly:9
		aPKDTCustoms{$2}:=[LoadTag:88]dtCustoms:11
		aPKTagComments{$2}:=[LoadTag:88]comment:22
		aPKTagOptions{$2}:=[LoadTag:88]tagOptions:28
		aPKCustomerVendorID{$2}:=[LoadTag:88]customerID:23
		aPKdocumentID{$2}:=[LoadTag:88]documentID:17
		aPKTransactionType{$2}:=[LoadTag:88]transactionType:25
		aPKInvoiceNum{$2}:=[LoadTag:88]idNumInvoice:19
		//
		aPKCost{$2}:=[LoadTag:88]costShipment:13
		aPKCostOther{$2}:=[LoadTag:88]costOther:33
		aPKHazzard{$2}:=[LoadTag:88]hazardClass:20
		// ### jwm ### 20150126_1514 added new weight arrays
		aPKWeightProduct{$2}:=[LoadTag:88]weightProduct:51  // ### jwm ### 20150126_1514 capture product weight
		aPKWeightTare{$2}:=[LoadTag:88]weightTare:50  // ### jwm ### 20150126_1514 capture tare weight
		
	: ($1=-7)  // Add from Freight Window
		aPKtrackID{$2}:=iLo40String1  //[LoadTag]TrackingID
		aPKStatus{$2}:=iLo20String2  //[LoadTag]Status
		aPKInsuranceID{$2}:=iLo20String3  //[LoadTag]InsuranceID 
		aPKContainerType{$2}:=iLoLongInt1  //[LoadTag]ContainerType
		aPKWeightExtended{$2}:=iLoReal1  //[LoadTag]WeightExtended
		aPKValue{$2}:=iLoReal2  //[LoadTag]Value
		aPKCost{$2}:=iLoReal3  //[LoadTag]CostShipment
		aPKCostOther{$2}:=iLoReal4  //[LoadTag]CostOther
	: ($1=-8)  // Freight Window Area List Selection
		iLo40String1:=aPKtrackID{$2}  //[LoadTag]TrackingID
		iLo20String2:=aPKStatus{$2}  //[LoadTag]Status
		iLo20String3:=aPKInsuranceID{$2}  //[LoadTag]InsuranceID
		iLoLongInt1:=aPKContainerType{$2}  //[LoadTag]ContainerType
		iLoReal1:=aPKWeightExtended{$2}  //[LoadTag]WeightExtended
		iLoReal2:=aPKValue{$2}  //[LoadTag]Value
		iLoReal3:=aPKCost{$2}  //[LoadTag]CostShipment
		iLoReal4:=aPKCostOther{$2}  //[LoadTag]CostOther 
		HIGHLIGHT TEXT:C210(iLo40String1; 1; 40)
	: ($1=-9)  // Freight Window Area List No Selection
		iLo40String1:=""  //[LoadTag]TrackingID
		iLo20String2:=""  //[LoadTag]Status
		iLo20String3:=""  //[LoadTag]InsuranceID
		iLoLongInt1:=1  //[LoadTag]ContainerType
		iLoReal1:=0  //[LoadTag]WeightExtended
		iLoReal2:=0  //[LoadTag]Value
		iLoReal3:=0  //[LoadTag]CostShipment
		iLoReal4:=0  //[LoadTag]CostOther 
End case 
