//%attributes = {"publishedWeb":true}
//Procedure: List_FillinvLns
//October 26, 1995
C_LONGINT:C283($i; $k)
If ((OptKey=1) & (CtlKey=1) & (CmdKey=1))
	SELECTION TO ARRAY:C260([InvoiceLine:54]invoiceNum:1; aLsSrRec; [InvoiceLine:54]itemNum:4; aLsItemNum; [InvoiceLine:54]description:5; aLsItemDesc; [InvoiceLine:54]qtyShipped:7; aLsQtyOH; [InvoiceLine:54]unitPrice:9; aLsQtySO; [InvoiceLine:54]discount:10; aLsQtyPO; [InvoiceLine:54]dateShipped:25; aLsDate)
	$k:=Size of array:C274(aLsItemNum)
	ARRAY REAL:C219(aLsPrice; $k)
	ARRAY REAL:C219(aLsCost; $k)
	ARRAY REAL:C219(aLsMargin; $k)
	ARRAY TEXT:C222(aLsText1; $k)
	ARRAY TEXT:C222(aLsText2; $k)
	ARRAY LONGINT:C221(aLsSrRec; $k)  //Record number([Item])
	ARRAY TEXT:C222(aLsDocType; $k)
	ARRAY LONGINT:C221(aLsLeadTime; $k)
	ARRAY REAL:C219(aLsDiscount; $k)  //Discount
	ARRAY REAL:C219(aLsDiscountPrice; $k)  //Discounted Price
	For ($i; 1; $k)
		aLsText1{$i}:=String:C10(aLsSrRec{$i})
		aLsSrRec{$i}:=-1  //Record number([Item])
		aLsDocType{$i}:="il"
		aLsLeadTime{$i}:=Current date:C33-aLsDate{$i}
	End for   //use "h" to trigger a search
Else 
	$k:=Records in selection:C76([InvoiceLine:54])
	If (($k>50) & (CmdKey=0))
		$k:=50
	End if 
	List_RaySize($k)
	LAST RECORD:C200([InvoiceLine:54])
	For ($i; 1; $k)
		aLsItemNum{$i}:=[InvoiceLine:54]itemNum:4
		aLsItemDesc{$i}:=[InvoiceLine:54]description:5
		aLsQtyOH{$i}:=[InvoiceLine:54]qtyShipped:7
		aLsQtySO{$i}:=[InvoiceLine:54]unitPrice:9
		aLsQtyPO{$i}:=[InvoiceLine:54]discount:10
		aLsDate{$i}:=[InvoiceLine:54]dateShipped:25
		aLsSrRec{$i}:=-1  //Record number([Item])
		aLsDocType{$i}:="il"
		aLsLeadTime{$i}:=Current date:C33-aLsDate{$i}
		//   
		aLsPrice{$i}:=0
		aLsCost{$i}:=0
		aLsMargin{$i}:=0
		aLsText1{$i}:=String:C10([InvoiceLine:54]invoiceNum:1)
		aLsText2{$i}:=""
		aLsDiscount{$i}:=0
		aLsDiscountPrice{$i}:=0
		//
		PREVIOUS RECORD:C110([InvoiceLine:54])
	End for 
End if 
UNLOAD RECORD:C212([InvoiceLine:54])