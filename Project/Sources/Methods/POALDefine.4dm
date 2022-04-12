//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/21/07, 12:03:24
// ----------------------------------------------------
// Method: Method: POALDefine
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283(ePoLines)
//
//
// -- $error:=AL_SetArraysNam(ePOs; 1; 13; "aPODate"; "aPOs"; "aPOBuyer"; "aPOStatusVendor"; "aPOStatus"; "aVendors"; "aPOAttn"; "aPOSONum"; "aPOCustomerRef"; "aPOShipTo"; "aPOOpenAmt"; "aPOTotal"; "aPORecs")
// -- AL_SetHeaders(ePOs; 1; 13; "Date Ordered"; "PO Num"; "Buyer"; "VStatus"; "Status"; "Vendor"; "Attn"; "SONum"; "CustRef"; "Ship To"; "Open Amnt"; "Total"; "Rec Num")
// -- AL_SetWidths(ePOs; 1; 13; 54; 58; 58; 58; 58; 58; 72; 81; 68; 77; 60; 60; 54)
//
// -- AL_SetRowOpts(ePOs; 1; 1; 0; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts(ePOs; 1; 0; 1; 0; 0)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
// -- AL_SetEntryOpts(ePOs; 1; 0; 0)
//Name; EntryMode; AllowReturn; DisplaySeconds
// -- AL_SetSortOpts(ePOs; 0; 1; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
// -- AL_SetCallbacks(ePOs; ""; "")
//Name; GP at entry; Function true or false if keep changes    
// -- AL_SetMiscOpts(ePOs; 0; 1; ""; 0)
//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
//
// -- AL_SetFormat(ePOs; 2; "0000-0000"; 2; 2)
// -- AL_SetFormat(ePOs; 8; "0000-0000"; 2; 2)
// -- AL_SetFormat(ePOs; 1; "1"; 2; 2)  //date

// -- AL_SetHdrStyle(ePOs; 0; "Geneva"; 9; 2)
// -- AL_SetStyle(ePOs; 0; "Geneva"; 12; 0)
// -- AL_SetDividers(ePOs; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetSort(ePOs; -1; 2)
//