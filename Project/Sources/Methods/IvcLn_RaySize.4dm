//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/30/13, 20:57:19
// ----------------------------------------------------
// Method: IvcLn_RaySize
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1; $lineTask; $2; $lineAction; $3; $lineExpansion)
$lineTask:=$1
$lineAction:=0
$lineExpansion:=1
If (Count parameters:C259>1)
	$lineAction:=$2
	If (Count parameters:C259>1)
		$lineExpansion:=$3
	End if 
End if 
Case of 
	: ($1=0)
		$cntLines:=0
		ARRAY LONGINT:C221(aiLinesDelete; 0)
		//
		ARRAY LONGINT:C221(aiLineAction; $cntLines)  //initialize the array to 0's in the elements
		ARRAY LONGINT:C221(aiLineNum; $cntLines)
		ARRAY TEXT:C222(aiItemNum; $cntLines)
		ARRAY TEXT:C222(aiAltItem; $cntLines)
		ARRAY REAL:C219(aiQtyOrder; $cntLines)
		ARRAY REAL:C219(aiQtyRemain; $cntLines)
		ARRAY REAL:C219(aiQtyShip; $cntLines)
		ARRAY REAL:C219(aiQtyBL; $cntLines)
		ARRAY TEXT:C222(aiDescpt; $cntLines)
		ARRAY REAL:C219(aiUnitPrice; $cntLines)
		ARRAY REAL:C219(aiDiscnt; $cntLines)
		ARRAY REAL:C219(aiUnitPriceDiscounted; $cntLines)
		ARRAY LONGINT:C221(aiPQDIR; $cntLines)  //Item Record Number, for lookup
		ARRAY REAL:C219(aiExtPrice; $cntLines)
		ARRAY REAL:C219(aiUnitCost; $cntLines)
		ARRAY REAL:C219(aiExtCost; $cntLines)
		//ARRAY REAL(aiBackLog;$cntLines)
		ARRAY TEXT:C222(aiTaxable; $cntLines)
		ARRAY REAL:C219(aiSaleTax; $cntLines)
		ARRAY REAL:C219(aiTaxCost; $cntLines)
		ARRAY REAL:C219(aiSaleComm; $cntLines)
		ARRAY REAL:C219(aiSalesRate; $cntLines)
		ARRAY REAL:C219(aiRepComm; $cntLines)
		ARRAY REAL:C219(aiRepRate; $cntLines)
		ARRAY TEXT:C222(aiUnitMeas; $cntLines)
		ARRAY REAL:C219(aiUnitWt; $cntLines)
		ARRAY REAL:C219(aiExtWt; $cntLines)
		ARRAY LONGINT:C221(aiLocation; $cntLines)
		ARRAY TEXT:C222(aiLocationBin; $cntLines)
		ARRAY REAL:C219(aiQtyOpen; $cntLines)
		//ARRAY LONGINT(aiSerialed;$cntLines)//serial rec number changes
		ARRAY LONGINT:C221(aiSerialRc; $cntLines)  //maintains orig serial num status
		ARRAY TEXT:C222(aiSerialNm; $cntLines)  // selected serial number
		ARRAY TEXT:C222(aiPricePt; $cntLines)
		ARRAY LONGINT:C221(aiSeq; $cntLines)
		ARRAY TEXT:C222(aiProdBy; $cntLines)
		ARRAY TEXT:C222(aiLnComment; $cntLines)
		ARRAY TEXT:C222(aiShipOrdSt; $cntLines)
		ARRAY TEXT:C222(aiProfile1; $cntLines)
		ARRAY TEXT:C222(aiProfile2; $cntLines)
		ARRAY TEXT:C222(aiProfile3; $cntLines)
		ARRAY LONGINT:C221(aiUniqueID; $cntLines)
		ARRAY LONGINT:C221(aiLnOrdUnique; $cntLines)
		ARRAY LONGINT:C221(aiPrintThis; $cntLines)
		
		
		ARRAY LONGINT:C221(aiOgLineNum; 0)
	: ($1=-1)  //subtract elements
		//$2  --  aPOLineAction - the position and number of elements
		Ray_DeleteElems($2; $3; ->aiLineAction; ->aiLineNum; ->aiItemNum; ->aiAltItem; ->aiQtyOrder; ->aiQtyRemain; ->aiQtyShip; ->aiQtyBL; ->aiDescpt; ->aiUnitPrice; ->aiDiscnt; ->aiUnitPriceDiscounted; ->aiTaxCost; ->aiPrintThis)
		Ray_DeleteElems($2; $3; ->aiPQDIR; ->aiExtPrice; ->aiUnitCost; ->aiExtCost; ->aiTaxable; ->aiSaleTax; ->aiSaleComm; ->aiSalesRate; ->aiRepComm; ->aiRepRate; ->aiUnitMeas; ->aiUnitWt; ->aiLocationBin)
		Ray_DeleteElems($2; $3; ->aiExtWt; ->aiLocation; ->aiQtyOpen; ->aiSerialRc; ->aiSerialNm; ->aiSeq; ->aiPricePt; ->aiProdBy; ->aiLnComment; ->aiShipOrdSt; ->aiProfile1; ->aiProfile2; ->aiProfile3; ->aiUniqueID; ->aiLnOrdUnique)
	: ($1>0)  //add an element
		Ray_InsertElems($2; $3; ->aiLineAction; ->aiLineNum; ->aiItemNum; ->aiAltItem; ->aiQtyOrder; ->aiQtyRemain; ->aiQtyShip; ->aiQtyBL; ->aiDescpt; ->aiUnitPrice; ->aiDiscnt; ->aiUnitPriceDiscounted; ->aiTaxCost; ->aiPrintThis)
		Ray_InsertElems($2; $3; ->aiPQDIR; ->aiExtPrice; ->aiUnitCost; ->aiExtCost; ->aiTaxable; ->aiSaleTax; ->aiSaleComm; ->aiSalesRate; ->aiRepComm; ->aiRepRate; ->aiUnitMeas; ->aiUnitWt; ->aiLocationBin)
		Ray_InsertElems($2; $3; ->aiExtWt; ->aiLocation; ->aiQtyOpen; ->aiSerialRc; ->aiSerialNm; ->aiSeq; ->aiPricePt; ->aiProdBy; ->aiLnComment; ->aiShipOrdSt; ->aiProfile1; ->aiProfile2; ->aiProfile3; ->aiUniqueID; ->aiLnOrdUnique)
		aiUniqueID{$2}:=-3
		aiLnOrdUnique{$2}:=-3  // must be over written if there is an order
		aiLineAction{$2}:=-3
		
		// Modified by: William James (2014-01-20T00:00:00)
		//  ????? Why was a -1 used.  Change to a -3 for new
		//  aiLineAction{$i}:=-1  // -1 from order and -3 for new
		
	: ($1=-3)  // do not think this will be used
		INSERT IN ARRAY:C227(aiLineAction; $2; 1)  //initialize the array to 0's in the elements
		INSERT IN ARRAY:C227(aiLineNum; $2; $3)
		INSERT IN ARRAY:C227(aiItemNum; $2; $3)
		INSERT IN ARRAY:C227(aiAltItem; $2; $3)
		INSERT IN ARRAY:C227(aiQtyOrder; $2; $3)
		INSERT IN ARRAY:C227(aiQtyRemain; $2; $3)
		INSERT IN ARRAY:C227(aiQtyShip; $2; $3)
		INSERT IN ARRAY:C227(aiQtyBL; $2; $3)
		INSERT IN ARRAY:C227(aiDescpt; $2; $3)
		INSERT IN ARRAY:C227(aiUnitPrice; $2; $3)
		INSERT IN ARRAY:C227(aiDiscnt; $2; $3)
		INSERT IN ARRAY:C227(aiUnitPriceDiscounted; $2; $3)
		INSERT IN ARRAY:C227(aiPQDIR; $2; $3)  //Item Record Number, for lookup
		INSERT IN ARRAY:C227(aiExtPrice; $2; $3)
		INSERT IN ARRAY:C227(aiUnitCost; $2; $3)
		INSERT IN ARRAY:C227(aiExtCost; $2; $3)
		//insert element(aiBackLog;$2;$3)
		INSERT IN ARRAY:C227(aiTaxable; $2; $3)
		INSERT IN ARRAY:C227(aiSaleTax; $2; $3)
		INSERT IN ARRAY:C227(aiTaxCost; $2; $3)
		INSERT IN ARRAY:C227(aiSaleComm; $2; $3)
		INSERT IN ARRAY:C227(aiSalesRate; $2; $3)
		INSERT IN ARRAY:C227(aiRepComm; $2; $3)
		INSERT IN ARRAY:C227(aiRepRate; $2; $3)
		INSERT IN ARRAY:C227(aiUnitMeas; $2; $3)
		INSERT IN ARRAY:C227(aiUnitWt; $2; $3)
		INSERT IN ARRAY:C227(aiExtWt; $2; $3)
		INSERT IN ARRAY:C227(aiLocation; $2; $3)
		INSERT IN ARRAY:C227(aiLocationBin; $2; $3)
		INSERT IN ARRAY:C227(aiQtyOpen; $2; $3)
		//insert element(aiSerialed;$2;$3)//serial rec number changes
		INSERT IN ARRAY:C227(aiSerialRc; $2; $3)  //maintains orig serial num status
		INSERT IN ARRAY:C227(aiSerialNm; $2; $3)  // selected serial number
		INSERT IN ARRAY:C227(aiPricePt; $2; $3)
		INSERT IN ARRAY:C227(aiSeq; $2; $3)
		INSERT IN ARRAY:C227(aiProdBy; $2; $3)
		INSERT IN ARRAY:C227(aiLnComment; $2; $3)
		INSERT IN ARRAY:C227(aiShipOrdSt; $2; $3)
		INSERT IN ARRAY:C227(aiProfile1; $2; $3)
		INSERT IN ARRAY:C227(aiProfile2; $2; $3)
		INSERT IN ARRAY:C227(aiProfile3; $2; $3)
		INSERT IN ARRAY:C227(aiUniqueID; $2; $3)
		INSERT IN ARRAY:C227(aiLnOrdUnique; $2; $3)
		INSERT IN ARRAY:C227(aiPrintThis; $2; $3)
		aiUniqueID{$2}:=-3
		aiLnOrdUnique{$2}:=-3
		
		
		
	: ($1=3)  //fill record values from arrays 
		ALERT:C41("Not used. Contact JIT")
		// Modified by: Bill James (2016-08-09T00:00:00 AutomateIDs Only use rray to selection to consolidate records to a new relationship)
		// $1 is never passed a 3 to this procedure
		If (False:C215)
			If (False:C215)  //  do not think this should be used.
				READ WRITE:C146([InvoiceLine:54])
				READ WRITE:C146([OrderLine:49])
				//TRACE
				If (Size of array:C274(aiLinesDelete)>0)
					$k:=Size of array:C274(aiLinesDelete)
					For ($i; 1; $k)
						QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]idNum:47=aiLinesDelete{$i})
						DELETE RECORD:C58([InvoiceLine:54])
					End for 
				End if 
				ARRAY LONGINT:C221(aiLinesDelete; 0)
				QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2)
				C_LONGINT:C283($diffRecCnt)
				$diffRecCnt:=Records in selection:C76([InvoiceLine:54])-Size of array:C274(aiLineNum)
				If ($diffRecCnt>0)
					REDUCE SELECTION:C351([InvoiceLine:54]; $diffRecCnt)
					DELETE SELECTION:C66([InvoiceLine:54])
					QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2)
				End if 
				C_LONGINT:C283($1; $k)
				$k:=Size of array:C274(aiLineNum)
				ARRAY LONGINT:C221(aTmpLong1; $k)
				ARRAY TEXT:C222(aTmp10Str1; $k)
				ARRAY TEXT:C222(aTmp25Str1; $k)
				ARRAY TEXT:C222(aTmp25Str2; $k)
				ARRAY DATE:C224(aDate1; $k)
				For ($i; 1; $k)
					aTmpLong1{$i}:=[Invoice:26]invoiceNum:2
					aTmp10Str1{$i}:=[Invoice:26]customerID:3
					aTmp25Str1{$i}:=[Invoice:26]repID:22
					aTmp25Str2{$i}:=[Invoice:26]salesNameID:23
					aDate1{$i}:=[Invoice:26]dateShipped:4
					If (aiUniqueID{$i}<0)
						aiUniqueID{$i}:=Sequence number:C244([InvoiceLine:54])
					End if 
				End for 
				
				// Modified by: Bill James (2016-08-09T00:00:00 Subrecord eliminated)
				
				
				// RRAY TO SELECTION(aTmpLong1;[InvoiceLine]InvoiceNum;aTmp10Str1;[InvoiceLine]customerID;aTmp25Str1;[InvoiceLine]RepID;aTmp25Str2;[InvoiceLine]SalesName;aiLineNum;[InvoiceLine]LineNum;aiItemNum;[InvoiceLine]ItemNum;aiAltItem;[InvoiceLine]AltItem;aiDescpt;[InvoiceLine]Description;aiQtyShip;[InvoiceLine]QtyShipped;aiTaxCost;[InvoiceLine]TaxCost)
				// RRAY TO SELECTION(aiQtyRemain;[InvoiceLine]QtyRemain;aiQtyBL;[InvoiceLine]QtyBackLogged;aiUnitPrice;[InvoiceLine]UnitPrice;aiDiscnt;[InvoiceLine]Discount;aiExtPrice;[InvoiceLine]ExtendedPrice;aiUnitCost;[InvoiceLine]UnitCost;aiExtCost;[InvoiceLine]ExtendedCost;aiTaxable;[InvoiceLine]taxID;aiUniqueID;[InvoiceLine]UniqueID;aiLnOrdUnique;[InvoiceLine]UniqueOrdLnID;aiLocationBin;[InvoiceLine]LocationBin)
				// RRAY TO SELECTION(aiSaleTax;[InvoiceLine]SalesTax;aiSaleComm;[InvoiceLine]CommSales;aiSalesRate;[InvoiceLine]CommRateSales;aiRepComm;[InvoiceLine]CommRep;aiRepRate;[InvoiceLine]CommRateRep;aiUnitMeas;[InvoiceLine]UnitofMeasure;aiUnitWt;[InvoiceLine]UnitWt;aiExtWt;[InvoiceLine]ExtendedWt;aiLocation;[InvoiceLine]Location;aiSerialRc;[InvoiceLine]SerialRc)
				// RRAY TO SELECTION(aiSerialNm;[InvoiceLine]SerialNum;aiPricePt;[InvoiceLine]TypeSale;aiSeq;[InvoiceLine]Sequence;aDate1;[InvoiceLine]DateShipped;aiProdBy;[InvoiceLine]ProducedBy;aiLnComment;[InvoiceLine]Comment;aiShipOrdSt;[InvoiceLine]ShipOrderStatus;aiProfile1;[InvoiceLine]LineProfile1;aiProfile2;[InvoiceLine]LineProfile2;aiProfile3;[InvoiceLine]LineProfile3)
				// RRAY TO SELECTION(aiPrintThis;[InvoiceLine]PrintNot;aiUnitPriceDiscounted;[InvoiceLine]DiscountedPrice)
				//
				FIRST RECORD:C50([InvoiceLine:54])
				For ($i; 1; $k)
					[InvoiceLine:54]salesNameID:35:=[Invoice:26]salesNameID:23
					MarginCalc(->[InvoiceLine:54]extendedPrice:11; ->[InvoiceLine:54]extendedCost:13; ->[InvoiceLine:54]margin:54; ->[InvoiceLine:54]marginPerCent:55)
					
					If (False:C215)
						// Modified by: William James (2013-12-12T00:00:00)
						If ([InvoiceLine:54]orderLineNum:48#0)
							QUERY:C277([OrderLine:49]; [OrderLine:49]idNum:50=[InvoiceLine:54]orderLineNum:48)
							[InvoiceLine:54]lineProfile1:42:=[OrderLine:49]lineProfile1:45
							[InvoiceLine:54]lineProfile2:43:=[OrderLine:49]lineProfile2:46
							[InvoiceLine:54]lineProfile3:44:=[OrderLine:49]lineProfile3:47
						End if 
					End if 
					[InvoiceLine:54]orderNum:60:=[Invoice:26]orderNum:1
					SAVE RECORD:C53([InvoiceLine:54])
					NEXT RECORD:C51([InvoiceLine:54])
				End for 
				READ ONLY:C145([InvoiceLine:54])
				$k:=0
				ARRAY LONGINT:C221(aTmpLong1; $k)
				ARRAY TEXT:C222(aTmp10Str1; $k)
				ARRAY TEXT:C222(aTmp25Str1; $k)
				ARRAY TEXT:C222(aTmp25Str2; $k)
				ARRAY DATE:C224(aDate1; $k)
				//aiLineAction{$i}:=10
				//Selected record number([InvLine]);
				//aiUnitPriceDiscounted{$i}:=DiscountApply (aiUnitPrice{$i};aiDiscnt{$i};<>tcDecimalUP);
				//aiQtyOpen{$i}:=0;
				//aiPQDIR{$i}:=-1;
				//aiQtyOrder;[InvLine]QtyOrdered
			End if 
		End if 
		
End case 


