//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-02-08T00:00:00, 17:01:42
// ----------------------------------------------------
// Method: POLn_RaySize
// Description
// Modified: 02/08/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


READ WRITE:C146([POLine:40])

C_LONGINT:C283($1; $2; $3)  //initialize all arrays
If (($1=0) | ($1=2))
	ARRAY REAL:C219(aPOQtyOrder; 0)
	ARRAY REAL:C219(aPOQtyRcvd; 0)
	ARRAY REAL:C219(aPOQtyNow; 0)
	ARRAY TEXT:C222(aPOLnCmplt; 0)
	ARRAY REAL:C219(aPoQtyBL; 0)
	ARRAY TEXT:C222(aPODescpt; 0)
	ARRAY REAL:C219(aPOUnitCost; 0)
	ARRAY REAL:C219(aPODiscnt; 0)
	ARRAY REAL:C219(aPoDscntUP; 0)
	ARRAY REAL:C219(aPOExtCost; 0)
	ARRAY REAL:C219(aPOVATax; 0)
	ARRAY TEXT:C222(aPOTaxable; 0)
	ARRAY TEXT:C222(aPOUnitMeas; 0)
	ARRAY REAL:C219(aPoUnitWt; 0)
	ARRAY REAL:C219(aPoBackLog; 0)
	ARRAY LONGINT:C221(aPOLineNum; 0)
	ARRAY DATE:C224(aPODateExp; 0)
	ARRAY LONGINT:C221(aPOOrdRef; 0)
	ARRAY DATE:C224(aPODateRcvd; 0)
	ARRAY LONGINT:C221(aPOSerialRc; 0)
	ARRAY OBJECT:C1221(aPOSerialNm; 0)
	ARRAY TEXT:C222(aPOVndrAlph; 0)
	ARRAY TEXT:C222(aPoItemNum; 0)
	ARRAY LONGINT:C221(aPOLineAction; 0)
	ARRAY LONGINT:C221(aPoPQBIR; 0)
	ARRAY LONGINT:C221(aPoSeq; 0)
	ARRAY TEXT:C222(aPoLComment; 0)
	ARRAY REAL:C219(aPoNPCosts; 0)
	ARRAY REAL:C219(aPoDuties; 0)
	ARRAY REAL:C219(aPoExtWt; 0)
	
	// array TEXT(aPOOrigItemNum;0)
	// ARRAY LONGINT(aPOOrigUniqueID;0)
	// ARRAY LONGINT(aPOOrigQtyOrder;0)
	
	
	ARRAY REAL:C219(aPoHoldQty; 0)
	ARRAY LONGINT:C221(aPoUniqueID; 0)
	//
	ARRAY LONGINT:C221(aPoDelete; 0)
	//
	ARRAY TEXT:C222(aPOCustRef; 0)
	ARRAY LONGINT:C221(aPoSiteRef; 0)
	If (<>vbDoSrlNums)
		InitPOSrlNmArys
	End if 
