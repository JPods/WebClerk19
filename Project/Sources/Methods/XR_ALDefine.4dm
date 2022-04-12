//%attributes = {"publishedWeb":true}
//Procedure: XR_ALDefine
C_LONGINT:C283($error; $1)
// -- $error:=AL_SetArraysNam($1; 1; 8; "aXLocation"; "aXItemNum"; "aXItemDesc"; "aXQtyLoc"; "aXCost"; "aXLead"; "aXVendCode"; "aXRefRec")
// -- AL_SetHeaders($1; 1; 7; "Site"; "Item XRef"; "Description"; "Qty"; "Price/Cost"; "Lead"; "Source")
// -- AL_SetWidths($1; 1; 7; 29; 91; 117; 29; 53; 32; 65)
//
// -- AL_SetRowOpts($1; 1; 0; 0; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts($1; 1; 0; 1; 1; 0)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
// -- AL_SetEntryOpts($1; 1; 0; 0)
//Name; EntryMode; AllowReturn; DisplaySeconds
// -- AL_SetSortOpts($1; 0; 1; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
// -- AL_SetCallbacks($1; ""; "")
//Name; GP at entry; Function true or false if keep changes
// -- AL_SetSort($1; 1)
// -- AL_SetFormat($1; 4; ""; 3; 2)
// -- AL_SetFormat($1; 4; "###,###.######"; 0; 0)
// -- AL_SetFormat($1; 5; "###,###.###"; 0; 0)
//// -- AL_SetFormat ($1;7;"###,###.###";0;0)

// -- AL_SetHdrStyle($1; 0; "Geneva"; 9; 2)
// -- AL_SetStyle($1; 0; "Geneva"; 12; 0)
// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)