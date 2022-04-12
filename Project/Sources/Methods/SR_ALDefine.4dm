//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)
// -- $error:=AL_SetArraysNam($1; 1; 10; "aSrAvail"; "aSrNum"; "aSrOnFP"; "aSrLife"; "aSrExpire"; "aSrDateIn"; "aSrRecID"; "aSrPoID"; "aSrSaleID"; "aSrRecNum")
// -- AL_SetHeaders($1; 1; 10; "Avail"; "Serial Num"; "F.Plan"; "Life"; "Expire"; "Date In"; "Rec ID"; "Po Ln ID"; "Sale Ln ID"; "RecNum")
// -- AL_SetWidths($1; 1; 10; 18; 122; 35; 54; 54; 54; 54; 54; 54; 80)
//
// -- AL_SetRowOpts($1; 1; 1; 0; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts($1; 1; 0; 1; 0; 0)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
// -- AL_SetEntryOpts($1; 6; 0; 0)
//Name; EntryMode; AllowReturn; DisplaySeconds
// -- AL_SetSortOpts($1; 0; 1; 1; ""; 1)
//Name; SortInDuring; UserSort; AllowSortEditor; Prompt; ShowSortOrder
// -- AL_SetCallbacks($1; ""; "")
//Name; GP at entry; Function true or false if keep changes    
// -- AL_SetHdrStyle($1; 0; "Geneva"; 9; 2)
// -- AL_SetStyle($1; 0; "Geneva"; 12; 0)
// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetSort($1; -1; 2)  //do NOT sort, leave TBD the first item
ARRAY LONGINT:C221(aSrlSelect; 0)
// -- AL_SetSelect($1; aSrlSelect)