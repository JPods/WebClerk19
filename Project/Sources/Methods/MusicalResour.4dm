//%attributes = {"publishedWeb":true}
//Procedure: MusicalResour
TRACE:C157
QUERY:C277([Invoice:26]; [Invoice:26]orderNum:1=[Order:3]orderNum:2)
SELECTION TO ARRAY:C260([Invoice:26]amount:14; aReal1; [Invoice:26]salesTax:19; aReal2; [Invoice:26]shipTotal:20; aReal3; [Invoice:26]total:18; aReal4)
$k:=Size of array:C274(aReal1)
vR1:=0
vR2:=0
vR3:=0
vR4:=0
FIRST RECORD:C50([Invoice:26])
For ($i; 1; $k)
	vR1:=vR1+aReal1{$i}  //[Invoice]Amount
	vR2:=vR2+aReal2{$i}  //[Invoice]SalesTax
	vR3:=vR3+aReal3{$i}  //[Invoice]ShipTotal
	vR4:=vR4+aReal4{$i}  //[Invoice]Total
	If ([Order:3]completeid:83>1)
		[Invoice:26]dateShipped:4:=[Order:3]dateInvoiceComp:6
		[Invoice:26]dateInvoiced:35:=[Order:3]dateInvoiceComp:6
		SAVE RECORD:C53([Invoice:26])
		Ledger_InvSave
		NEXT RECORD:C51([Invoice:26])
	End if 
End for 
RELATE MANY SELECTION:C340([InvoiceLine:54]invoiceNum:1)
SELECTION TO ARRAY:C260([InvoiceLine:54]itemNum:4; aTmp35Str1; [InvoiceLine:54]description:5; aTmp80Str1; [InvoiceLine:54]qtyShipped:7; aTmpReal1; [InvoiceLine:54]unitPrice:9; aTmpReal2; [InvoiceLine:54]discount:10; aTmpReal3; [InvoiceLine:54]extendedPrice:11; aTmpReal4)
$k:=Size of array:C274(aTmp35Str1)
ARRAY TEXT:C222(aTmpText1; $k)
ARRAY REAL:C219(aTmpReal5; $k)
ARRAY REAL:C219(aTmpReal6; $k)
ARRAY REAL:C219(aTmpReal7; $k)
C_LONGINT:C283($i; $k)
vR6:=0
vR7:=0
SORT ARRAY:C229(aTmp35Str1; aTmp80Str1; aTmpReal1; aTmpReal2; aTmpReal3; aTmpReal4)
For ($i; $k; 1; -1)
	If (aTmpReal1{$i}=0)
		DELETE FROM ARRAY:C228(aTmp35Str1; $i; 1)  //item num
		DELETE FROM ARRAY:C228(aTmp80Str1; $i; 1)  //item description
		DELETE FROM ARRAY:C228(aTmpReal1; $i; 1)  //Qty Shipped
		DELETE FROM ARRAY:C228(aTmpReal2; $i; 1)  //Unit Price
		DELETE FROM ARRAY:C228(aTmpReal3; $i; 1)  //Discount
		DELETE FROM ARRAY:C228(aTmpReal4; $i; 1)  //ExtendedPrice
		DELETE FROM ARRAY:C228(aTmpText1; $i; 1)  //[Item]VendorID
		DELETE FROM ARRAY:C228(aTmpReal5; $i; 1)  //Disc Unit Price
		DELETE FROM ARRAY:C228(aTmpReal6; $i; 1)  //Disc ExtendedPrice
		DELETE FROM ARRAY:C228(aTmpReal7; $i; 1)  //ExtendedPrice
		
		//    vR5:=vR5+aTmpReal5{$i}//Discounted Total Price
		// vR6:=vR6+aTmpReal6{$i}//Normal Total Price
	Else 
		aTmpReal5{$i}:=Round:C94(DiscountApply(aTmpReal2{$i}; aTmpReal3{$i}; 10); <>tcDecimalUP)
		aTmpReal6{$i}:=Round:C94(aTmpReal1{$i}*aTmpReal5{$i}; <>tcDecimalTt)
		aTmpReal7{$i}:=Round:C94(aTmpReal1{$i}*aTmpReal2{$i}; <>tcDecimalTt)
		vR6:=vR6+aTmpReal6{$i}  //total discounted price
		vR7:=vR7+aTmpReal7{$i}  //total standard price
		If ([Item:4]itemNum:1#aTmp35Str1{$i})
			QUERY:C277([Item:4]; [Item:4]itemNum:1=aTmp35Str1{$i})
			If ([Item:4]vendorID:45#[Vendor:38]vendorID:1)
				QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[Item:4]vendorID:45)
			End if 
		End if 
		aTmpText1{$i}:=[Vendor:38]company:2
	End if 
End for 
UNLOAD RECORD:C212([Invoice:26])
UNLOAD RECORD:C212([InvoiceLine:54])
//
vR8:=Round:C94(vR6+vR2+vR3; 2)
vR9:=Round:C94(vR7+vR2+vR3; 2)
QUERY:C277([Term:37]; [Term:37]termID:1=[Order:3]terms:23)
vText3:="For payment within "+String:C10([Term:37]dueDays:3)+" days of Invoice Date you may deduct "+(String:C10(vR7-vR6; "###,###,##0.00"))
vText3:=vText3+" and pay only "+(String:C10(vR8; "###,###,##0.00"))+"."
vText3:=vText3*Num:C11((vR7-vR6)#0)
vText4:="Disc"*Num:C11(vR5#0)
//