//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-02-22T00:00:00, 04:22:04
// ----------------------------------------------------
// Method: FldMatch_ALDefine
// Description
// Modified: 02/22/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($error)
C_LONGINT:C283(eMatchList)

//

// array TEXT(aMatchField;0)
// array TEXT(aMatchType;0)
// ARRAY Longint(aMatchNum;0)
//
ARRAY LONGINT:C221(aMatchLines; 0)
// NOTE, following are variables of the array names. Array names are listed above
// -- $error:=AL_SetArraysNam(eMatchList; 1; 4; "aCntMatFlds"; "aMatchField"; "aMatchType"; "aMatchNum")
// -- AL_SetHeaders(eMatchList; 1; 4; "Num"; "Field"; "Type"; "FldNum")

// -- AL_SetWidths(eMatchList; 1; 4; 24; 125; 20; 30)
//
//// -- AL_SetCallbacks (eMatchList;"Ord_WFALCBEntry";"Ord_WFALCBExit")//
//
// -- AL_SetRowOpts(eMatchList; 1; 0; 1; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts(eMatchList; 0; 0; 0; 0; <>vPixel)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
//// -- AL_SetEnterable (eMatchList;7;3;<>aNameID)
//name; column; mode; array

// -- AL_SetEntryOpts(eMatchList; 1; 1; 1; 1)
//Name; EntryMode; AllowReturn; DisplaySeconds;MoveWithArrow;MapEnterKey
// -- AL_SetSortOpts(eMatchList; 0; 0; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
//// -- AL_SetCallbacks (eMatchList;"";"")
//Name; GP at entry; Function true or false if keep changes
// // -- AL_SetSort (eMatchList;1)
//
// -- AL_SetHdrStyle(eMatchList; 0; "Geneva"; 9; 2)
// -- AL_SetStyle(eMatchList; 0; "Geneva"; 12; 0)
// -- AL_SetDividers(eMatchList; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetMiscOpts(eMatchList; 0; 1; ""; 0)
//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
//