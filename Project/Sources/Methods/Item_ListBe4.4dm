//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 04/27/10, 11:58:23
// ----------------------------------------------------
// Method: Item_ListBe4
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($error)
C_LONGINT:C283($1; $2; $doLevel)
If (Count parameters:C259=2)
	$doLevel:=$2
Else 
	$doLevel:=1
End if 
//If (Count parameters=0)
//$1:=eItemList
//Else 
//$1:=eQuickQuote 
//End if 
srItem:=""
srItemDscrp:=""
srItemType:=""
srItemsProfile1:=""
srItemsProfile2:=""
srItemsProfile3:=""
srItemsProfile4:=""
vi1:=1
//QtyAvailable, QtyAllocated, QtyVirtual, BackOrderStatus, Retired
ARRAY LONGINT:C221(aItemLines; 0)
If ($doLevel=2)
	//  CHOPPED  AL_RemoveArrays($1; 1; 20)
	//   CHOPPED  $error:=AL_InsArraysNam($1; 1; 9; "aLsDocType"; "aLsItemNum"; "aLsItemDesc"; "aLsQtyOH"; "aLsQtySO"; "aLsQtyPO"; "aLsLeadTime"; "aLsDiscountPrice"; "aLsDiscount")
	//   CHOPPED  $error:=AL_InsArraysNam($1; 10; 7; "aLsPrice"; "aLsCost"; "aLSMargin"; "aLsDate"; "aLsText1"; "aLsText2"; "aLsSrRec")
Else 
	// -- $error:=AL_SetArraysNam($1; 1; 9; "aLsDocType"; "aLsItemNum"; "aLsItemDesc"; "aLsQtyOH"; "aLsQtySO"; "aLsQtyPO"; "aLsLeadTime"; "aLsDiscountPrice"; "aLsDiscount")
	// -- $error:=AL_SetArraysNam($1; 10; 7; "aLsPrice"; "aLsCost"; "aLSMargin"; "aLsDate"; "aLsText1"; "aLsText2"; "aLsSrRec")
End if 



