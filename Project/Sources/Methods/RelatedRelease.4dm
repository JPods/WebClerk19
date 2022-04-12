//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-08-24T00:00:00, 16:49:15
// ----------------------------------------------------
// Method: RelatedRelease
// Description
// Modified: 08/24/17
// 
// 
//
// Parameters
// ----------------------------------------------------


// qqq replace this with filling in when asked for data.
//  example ds loading  RelateCustomer(0)
//TRACE


If (False:C215)
	C_LONGINT:C283(eItemCust)
	C_LONGINT:C283($1; $overRideNormal)
	If (Count parameters:C259=0)
		$overRideNormal:=0
	Else 
		$overRideNormal:=$1
	End if 
	//Procedure: jrelateClrFiles
	//If (vHere=2)//((Not(autoRelate))&(vHere=2))
	If ((vHere=2) & ($overRideNormal=0))  //(Before)&
		//If (Form event#On Load)//why
		RelatedGet
		//End if 
	Else 
		Case of 
			: (ptCurTable=(->[Customer:2]))  //&(LastCustRec#Record number([Customer])))
				RelateCustomer(0)
				//  //  CHOPPED FillPayArrays(0)
				//  //  CHOPPED FillInvArrays(0)
				//  CHOPPED FillContactArrays(0)
				//  CHOPPED   Ledger_FillRay(0)
				////  //  CHOPPED FillInvArrays (0)
				////  //  CHOPPED FillPayArrays (0)
				
				///  Cust_OpiFillRay(0)
				//  CHOPPED  Cust_OPiRInitAr(0)
				//  CHOPPED  Cust_OPRLInitAr(0)
				//  CHOPPED QA_FillAnswRay(0)
				
				If ([Customer:2]customerID:1#"")
					QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Customer:2]customerID:1; *)
					QUERY:C277([Contact:13]; [Contact:13]dateRetired:57=!00-00-00!)  // ### jwm ### 20171110_1238 hide retired in input layout by default
					
					//  CHOPPED FillContactArrays(Records in selection([Contact]); eContactsAreaList)
					ARRAY TEXT:C222(aElectroZip; 0)  // El_Zip_Fill 
					
				End if 
				REDUCE SELECTION:C351([ItemSerial:47]; 0)
				If (False:C215)
					If (allowAlerts_boo)
						If (eItemCust>0)
							//  --  CHOPPED  AL_UpdateArrays(eContactsAreaList; -2)
							//  --  CHOPPED  AL_UpdateArrays(eCustIvc; -2)
							//  --  CHOPPED  AL_UpdateArrays(eCustPay; 2)
							//  --  CHOPPED  AL_UpdateArrays(eLedgerCust; -2)
							//  --  CHOPPED  AL_UpdateArrays(eItemCust; -2)  //Define Document Area
							//  --  CHOPPED  AL_UpdateArrays(eCustRelate; -2)  //Define AreaList middle
							//  --  CHOPPED  AL_UpdateArrays(eCustRLines; -2)
							//  --  CHOPPED  AL_UpdateArrays(eAnsListCustomers; -2)
							//  --  CHOPPED  AL_UpdateArrays(eListDocuments; -2)
						End if 
					End if 
				End if 
			: ((ptCurTable=(->[Order:3])) & (vHere=2))
				//TRACE
				REDUCE SELECTION:C351([Invoice:26]; 0)
				REDUCE SELECTION:C351([Service:6]; 0)
				REDUCE SELECTION:C351([POLine:40]; 0)
				REDUCE SELECTION:C351([Payment:28]; 0)
				REDUCE SELECTION:C351([LoadTag:88]; 0)
				REDUCE SELECTION:C351([LoadItem:87]; 0)
				//If (eLoadItemsOrders>0)
				////  CHOPPED  AL_UpdateFields (eLoadTagsInvoices;2)
				////  CHOPPED  AL_UpdateFields (eLoadItemsInvoices;2)
				//End if 
				//      If (Records in selection([Customer])>0)
				//       SEARCH([Contact];[Contact]AccountKey=[Order]AccountKey)
				//     End if 
				TC_FillArrays(0)
				MD_FillArrays(0)
				WO_FillArrays(0)
				QUERY:C277([Invoice:26]; [Invoice:26]idNumOrder:1=[Order:3]idNum:2)
			: ((ptCurTable=(->[Invoice:26])) & (vHere=2))
				REDUCE SELECTION:C351([Payment:28]; 0)
				REDUCE SELECTION:C351([Service:6]; 0)
				
				REDUCE SELECTION:C351([LoadTag:88]; 0)
				REDUCE SELECTION:C351([LoadItem:87]; 0)
				//If (eLoadItemsInvoices>0)
				////  CHOPPED  AL_UpdateFields (eLoadTagsInvoices;2)
				////  CHOPPED  AL_UpdateFields (eLoadItemsInvoices;2)
				//End if 
				
			: ((ptCurTable=(->[Proposal:42])) & (vHere=2))
				REDUCE SELECTION:C351([Service:6]; 0)
				REDUCE SELECTION:C351([WorkOrder:66]; 0)
				REDUCE SELECTION:C351([Document:100]; 0)
				REDUCE SELECTION:C351([QA:70]; 0)
				
			: ((ptCurTable=(->[Service:6])) & (vHere=2))
				REDUCE SELECTION:C351([Order:3]; 0)
				REDUCE SELECTION:C351([Proposal:42]; 0)
				REDUCE SELECTION:C351([CallReport:34]; 0)
				REDUCE SELECTION:C351([Invoice:26]; 0)
				
				//      If ([Contact]AccountKey#[Customer]AccountCode)
				//        SEARCH([Contact];[Contact]AccountKey=[Service]AccountKey)
				//      End if 
			: ((ptCurTable=(->[Project:24])) & (vHere=2))
				REDUCE SELECTION:C351([Customer:2]; 0)
				REDUCE SELECTION:C351([Order:3]; 0)
				REDUCE SELECTION:C351([Invoice:26]; 0)
				REDUCE SELECTION:C351([Proposal:42]; 0)
				REDUCE SELECTION:C351([Service:6]; 0)
				REDUCE SELECTION:C351([PO:39]; 0)
				REDUCE SELECTION:C351([InventoryStack:29]; 0)
			: ((ptCurTable=(->[Vendor:38])) & (vHere=2))
				REDUCE SELECTION:C351([ItemSerial:47]; 0)
				REDUCE SELECTION:C351([PO:39]; 0)
				REDUCE SELECTION:C351([POLine:40]; 0)
				REDUCE SELECTION:C351([QA:70]; 0)
				PoArrayManage(0)
				PoLnFillRays(0)
				
				If (ePoLines>0)
					//  --  CHOPPED  AL_UpdateArrays(ePoLines; -2)
				End if 
			: (ptCurTable=(->[Payment:28]))
				REDUCE SELECTION:C351([DCash:62]; 0)
			: (ptCurTable=(->[Control:1]))
				TC_FillArrays(0)
				MD_FillArrays(0)
				WO_FillArrays(0)
				Ray_ZeroElement(->aFCItem; ->aFCBomCnt; ->aFCActionDt; ->aFCBomLevel; ->aFCParent; ->aFCTypeTran; ->aFCDocID; ->aFCDesc; ->aFCRunQty; ->aFCRecNum; ->aFCWho; ->aFCBaseQty; ->aFCTallyYTD; ->aFCTallyLess1Year; ->aFCTallyLess2Year)
				Vnd_FillLwItms(0)
				Itm_FillLowVend(0; 0; 0; 0; 0)
			: (ptCurTable=(->[Contact:13]))
				REDUCE SELECTION:C351([CallReport:34]; 0)
				REDUCE SELECTION:C351([QA:70]; 0)
				REDUCE SELECTION:C351([Document:100]; 0)
				REDUCE SELECTION:C351([Service:6]; 0)
				REDUCE SELECTION:C351([ItemSerial:47]; 0)
				REDUCE SELECTION:C351([Word:99]; 0)
			: (ptCurTable=(->[Item:4]))
				Item_GetSpec
				REDUCE SELECTION:C351([Usage:5]; 0)
				REDUCE SELECTION:C351([ItemXRef:22]; 0)
				REDUCE SELECTION:C351([ItemSerial:47]; 0)
				REDUCE SELECTION:C351([DInventory:36]; 0)
				REDUCE SELECTION:C351([Document:100]; 0)
				REDUCE SELECTION:C351([PriceMatrix:105]; 0)
				REDUCE SELECTION:C351([ItemWarehouse:117]; 0)
				REDUCE SELECTION:C351([BOM:21]; 0)
				REDUCE SELECTION:C351([Word:99]; 0)
				Bom_FillArray(0)
				
				PriceMatrix_FillArrays(0)
				BOM_BuildMom(0)
				iLoReal1:=0  // buckets and locations
				iLoReal2:=0
				iLoReal3:=0
				iLoReal4:=0
				iLoReal5:=0
			: (ptCurTable=(->[Carrier:11]))
				REDUCE SELECTION:C351([CarrierZone:143]; 0)
				REDUCE SELECTION:C351([CarrierWeight:144]; 0)
			: (ptCurTable=(->[SpecialDiscount:44]))  // ### jwm ### 20171219_1447
				QUERY:C277([ItemDiscount:45]; [ItemDiscount:45]specialDiscountsid:1=[SpecialDiscount:44]idNum:4)
		End case 
		
		
	End if 
End if 

