//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)
// -- $error:=AL_SetArraysNam($1; 1; 15; "aPoRcptVendorID"; "aPoRcptJrnlID"; "aPoRcptID"; "aPoRcptPONum"; "aPoRcptPackID"; "aPoRcptPackDate"; "aPoRcptInvNum"; "aPoRcptInvDate"; "aPoRcptValue"; "aPoRcptInvAmount"; "aPoRcptInvFrght"; "aPoRcptDuty"; "aPoRcptNonProduct"; "aPoRcptVAT"; aPoRcptRecNum)



// -- AL_SetHeaders($1; 1; 15; "VendorID"; "JrnlID"; "ReceiptID"; "PONum"; "PackID"; "PackDate"; "InvoiceID"; "InvoiceDate"; "ReceiptValue"; "InvAmount"; "InvFreight"; "InvDuty"; "InvNP"; "InvVAT"; "RecNum")
// -- AL_SetWidths($1; 1; 15; 3; 3; 54; 54; 54; 3; 62; 60; 63; 67; 66; 66; 66; 60)

// -- AL_SetRowOpts($1; 1; 0; 0; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts($1; 1; 0; 1; 0; 1)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
// -- AL_SetEntryOpts($1; 6; 1; 1; 0)
//Name; EntryMode; AllowReturn; DisplaySeconds
// -- AL_SetSortOpts($1; 0; 1; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
//// -- AL_SetCallbacks ($1;"Ord_WFALCBEntry";"Ord_WFALCBExit")
//Name; GP at entry; Function true or false if keep changes
//    // -- AL_SetSort ($1;2)
//


// -- AL_SetHdrStyle($1; 0; "Geneva"; 9; 0)
// -- AL_SetStyle($1; 0; "Geneva"; 12; 0)
// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetMiscOpts($1; 0; 1; ""; 0)
//
// -- AL_SetFormat($1; 2; "0000-0000"; 3; 2)
// -- AL_SetFormat($1; 3; "0000-0000"; 3; 2)
// -- AL_SetFormat($1; 4; "0000-0000"; 3; 2)
//
// -- AL_SetFormat($1; 9; <>tcFormatUC; 0; 0)  //RecptValue
// -- AL_SetFormat($1; 10; <>tcFormatUC; 0; 0)  //Inv Amt
// -- AL_SetFormat($1; 11; <>tcFormatUC; 0; 0)  //Frght
// -- AL_SetFormat($1; 12; <>tcFormatUC; 0; 0)  //Duty
// -- AL_SetFormat($1; 13; <>tcFormatUC; 0; 0)  //NP
// -- AL_SetFormat($1; 14; <>tcFormatUC; 0; 0)  //VAT