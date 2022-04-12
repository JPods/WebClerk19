//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-22T00:00:00, 01:48:17
// ----------------------------------------------------
// Method: InvoiceLinesorderlinesChange
// Description
// Modified: 01/22/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


[InvoiceLine:54]discountedPrice:59:=DiscountApply([InvoiceLine:54]unitPrice:9; [InvoiceLine:54]discount:10; <>tcDecimalUP)
Case of 
	: (vPackingProcess="PK")  //when operating from the PK window
		//TRACE
	: ($k<1)  //existing order line
		$dAction:=3
		$dOnOrd:=-MaxChange([OrderLine:49]qtyBackLogged:8; -$dOnHand)
		Case of 
			: ($dOnHand=0)
				//no action
			: (($dOnHand<0) & ([OrderLine:49]qtyOrdered:6>0) & ([OrderLine:49]qtyBackLogged:8<[InvoiceLine:54]qtyShipped:7))
				[OrderLine:49]qtyBackLogged:8:=0
				[OrderLine:49]backOrdAmount:26:=0
				[OrderLine:49]qtyOrdered:6:=[OrderLine:49]qtyOrdered:6-[InvoiceLine:54]qtyBackLogged:8
				[OrderLine:49]qtyShipped:7:=[OrderLine:49]qtyOrdered:6
				OrdLnExtendSub
			: (($dOnHand>0) & ([OrderLine:49]qtyOrdered:6<0) & ([OrderLine:49]qtyBackLogged:8>=[InvoiceLine:54]qtyShipped:7))
				[OrderLine:49]qtyOrdered:6:=[OrderLine:49]qtyOrdered:6-[InvoiceLine:54]qtyBackLogged:8
				[OrderLine:49]qtyShipped:7:=[OrderLine:49]qtyOrdered:6
				[OrderLine:49]qtyBackLogged:8:=0
				[OrderLine:49]backOrdAmount:26:=0
				OrdLnExtendSub
			Else 
				[OrderLine:49]qtyShipped:7:=[OrderLine:49]qtyShipped:7-$dOnHand  //when shipping $dOnHand is negative
				[OrderLine:49]qtyBackLogged:8:=[OrderLine:49]qtyOrdered:6-[OrderLine:49]qtyShipped:7
				[OrderLine:49]backOrdAmount:26:=Round:C94([OrderLine:49]qtyBackLogged:8*[InvoiceLine:54]discountedPrice:59; <>tcDecimalTt)
		End case 
End case 
Invt_dRecCreate("IV"; [Invoice:26]invoiceNum:2; [Invoice:26]orderNum:1; [Invoice:26]customerID:3; [Invoice:26]projectNum:50; "ivc+ship"; $dAction; [InvoiceLine:54]idNum:47; [InvoiceLine:54]itemNum:4; $dOnHand; $dOnOrd; [InvoiceLine:54]unitCost:12; ""; vsiteID; [InvoiceLine:54]discountedPrice:59)
//  zzzzzz
//  check to see if we should stay with the order value of pricing for backorder calc