If ($error#0)
	ALERT:C41("Error: "+String:C10($error)+" in  Item_ListBe4")
End if 
//$error:=// -- AL_SetArraysNam ($1;1;15;"aBackOrder";"aPartNum";"aPartDesc";
//"aQtyOnHand";"aQtyOrd";"aQtyOnPOLns";"aLeadTime";"aQtyRecds";"aCosts";
//"aPartQty";"aItmText1";"aItmText2";"aItemSrRec")


//// -- AL_SetHeaders ($1;1;9;"T";"Item Number";"Description";"On Hand";"On S/O";"On P/O";"Lead";"Disc Price";"Discount")
//// -- AL_SetHeaders ($1;10;7;"Price";"Cost";"Margin";"Dt";"T1";"T2";"Rec")//;"Rec")




//### jwm ### 20100818 switch headers based on Qty shown
KeyModifierCurrent
If (<>vbQtyAvailable)
	If (OptKey=0)
		// -- AL_SetHeaders($1; 1; 9; "T"; "Item Number"; "Description"; "Available"; "On S/O"; "On P/O"; "Lead"; "Disc Price"; "Discount")
		// -- AL_SetHeaders($1; 10; 7; "Price"; "Cost"; "Margin"; "Dt"; "T1"; "T2"; "Rec")  //;"Rec")
	Else 
		// -- AL_SetHeaders($1; 1; 9; "T"; "Item Number"; "Description"; "On Hand"; "On S/O"; "On P/O"; "Lead"; "Disc Price"; "Discount")
		// -- AL_SetHeaders($1; 10; 7; "Price"; "Cost"; "Margin"; "Dt"; "T1"; "T2"; "Rec")  //;"Rec")
	End if 
Else 
	If (OptKey=1)
		// -- AL_SetHeaders($1; 1; 9; "T"; "Item Number"; "Description"; "Available"; "On S/O"; "On P/O"; "Lead"; "Disc Price"; "Discount")
		// -- AL_SetHeaders($1; 10; 7; "Price"; "Cost"; "Margin"; "Dt"; "T1"; "T2"; "Rec")  //;"Rec")
	Else 
		// -- AL_SetHeaders($1; 1; 9; "T"; "Item Number"; "Description"; "On Hand"; "On S/O"; "On P/O"; "Lead"; "Disc Price"; "Discount")
		// -- AL_SetHeaders($1; 10; 7; "Price"; "Cost"; "Margin"; "Dt"; "T1"; "T2"; "Rec")  //;"Rec")
	End if 
End if 






C_LONGINT:C283(eQuickQuote; eItemInv; eItemOrd; eItemPo; eItemPp)
C_LONGINT:C283(eItemList)  //Adjustments
Case of 
	: ($1=eQuickQuote)
		// -- AL_SetWidths($1; 1; 9; <>aeQuickQuote{1}; <>aeQuickQuote{2}; <>aeQuickQuote{3}; <>aeQuickQuote{4}; <>aeQuickQuote{5}; <>aeQuickQuote{6}; <>aeQuickQuote{7}; <>aeQuickQuote{8}; <>aeQuickQuote{9})
		// -- AL_SetWidths($1; 10; 7; <>aeQuickQuote{10}; <>aeQuickQuote{11}; <>aeQuickQuote{12}; <>aeQuickQuote{13}; <>aeQuickQuote{14}; <>aeQuickQuote{15}; <>aeQuickQuote{16})
	: (($1=eItemInv) | ($1=eItemOrd) | ($1=eItemPo) | ($1=eItemPp))
		
		// -- AL_SetWidths($1; 1; 9; <>aeListItems{1}; <>aeListItems{2}; <>aeListItems{3}; <>aeListItems{4}; <>aeListItems{5}; <>aeListItems{6}; <>aeListItems{7}; <>aeListItems{8}; <>aeListItems{9})
		// -- AL_SetWidths($1; 10; 7; <>aeListItems{10}; <>aeListItems{11}; <>aeListItems{12}; <>aeListItems{13}; <>aeListItems{14}; <>aeListItems{15}; <>aeListItems{16})
		
	Else 
		// -- AL_SetWidths($1; 1; 9; 12; 65; 100; 51; 51; 51; 45; 47; 10)
		// -- AL_SetWidths($1; 10; 8; 51; 35; 51; 51; 3; 50; 50; 50)
		
End case 
//
// -- AL_SetRowOpts($1; 1; 0; 0; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts($1; 1; 0; 1; 0; <>viPixel)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
// -- AL_SetEntryOpts($1; 1; 0; 0)
//Name; EntryMode; AllowReturn; DisplaySeconds
// -- AL_SetSortOpts($1; 0; 1; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
//// -- AL_SetCallbacks ($1;"";"")
//Name; GP at entry; Function true or false if keep changes
// -- AL_SetSort($1; 2)
//
//// -- AL_SetRowColor ($1;0;"Black";0;"white";0)
// -- AL_SetFormat($1; 4; "###,###.####"; 3; 2)
// -- AL_SetFormat($1; 5; "###,###.####"; 3; 2)
// -- AL_SetFormat($1; 6; "###,###.####"; 3; 2)
// -- AL_SetFormat($1; 7; "###,###.####"; 3; 2)
// -- AL_SetFormat($1; 8; <>tcFormatUP; 3; 2)
// -- AL_SetFormat($1; 9; "##0.###%"; 3; 2)
// -- AL_SetFormat($1; 11; <>tcFormatUC; 3; 2)
// -- AL_SetFormat($1; 12; "###,##0.0"; 3; 2)
// -- AL_SetFormat($1; 13; "1"; 0; 0)  //date
// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetMiscOpts($1; 0; 1; ""; 0)
//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
//

// -- AL_SetHdrStyle($1; 0; "Arial"; 9; 2)
// -- AL_SetStyle($1; 0; "Arial"; 12; 0)
