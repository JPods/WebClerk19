//%attributes = {"publishedWeb":true}
srCustomer:=""
srPhone:=""
srVndAlpha:=""
srZip:=""
srLstName:=""
C_LONGINT:C283(viVendSel)
viVendSel:=0
Vnd_FillLwItms(0)
ARRAY LONGINT:C221(aLwVndLines; 0)
//$error:=// -- AL_SetArrays (eLowVndList;1;3;aVndAlpha;aVndCompany;aVendRec)
// -- $error:=AL_SetArraysNam(eLowVndList; 1; 3; "aVndAlpha"; "aVndCompany"; "aVendRec")
// -- AL_SetHeaders(eLowVndList; 1; 2; "Account"; "Company")
// -- AL_SetWidths(eLowVndList; 1; 2; 61; 110)
//
// -- AL_SetRowOpts(eLowVndList; 1; 0; 0; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts(eLowVndList; 1; 0; 1; 1; 0)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
// -- AL_SetEntryOpts(eLowVndList; 1; 0; 0)
//Name; EntryMode; AllowReturn; DisplaySeconds
// -- AL_SetSortOpts(eLowVndList; 0; 1; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
//// -- AL_SetCallbacks (eLowVndList;"";"")
//Name; GP at entry; Function true or false if keep changes
// -- AL_SetSort(eLowVndList; 1)
//
// -- AL_SetHdrStyle(eLowVndList; 0; "Geneva"; 9; 2)
// -- AL_SetStyle(eLowVndList; 0; "Geneva"; 12; 0)
// -- AL_SetDividers(eLowVndList; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetMiscOpts(eLowVndList; 0; 1; ""; 0)
//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
//
C_LONGINT:C283(viVert; viHorz)
viVert:=0
viHorz:=0
C_LONGINT:C283(doSearch)
doSearch:=0
C_LONGINT:C283(viItemSel)
viItemSel:=0
C_LONGINT:C283(vOrdNum)
vOrdNum:=0
C_LONGINT:C283($cntRecs; $index; $w)
If (myOK=11)
	myOK:=0
	C_DATE:C307($baseDate)
	$baseDate:=Date_ThisMon(Current date:C33; 1)+1
	FIRST RECORD:C50([Item:4])
	$cntRecs:=Records in selection:C76([Item:4])
	C_REAL:C285($leadQty; $qtyShort)
	TRACE:C157
	For ($index; 1; $cntRecs)
		If (OptKey=1)
			QUERY:C277([Usage:5]; [Usage:5]itemNum:1=[Item:4]itemNum:1; *)
			QUERY:C277([Usage:5];  & [Usage:5]periodDate:2=$baseDate)
			$leadQty:=Round:C94([Usage:5]salesQtyPlan:3*([Item:4]leadTimeSales:12/30); 0)
		End if 
		
		// If ($qtyShort<0)
		$w:=Find in array:C230(<>aPartNum; [Item:4]itemNum:1)
		If ($w>0)
			$qtyShort:=<>aReal1{$w}-[Item:4]qtyMinStock:18
			$forecast:=<>aReal1{$w}
		Else 
			$qtyShort:=[Item:4]qtyOnHand:14+[Item:4]qtyOnPo:20-[Item:4]qtyOnSalesOrder:16-$leadQty-[Item:4]qtyMinStock:18
			$forecast:=0
		End if 
		Itm_FillLowVend(1; 1; 1; $qtyShort; $leadQty)  //action; element; num elements; short; forecast
		aLitmFrcst{Size of array:C274(aLitmFrcst)}:=$forecast
		//  End if 
		
		NEXT RECORD:C51([Item:4])
	End for 
	ARRAY TEXT:C222(<>aPartNum; 0)
	ARRAY REAL:C219(<>aReal1; 0)
	doSearch:=2000
Else 
	Itm_FillLowVend(0; 0; 0; 0; 0)
End if 
ARRAY LONGINT:C221(aLwItmLines; 0)
//
// -- $error:=AL_SetArraysNam(eLwItmList; 1; 12; "aLItmAlpha"; "aLItmDesc"; "aLItmQtyLow"; "aLItmOnHand"; "aLItmOnPO"; "aLItmOnSO"; "aLitmFrcst"; "aLItmQtyMin"; "aLItmCosts"; "aLItmLeadTm"; "aLItmVend"; "aLItmRecNum")
// -- AL_SetHeaders(eLwItmList; 1; 11; "Item Num"; "Description"; "Low By"; "on Hand"; "on PO"; "on SO"; "Frcast"; "Min"; "Cost"; "Lead"; "Vendor")
// -- AL_SetWidths(eLwItmList; 1; 11; 60; 83; 40; 40; 40; 40; 40; 40; 55; 30; 70)
//
// -- AL_SetRowOpts(eLwItmList; 1; 0; 0; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts(eLwItmList; 1; 0; 1; 1; 1)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
// -- AL_SetEntryOpts(eLwItmList; 1; 0; 0)
//Name; EntryMode; AllowReturn; DisplaySeconds
// -- AL_SetSortOpts(eLwItmList; 0; 1; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
//// -- AL_SetCallbacks (eLwItmList;"";"")
//Name; GP at entry; Function true or false if keep changes
// -- AL_SetSort(eLwItmList; 1)
// -- AL_SetMiscOpts(eLwItmList; 0; 1; ""; 0)
//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
//
// -- AL_SetFormat(eLwItmList; 3; "###,###,###"; 3; 2)  //qty low
// -- AL_SetFormat(eLwItmList; 4; "###,###,###"; 3; 2)  //on hand
// -- AL_SetFormat(eLwItmList; 5; "###,###,###"; 3; 2)  //on po
// -- AL_SetFormat(eLwItmList; 6; "###,###,###"; 3; 2)  //on so
// -- AL_SetFormat(eLwItmList; 7; "###,###,###"; 3; 2)  //Forecast
// -- AL_SetFormat(eLwItmList; 8; "###,###,###"; 3; 2)  //Qty min
// -- AL_SetFormat(eLwItmList; 9; <>tcFormatUC; 3; 2)
//
// -- AL_SetHdrStyle(eLwItmList; 0; "Geneva"; 9; 2)
// -- AL_SetStyle(eLwItmList; 0; "Geneva"; 12; 0)
// -- AL_SetDividers(eLwItmList; "Gray"; "Gray"; 0; ""; ""; 0)
// -- //  --  CHOPPED  AL_UpdateArrays(eLwItmList; -2)