End if 
Case of 
	: ($1=2)
		READ ONLY:C145([ItemSerial:47])
		viPOLnCnt:=0
		viBoxCnt:=0
		
		SELECTION TO ARRAY:C260([POLine:40]complete:25; aPOLnCmplt; [POLine:40]qty:3; aPOQtyOrder; \
			[POLine:40]qtyReceived:4; aPOQtyRcvd; [POLine:40]qtyBackLogged:5; aPOQtyBL; \
			[POLine:40]description:6; aPODescpt; [POLine:40]unitCost:7; aPOUnitCost; [POLine:40]discount:8; aPODiscnt; \
			[POLine:40]extendedCost:9; aPOExtCost; [POLine:40]vaTax:10; aPOVATax; [POLine:40]taxJuris:11; aPOTaxable; \
			[POLine:40]unitofMeasure:12; aPOUnitMeas; [POLine:40]backOrderAmount:13; aPoBackLog; \
			[POLine:40]lineNum:14; aPOLineNum; [POLine:40]dateExpected:15; aPODateExp; [POLine:40]idNumOrder:16; aPOOrdRef; \
			[POLine:40]unitWt:29; aPoUnitWt; [POLine:40]dateReceived:17; aPODateRcvd; [POLine:40]serialRc:18; aPOSerialRc; \
			[POLine:40]obSerial:19; aPOSerialNm; [POLine:40]itemNumAlt:20; aPOVndrAlph; [POLine:40]itemNum:2; aPoItemNum; \
			[POLine:40]; aPOLineAction; [POLine:40]seq:21; aPoSeq; [POLine:40]refCustomer:22; aPOCustRef; [POLine:40]siteAdder:26; aPoSiteRef; \
			[POLine:40]comment:27; aPoLComment; [POLine:40]nonProdCosts:28; aPoNPCosts; [POLine:40]duties:30; aPoDuties; \
			[POLine:40]idNum:32; aPoUniqueID; [POLine:40]qtyHold:34; aPoHoldQty)
		SORT ARRAY:C229(aPoSeq; aPOLnCmplt; aPOQtyOrder; aPOQtyRcvd; aPOQtyBL; aPODescpt; aPOUnitCost; \
			aPODiscnt; aPOExtCost; aPOVATax; aPOTaxable; aPOUnitMeas; aPoBackLog; aPOLineNum; aPODateExp; \
			aPOOrdRef; aPoUnitWt; aPODateRcvd; aPOSerialRc; aPOSerialNm; aPOVndrAlph; aPoItemNum; \
			aPOLineAction; aPOCustRef; aPoSiteRef; aPoLComment; aPoNPCosts; aPoDuties; aPoUniqueID; aPoHoldQty)
		
		
		// aPOLnCmplt{$i}:=[POLine]Complete
		// :=[POLine]PONum
		// aPOQtyOrder{$i}:=[POLine]QtyOrdered
		// aPOQtyRcvd{$i}:=[POLine]QtyReceived
		// aPOQtyBL{$i}:=[POLine]QtyBackLogged
		// aPODescpt{$i}:=[POLine]Description
		// aPOUnitCost{$i}:=[POLine]UnitCost
		// aPODiscnt{$i}:=[POLine]Discount
		// aPOExtCost{$i}:=[POLine]ExtendedCost
		// aPOVATax{$i}:=[POLine]VATax
		// aPOTaxable{$i}:=[POLine]taxID
		// aPOUnitMeas{$i}:=[POLine]UnitOfMeasure
		// aPOBackLog{$i}:=[POLine]BackOrderAmount
		// aPOLineNum{$i}:=[POLine]LineNum
		// aPODateExp{$i}:=[POLine]DateExpected
		// aPOOrdRef{$i}:=[POLine]SONum
		// aPoSiteRef{$i}:=[POLine]SiteAdder
		// aPoUnitWt{$i}:=[POLine]UnitWt
		// aPODateRcvd{$i}:=[POLine]DateReceived
		// aPOSerialNm{$i}:=[POLine]SerialNum
		// aPOVndrAlph{$i}:=[POLine]AltItemNum
		// aPoItemNum{$i}:=[POLine]ItemNum
		// aPoSeq{$i}:=[POLine]Sequence
		// aPOSerialRc{$i}:=[POLine]SerialRc
		// aPOCustRef{$i}:=[POLine]RefCustomer
		// :=[POLine]VendorID
		// aTmpText1{$i}:=[POLine]RefVendor
		// aPoLComment{$i}:=[POLine]Comment
		// aPoNPCosts{$i}:=[POLine]NonProdCosts
		// aPoDuties{$i}:=[POLine]Duties
		// aPoUniqueID{$i}:=[POLine]UniqueID
		// aPoHoldQty{$i}:=[POLine]QtyHold
		// aPoDscntUP{$i}:=[POLine]DiscountedCost
		
		//SELECTION TO ARRAY([POLine]Complete;aPOLnCmplt;[POLine]QtyOrdered;aPOQtyOrder;[POLine]QtyReceived;aPOQtyRcvd;[POLine]QtyBackLogged;aPOQtyBL;[POLine]Description;aPODescpt;[POLine]UnitCost;aPOUnitCost;[POLine]Discount;aPODiscnt;[POLine]ExtendedCost;aPOExtCost)
		//SELECTION TO ARRAY([POLine]VATax;aPOVATax;[POLine]taxID;aPOTaxable;[POLine]UnitOfMeasure;aPOUnitMeas;[POLine]BackOrderAmount;aPoBackLog;[POLine]LineNum;aPOLineNum;[POLine]DateExpected;aPODateExp;[POLine]SONum;aPOOrdRef;[POLine]UnitWt;aPoUnitWt)
		//SELECTION TO ARRAY([POLine]DateReceived;aPODateRcvd;[POLine]SerialRc;aPOSerialRc;[POLine]SerialNum;aPOSerialNm;[POLine]AltItemNum;aPOVndrAlph;[POLine]ItemNum;aPoItemNum;[POLine];aPOLineAction;[POLine]Sequence;aPoSeq;[POLine]RefCustomer;aPOCustRef)
		//SELECTION TO ARRAY([POLine]SiteAdder;aPoSiteRef;[POLine]Comment;aPoLComment;[POLine]NonProdCosts;aPoNPCosts;[POLine]Duties;aPoDuties;[POLine]UniqueID;aPoUniqueID;[POLine]QtyHold;aPoHoldQty)
		C_LONGINT:C283($k)
		$k:=Size of array:C274(aPOLnCmplt)
		ARRAY LONGINT:C221(aPoPQBIR; $k)
		ARRAY REAL:C219(aPOQtyNow; $k)
		ARRAY REAL:C219(aPoDscntUP; $k)
		ARRAY REAL:C219(aPoExtWt; $k)
		
		// array TEXT(aPOOrigItemNum;$k)
		// ARRAY LONGINT(aPOOrigUniqueID;$k)
		// ARRAY LONGINT(aPOOrigQtyOrder;$k)
		
		For ($i; 1; $k)
			aPOQtyNow{$i}:=0  // 
			aPoPQBIR{$i}:=0  // 
			// aPOOrigItemNum{$i}:=aPoItemNum{$i}
			// aPOOrigUniqueID{$i}:=aPoUniqueID{$i}
			// aPOOrigQtyOrder{$i}:=aPOQtyOrder{$i}
			poUniqueIDChange:=1
			aPoDscntUP{$i}:=DiscountApply(aPOUnitCost{$i}; aPODiscnt{$i}; <>tcDecimalUC)
			aPoExtWt{$i}:=aPOQtyOrder{$i}*aPoUnitWt{$i}
			If (viPOLnCnt<aPOLineNum{$i})
				viPOLnCnt:=aPOLineNum{$i}
			End if 
			viBoxCnt:=viBoxCnt+aPOQtyOrder{$i}
		End for 
		
		ARRAY LONGINT:C221(aPoDelete; 0)
		
		UNLOAD RECORD:C212([ItemSerial:47])
		READ WRITE:C146([ItemSerial:47])
		If (<>vbDoSrlNums)
			InitPOSrlNmArys
		End if 
		//need this to assure check rays are the same size and value    
	: ($1=-1)  //subtract elements
		//$2  --  aPOLineAction - the position and number of elements
		Ray_DeleteElems($2; $3; ->aPOLnCmplt; ->aPOQtyNow; ->aPOQtyOrder; ->aPOQtyRcvd; ->aPOQtyBL; ->aPODescpt; ->aPOUnitCost; ->aPODiscnt; ->aPoDscntUP)
		Ray_DeleteElems($2; $3; ->aPOExtCost; ->aPOVATax; ->aPOTaxable; ->aPOUnitMeas; ->aPoUnitWt; ->aPoNPCosts; ->aPoDuties)
		Ray_DeleteElems($2; $3; ->aPOBackLog; ->aPOLineNum; ->aPODateExp; ->aPOOrdRef; ->aPODateRcvd; ->aPOSerialRc; ->aPOSerialNm; ->aPOVndrAlph)
		Ray_DeleteElems($2; $3; ->aPoItemNum; ->aPoPQBIR; ->aPOLineAction; ->aPoSeq; ->aPOCustRef; ->aPoSiteRef; ->aPoLComment; ->aPoExtWt; ->aPoUniqueID; ->aPoHoldQty)
	: ($1=1)  //add an element
		Ray_InsertElems($2; $3; ->aPOLnCmplt; ->aPOQtyNow; ->aPOQtyOrder; ->aPOQtyRcvd; ->aPOQtyBL; ->aPODescpt; ->aPOUnitCost; ->aPODiscnt; ->aPoDscntUP)
		Ray_InsertElems($2; $3; ->aPOExtCost; ->aPOVATax; ->aPOTaxable; ->aPOUnitMeas; ->aPoUnitWt; ->aPoNPCosts; ->aPoDuties)
		Ray_InsertElems($2; $3; ->aPOBackLog; ->aPOLineNum; ->aPODateExp; ->aPOOrdRef; ->aPODateRcvd; ->aPOSerialRc; ->aPOSerialNm; ->aPOVndrAlph)
		Ray_InsertElems($2; $3; ->aPoItemNum; ->aPoPQBIR; ->aPOLineAction; ->aPoSeq; ->aPOCustRef; ->aPoSiteRef; ->aPoLComment; ->aPoExtWt; ->aPoUniqueID; ->aPoHoldQty)
		aPoUniqueID{$2}:=-1
	: ($1=3)
		IVNT_dRayInit  // clear to create dInventory
		READ WRITE:C146([POLine:40])
		C_LONGINT:C283($orig; $k; $i)
		$k:=Size of array:C274(aPoDelete)
		For ($i; 1; $k)
			poUniqueIDChange:=1
			QUERY:C277([POLine:40]; [POLine:40]idNum:32=aPoDelete{$i})
			If (Locked:C147([POLine:40]))
				ConsoleLog("[POLine]uniqueID is locked: "+String:C10([POLine:40]idNum:32))
			Else 
				$dCost:=DiscountApply([POLine:40]unitCost:7; [POLine:40]discount:8; <>tcDecimalUC)
				$dOnPo:=[POLine:40]qtyBackLogged:5  //*Num([POLine]QtyBackLogged>0)
				
				// Modified by: William James (2013-06-09T00:00:00)   Inventory Error correction effort
				//  If ([POLine]QtyReceived#0) //  & (vlReceiptID=-1) & (haveReceiptID=False))  // removed the multiple conditions
				
				If ([POLine:40]qtyReceived:4#0)  //  & (vlReceiptID=-1) & (haveReceiptID=False))  
					Invt_dRecCreate("PO"; [PO:39]idNum:5; vlReceiptID; [PO:39]vendorID:1; [PO:39]idNumProject:6; "Void PO Line"; 1; [POLine:40]lineNum:14; [POLine:40]itemNum:2; -[POLine:40]qtyReceived:4; -$dOnPo; $dCost; ""; vsiteID; 0)
					vlReceiptID:=PORcpt_CreateNew([PO:39]idNum:5; [PO:39]vendorID:1)  //  voiding a POLine must cause its associated inventory to rise. 
					// Add a feature to the delete line button that prevents deleting a line that has receipts. Keep this to track if it is missed somewhere.
					
				Else 
					// Modified by: Bill James (2015-04-01T00:00:00 Fixed so a dInventory is created if a POLine is deleted $11 changed to -$dOnPo)
					//Invt_dRecCreate ("PO";[PO]PONum;vlReceiptID;[PO]VendorID;[PO]projectNum;"Void PO Line";1;[POLine]LineNum;[POLine]ItemNum;-[POLine]QtyReceived;0;$dCost;"";vsiteID;0)
					// ### jwm ### 20150720_1921 QQQQQQQQ
					Invt_dRecCreate("PO"; [PO:39]idNum:5; vlReceiptID; [PO:39]vendorID:1; [PO:39]idNumProject:6; "Void PO Line"; 1; [POLine:40]lineNum:14; [POLine:40]itemNum:2; -[POLine:40]qtyReceived:4; -$dOnPo; $dCost; ""; vsiteID; 0)
				End if 
				DELETE RECORD:C58([POLine:40])
			End if 
		End for 
		
		C_LONGINT:C283($dAction)
		$k:=Size of array:C274(aPoUniqueID)
		C_LONGINT:C283($dtEnter)
		$dtEnter:=DateTime_DTTo
		For ($i; 1; $k)
			$dAction:=1
			If (aPoUniqueID{$i}=-3)  // new record
				CREATE RECORD:C68([POLine:40])
				// aPoUniqueID{$i}:=j  CounterNew (->[POLine])
				// Modified by: Bill James (2016-08-08T00:00:00 automatic numbering of [POLine])
				aPoUniqueID{$i}:=[POLine:40]idNum:32
				[POLine:40]itemNum:2:=aPoItemNum{$i}
				[POLine:40]idNumPO:1:=[PO:39]idNum:5
				// Modified by: Bill James (2017-05-22T00:00:00)
				[POLine:40]dtLastSync:36:=$dtEnter
				$dAction:=4  // new line in creating dInventories
				$dOnPo:=aPOQtyBL{$i}*Num:C11(aPOLnCmplt{$i}="")  //*Num(aPOQtyBL{$i}>0)
				//
				If ((aPOQtyRcvd{$i}#0) & (vlReceiptID=-1))
					vlReceiptID:=PORcpt_CreateNew([PO:39]idNum:5; [PO:39]vendorID:1)
				End if 
				Invt_dRecCreate("PO"; [PO:39]idNum:5; vlReceiptID; [PO:39]vendorID:1; [PO:39]idNumProject:6; "+new PO line"; 1; aPoUniqueID{$i}; aPoItemNum{$i}; aPOQtyRcvd{$i}; $dOnPo; aPoDscntUP{$i}; ""; vsiteID; 0)
				
			Else 
				QUERY:C277([POLine:40]; [POLine:40]idNum:32=aPoUniqueID{$i})
				If (Locked:C147([POLine:40]))
					ConsoleLog("[POLine]uniqueID is locked: "+String:C10([POLine:40]idNum:32))
					$dAction:=-1
				Else 
					Case of 
						: ([POLine:40]qtyReceived:4#aPOQtyRcvd{$i})
							$dAction:=3
							$dRec:=aPOQtyRcvd{$i}-[POLine:40]qtyReceived:4
							$dOnPo:=aPOQtyBL{$i}-[POLine:40]qtyBackLogged:5
							$dCost:=DiscountApply(aPOUnitCost{$i}; aPODiscnt{$i}; <>tcDecimalUC)
							If (($dRec#0) & (vlReceiptID=-1))
								vlReceiptID:=PORcpt_CreateNew([PO:39]idNum:5; [PO:39]vendorID:1)
							End if 
							Invt_dRecCreate("PO"; [PO:39]idNum:5; vlReceiptID; [PO:39]vendorID:1; [PO:39]idNumProject:6; "d Inship"; 1; aPoUniqueID{$i}; aPoItemNum{$i}; $dRec; $dOnPo; aPoDscntUP{$i}; ""; vsiteID; 0)
						: ([POLine:40]qty:3#aPOQtyOrder{$i})
							$dAction:=1
							$dRec:=aPOQtyRcvd{$i}-[POLine:40]qtyReceived:4  //aPoOgQOrd{$w}+
							$dOnPo:=aPOQtyBL{$i}-[POLine:40]qtyBackLogged:5
							If (($dRec#0) & (vlReceiptID=-1))
								vlReceiptID:=PORcpt_CreateNew([PO:39]idNum:5; [PO:39]vendorID:1)
							End if 
							Invt_dRecCreate("PO"; [PO:39]idNum:5; vlReceiptID; [PO:39]vendorID:1; [PO:39]idNumProject:6; "d PO Ordered"; $dAction; aPoUniqueID{$i}; aPoItemNum{$i}; $dRec; $dOnPo; aPoDscntUP{$i}; ""; vsiteID; 0)
						: ([POLine:40]qtyBackLogged:5#aPOQtyBL{$i})
							$dAction:=2
							$dOnPo:=aPOQtyBL{$i}-[POLine:40]qtyBackLogged:5
							Invt_dRecCreate("PO"; [PO:39]idNum:5; vlReceiptID; [PO:39]vendorID:1; [PO:39]idNumProject:6; "d PO BL"; 1; aPoUniqueID{$i}; aPoItemNum{$i}; 0; $dOnPo; aPoDscntUP{$i}; ""; vsiteID; 0)
					End case 
				End if 
			End if 
			
			If ($dAction>0)  // apply array except if record in locked
				If (aPODateExp{$i}=!00-00-00!)
					aPODateExp{$i}:=[PO:39]dateNeeded:3
				End if 
				
				
				[POLine:40]vendorID:24:=[PO:39]vendorID:1
				[POLine:40]refVendor:23:=[PO:39]vendorCompany:39
				[POLine:40]complete:25:=aPOLnCmplt{$i}
				
				[POLine:40]seq:21:=aPoSeq{$i}
				
				[POLine:40]qty:3:=aPOQtyOrder{$i}
				[POLine:40]qtyReceived:4:=aPOQtyRcvd{$i}
				[POLine:40]qtyBackLogged:5:=aPOQtyBL{$i}
				[POLine:40]description:6:=aPODescpt{$i}
				[POLine:40]unitCost:7:=aPOUnitCost{$i}
				[POLine:40]discount:8:=aPODiscnt{$i}
				[POLine:40]extendedCost:9:=aPOExtCost{$i}
				[POLine:40]vaTax:10:=aPOVATax{$i}
				[POLine:40]taxJuris:11:=aPOTaxable{$i}
				[POLine:40]unitofMeasure:12:=aPOUnitMeas{$i}
				[POLine:40]backOrderAmount:13:=aPOBackLog{$i}
				[POLine:40]lineNum:14:=aPOLineNum{$i}
				[POLine:40]dateExpected:15:=aPODateExp{$i}
				[POLine:40]idNumOrder:16:=aPOOrdRef{$i}
				[POLine:40]siteAdder:26:=aPoSiteRef{$i}
				[POLine:40]unitWt:29:=aPoUnitWt{$i}
				[POLine:40]dateReceived:17:=aPODateRcvd{$i}
				//[POLine]obSerial:=aPOSerialNm{$i}
				[POLine:40]itemNumAlt:20:=aPOVndrAlph{$i}
				
				[POLine:40]serialRc:18:=aPOSerialRc{$i}
				[POLine:40]refCustomer:22:=aPOCustRef{$i}
				
				[POLine:40]comment:27:=aPoLComment{$i}
				[POLine:40]nonProdCosts:28:=aPoNPCosts{$i}
				[POLine:40]duties:30:=aPoDuties{$i}
				
				[POLine:40]qtyHold:34:=aPoHoldQty{$i}
				[POLine:40]discountedCost:35:=aPoDscntUP{$i}
				SAVE RECORD:C53([POLine:40])
				
				aPOLineAction{$i}:=Record number:C243([POLine:40])
			End if 
			aPOQtyNow{$i}:=0  // reset receiving field
			aPoExtWt{$i}:=aPOQtyOrder{$i}*aPoUnitWt{$i}
		End for 
		
		ARRAY LONGINT:C221(aPoDelete; 0)
End case 

READ ONLY:C145([POLine:40])