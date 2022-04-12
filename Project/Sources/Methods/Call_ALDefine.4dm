//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/30/11, 07:35:00
// ----------------------------------------------------
// Method: Call_ALDefine
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($error)
C_LONGINT:C283($1)
//;
// -- $error:=AL_SetArraysNam($1; 1; 8; "aCallAction"; "aCallDTStrAct"; "aCallNameID"; "aCallinitiated"; "aCallWho"; "aCallComplete"; "aCallLtrName"; "aCallRecordNum")
// -- AL_SetHeaders($1; 1; 8; "Action"; "DateTime"; "Action"; "Initiated"; "Who"; "Complete"; "Letter"; "Rec")
// -- AL_SetWidths($1; 1; 8; 54; 54; 54; 54; 54; 54; 54; 80)
//
// -- AL_SetRowOpts($1; 1; 0; 1; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts($1; 1; 0; 1; 0; <>viPixel)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
//// -- AL_SetEntryOpts ($1;1;0;0)
////Name; EntryMode; AllowReturn; DisplaySeconds
// -- AL_SetEntryOpts($1; 6; 1; 1; 1)
//Name; EntryMode; AllowReturn; DisplaySeconds;MoveWithArrow;MapEnterKey
//// -- AL_SetEnterable ($1;2;3;<>aAnswers)
// -- AL_SetSortOpts($1; 0; 1; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
// -- AL_SetCallbacks($1; ""; "QA_Exit")
//Name; GP at entry; Function true or false if keep changes
// -- AL_SetSort($1; 3)
//
//// -- AL_SetCallbacks ($1;"Ord_WFALCBEntry";"")
//// -- AL_SetEnterable ($1;5;3;<>aAnswers)
// -- AL_SetHdrStyle($1; 0; "Geneva"; 9; 2)
// -- AL_SetStyle($1; 0; "Geneva"; 12; 0)
// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetMiscOpts($1; 0; 1; ""; 0)
//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
//