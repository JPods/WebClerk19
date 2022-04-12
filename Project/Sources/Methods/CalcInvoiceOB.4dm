//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/15/21, 15:50:36
// ----------------------------------------------------
// Method: CalcInvoiceOB
// Description
// 
//
// Parameters
// ----------------------------------------------------
#DECLARE($obOrderRec : Object)

If ($obOrderRec#Null:C1517)
	
	C_OBJECT:C1216($obOrderLines; $obinvoiceLines)
	
	$obOrderLines:=ds:C1482.OrderLines.query("orderNum = :1"; $obOrderRec.orderNum)
	C_LONGINT:C283($i; $e; $addCnt; $doLine; $k)
	C_BOOLEAN:C305($0; $notLocked; $doItem)
	C_REAL:C285($totalShip)
	$forceInventory:=False:C215
	// If (Count parameters=1)  add to the Order Obj is required
	If ($obOrderRec.forceInventory#Null:C1517)
		$forceInventory:=$obOrderRec.forceInventory
	End if 
End if 
$notLocked:=True:C214
//    vlineCnt   //defined in the procedure which fills the arrays

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
		
		$shipAllBL:=2  // set the value in the case statement
		// get rid of this, drive all values to 2 then delete the 
		C_LONGINT:C283($costFromOrder)  // set default value  
		//  I think this should aways be set to zero
		// set in DefaultSetups
		// (P) Essentials
		$costFromOrder:=<>viloadOrderCost
		Case of 
			: (vPackingProcess="PK")  // Processing a Packing Window Order
				aiQtyShip{$i}:=$qtyLoadItem
				aiSerialRc{$i}:=aOSerialRc{$e}  // pass through serial information
				aiSerialNm{$i}:=aOSerialNm{$e}
				// always ship the full amount because it was physically packed
			: (aOQtyBL{$e}<0)  // if negative, always ship everything  (([Item]QtyOnHand<0) & (aOQtyBL{$e}<0))
				// ### bj ### 20181025_0305 moved higher see commented out below
				aiQtyShip{$i}:=aOQtyBL{$e}  // fully ship all negative quantities
				
			: (((aOSerialRc{$e}>-1) | (aOSerialRc{$e}<<>ciSRThisSerialNumber)) & (<>vbDoSrlNums) & ([Item:4]serialized:41))  //valid serial number or as reference to work
				// ### bj ### 20181025_0254
				// Modified by: Bill James (2017-11-28T00:00:00) pass through serial data
				// serial numbers are known and should match the quantity.
				// test 2018
				aiSerialRc{$i}:=aOSerialRc{$e}
				aiSerialNm{$i}:=aOSerialNm{$e}
				aiQtyShip{$i}:=aOQtyBL{$e}
			: (([Item:4]notTracked:56) | (vbForceShip))  // force ship items regardless of issues
				aiQtyShip{$i}:=aOQtyBL{$e}
			: ((aOSerialRc{$e}=<>ciSRUnknown) & (<>vbDoSrlNums))  // serial number are yet to be assigned
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
						// ### bj ### 20181101_2203
						// $addCnt:=1
						// changed to 0, if the serial number is not set, for selection to procede.
						// not sure why this was here
						$addCnt:=0
						aiQtyShip{$i}:=$addCnt  //1 or 0
				End case 
			: (Not:C34(<>tcbLoadItem))  //forget skipReCost at this time.  Something could happen else where in time.
				// <>tcbLoadItem is true if inventory tracking is turned on
				// this is for when tracking inventory is turned off
				// ship the quantity listed in the Location field
				aiQtyShip{$i}:=aOQtyBL{$e}  //  // there is enough on hand to ship all
			: (([Order:3]profile1:61="Blanket") & (aOQtyBL{$e}>=aiLocation{$i}))
				// ### bj ### 20181101_2221
				//If (([Order]Profile1="Blanket") & (aOQtyBL{$e}>=aiLocation{$i}))
				// seemed to be improperly nested under : (Not(<>tcbLoadItem))
				// made "blanket" orders their own case
				aiQtyShip{$i}:=aiLocation{$i}
				Case of 
					: (aiLocation{$i}>aOQtyBL{$e})  // blanket order is greater than remaining on order
						aiQtyShip{$i}:=aOQtyBL{$e}  // ship just the remaining
					: (aiQtyShip{$i}>[Item:4]qtyOnHand:14)  // ship only what is on hand
						aiQtyShip{$i}:=[Item:4]qtyOnHand:14
						If (allowAlerts_boo)
							ALERT:C41([Item:4]itemNum:1+" is undershipped from Blanket Order Amount of "+String:C10(aiLocation{$i}))
						End if 
					Else 
						aiQtyShip{$i}:=aiLocation{$i}  // there is enough on hand to this bl;anket amount
				End case 
				$costFromOrder:=1
			: (((aiLocation{$i}<0) & (aiLocation{$i}>-150)) | (aiLocation{$i}=-1111) | (aiLocation{$i}=-1112))
				// between -1 and -150 or -1111 or -1112
				$costFromOrder:=1
				// aiQtyShip{$i}:=0  //  aOQtyBL{$e}
				// ship 
				aiQtyShip{$i}:=aOQtyBL{$e}
				If (aiQtyShip{$i}>[Item:4]qtyOnHand:14)  // Calculate from OH
					aiQtyShip{$i}:=[Item:4]qtyOnHand:14
				End if 
			: (aiLocation{$i}<-9000)
				// ### bj ### 20181101_2224
				//  : (aiLocation{$i}<0)  wrecks the logic of case above
				// needed for when it is a Rep item, Location set to very large negative numbers
				aiQtyShip{$i}:=aOQtyBL{$e}
			: (([Item:4]backOrder:24) | (([Item:4]qtyOnHand:14<=0) & (aOQtyBL{$e}>=0)))
				aiQtyShip{$i}:=0
			: (aOQtyBL{$e}>=[Item:4]qtyOnHand:14)  // there is enough on hand to ship all
				aiQtyShip{$i}:=aOQtyBL{$e}
			Else   // all other cases
				If (aOQtyBL{$i}>[Item:4]qtyOnHand:14)  // ship only what is on hand
					aiQtyShip{$i}:=[Item:4]qtyOnHand:14
				Else 
					aiQtyShip{$i}:=aOQtyBL{$e}  //  // there is enough on hand to ship all
				End if 
		End case 
		//
		// ### bj ### 20181101_2158
		// get rid of this
		If (False:C215)  // should be integrated into above for more readability
			Case of   // tried to move these into the case above. (aiQtyShip{$i}>[Item]QtyOnHand) special care
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
		End if 
		// ### bj ### 20181101_2210
		// keep test for costs from order separate from QtyShipped
		// set the cost of the line based on order or item
		$costFromOrder:=0
		Case of 
			: (((aiLocation{$i}<0) & (aiLocation{$i}>-150)) | (aiLocation{$i}=-1111) | (aiLocation{$i}=-1112))
				$costFromOrder:=1
			: (([Order:3]profile1:61="Blanket") & (aOQtyBL{$e}>=aiLocation{$i}))
				$costFromOrder:=1
		End case 
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

