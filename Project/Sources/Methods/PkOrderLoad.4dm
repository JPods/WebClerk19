//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-17T00:00:00, 11:51:05
// ----------------------------------------------------
// Method: PkOrderLoad
// Description
// Modified: 01/17/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


iLoText1:=""  //clear any existing error message
C_LONGINT:C283($2; $1; $lastRecordNum; LastOrderNum)
//$1 - [Order]OrderNum
//$2 - arealist eOrdList

$lastRecordNum:=Record number:C243([Order:3])
LastOrderNum:=[Order:3]idNum:2  //###_jwm_### 20081212 Used in TallyMaster script
QUERY:C277([Order:3]; [Order:3]idNum:2=$1)
LOAD RECORD:C52([Order:3])
READ WRITE:C146([OrderLine:49])  // ### jwm ### 20160318_1820
TransactionStart(->[Order:3])

Case of 
	: (Locked:C147([Order:3]))
		If ($lastRecordNum>-1)
			GOTO RECORD:C242([Order:3]; $lastRecordNum)
		End if 
		<>pkScaleComment:="Locked by another user: "+String:C10($1)
		//ALERT("Order "+String($1)+" is LOCKED and CANNOT be processed.")
		LockedNotice(->[Order:3]; "Order not loaded.")
	: (Records in selection:C76([Order:3])=1)
		bLoadRecord:=True:C214
		Execute_TallyMaster("Orders_OnLoad"; "Control_Packing"; 1)
		If (bLoadRecord)
			If (([Order:3]alertMessage:80#"") & (allowAlerts_boo))
				ALERT:C41([Order:3]alertMessage:80)
			End if 
			C_LONGINT:C283(<>orderPacking)
			<>orderPacking:=[Order:3]idNum:2
			UNLOAD RECORD:C212([Customer:2])
			C_LONGINT:C283($found)
			$found:=Prs_CheckRunnin("PalletsContainers")
			If ($found>0)
				POST OUTSIDE CALL:C329(<>aPrsNum{$found})
			End if 
			//TRACE
			//
			OrdLnFillRays
			$k:=Size of array:C274(aOLineAction)
			C_LONGINT:C283($i; $k)
			ARRAY REAL:C219(aOQtyPack; $k)
			READ ONLY:C145([Item:4])
			For ($i; 1; $k)
				QUERY:C277([Item:4]; [Item:4]itemNum:1=aOItemNum{$i})
				If (Records in selection:C76([Item:4])=1)
					aOUnitWt{$i}:=[Item:4]weightAverage:8
				End if 
				aOQtyPack{$i}:=0
				aOQtyOpen{$i}:=[Item:4]qtyOnHand:14-[Item:4]qtyOnSalesOrder:16
				
			End for 
			READ ONLY:C145([Item:4])
			REDUCE SELECTION:C351([Item:4]; 0)
			//
			//Fill Load Tags
			QUERY:C277([LoadTag:88]; [LoadTag:88]documentID:17=[Order:3]idNum:2; *)
			QUERY:C277([LoadTag:88];  & [LoadTag:88]containerType:26<2)
			PKArrayManage(Records in selection:C76([LoadTag:88]))
			If (eShipList>0)
				//  --  CHOPPED  AL_UpdateArrays(eShipList; -2)
			End if 
			//
			//TRACE
			PKListPalletsAvailable([Order:3]customerID:1)
			//
			// QUERY([LoadItem];[LoadItem]OrderNum=[Order]OrderNum)
			REDUCE SELECTION:C351([LoadItem:87]; 0)
			LT_FillArrayLoadItems(Records in selection:C76([LoadItem:87]))
			If (eLoadList>0)
				//  --  CHOPPED  AL_UpdateArrays(eLoadList; -2)
			End if 
			
			// Modified by: Bill James (2017-05-01T00:00:00)
			// hide voided invoices from packing window
			QUERY:C277([Invoice:26]; [Invoice:26]idNumOrder:1=[Order:3]idNum:2; *)
			QUERY:C277([Invoice:26];  & ; [Invoice:26]terms:24#"Void@")
			PKInvoiceFillArrays(Records in selection:C76([Invoice:26]); 0; 0; eInvoiceList)  //eInvoiceList)  
		End if 
	Else 
		OrdLnRays(0)
		ARRAY REAL:C219(aOQtyPack; 0)
		
End case 

If ($2>0)
	PKSetColor(eOrdList; ->aOItemNum)  //###_jwm_### 20101014
	////  --  CHOPPED  AL_UpdateArrays ($2;-2)  in PKSetColor
End if 
