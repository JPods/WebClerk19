//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 04/02/13, 19:58:52
// ----------------------------------------------------
// Method: PpLn_RaySize
// Description
//  SEE: PpLn_AddAsRecord for adding a ProposalDirectly from the Web
//
// Parameters
// ----------------------------------------------------

Case of 
	: ($1=0)
		PpLnInitRays
	: ($1=2)  //fill arrays with record values
		
		//  SELECTION TO ARRAY([ProposalLine];aPLineAction;[ProposalLine]ItemNum;aPItemNum;[ProposalLine]AltItemNum;aPAltItem;[ProposalLine]Qty;aPQtyOrder;
		//  [ProposalLine]Description;aPDescpt;[ProposalLine]CalculateLine;aPBooUse;[ProposalLine]UnitPrice;aPUnitPrice;[ProposalLine]Discount;aPDiscnt;
		//  [ProposalLine]ExtendedPrice;aPExtPrice;[ProposalLine]taxID;aPTaxable;[ProposalLine]SalesTax;aPSaleTax;[ProposalLine]TaxCost;aPTaxCost;
		//  [ProposalLine]UnitWeight;aPUnitWt;[ProposalLine]ExtendedWt;aPExtWt;[ProposalLine]UnitCost;aPUnitCost;[ProposalLine]ExtendedCost;aPExtCost;
		//  [ProposalLine]DateExpected;aPDateExp;[ProposalLine]UniqueID;aPUniqueID;[ProposalLine]CommRateRep;aPRepRate;[ProposalLine]CommRep;aPRepComm;
		//  [ProposalLine]CommRateSales;aPSalesRate;[ProposalLine]CommSales;aPSaleComm;[ProposalLine]Leadtime;aPLeadTime;[ProposalLine]PrintNot;aPPrintThis;
		//  [ProposalLine]Location;aPLocation;[ProposalLine]SaleUnitofMeas;aPUnitMeas;[ProposalLine]Serialized;aPSerial;[ProposalLine]TypeSale;aPPricePt;
		//  [ProposalLine]Sequence;aPSeq;[ProposalLine]QtyOpen;aPQtyOpen;[ProposalLine]ProducedBy;aPProdBy;[ProposalLine]Comment;aPLnComment;
		//  [ProposalLine]Profile1;aPProfile1;[ProposalLine]Profile2;aPProfile2;[ProposalLine]Profile3;aPProfile3;[ProposalLine]LineNum;aPLineNum;[ProposalLine]LocationBin;aPLocationBin)
		
		
		ARRAY BOOLEAN:C223($aPBooUse; 0)
		SELECTION TO ARRAY:C260([ProposalLine:43]; aPLineAction; [ProposalLine:43]itemNum:2; aPItemNum; [ProposalLine:43]altItemNum:34; aPAltItem; [ProposalLine:43]qty:3; aPQtyOrder; [ProposalLine:43]description:4; aPDescpt; [ProposalLine:43]calculateLine:20; $aPBooUse; [ProposalLine:43]unitPrice:15; aPUnitPrice; [ProposalLine:43]discount:17; aPDiscnt; [ProposalLine:43]extendedPrice:16; aPExtPrice; [ProposalLine:43]taxJuris:14; aPTaxable; [ProposalLine:43]salesTax:18; aPSaleTax; [ProposalLine:43]taxCost:53; aPTaxCost; [ProposalLine:43]unitWeight:22; aPUnitWt; [ProposalLine:43]extendedWt:19; aPExtWt; [ProposalLine:43]unitCost:7; aPUnitCost; [ProposalLine:43]extendedCost:8; aPExtCost; [ProposalLine:43]dateExpected:41; aPDateExp; [ProposalLine:43]idNum:52; aPUniqueID; [ProposalLine:43]commRateRep:27; aPRepRate; [ProposalLine:43]commRep:28; aPRepComm; [ProposalLine:43]commRateSales:21; aPSalesRate; [ProposalLine:43]commSales:29; aPSaleComm; [ProposalLine:43]leadTime:26; aPLeadTime; [ProposalLine:43]printNot:54; aPPrintThis; [ProposalLine:43]location:12; aPLocation; [ProposalLine:43]unitofMeasure:13; aPUnitMeas; [ProposalLine:43]serialized:31; aPSerial; [ProposalLine:43]typeSale:32; aPPricePt; [ProposalLine:43]seq:33; aPSeq; [ProposalLine:43]qtyOpen:51; aPQtyOpen; [ProposalLine:43]producedBy:36; aPProdBy; [ProposalLine:43]comment:37; aPLnComment; [ProposalLine:43]profile1:38; aPProfile1; [ProposalLine:43]profile2:39; aPProfile2; [ProposalLine:43]profile3:40; aPProfile3; [ProposalLine:43]lineNum:43; aPLineNum; [ProposalLine:43]locationBin:55; aPLocationBin)
		C_LONGINT:C283($i; $k)
		$k:=Size of array:C274($aPBooUse)
		ARRAY TEXT:C222(aPUse; $k)
		ARRAY LONGINT:C221(aPPQDiR; $k)
		ARRAY REAL:C219(aPDscntUP; $k)
		viBoxCnt:=0
		For ($i; 1; $k)  // added from PpLnFillRays
			aPUse{$i}:=Num:C11($aPBooUse{$i})*"x"
			aPPQDiR{$i}:=-1
			aPDscntUP{$i}:=DiscountApply(aPUnitPrice{$i}; aPDiscnt{$i}; <>tcDecimalUP)
			viBoxCnt:=viBoxCnt+aPQtyOrder{$i}
		End for 
		
		If (False:C215)  // from PpLnFillRays
			$k:=Size of array:C274(aPItemNum)
			ARRAY TEXT:C222(aPUse; $k)
			ARRAY LONGINT:C221(aPPQDiR; $k)
			ARRAY REAL:C219(aPDscntUP; $k)
			//
			//ARRAY LONGINT(aPpOgRec;$k)  //Original record count
			//
			For ($i; 1; $k)  //Size of array(aPItemNum))
				
				aPPQDiR{$i}:=-1
				aPDscntUP{$i}:=DiscountApply(aPUnitPrice{$i}; aPDiscnt{$i}; <>tcDecimalUP)
				viBoxCnt:=viBoxCnt+aPQtyOrder{$i}
				//
				If (viPrplLnCnt<aPLineNum{$i})
					viPrplLnCnt:=aPLineNum{$i}
				End if 
			End for 
			For ($i; 1; $k)
				If (aPLineNum{$i}<=0)
					viPrplLnCnt:=viPrplLnCnt+1
					aPLineNum{$i}:=viPrplLnCnt
				End if 
			End for 
			ARRAY BOOLEAN:C223(aPBooUse; 0)
		End if 
		
		COPY ARRAY:C226(aPQtyOrder; aPQtyOriginal)
		If (Size of array:C274(aPSeq)>1)
			SORT ARRAY:C229(aPSeq; aPItemNum; aPAltItem; aPQtyOrder; aPDescpt; aPUnitPrice; aPDiscnt; aPDscntUP; aPExtPrice; aPTaxable; aPSaleTax; aPUnitWt; aPQtyOriginal; aPLocationBin; aPExtWt; aPUnitCost; aPExtCost; aPSaleComm; aPSalesRate; aPRepComm; aPRepRate; aPLeadTime; aPLocation; aPUnitMeas; aPDateExp; aPPrintThis; aPTaxCost; aPLineAction; aPUse; aPQtyOpen; aPPQDiR; aPSerial; aPPricePt; aPLineNum; aPProdBy; aPLnComment; aPProfile1; aPProfile2; aPProfile3; aPUniqueID)
		End if 
		
		//SELECTION TO ARRAY([ProposalLine];aPLineAction;[ProposalLine]ItemNum;aPItemNum;[ProposalLine]AltItemNum;aPAltItem;[ProposalLine]Qty;aPQtyOrder;[ProposalLine]Description;aPDescpt;[ProposalLine]CalculateLine;aPBooUse)
		//SELECTION TO ARRAY([ProposalLine]UnitPrice;aPUnitPrice;[ProposalLine]Discount;aPDiscnt;[ProposalLine]ExtendedPrice;aPExtPrice;[ProposalLine]taxID;aPTaxable;[ProposalLine]SalesTax;aPSaleTax;[ProposalLine]TaxCost;aPTaxCost)
		//SELECTION TO ARRAY([ProposalLine]UnitWeight;aPUnitWt;[ProposalLine]ExtendedWt;aPExtWt;[ProposalLine]UnitCost;aPUnitCost;[ProposalLine]ExtendedCost;aPExtCost;[ProposalLine]DateExpected;aPDateExp;[ProposalLine]UniqueID;aPUniqueID)
		//SELECTION TO ARRAY([ProposalLine]CommRateRep;aPRepRate;[ProposalLine]CommRep;aPRepComm;[ProposalLine]CommRateSales;aPSalesRate;[ProposalLine]CommSales;aPSaleComm;[ProposalLine]Leadtime;aPLeadTime;[ProposalLine]PrintNot;aPPrintThis)
		//SELECTION TO ARRAY([ProposalLine]Location;aPLocation;[ProposalLine]SaleUnitofMeas;aPUnitMeas;[ProposalLine]Serialized;aPSerial;[ProposalLine]TypeSale;aPPricePt;[ProposalLine]Sequence;aPSeq;[ProposalLine]QtyOpen;aPQtyOpen)
		//SELECTION TO ARRAY([ProposalLine]ProducedBy;aPProdBy;[ProposalLine]Comment;aPLnComment;[ProposalLine]Profile1;aPProfile1;[ProposalLine]Profile2;aPProfile2;[ProposalLine]Profile3;aPProfile3;[ProposalLine]LineNum;aPLineNum;[ProposalLine]LocationBin;aPLocationBin)
		
		
		
	: ($1=-1)  //subtract elements
		//$2  --  aPOLineAction - the position and number of elements
		Ray_DeleteElems($2; $3; ->aPItemNum; ->aPAltItem; ->aPQtyOrder; ->aPDescpt; ->aPUnitPrice; ->aPDiscnt; ->aPDscntUP; ->aPExtPrice; ->aPTaxable; ->aPSaleTax; ->aPUnitWt; ->aPQtyOriginal; ->aPLocationBin)
		Ray_DeleteElems($2; $3; ->aPExtWt; ->aPUnitCost; ->aPExtCost; ->aPSaleComm; ->aPSalesRate; ->aPRepComm; ->aPRepRate; ->aPLeadTime; ->aPLocation; ->aPUnitMeas; ->aPDateExp; ->aPPrintThis; ->aPTaxCost)
		Ray_DeleteElems($2; $3; ->aPLineAction; ->aPUse; ->aPQtyOpen; ->aPPQDiR; ->aPSerial; ->aPSeq; ->aPPricePt; ->aPLineNum; ->aPProdBy; ->aPLnComment; ->aPProfile1; ->aPProfile2; ->aPProfile3; ->aPUniqueID)
	: ($1=1)  //add an element
		Ray_InsertElems($2; $3; ->aPItemNum; ->aPAltItem; ->aPQtyOrder; ->aPDescpt; ->aPUnitPrice; ->aPDiscnt; ->aPDscntUP; ->aPExtPrice; ->aPTaxable; ->aPSaleTax; ->aPUnitWt; ->aPQtyOriginal; ->aPLocationBin)
		Ray_InsertElems($2; $3; ->aPExtWt; ->aPUnitCost; ->aPExtCost; ->aPSaleComm; ->aPSalesRate; ->aPRepComm; ->aPRepRate; ->aPLeadTime; ->aPLocation; ->aPUnitMeas; ->aPDateExp; ->aPPrintThis; ->aPTaxCost)
		Ray_InsertElems($2; $3; ->aPLineAction; ->aPUse; ->aPQtyOpen; ->aPPQDiR; ->aPSerial; ->aPSeq; ->aPPricePt; ->aPLineNum; ->aPProdBy; ->aPLnComment; ->aPProfile1; ->aPProfile2; ->aPProfile3; ->aPUniqueID)
		aPUniqueID{$2}:=-1
	: ($1=3)  //fill record values from arrays 
		//make sure the current lines are inselection    
		C_LONGINT:C283($i; $k)
		
		
		C_LONGINT:C283($orig; $k; $i)
		$k:=Size of array:C274(aPpDeleteLines)
		READ WRITE:C146([ProposalLine:43])
		// TRACE
		C_TEXT:C284($errorText)
		$errorText:=""
		If (Size of array:C274(aPpDeleteLines)>0)
			$k:=Size of array:C274(aPpDeleteLines)
			For ($i; 1; $k)
				QUERY:C277([ProposalLine:43]; [ProposalLine:43]idNum:52=aPpDeleteLines{$i})
				Case of 
					: (Locked:C147([ProposalLine:43]))
						$errorText:="Delete line locked: "+String:C10(aPpDeleteLines{$i})+"\r"
					: (Records in selection:C76([ProposalLine:43])=0)
						$errorText:="Delete line missing: "+String:C10(aPpDeleteLines{$i})+"\r"
					: (Records in selection:C76([ProposalLine:43])>1)
						$errorText:="Delete line multiples: "+String:C10(aPpDeleteLines{$i})+"\r"
					Else 
						DELETE RECORD:C58([ProposalLine:43])
				End case 
				If ($errorText#"")
					ConsoleMessage($errorText)
				End if 
			End for 
		End if 
		ARRAY LONGINT:C221(aPpDeleteLines; 0)
		
		// RRAY TO SELECTION(aliRefID1;[ProposalLine]ProposalNum;aStr20Ref1;[ProposalLine]Status;aintRef1;[ProposalLine]Probability;aPBooUse;[ProposalLine]CalculateLine;aPItemNum;[ProposalLine]ItemNum;aTmp10Str1;[ProposalLine]customerID;aPTaxCost;[ProposalLine]TaxCost)
		// RRAY TO SELECTION(aPAltItem;[ProposalLine]AltItemNum;aPQtyOrder;[ProposalLine]Qty;aPDescpt;[ProposalLine]Description;aPUnitPrice;[ProposalLine]UnitPrice;aPDiscnt;[ProposalLine]Discount;aPDateExp;[ProposalLine]DateExpected;aPLocationBin;[ProposalLine]LocationBin)
		// RRAY TO SELECTION(aPExtPrice;[ProposalLine]ExtendedPrice;aPTaxable;[ProposalLine]taxID;aPSaleTax;[ProposalLine]SalesTax;aPUnitWt;[ProposalLine]UnitWeight;aPExtWt;[ProposalLine]ExtendedWt;aPQtyOpen;[ProposalLine]QtyOpen;aPPrintThis;[ProposalLine]PrintNot)
		// RRAY TO SELECTION(aPUnitCost;[ProposalLine]UnitCost;aPExtCost;[ProposalLine]ExtendedCost;aPRepRate;[ProposalLine]CommRateRep;aPRepComm;[ProposalLine]CommRep;aPSalesRate;[ProposalLine]CommRateSales;aPUniqueID;[ProposalLine]UniqueID)
		// RRAY TO SELECTION(aPSaleComm;[ProposalLine]CommSales;aPLeadTime;[ProposalLine]Leadtime;aPLocation;[ProposalLine]Location;aPUnitMeas;[ProposalLine]SaleUnitofMeas;aPSerial;[ProposalLine]Serialized;aPLineNum;[ProposalLine]LineNum;aPDscntUP;[ProposalLine]DiscountedPrice)
		// RRAY TO SELECTION(aPPricePt;[ProposalLine]TypeSale;aPSeq;[ProposalLine]Sequence;aTmpBoo1;[ProposalLine]Complete;aPProdBy;[ProposalLine]ProducedBy;aPLnComment;[ProposalLine]Comment;aPProfile1;[ProposalLine]Profile1;aPProfile2;[ProposalLine]Profile2;aPProfile3;[ProposalLine]Profile3)
		//TRACE////This is needed for loading the record number of new lines
		// SELECTION TO ARRAY([ProposalLine];aPLineAction)
		// RRAY LONGINT(aPpDeleteLines;0
		
		$k:=Size of array:C274(aPUniqueID)
		For ($i; 1; $k)
			If (aPUniqueID{$i}=-3)
				CREATE RECORD:C68([ProposalLine:43])
				
				// Modified by: Bill James (2016-08-08T00:00:00 automatic numbering of [ProposalLine])
				aPUniqueID{$i}:=[ProposalLine:43]idNum:52
			Else 
				QUERY:C277([ProposalLine:43]; [ProposalLine:43]idNum:52=aPUniqueID{$i})
			End if 
			[ProposalLine:43]idNumProposal:1:=[Proposal:42]idNum:5
			[ProposalLine:43]status:30:=[Proposal:42]status:2
			[ProposalLine:43]probability:9:=[Proposal:42]probability:43
			[ProposalLine:43]customerID:42:=[Proposal:42]customerID:1
			[ProposalLine:43]dateExpected:41:=[Proposal:42]dateExpected:42
			[ProposalLine:43]complete:35:=(([Proposal:42]complete:56) & (aPUse{$i}="x"))  //aTmpBoo1{$i}
			[ProposalLine:43]calculateLine:20:=(aPUse{$i}="x")
			//
			// test which
			// [ProposalLine]QtyOpen:=aPQtyOrder{$i}-aPQtyOriginal{$i}
			[ProposalLine:43]qtyOpen:51:=aPQtyOpen{$i}+aPQtyOrder{$i}-aPQtyOriginal{$i}
			//
			[ProposalLine:43]itemNum:2:=aPItemNum{$i}
			[ProposalLine:43]taxCost:53:=aPTaxCost{$i}
			[ProposalLine:43]altItemNum:34:=aPAltItem{$i}
			[ProposalLine:43]qty:3:=aPQtyOrder{$i}
			[ProposalLine:43]description:4:=aPDescpt{$i}
			[ProposalLine:43]unitPrice:15:=aPUnitPrice{$i}
			[ProposalLine:43]discount:17:=aPDiscnt{$i}
			
			[ProposalLine:43]locationBin:55:=aPLocationBin{$i}
			[ProposalLine:43]extendedPrice:16:=aPExtPrice{$i}
			[ProposalLine:43]taxJuris:14:=aPTaxable{$i}
			[ProposalLine:43]salesTax:18:=aPSaleTax{$i}
			[ProposalLine:43]unitWeight:22:=aPUnitWt{$i}
			[ProposalLine:43]extendedWt:19:=aPExtWt{$i}
			
			[ProposalLine:43]printNot:54:=aPPrintThis{$i}
			[ProposalLine:43]unitCost:7:=aPUnitCost{$i}
			[ProposalLine:43]extendedCost:8:=aPExtCost{$i}
			[ProposalLine:43]commRateRep:27:=aPRepRate{$i}
			[ProposalLine:43]commRep:28:=aPRepComm{$i}
			[ProposalLine:43]commRateSales:21:=aPSalesRate{$i}
			[ProposalLine:43]idNum:52:=aPUniqueID{$i}
			[ProposalLine:43]commSales:29:=aPSaleComm{$i}
			[ProposalLine:43]leadTime:26:=aPLeadTime{$i}
			[ProposalLine:43]location:12:=aPLocation{$i}
			[ProposalLine:43]unitofMeasure:13:=aPUnitMeas{$i}
			[ProposalLine:43]serialized:31:=aPSerial{$i}
			[ProposalLine:43]lineNum:43:=aPLineNum{$i}
			[ProposalLine:43]discountedPrice:56:=aPDscntUP{$i}
			[ProposalLine:43]typeSale:32:=aPPricePt{$i}
			[ProposalLine:43]seq:33:=aPSeq{$i}
			
			[ProposalLine:43]producedBy:36:=aPProdBy{$i}
			[ProposalLine:43]comment:37:=aPLnComment{$i}
			[ProposalLine:43]profile1:38:=aPProfile1{$i}
			[ProposalLine:43]profile2:39:=aPProfile2{$i}
			[ProposalLine:43]profile3:40:=aPProfile3{$i}
			SAVE RECORD:C53([ProposalLine:43])
			aPLineAction{$i}:=Record number:C243([ProposalLine:43])
		End for 
		
		
End case 
C_LONGINT:C283(ePropList)
If (ePropList#0)
	//  --  CHOPPED  AL_UpdateArrays(ePropList; -2)
End if 