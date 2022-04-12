//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)

// -- $error:=AL_SetArraysNam($1; 1; 2; "aTmp20Str1"; "aTmpLong1")
// -- AL_SetHeaders($1; 1; 2; "Name"; "Num")

// -- AL_SetWidths($1; 1; 2; 120; 30)
//
//// -- AL_SetCallbacks ($1;"Ord_WFALCBEntry";"Ord_WFALCBExit")//
//
// -- AL_SetRowOpts($1; 0; 0; 1; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts($1; 1; 0; 1; 0; 0)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
//// -- AL_SetEnterable ($1;7;3;<>aNameID)
//name; column; mode; array

// -- AL_SetEntryOpts($1; 1; 1; 1; 0)
//Name; EntryMode; AllowReturn; DisplaySeconds;MoveWithArrow;MapEnterKey
// -- AL_SetSortOpts($1; 0; 1; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
//// -- AL_SetCallbacks ($1;"";"")
//Name; GP at entry; Function true or false if keep changes
// -- AL_SetSort($1; 1)
//
// -- AL_SetHdrStyle($1; 0; "Geneva"; 9; 2)
// -- AL_SetStyle($1; 0; "Geneva"; 12; 0)
// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetMiscOpts($1; 0; 1; ""; 0)