//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): jimmedlen
// Date and time: 04/04/13, 10:28:42
// ----------------------------------------------------
// Method: IvcLnLoadRec
// Description
// File: IvcLnLoadRec.txt
// Parameters  ($w;[Invoice]OrderNum;True)
// ----------------------------------------------------

//Procedure: IvcLnLoadRec
//    October 6, 1995
C_LONGINT:C283($1; $2; $k; $dAction; $BomID; $lineNum)
C_BOOLEAN:C305($3; $stdConsume)
C_REAL:C285($dOnHand; $dOnOrd; $qtyOnOrder; $qtyAddedtoOrder; $qtyAlreadyShipped; $qtyBacklogged; $addToOrd)
READ WRITE:C146([OrderLine:49])
$dOnOrd:=0  //no change in on order status
$dAction:=1
//
C_LONGINT:C283($lineNum)
C_BOOLEAN:C305($isOrder)
$qtyOn_Order:=0
$qtyShipped_order:=0
$qtyBL_Order:=0
$dOnOrd:=0
$addToOrd:=0
$lineNum:=0
If ([Invoice:26]idNumOrder:1>9)
	$isOrder:=True:C214
Else 
	$isOrder:=False:C215
End if 
C_REAL:C285($qtyOn_Order; $qtyShipped_order; $qtyBL_Order)
$lineNum:=-3
$qtyOn_Order:=0
$qtyShipped_order:=0
$qtyBL_Order:=0
If (aiLnOrdUnique{$1}>0)
	QUERY:C277([OrderLine:49]; [OrderLine:49]idNum:50=aiLnOrdUnique{$1})
	$qtyOn_Order:=[OrderLine:49]qty:6
	$lineNum:=[OrderLine:49]lineNum:3
	If (vPackingProcess="PK")  // from the packing window
		$qtyShipped_order:=[OrderLine:49]qtyShipped:7-aiQtyShip{$1}
		$qtyBL_Order:=aiQtyRemain{$1}
	Else 
		$qtyShipped_order:=[OrderLine:49]qtyShipped:7
		$qtyBL_Order:=[OrderLine:49]qtyBackLogged:8
	End if 
End if 

If (Is new record:C668([InvoiceLine:54]))  //
	// If (aiUniqueID{$1}<0)
	// 
	// If (aoUniqueID{$i}<0)
	// Modified by: Bill James (2016-08-08T00:00:00 automatic numbering of [InvoiceLine])
	aiUniqueID{$1}:=[InvoiceLine:54]idNum:47
	[InvoiceLine:54]orderLineNum:48:=aiLnOrdUnique{$1}  // if this is a created line, create the orderline below
	// must be reset if this is an new line added in the invoice
	
	[InvoiceLine:54]idNumInvoice:1:=[Invoice:26]idNum:2
	[InvoiceLine:54]lineNum:3:=aiLineNum{$1}
	[InvoiceLine:54]itemNum:4:=aiItemNum{$1}
	[InvoiceLine:54]qtyOrderedAtInvoice:63:=$qtyOn_Order  // from orderlines assigned only to new lines
	[InvoiceLine:54]qtyRemain:6:=$qtyBL_Order
End if 




