//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/20/06, 13:23:12
// ----------------------------------------------------
// Method: WOEvents_ALDefine
// Description
// WOEvents_FillArrays
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($error)
C_LONGINT:C283($1; $2; $3; $doLocal)
ARRAY LONGINT:C221(aWoLines; 0)  //;"aLsItemDesc"
// -- $error:=AL_SetArraysNam($1; 1; 6; "aWOEventReason"; "aWoEventTimeOrig"; "aWoEventDateOrig"; "aWoeventID"; "aWoEventWoNum"; "aWoEventRecNum")
// -- AL_SetHeaders($1; 1; 6; "Reason"; "Time"; "Date"; "eventID"; "WONum"; "RecNum")
// -- AL_SetWidths($1; 1; 6; 75; 60; 60; 60; 60; 60)
//
// -- AL_SetRowOpts($1; 1; 0; 1; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts($1; 1; 0; 1; 0; <>viPixel)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel


//// -- AL_SetEntryOpts ($1;6;1;1;1)
//Name; EntryMode; AllowReturn; DisplaySeconds;MoveWithArrow;MapEnterKey
// -- AL_SetSortOpts($1; 0; 1; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
//// -- AL_SetCallbacks ($1;"";"")
//Name; GP at entry; Function true or false if keep changes
// -- AL_SetSort($1; 3; 2)
//
// -- AL_SetFormat($1; 2; "&/5"; 3; 2)
//// -- AL_SetFormat ($1;2;"&/5";3;0)
//
// -- AL_SetHdrStyle($1; 0; "Geneva"; 9; 2)
// -- AL_SetStyle($1; 0; "Geneva"; 12; 0)
// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetMiscOpts($1; 0; 1; "\\"; 0)
//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
