//%attributes = {"publishedWeb":true}

C_LONGINT:C283($1; $2)

// -- $error:=AL_SetArraysNam($1; 1; 9; "aPayInvs"; "aPayments"; "aPayOrig"; "aPayDate"; "aPayType"; "aPayCom"; "aPayOrds"; "aPayCust"; "aPayRecs")
// -- AL_SetHeaders($1; 1; 8; "Ref Inv"; "Amt Avail"; "Orig Amt"; "Paid"; "Type"; "Com"; "Ref Ord"; "Cust")
If ($2=2)
	// -- AL_SetWidths($1; 1; 8; 80; 80; 80; 70; 75; 80; 80; 80)  //update when filled
Else 
	// -- AL_SetWidths($1; 1; 8; 80; 80; 80; 70; 75; 80; 80; 80)
End if 
//
// -- AL_SetRowOpts($1; 0; 1; 0; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts($1; 1; 0; 1; 1; <>viPixel)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
// -- AL_SetEntryOpts($1; 1; 0; 0)
//Name; EntryMode; AllowReturn; DisplaySeconds
// -- AL_SetSortOpts($1; 0; 1; 1; ""; 0)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
//// -- AL_SetCallbacks ($1;"";"")
//Name; GP at entry; Function true or false if keep changes
//    // -- AL_SetSort ($1;2)
// -- AL_SetFormat($1; 2; <>tcFormatTt; 3; 2)
// -- AL_SetFormat($1; 3; <>tcFormatTt; 3; 2)
// -- AL_SetFormat($1; 1; "0000-0000"; 3; 2)
// -- AL_SetFormat($1; 7; "0000-0000"; 3; 2)
// -- AL_SetHdrStyle($1; 0; "Geneva"; 9; 2)
// -- AL_SetStyle($1; 0; "Geneva"; 10; 0)
// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetMiscOpts($1; 0; 1; ""; 0)
//Name; HideHeaders; AreaSelected; PostKey; ShowFooters