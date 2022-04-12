//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/20/06, 13:23:12
// ----------------------------------------------------
// Method: WOTasks_ALDefine
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($error)
C_LONGINT:C283($1; $2; $3; $doLocal)
ARRAY LONGINT:C221(aWoLines; 0)  //;"aLsItemDesc"
// -- $error:=AL_SetArraysNam($1; 1; 13; "aWOTaskAction"; "aWOTaskActionBy"; "aWoTaskDateComplete"; "aWoTaskTimeComplete"; "aWoTaskComment"; "aWoTaskTools"; "aWoTaskSafety"; "aWoTaskItemNum"; "aWoTaskSequence"; "aWotaskID"; "aWoTaskWONum"; "aWoTaskRecNum"; "aWoTaskDTComplete")
// -- AL_SetHeaders($1; 1; 13; "Action"; "ActionBy"; "DateCmplt"; "TimeCmplt"; "Comment"; "Tools"; "Safety"; "ItemNum"; "Seq"; "taskID"; "WO"; "RecNum"; "DTCmplt")
// -- AL_SetWidths($1; 1; 13; 52; 52; 56; 56; 100; 100; 100; 56; 30; 60; 60; 60; 50)
//
// -- AL_SetEnterable($1; 2; 3; <>aNameID)
// -- AL_SetCallbacks($1; "WO_TaskEnter"; "WO_TaskExit")
//// -- AL_SetCallbacks ($1;"Ord_WFALCBEntry";"Ord_WFALCBExit")

// -- AL_SetRowOpts($1; 1; 0; 1; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts($1; 1; 0; 1; 2; <>viPixel)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel


//// -- AL_SetEntryOpts ($1;6;1;1;1)
//Name; EntryMode; AllowReturn; DisplaySeconds;MoveWithArrow;MapEnterKey
// -- AL_SetSortOpts($1; 0; 1; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
//// -- AL_SetCallbacks ($1;"";"")
//Name; GP at entry; Function true or false if keep changes
// -- AL_SetSort($1; 9)
//
// -- AL_SetFormat($1; 4; "&/5"; 3; 2)
//// -- AL_SetFormat ($1;2;"&/5";3;0)
// -- AL_SetFormat($1; 12; "###,###,###.###"; 0; 2)
// -- AL_SetFormat($1; 17; "###,###,###.###"; 0; 2)
//
// -- AL_SetHdrStyle($1; 0; "Geneva"; 9; 2)
// -- AL_SetStyle($1; 0; "Geneva"; 12; 0)
// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetMiscOpts($1; 0; 1; "\\"; 0)
//Name; HideHeaders; AreaSelected; PostKey; ShowFooters



//