If (($lineNum>0) & (aiLineNum{$1}#$lineNum))
	ErrorTallyResults("InvoiceLineError"; "IvcLnLoadRec, Orderline and InvoiceLineNum mismatch")
End if 
[InvoiceLine:54]customerID:2:=[Invoice:26]customerID:3
[InvoiceLine:54]repID:34:=[Invoice:26]repID:22
[InvoiceLine:54]salesNameID:35:=[Invoice:26]salesNameID:23
[InvoiceLine:54]dateShipped:25:=[Invoice:26]dateShipped:4
[InvoiceLine:54]altItem:29:=aiAltItem{$1}
[InvoiceLine:54]description:5:=aiDescpt{$1}

$qtyShipped_start:=[InvoiceLine:54]qty:7  // qty being shipped minus existing shipped
$dShipped:=aiQtyShip{$1}-$qtyShipped_start
$dOnHand:=-$dShipped
$qtyBL_start:=[InvoiceLine:54]qtyBackLogged:8
$dBL:=0


// Modified by: William James (2014-04-23T00:00:00 Subrecord eliminated)

//  Should this be changed with processing from the Packing Window


If ($dShipped#0)
	Case of 
		: (True:C214)  //  let a over shipped invoice drive [InvoiceLine]QtyBackLogged negative
		: (([InvoiceLine:54]qtyBackLogged:8>0) & ([InvoiceLine:54]qtyBackLogged:8<$dShipped))
			[InvoiceLine:54]qtyBackLogged:8:=0
		: (([InvoiceLine:54]qtyBackLogged:8<0) & ([InvoiceLine:54]qtyBackLogged:8>$dShipped))
			[InvoiceLine:54]qtyBackLogged:8:=0
		Else 
			[InvoiceLine:54]qtyBackLogged:8:=[InvoiceLine:54]qtyBackLogged:8-$dShipped
	End case 
	If ($isOrder)  // skip if there was no change to shipping qty
		$dOnOrd:=$dOnHand
		Case of 
			: ($qtyOn_Order>0)
				If ($dShipped>$qtyBL_Order)
					$addToOrd:=$dShipped-$qtyBL_Order
					$dOnOrd:=-$qtyBL_Order  // limit change in SO to BLqty
				End if 
			: ($qtyOn_Order<0)
				If ($dShipped<$qtyBL_Order)
					$addToOrd:=$dShipped-$qtyBL_Order
					$dOnOrd:=-$qtyBL_Order  // limit change in SO to BLqty
				End if 
		End case 
	End if 
End if 
$discntPrice:=DiscountApply(aiUnitPrice{$1}; aiDiscnt{$1}; <>tcDecimalUP)
$discntPrice:=aiUnitPriceDiscounted{$1}


//
If (((aiLocation{$1}=-1111) | (aiLocation{$1}=-1112)) & ($dOnHand#0))
	$BomID:=-DateTime_Enter
	aiUnitCost{$1}:=BOM_Consume(aiLocation{$1}; ->aiItemNum{$1}; $dOnHand; $BomID)  //no 5th paramater does not effect QOH
	aiExtCost{$1}:=Round:C94(aiQtyShip{$1}*aiUnitCost{$1}; <>tcDecimalTt)
	//If (vPackingProcess="PK")   This needs to be in Orders
	//Invt_dRecCreate ("PK";[Invoice]InvoiceNum;[Invoice]OrderNum;[Invoice]customerID;$BomID;"ivc+pk";$dAction;[InvoiceLine]LineNum;[InvoiceLine]ItemNum;-$dOnHand;-$dOnOrd;aiUnitCost{$1};"";vsiteID;$discntPrice)
	//Bom_FillArray (0)
	//Else 
	
	Invt_dRecCreate("BM"; [Invoice:26]idNum:2; [Invoice:26]idNumOrder:1; [Invoice:26]customerID:3; $BomID; "ivc+bom"; $dAction; [InvoiceLine:54]lineNum:3; [InvoiceLine:54]itemNum:4; -$dOnHand; -$dOnOrd; aiUnitCost{$1}; ""; vsiteID; $discntPrice)
	Bom_FillArray(0)
End if 
// InvoiceLines Direct
[InvoiceLine:54]qtyBackLogged:8:=aiQtyBL{$1}
[InvoiceLine:54]qty:7:=aiQtyShip{$1}
[InvoiceLine:54]unitPrice:9:=aiUnitPrice{$1}
[InvoiceLine:54]discount:10:=aiDiscnt{$1}
[InvoiceLine:54]discountedPrice:59:=aiUnitPriceDiscounted{$1}
[InvoiceLine:54]extendedPrice:11:=aiExtPrice{$1}
[InvoiceLine:54]unitCost:12:=aiUnitCost{$1}
[InvoiceLine:54]extendedCost:13:=aiExtCost{$1}
[InvoiceLine:54]taxJuris:14:=aiTaxable{$1}
[InvoiceLine:54]salesTax:15:=aiSaleTax{$1}
[InvoiceLine:54]commRateSales:23:=aiSalesRate{$1}
[InvoiceLine:54]commSales:17:=aiSaleComm{$1}
[InvoiceLine:54]commRateRep:18:=aiRepRate{$1}
[InvoiceLine:54]commRep:16:=aiRepComm{$1}
//
[InvoiceLine:54]unitofMeasure:19:=aiUnitMeas{$1}
[InvoiceLine:54]unitWt:20:=aiUnitWt{$1}
[InvoiceLine:54]extendedWt:21:=aiExtWt{$1}
[InvoiceLine:54]location:22:=aiLocation{$1}
[InvoiceLine:54]typeSale:27:=aiPricePt{$1}
[InvoiceLine:54]seq:28:=aiSeq{$1}
[InvoiceLine:54]producedBy:39:=aiProdBy{$1}
[InvoiceLine:54]comment:40:=aiLnComment{$1}
[InvoiceLine:54]shipOrderStatus:41:=aiShipOrdSt{$1}
[InvoiceLine:54]lineProfile1:42:=aiProfile1{$1}
[InvoiceLine:54]lineProfile2:43:=aiProfile2{$1}
[InvoiceLine:54]lineProfile3:44:=aiProfile3{$1}
[InvoiceLine:54]printNot:52:=aiPrintThis{$1}
//
READ ONLY:C145([Item:4])
If ([Item:4]itemNum:1#[InvoiceLine:54]itemNum:4)
	QUERY:C277([Item:4]; [Item:4]itemNum:1=[InvoiceLine:54]itemNum:4)
End if 
[InvoiceLine:54]typeItem:24:=[Item:4]type:26
[InvoiceLine:54]profile1:30:=[Item:4]profile1:35
[InvoiceLine:54]profile2:31:=[Item:4]profile2:36
[InvoiceLine:54]profile3:32:=[Item:4]profile3:37
[InvoiceLine:54]profile4:33:=[Item:4]profile4:38
[InvoiceLine:54]vendorID:38:=[Item:4]vendorID:45
UNLOAD RECORD:C212([Item:4])
READ WRITE:C146([Item:4])

// InvoiceLines Direct
[InvoiceLine:54]serialRc:26:=aiSerialRc{$1}
// InvoiceLines Direct
[InvoiceLine:54]serialRc:26:=[InvoiceLine:54]serialRc:26

If (aiSerialRc{$1}<<>ciSRThisSerialNumber)
	CREATE RECORD:C68([ItemSerialAction:64])
	
	[ItemSerialAction:64]itemSerialid:1:=Abs:C99([InvoiceLine:54]serialRc:26)
	QUERY:C277([ItemSerial:47]; [ItemSerial:47]idNum:18=[ItemSerialAction:64]itemSerialid:1)
	[ItemSerialAction:64]serialNum:2:=[ItemSerial:47]serialNum:4
	[ItemSerialAction:64]itemNum:8:=[ItemSerial:47]itemNum:1
	[ItemSerialAction:64]vendorID:14:=[Item:4]vendorID:45
	UNLOAD RECORD:C212([ItemSerial:47])
	[ItemSerialAction:64]action:7:=aiItemNum{$1}
	[ItemSerialAction:64]comment:5:=aiLnComment{$1}
	[ItemSerialAction:64]dateAction:6:=Current date:C33
	[ItemSerialAction:64]tableNum:3:=Table:C252(->[Invoice:26])
	[ItemSerialAction:64]docid:4:=[Invoice:26]idNum:2
	[ItemSerialAction:64]cost:10:=aiExtCost{$1}
	[ItemSerialAction:64]price:12:=aiExtPrice{$1}
	[ItemSerialAction:64]costType:11:=aiProfile1{$1}+("Assign"*Num:C11(aiProfile1{$1}=""))
	SAVE RECORD:C53([ItemSerialAction:64])
	UNLOAD RECORD:C212([ItemSerialAction:64])
End if 

// InvoiceLines Direct
[InvoiceLine:54]serialNum:36:=aiSerialNm{$1}
// InvoiceLines Direct
// ### bj ### 20190104_1423  why is this here??????
[InvoiceLine:54]serialNum:36:=[InvoiceLine:54]serialNum:36
// ### bj ### 20190104_1421  we were not saving the OrderNum in the InvoiceLines
[InvoiceLine:54]idNumOrder:60:=[Invoice:26]idNumOrder:1
// InvoiceLines Direct
C_LONGINT:C283($w)
If ($isOrder)
	If (aiLnOrdUnique{$1}>0)
		If ($dShipped#0)
			$w:=Find in array:C230(aoUniqueID; aiLnOrdUnique{$1})
			If ($w>0)
				If (vPackingProcess="PK")  // vPackingProcess should be = PK 
					//  no changes to the Order arrays
				Else 
					aOQtyOrder{$w}:=aOQtyOrder{$w}+$addToOrd
					aOQtyShip{$w}:=aOQtyShip{$w}+$dShipped  // negative number converts to a positive 
					aOQtyBL{$w}:=aOQtyBL{$w}+$dOnOrd
				End if 
				OrdLnExtend($w)
				Case of 
					: ((aOQtyBL{$w}=0) & ([OrderLine:49]dateShipped:39#[Invoice:26]dateShipped:4))
						[OrderLine:49]dateShipped:39:=[Invoice:26]dateShipped:4
					: ((aOQtyBL{$w}#0) & (aOQtyBL{$w}=aOQtyOrder{$w}))
						[OrderLine:49]dateShipped:39:=!00-00-00!
					Else   // partially shipped
						[OrderLine:49]dateShipped:39:=!2001-01-01!
				End case 
				OrdLn_RecordFill($w)
			Else 
				// this should never happen
				[InvoiceLine:54]description:5:="Error to Orderline: "+[InvoiceLine:54]description:5
			End if 
		End if 
	Else 
		$dAction:=4  // orderline created in an invoice
		// Modified by: William James (2013-12-05T00:00:00)  OrderLine Changes
		OrdLineCreateFromInvoice($1; vLineSeq)
		
	End if 
End if 
If ($dShipped#0)
	Case of 
		: (vPackingProcess="PK")  // from the packing window
			// change in On Order is already accounted for
			$dOnOrd:=0
			Invt_dRecCreate("IV"; [Invoice:26]idNum:2; [Invoice:26]idNumOrder:1; [Invoice:26]customerID:3; [Invoice:26]idNumProject:50; "ivc+PK"; $dAction; [InvoiceLine:54]idNum:47; [InvoiceLine:54]itemNum:4; $dOnHand; $dOnOrd; aiUnitCost{$1}; ""; vsiteID; $discntPrice)
		: ([InvoiceLine:54]idNumOrder:60>9)
			Invt_dRecCreate("IV"; [Invoice:26]idNum:2; [Invoice:26]idNumOrder:1; [Invoice:26]customerID:3; [Invoice:26]idNumProject:50; "ivc+direct"; $dAction; [InvoiceLine:54]idNum:47; [InvoiceLine:54]itemNum:4; $dOnHand; $dOnOrd; aiUnitCost{$1}; ""; vsiteID; $discntPrice)
		Else 
			Invt_dRecCreate("IV"; [Invoice:26]idNum:2; [Invoice:26]idNumOrder:1; [Invoice:26]customerID:3; [Invoice:26]idNumProject:50; "ivc+direct"; $dAction; [InvoiceLine:54]idNum:47; [InvoiceLine:54]itemNum:4; $dOnHand; $dOnOrd; aiUnitCost{$1}; ""; vsiteID; $discntPrice)
	End case 
End if 
aiLineAction{$1}:=10  //record number if Relate File
UNLOAD RECORD:C212([OrderLine:49])
SAVE RECORD:C53([InvoiceLine:54])
UNLOAD RECORD:C212([InvoiceLine:54])
