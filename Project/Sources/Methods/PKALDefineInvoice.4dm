//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method:Method: PKALDefineInvoice
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//


C_LONGINT:C283($1; $theArea)
C_TEXT:C284($fontName; $2)
C_LONGINT:C283($3; $4; $fontSize; $styleLayout)
If (Count parameters:C259<3)
	$theArea:=eLoadList
	$fontName:="Geneva"
	$fontSize:=9
	$styleLayout:=0
Else 
	$theArea:=$1
	$fontName:=$2
	$fontSize:=$3
	$styleLayout:=$4
End if 
//
// -- $error:=AL_SetArraysNam($1; 1; 6; "aInvoices"; "aInvDate"; "aCustPO"; "aOrders"; "aInvCust"; "aInvRecs")
// -- AL_SetHeaders($1; 1; 6; "Invoice"; "Date"; "CustPO"; "Order"; "Cust"; "RecNum")

// -- AL_SetWidths($1; 1; 6; 59; 59; 53; 60; 22; 24; 58; 60; 60; 60; 60; 60)
//
// -- AL_SetRowOpts($1; 1; 1; 1; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts($1; 1; 0; 1; 1; <>viPixel)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
// -- AL_SetEntryOpts($1; 1; 0; 0)
//Name; EntryMode; AllowReturn; DisplaySeconds
// -- AL_SetSortOpts($1; 0; 1; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
//// -- AL_SetCallbacks ($1;"";"")
//Name; GP at entry; Function true or false if keep changes
//    // -- AL_SetSort ($1;7)
// -- AL_SetFormat($1; 1; "0000-0000"; 3; 2)
// -- AL_SetFormat($1; 2; <>tcFormatTt; 3; 2)
// -- AL_SetFormat($1; 3; <>tcFormatTt; 3; 2)
// -- AL_SetFormat($1; 4; <>tcFormatTt; 3; 2)
// -- AL_SetFormat($1; 7; "1"; 0; 0)  //date
// -- AL_SetFormat($1; 10; <>tcFormatTt; 3; 2)
// -- AL_SetFormat($1; 11; "0000-0000"; 3; 2)
// -- AL_SetHdrStyle($1; 0; "Geneva"; 9; 2)
// -- AL_SetStyle($1; 0; "Geneva"; 12; 0)
// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
//
// -- AL_SetMiscOpts($1; 0; 1; ""; 0)
//Name; HideHeaders; AreaSelected; PostKey; ShowFooters