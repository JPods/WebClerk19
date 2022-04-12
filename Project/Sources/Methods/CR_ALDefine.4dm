//%attributes = {"publishedWeb":true}
//Procedure: ClRpt_ALDefine
C_LONGINT:C283($1)
// -- $error:=AL_SetArraysNam($1; 1; 11; "aCLDate"; "aCLNameID"; "aCLLtr"; "aClPhone"; "aCLMessage"; "aCLFax"; "aCLVisit"; "aCLLtrName"; "aCLAction"; "aCLPath"; "aCLRec")
// -- AL_SetHeaders($1; 1; 11; "Date"; "Name ID"; "Ltr"; "Ph"; "Ms"; "Fx"; "Vs"; "Ltr Name"; "Action"; "Path"; "Rec")
// -- AL_SetWidths($1; 1; 11; 54; 43; 16; 16; 16; 16; 16; 120; 50; 100; 100)
//
// -- AL_SetRowOpts($1; 1; 0; 0; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts($1; 1; 0; 1; 0; <>viPixel)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
// -- AL_SetEntryOpts($1; 6; 0; 0)
//Name; EntryMode; AllowReturn; DisplaySeconds
// -- AL_SetSortOpts($1; 0; 1; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
// -- AL_SetCallbacks($1; ""; "")
//Name; GP at entry; Function true or false if keep changes    
// -- AL_SetMiscOpts($1; 0; 1; ""; 0)
//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
//
// -- AL_SetHdrStyle($1; 0; "Geneva"; 9; 2)
// -- AL_SetStyle($1; 0; "Geneva"; 12; 0)
// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetSort($1; 1)