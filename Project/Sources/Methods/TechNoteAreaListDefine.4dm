//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2018-07-22T00:00:00, 13:05:22
// ----------------------------------------------------
// Method: TechNoteAreaListDefine
// Description
// Modified: 07/22/18
// Structure: gkgkgk
// gkgkgk
//
// Parameters
// ----------------------------------------------------
ARRAY TEXT:C222(aTNName; 0)
ARRAY TEXT:C222(aTNSub; 0)
ARRAY LONGINT:C221(aTNRec; 0)
ARRAY LONGINT:C221(aTNChap; 0)
ARRAY LONGINT:C221(aTNSect; 0)

// -- $error:=AL_SetArraysNam(eTNList; 1; 5; "aTNChap"; "aTNSect"; "aTNName"; "aTNSub"; "aTNRec")
// -- AL_SetHeaders(eTNList; 1; 5; "Chap"; "Sect"; "Name"; "Subject"; "Num")
// -- AL_SetWidths(eTNList; 1; 5; 40; 40; 200; 140; 70)
//
// -- AL_SetRowOpts(eTNList; 1; 0; 0; 0; 0)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts(eTNList; 1; 0; 1; 0; 0)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
//// -- AL_SetEnterable ($1;7;3;<>aNameID)
//name; column; mode; array
// -- AL_SetEntryOpts(eTNList; 1; 1; 1; 1)
//Name; EntryMode; AllowReturn; DisplaySeconds;MoveWithArrow;MapEnterKey
// -- AL_SetSortOpts(eTNList; 0; 1; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
//// -- AL_SetCallbacks ($1;"";"")
//Name; GP at entry; Function true or false if keep changes
// -- AL_SetSort(eTNList; 1; 2)
//
// -- AL_SetHdrStyle(eTNList; 0; "Geneva"; 9; 2)
// -- AL_SetStyle(eTNList; 0; "Geneva"; 12; 0)
// -- AL_SetDividers(eTNList; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetMiscOpts(eTNList; 0; 1; ""; 0)
//  --  CHOPPED  AL_UpdateArrays(eTNList; -2)