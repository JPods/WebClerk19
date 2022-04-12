//%attributes = {"publishedWeb":true}
//  Ledge_RayInit (1)
// -- $error:=AL_SetArraysNam($1; 1; 15; "aLdgAcct"; "aLdgJrnl"; "aLdgTerms"; "aLdgDocType"; "aLdgDocId"; "aLdgDocDt"; "aLdgDue"; "aLdgExpire"; "aLdgDscPot"; "aLdgOrig"; "aLdgValue"; "aLdgCredit"; "aLdgComnt"; "aLdgUnique"; "aLdgRecs")  //
// -- AL_SetHeaders($1; 1; 15; "Acct"; "Journal"; "Term"; "Type"; "Doc ID"; "Doc Dt"; "Due"; "Expires"; "DscntPotential"; "Orig"; "Due"; "Credit"; "Comment"; "ID"; "Rec Num")
// -- AL_SetWidths($1; 1; 15; 3; 3; 61; 26; <>wAlAcctNum; <>wAlDate; <>wAlDate; <>wAlDate; 3; <>wAlValue; <>wAlValue; <>wAlValue; 200; 70; 70)
//
// -- AL_SetRowOpts($1; 1; 0; 0; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts($1; 1; 0; 1; 2; <>viPixel)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
// -- AL_SetEntryOpts($1; 7; 1; 0; 1; 0)
//Name; EntryMode; AllowReturn; DisplaySeconds;move with arrows; mapEnterkey
// -- AL_SetSortOpts($1; 0; 1; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
//// -- AL_SetCallbacks ($1;"";"")
//Name; GP at entry; Function true or false if keep changes
// -- AL_SetSort($1; -7)
// -- AL_SetEnterable($1; 1; 0)
// -- AL_SetEnterable($1; 2; 0)
// -- AL_SetEnterable($1; 3; 0)
// -- AL_SetEnterable($1; 4; 0)
// -- AL_SetEnterable($1; 5; 0)
// -- AL_SetEnterable($1; 6; 1)
//Name; column; entry option; popup
// -- AL_SetEnterable($1; 7; 1)
// -- AL_SetEnterable($1; 8; 0)
// -- AL_SetEnterable($1; 9; 0)
// -- AL_SetEnterable($1; 10; 0)
// -- AL_SetEnterable($1; 11; 0)
// -- AL_SetEnterable($1; 12; 0)

// -- AL_SetFormat($1; 5; "0000-0000"; 3; 2)
// -- AL_SetFormat($1; 6; "1"; 0; 0)  //date
// -- AL_SetFormat($1; 7; "1"; 0; 0)  //date
// -- AL_SetFormat($1; 8; "1"; 0; 0)  //date

//// -- AL_SetFormat ($1;7;<>tcFormatTt;3;2)
// -- AL_SetFormat($1; 8; <>tcFormatTt; 3; 2)
// -- AL_SetFormat($1; 9; <>tcFormatTt; 3; 2)
// -- AL_SetFormat($1; 10; <>tcFormatTt; 3; 2)
// -- AL_SetHdrStyle($1; 0; "Geneva"; 9; 2)
// -- AL_SetStyle($1; 0; "Geneva"; 12; 0)
// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetMiscOpts($1; 0; 1; ""; 0)
//Name; HideHeaders; AreaSelected; PostKey; ShowFooters