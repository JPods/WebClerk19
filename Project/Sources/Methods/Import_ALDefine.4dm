//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-02-22T00:00:00, 10:19:43
// ----------------------------------------------------
// Method: Import_ALDefine
// Description
// Modified: 02/22/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($error)
C_LONGINT:C283(eImportList)
//

// ARRAY LONGINT(aCntImpFlds;0)
// ARRAY TEXT(aImpFields;0)
// array TEXT(aBullets;0)
//
ARRAY LONGINT:C221(aImportLines; 0)
// NOTE, following are variables of the array names. Array names are listed above
// -- $error:=AL_SetArraysNam(eImportList; 1; 3; "aCntImpFlds"; "aImpFields"; "aBullets")
// -- AL_SetHeaders(eImportList; 1; 3; "Num"; "Value"; "Bt")

// -- AL_SetWidths(eImportList; 1; 3; 24; 140; 20)
//
//// -- AL_SetCallbacks (eImportList;"Ord_WFALCBEntry";"Ord_WFALCBExit")//
//
// -- AL_SetRowOpts(eImportList; 1; 0; 0; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts(eImportList; 0; 0; 0; 0; <>vPixel)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
//// -- AL_SetEnterable (eImportList;7;3;<>aNameID)
//name; column; mode; array

// -- AL_SetEntryOpts(eImportList; 1; 1; 1; 1)
//Name; EntryMode; AllowReturn; DisplaySeconds;MoveWithArrow;MapEnterKey
// -- AL_SetSortOpts(eImportList; 1; 1; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
//// -- AL_SetCallbacks (eImportList;"";"")
//Name; GP at entry; Function true or false if keep changes
// -- AL_SetSort(eImportList; 1)
//
// -- AL_SetHdrStyle(eImportList; 0; "Geneva"; 9; 2)
// -- AL_SetStyle(eImportList; 0; "Geneva"; 12; 0)
// -- AL_SetDividers(eImportList; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetMiscOpts(eImportList; 0; 1; ""; 0)
//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
//