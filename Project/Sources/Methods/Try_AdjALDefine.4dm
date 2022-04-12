//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)
// -- $error:=AL_SetArraysNam($1; 1; 8; "aStkType"; "aStkReceiptID"; "aStkPOLnNum"; "aStkJrl"; "aStkItem"; "aStkOrQty"; "aStkOrCost"; "aStkNwCost")
// -- $error:=AL_SetArraysNam($1; 9; 8; "aStkDuty"; "aStkNonPd"; "aStkVAT"; "aStkWt"; "aStkWayBill"; "aStkPOLnRec"; "aStkRec"; "aStkDocID")

// -- AL_SetHeaders($1; 1; 8; "Type"; "Receipt ID"; "POLn"; "GL"; "Item"; "Qty"; "Orig Cost"; "New Cost")
// -- AL_SetHeaders($1; 9; 8; "Type"; "Duty"; "Non-Prod"; "VAT"; "Wt"; "WayBill"; "POLnRec"; "StkRec"; "DocID")

// -- AL_SetWidths($1; 1; 8; 3; 58; 16; 14; 75; 62; 62; 60)
// -- AL_SetWidths($1; 9; 8; 63; 67; 66; 66; 66; 60; 60; 58)

// -- AL_SetRowOpts($1; 1; 0; 0; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts($1; 1; 0; 1; 0; 0)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
// -- AL_SetEntryOpts($1; 6; 1; 1; 0)
//Name; EntryMode; AllowReturn; DisplaySeconds
// -- AL_SetSortOpts($1; 0; 1; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
//// -- AL_SetCallbacks ($1;"Ord_WFALCBEntry";"Ord_WFALCBExit")
//Name; GP at entry; Function true or false if keep changes
//    // -- AL_SetSort ($1;2)

// -- AL_SetFormat($1; 6; "###,###,###.#####"; 0; 2)
// -- AL_SetFormat($1; 7; <>tcFormatTt; 3; 2)
// -- AL_SetFormat($1; 8; <>tcFormatTt; 3; 2)
// -- AL_SetFormat($1; 9; <>tcFormatTt; 3; 2)
// -- AL_SetFormat($1; 10; <>tcFormatTt; 3; 2)
// -- AL_SetFormat($1; 11; <>tcFormatTt; 3; 2)
// -- AL_SetFormat($1; 12; <>tcFormatTt; 3; 2)
// -- AL_SetFormat($1; 16; "0000-0000"; 3; 2)

// -- AL_SetHdrStyle($1; 1; "Geneva"; 9; 2)
// -- AL_SetHdrStyle($1; 2; "Geneva"; 9; 2)
// -- AL_SetHdrStyle($1; 3; "Geneva"; 9; 2)
// -- AL_SetHdrStyle($1; 4; "Geneva"; 9; 2)
// -- AL_SetHdrStyle($1; 5; "Geneva"; 9; 2)
// -- AL_SetHdrStyle($1; 6; "Geneva"; 9; 2)
// -- AL_SetHdrStyle($1; 7; "Geneva"; 9; 2)
// -- AL_SetHdrStyle($1; 8; "Geneva"; 9; 0)
// -- AL_SetHdrStyle($1; 9; "Geneva"; 9; 0)
// -- AL_SetHdrStyle($1; 10; "Geneva"; 9; 0)
// -- AL_SetHdrStyle($1; 11; "Geneva"; 9; 0)
// -- AL_SetHdrStyle($1; 12; "Geneva"; 9; 0)
// -- AL_SetHdrStyle($1; 13; "Geneva"; 9; 0)
// -- AL_SetHdrStyle($1; 14; "Geneva"; 9; 2)
// -- AL_SetHdrStyle($1; 15; "Geneva"; 9; 2)
// -- AL_SetHdrStyle($1; 16; "Geneva"; 9; 2)
// -- AL_SetStyle($1; 0; "Geneva"; 12; 0)
// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetMiscOpts($1; 0; 1; ""; 0)