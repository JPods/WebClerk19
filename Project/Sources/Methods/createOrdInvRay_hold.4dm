//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 09/13/10, 10:49:36
// ----------------------------------------------------
// Method: createOrdInvRay
// Description
// 
//
// Parameters
// ----------------------------------------------------

// hold until testing is competed of Orders to Invoices as changed
// ### bj ### 20181025_1546

C_LONGINT:C283($i; $e; $addCnt; $doLine; $k)
C_BOOLEAN:C305($0; $notLocked; $doItem)
C_REAL:C285($totalShip)
$forceInventory:=False:C215
If (Count parameters:C259=1)
	$forceInventory:=$1
End if 
$notLocked:=True:C214
//    vlineCnt   //defined in the procedure which fills the arrays
If (vHere=1)
	
	C_LONGINT:C283(<>zxc)
	ARRAY POINTER:C280(aAreaListArraysPointer; 0)
	ARRAY LONGINT:C221(aAreaListArraysSort; 0)
	AreaListArrayPointer(->aOSeq; ->aoLineAction; ->aOLineNum; ->aOItemNum; ->aOAltItem; ->aOQtyOrder; ->aOQtyShip; ->aOQtyBL; ->aODescpt; ->aOUnitPrice)
	AreaListArrayPointer(->aODiscnt; ->aoDscntUP; ->aOPQDIR; ->aOExtPrice; ->aOUnitCost; ->aOExtCost; ->aOBackLog; ->aOTaxable; ->aOSaleTax; ->aoDateShipOn)
	AreaListArrayPointer(->aOSaleComm; ->aOSalesRate; ->aORepComm; ->aORepRate; ->aOUnitMeas; ->aOUnitWt; ->aOExtWt; ->aOLocation; ->aiLnOrdUnique; ->aiUniqueID)
	AreaListArrayPointer(->aOQtyOpen; ->aOSerialRc; ->aOSerialNm; ->aOPricePt; ->aoDateReq; ->aoDateShipOn; ->aODateShipped; ->aoProdBy; ->aoLnComment; ->aoProfile1; ->aoProfile2; ->aoProfile3)
	//
	aAreaListArraysSort{1}:=1
	MULTI SORT ARRAY:C718(aAreaListArraysPointer; aAreaListArraysSort)
	ARRAY POINTER:C280(aAreaListArraysPointer; 0)
	ARRAY LONGINT:C221(aAreaListArraysSort; 0)
	
