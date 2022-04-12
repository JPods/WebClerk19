//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-22T00:00:00, 01:08:58
// ----------------------------------------------------
// Method: invoicelinedelete
// Description
// Modified: 01/22/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
C_REAL:C285($dOnHand; $dOnOrd; $discntPrice)
$discntPrice:=DiscountApply([InvoiceLine:54]unitPrice:9; [InvoiceLine:54]discount:10; <>tcDecimalUP)
$dOnHand:=0
$dOnOrd:=0
If (<>vbDoSrlNums)
	Case of 
		: ([InvoiceLine:54]serialRc:26>0)
			Srl_SalvageSale([InvoiceLine:54]serialRc:26)  //salvage deleted lines      
		: ([InvoiceLine:54]serialRc:26<<>ciSRThisSerialNumber)
			CREATE RECORD:C68([ItemSerialAction:64])
			
			[ItemSerialAction:64]itemSerialid:1:=Abs:C99([InvoiceLine:54]serialRc:26)
			QUERY:C277([ItemSerial:47]; [ItemSerial:47]idNum:18=[ItemSerialAction:64]itemSerialid:1)
			[ItemSerialAction:64]serialNum:2:=[ItemSerial:47]serialNum:4
			[ItemSerialAction:64]itemNum:8:=[ItemSerial:47]itemNum:1
			UNLOAD RECORD:C212([ItemSerial:47])
			[ItemSerialAction:64]action:7:="Reference removed."
			[ItemSerialAction:64]dateAction:6:=Current date:C33
			[ItemSerialAction:64]tableNum:3:=Table:C252(->[Invoice:26])
			[ItemSerialAction:64]docid:4:=[Invoice:26]invoiceNum:2
			[ItemSerialAction:64]cost:10:=0
			[ItemSerialAction:64]costType:11:=""
			SAVE RECORD:C53([ItemSerialAction:64])
			UNLOAD RECORD:C212([ItemSerialAction:64])
	End case 
End if 
$dOnHand:=[InvoiceLine:54]qtyShipped:7
If ([Invoice:26]orderNum:1>1)
	If ([InvoiceLine:54]orderLineNum:48>-1)  // There is an order line
		QUERY:C277([OrderLine:49]; [OrderLine:49]idNum:50=[InvoiceLine:54]orderLineNum:48)  // get the [Orderline] Record
		$dOnOrd:=MaxChange(([OrderLine:49]qtyBackLogged:8+[InvoiceLine:54]qtyShipped:7); [InvoiceLine:54]qtyShipped:7)
		[OrderLine:49]qtyShipped:7:=[OrderLine:49]qtyShipped:7-[InvoiceLine:54]qtyShipped:7
		[OrderLine:49]qtyBackLogged:8:=[OrderLine:49]qtyOrdered:6-[OrderLine:49]qtyShipped:7
		If ([OrderLine:49]qtyBackLogged:8>0)
			[OrderLine:49]complete:48:=False:C215
		End if 
		[OrderLine:49]backOrdAmount:26:=Round:C94([OrderLine:49]qtyBackLogged:8*$discntPrice; <>tcDecimalTt)
		Case of 
			: (([OrderLine:49]qtyBackLogged:8=0) & ([OrderLine:49]dateShipped:39#[Invoice:26]dateShipped:4))
				[OrderLine:49]dateShipped:39:=[Invoice:26]dateShipped:4
				
			: ([OrderLine:49]qtyBackLogged:8#0)
				[OrderLine:49]dateShipped:39:=!00-00-00!
				
		End case 
		
		// Modified by: William James (2013-12-05T00:00:00)  OrderLine Changes
		// Modified by: William James (2013-12-12T00:00:00)
		[OrderLine:49]dateShipOn:38:=[OrderLine:49]dateShipped:39
		[OrderLine:49]qtyShipped:7:=[OrderLine:49]qtyShipped:7
		[OrderLine:49]qtyBackLogged:8:=[OrderLine:49]qtyBackLogged:8
		[OrderLine:49]backOrdAmount:26:=[OrderLine:49]backOrdAmount:26
		//
		SAVE RECORD:C53([OrderLine:49])
	End if 
End if 
If ((Size of array:C274(<>asiteIDs)>1) & (vsiteID=""))
	If ([Invoice:26]siteid:86="")
		vsiteID:="error"
	Else 
		vsiteID:=[Invoice:26]siteid:86
	End if 
End if 
Invt_dRecCreate("IV"; [Invoice:26]invoiceNum:2; [Invoice:26]orderNum:1; [Invoice:26]customerID:3; [Invoice:26]projectNum:50; "Inv ln delete"; 1; [InvoiceLine:54]idNum:47; [InvoiceLine:54]itemNum:4; $dOnHand; $dOnOrd; [InvoiceLine:54]unitCost:12; ""; vsiteID; $discntPrice)
$script:="[SyncRecord]TextSample:="+Txt_Quoted("Deleted Line from Invoice: ")+"+string([InvoiceLine]Invoicenum)"
//RP_CreateSyncRecord (->[InvoiceLine];$script)  //just builds the Sync Record
DELETE RECORD:C58([InvoiceLine:54])