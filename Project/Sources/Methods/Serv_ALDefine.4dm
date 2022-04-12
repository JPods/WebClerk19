//%attributes = {"publishedWeb":true}
//Procedure: Serv_ALDefine
//Noah Dykoski  June 25, 1998 / 7:56 PM

//check retrieve button if there are changes; Srvc_ReadWrRays (0)//read file  

// -- $error:=AL_SetArraysNam(eService; 1; 10; "aServiceTableName"; "aServiceTime"; "aServiceDate"; "aServiceAction"; "aServiceActionBy"; "aServiceVariable"; "aServiceAttention"; "aServiceCompany"; "aServiceRecs")
// -- AL_SetHeaders(eService; 1; 10; "T"; "Time"; "Date"; "Action"; "ActionBy"; "Type"; "Name"; "Co"; "Ref")
// -- AL_SetWidths(eService; 1; 14; 30; 60; 70; 90; 90; 90; 90; 160; 50)
// -- AL_SetRowOpts(eService; 1; 1; 0; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts(eService; 1; 0; 1; 1; <>viPixel)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
// -- AL_SetEntryOpts(eService; 1; 0; 0)
//Name; EntryMode; AllowReturn; DisplaySeconds
// -- AL_SetSortOpts(eService; 0; 1; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
//// -- AL_SetCallbacks (eService;"";"")
//Name; GP at entry; Function true or false if keep changes
// -- AL_SetMiscOpts(eService; 0; 1; ""; 0)
//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
// -- AL_SetHdrStyle(eService; 0; "Geneva"; 9; 2)
// -- AL_SetStyle(eService; 0; "Geneva"; 12; 0)
//
// -- AL_SetFormat(eService; 3; "1"; 2; 2)  //date
// -- AL_SetFormat(eService; 2; "&/5"; 3; 0)  //time
// -- AL_SetFormat(eService; 8; "X; ")  //QACust
// -- AL_SetDividers(eService; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetSort(eService; 3; 1)