End if 
$i:=0
IvcLn_RaySize(0; 0; 0)
$k:=Size of array:C274(aOLineNum)
//TRACE
C_BOOLEAN:C305(doByLine)
C_LONGINT:C283($findOrderLine; $cntPKLines)
For ($e; 1; $k)
	$cntPKLines:=0
	$doItem:=False:C215
	$qtyLoadItem:=0
	ARRAY LONGINT:C221($aPKItemLines; 0)
	
	If (doByLine=True:C214)  // select lines to invoice, else send all orderlines to invoicelines
		$doLine:=Find in array:C230(<>aLsSrRec; Record number:C243([Item:4]))
		If ($doLine>0)
			$doLine:=Find in array:C230(<>aItemLines; $doLine)
		End if 
	Else 
		$doLine:=1
	End if 
	
	If (vPackingProcess="PK")  // Processing a Packing Window Order must reset arrays before
		// determine if this line was packed. If not packed, set qty to zero
		$qtyLoadItem:=PKInvoiceLines(aoUniqueID{$e}; aOItemNum{$e})
		If ($qtyLoadItem#0)
			// perhaps these would be better adjusted below. But PK window must be accounted for
			aOQtyShip{$e}:=aOQtyShip{$e}-$qtyLoadItem  // reset to original Order values
			aOQtyBL{$e}:=aOQtyBL{$e}+$qtyLoadItem
			//  aiQtyShip{$i}:=$qtyLoadItem // set this below where other shipment values are set
			// OrderLines must be reset also in the final saving of Invoice lines. They are reloaded 
		End if 
	End if 
	If (((aOQtyBL{$e}#0) | (<>booPassZero)) & ($doLine>0))  // unless mandated, or already shipped, made an invoiceline
		
		$i:=Size of array:C274(aiLineAction)+1
		IvcLn_RaySize(1; $i; 1)
		aiLineAction{$i}:=-3
		aiLnOrdUnique{$i}:=aoUniqueID{$e}
		aiLineNum{$i}:=aOLineNum{$e}
		aiItemNum{$i}:=aOItemNum{$e}
		If ([Item:4]itemNum:1#aiItemNum{$i})
			QUERY:C277([Item:4]; [Item:4]itemNum:1=aiItemNum{$i})
		End if 
		C_REAL:C285($itemCost; $qtyOpen; $qtyAvailable; $qtyOnHand)
		$itemCost:=[Item:4]costAverage:13
		$qtyOpen:=[Item:4]qtyOnHand:14-[Item:4]qtyOnSalesOrder:16
		$qtyAvailable:=[Item:4]qtyAvailable:73
		$qtyOnHand:=[Item:4]qtyOnHand:14
		
		//If ($doItem)
		If ([Item:4]useQtyPriceBrks:6>0)
			aiPQDIR{$i}:=Record number:C243([Item:4])
		Else 
			aiPQDIR{$i}:=-1
		End if 
		
		//
		aiAltItem{$i}:=aOAltItem{$e}
		aiQtyRemain{$i}:=aOQtyBL{$e}  //  must override if in Packing Window to prevent double shipping
		//
		aiQtyOrder{$i}:=aOQtyOrder{$e}
		aiQtyOpen{$i}:=aOQtyOpen{$e}
		aiLocation{$i}:=aOLocation{$e}
		aiLocationBin{$i}:=aOLocationBin{$e}
		aiPrintThis{$i}:=aoPrintThis{$e}
		aiPQDIR{$i}:=-1
		//
		
		// Modified by: William James (2014-08-14T00:00:00)
		//   qqq double chech all these cases May have wacked key characteristics of specialty efforts
		
		
		C_LONGINT:C283($costFromOrder)
		$costFromOrder:=<>viloadOrderCost
		Case of 
			: (vPackingProcess="PK")  // Processing a Packing Window Order
				
				aiQtyShip{$i}:=$qtyLoadItem
				$shipAllBL:=2  // leave unchanged
				// test 2018
				// Modified by: Bill James (2017-11-28T00:00:00) pass through serial data
				aiSerialRc{$i}:=aOSerialRc{$e}  // pass through serial information
				aiSerialNm{$i}:=aOSerialNm{$e}
				// always ship the full amount because it was physically packed
			: (((aOSerialRc{$e}>-1) | (aOSerialRc{$e}<<>ciSRThisSerialNumber)) & (<>vbDoSrlNums))  //valid serial number or as reference to work
				// Modified by: Bill James (2017-11-28T00:00:00) pass through serial data
				// serial numbers are known and should match the quantity.
				// test 2018
				aiSerialRc{$i}:=aOSerialRc{$e}
				aiSerialNm{$i}:=aOSerialNm{$e}
				aiQtyShip{$i}:=aOQtyBL{$e}
				$shipAllBL:=2  // leave unchanged
			: (([Item:4]notTracked:56) | (vbForceShip))  // force ship items regardless of issues
				$shipAllBL:=1  // ship all 
			: ((aOSerialRc{$e}=<>ciSRUnknown) & (<>vbDoSrlNums))
				Case of 
					: (([Item:4]multiSiteInventory:65>0) & (aOQtyBL{$e}#0))
						$addCnt:=0
						aiQtyShip{$i}:=0
						// MESSAGE("Multi-site inventory Items automatically backordered.")
					: ((aOSerialRc{$e}=<>ciSRUnknown) & (<>vbDoSrlNums) & (aOQtyBL{$e}#0))  //)&
						aiSerialRc{$i}:=CounterNew(->[DialingInfo:81])  // aOSerialRc{$e} 
						// Modified by: Bill James (2017-09-20T00:00:00)
						// aiSerialRc{$i}:=CounterNew (-[DialingInfo])  //aOSerialRc{$e}   
						// need to apply serialization to multisite  qqqq     
						$addCnt:=0
						aiQtyShip{$i}:=0
						If (allowAlerts_boo)
							MESSAGE:C88("Serialized Items automatically backordered.")
						End if 
						
					Else 
						$addCnt:=1
						aiQtyShip{$i}:=$addCnt  //1 or 0
				End case 
				$shipAllBL:=2  // leave unchanged below
			: (Not:C34(<>tcbLoadItem))  //forget skipReCost at this time.  Something could happen else where in time.
				// ship the quantity listed in the Location field
				If (([Order:3]profile1:61="Blanket") & (aOQtyBL{$e}>=aiLocation{$i}))
					aiQtyShip{$i}:=aiLocation{$i}
					$shipAllBL:=2  // leave unchanged below
				Else 
					$shipAllBL:=1  // ship all 
				End if 
				$costFromOrder:=1
				$shipAllBL:=2  // leave unchanged below
			: (((aiLocation{$i}<0) & (aiLocation{$i}>-150)) | (aiLocation{$i}=-1111) | (aiLocation{$i}=-1112))
				$costFromOrder:=1
				$shipAllBL:=1  // ship zero
			: (aiLocation{$i}<0)
				aiQtyShip{$i}:=aOQtyBL{$e}
				$shipAllBL:=2  // leave unchanged below
			: (([Order:3]profile1:61="Blanket") & (aOQtyBL{$e}>=aiLocation{$i}))
				aiQtyShip{$i}:=aiLocation{$i}
				$shipAllBL:=2  // leave unchanged below
			: (([Item:4]backOrder:24) | (([Item:4]qtyOnHand:14<=0) & (aOQtyBL{$e}>=0)))
				$shipAllBL:=-1  // ship zero
			: (aOQtyBL{$e}<0)  // if negative, always ship everything  (([Item]QtyOnHand<0) & (aOQtyBL{$e}<0))
				$shipAllBL:=1  // ship all BLQ
			: (aOQtyBL{$e}>=[Item:4]qtyOnHand:14)
				$shipAllBL:=1  // ship all 
			Else 
				$shipAllBL:=0
		End case 
		//
		Case of 
			: ($shipAllBL=2)  // already set in the case statement above
				// leave unchanged
			: ($shipAllBL=-1)  // force to ship zero
				aiQtyShip{$i}:=0
			: ($shipAllBL=1)  // ship all BLQ
				aiQtyShip{$i}:=aOQtyBL{$e}
			Else 
				// Modified by: Bill James (2014-11-18T00:00:00 BUGFIX
				//  If (aiQtyShip{$i}<[Item]QtyOnHand)  // Calculate from OH
				// it was shipping the entire in stock quty
				If (aiQtyShip{$i}>[Item:4]qtyOnHand:14)  // Calculate from OH
					aiQtyShip{$i}:=[Item:4]qtyOnHand:14
				Else 
					aiQtyShip{$i}:=aOQtyBL{$e}
				End if 
		End case 
		
		// set the cost of the line based on order or item
		If ($costFromOrder=1)
			aiUnitCost{$i}:=aOUnitCost{$e}
		Else 
			aiUnitCost{$i}:=$itemCost
		End if 
		//
		aiUnitWt{$i}:=aOUnitWt{$e}
		aiDescpt{$i}:=aODescpt{$e}
		aiUnitPrice{$i}:=aOUnitPrice{$e}
		aiDiscnt{$i}:=aODiscnt{$e}
		aiUnitPriceDiscounted{$i}:=aODscntUP{$e}
		aiLocation{$i}:=aOLocation{$e}
		aiLocationBin{$i}:=aOLocationBin{$e}
		aiTaxable{$i}:=aOTaxable{$e}
		aiUnitMeas{$i}:=aOUnitMeas{$e}
		aiSalesRate{$i}:=aOSalesRate{$e}
		aiRepRate{$i}:=aORepRate{$e}
		aiSeq{$i}:=$i
		aiPricePt{$i}:=aOPricePt{$e}
		aiProdBy{$i}:=aoProdBy{$e}
		aiLnComment{$i}:=aoLnComment{$e}
		aiProfile1{$i}:=aoProfile1{$e}
		aiProfile2{$i}:=aoProfile2{$e}
		aiProfile3{$i}:=aoProfile3{$e}
		aiPrintThis{$i}:=aoPrintThis{$e}
		aiLineAction:=$i
		IvcLnExtend($i)
		$totalShip:=$totalShip+Abs:C99(aiQtyShip{$i})
	End if 
End for 
vMod:=calcInvoice(vMod)
$0:=($totalShip#0)
viInvcLnCnt:=MaxValueInArray(->aOLineNum)
REDRAW WINDOW:C456
UNLOAD RECORD:C212([Item:4])

