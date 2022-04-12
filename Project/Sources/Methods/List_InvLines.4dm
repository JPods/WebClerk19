//%attributes = {"publishedWeb":true}
//  List_InvLines (eItemOrd;aOItemNum{aoLineAction})//Last 5 buys of this itemp
//November 19, 1995    3:10 PM
MESSAGES OFF:C175
C_LONGINT:C283($1; $3)
C_POINTER:C301($2)
KeyModifierCurrent
If (ptCurTable=(->[PO:39]))
	QUERY:C277([POLine:40]; [POLine:40]itemNum:2=$2->; *)
	QUERY:C277([POLine:40];  & [POLine:40]vendorID:24=[PO:39]vendorID:1)
	If (OptKey=0)
		ORDER BY:C49([POLine:40]dateExpected:15; <)
		REDUCE SELECTION:C351([POLine:40]; 5)
	End if 
	$k:=Records in selection:C76([POLine:40])
	FIRST RECORD:C50([POLine:40])
	List_RaySize($k)
	TRACE:C157
	For ($i; 1; $k)
		aLsItemNum{$i}:=[POLine:40]itemNum:2
		aLsItemDesc{$i}:=[POLine:40]description:6
		aLsQtyOH{$i}:=[POLine:40]qtyOrdered:3
		aLsQtySO{$i}:=[POLine:40]unitCost:7
		aLsQtyPO{$i}:=[POLine:40]discount:8
		aLsDate{$i}:=[POLine:40]dateExpected:15
		aLsSrRec{$i}:=-1  //Record number([Item])
		aLsDocType{$i}:="pl"
		aLsLeadTime{$i}:=Current date:C33-aLsDate{$i}
		//
		aLsPrice{$i}:=0
		aLsCost{$i}:=0
		aLsMargin{$i}:=0
		aLsLeadTime{$i}:=0
		aLsText1{$i}:=""
		aLsText2{$i}:=""
		aLsDiscount{$i}:=0
		aLsDiscountPrice{$i}:=0
		//
		NEXT RECORD:C51([POLine:40])
	End for   //use "h" to trigger a search
	If ($1#0)
		// -- AL_SetHeaders($1; 1; 8; "T"; "Item Number"; "Vendor Description"; "Qty"; "Unit Cost"; "Discnt"; "Days"; "")
		// -- AL_SetHeaders($1; 9; 8; ""; ""; ""; ""; "Date Expected"; ""; ""; "")
		//  --  CHOPPED  AL_UpdateArrays($1; -2)
	End if 
	QUERY:C277([POLine:40]; [POLine:40]idNumPO:1=[PO:39]idNum:5)
Else 
	QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]itemNum:4=$2->; *)
	QUERY:C277([InvoiceLine:54];  & [InvoiceLine:54]customerID:2=[Customer:2]customerID:1)
	List_FillinvLns
	If ($1#0)
		// -- AL_SetHeaders($1; 1; 8; "T"; "Item Number"; "Inv Ln Description"; "Qty"; "Unit Price"; "Discnt"; "Days"; "")
		// -- AL_SetHeaders($1; 9; 8; ""; ""; ""; ""; "Date"; ""; ""; "")
		// -- AL_SetWidths($1; 1; 8; 3; 54; 128; 29; 39; 27; 3)
		// -- AL_SetWidths($1; 9; 8; 3; 3; 3; 3; <>wAlDate; 120; 120; 30)
		//  --  CHOPPED  AL_UpdateArrays($1; -2)
	End if 
	If ((ptCurTable=(->[Invoice:26])) & (Record number:C243([Invoice:26])>-1))
		QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]idNumInvoice:1=[Invoice:26]idNum:2)
	End if 
End if 
MESSAGES ON:C181