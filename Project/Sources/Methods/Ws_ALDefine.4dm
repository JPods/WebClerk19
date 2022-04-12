//%attributes = {"publishedWeb":true}
//Procedure: Ws_ALDefine
C_LONGINT:C283($error)
C_LONGINT:C283($1)
// -- $error:=AL_SetArraysNam($1; 1; 11; "aWsActive"; "aWsDescpt"; "aWsRate"; "aWsDura"; "aWsNature"; "aWsBillTp"; "aWsWho"; "aWsSeq"; "aWsPublish"; "aWsRecNum"; "aWsUniqueID")
// -- AL_SetHeaders($1; 1; 11; "Activity"; "Description"; "Rate"; "Duration"; "ID"; "Bill Type"; "Who"; "Seq"; "Publish"; "RecNum"; "idNum")
// -- AL_SetWidths($1; 1; 11; 50; 250; 50; 50; 50; 50; 50; 50; 50; 50; 50)
//
// -- AL_SetRowOpts($1; 1; 0; 3; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts($1; 1; 0; 1; 0; <>viPixel)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
// -- AL_SetEntryOpts($1; 1; 0; 0)
//Name; EntryMode; AllowReturn; DisplaySeconds
// -- AL_SetSortOpts($1; 0; 1; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
//// -- AL_SetCallbacks ($1;"";"")
//Name; GP at entry; Function true or false if keep changes
// -- AL_SetSort($1; 8)
//
// -- AL_SetHdrStyle($1; 0; "Geneva"; 9; 2)
// -- AL_SetStyle($1; 0; "Geneva"; 12; 0)
// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetMiscOpts($1; 0; 1; ""; 0)
//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
//