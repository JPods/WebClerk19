//%attributes = {"publishedWeb":true}
// -- $error:=AL_SetArraysNam($1; 1; 9; "aTCSignedIN"; "aTCNameID"; "aTCActivity"; "aTCCause"; "aTCPerCent"; "aTCOrdNum"; "aTCOrdLn"; "aTCTimeIn"; "aTCTimeOut")
// -- $error:=AL_SetArraysNam($1; 10; 7; "aTCLapsed"; "aTCComment"; "aTCDateIn"; "aTCDateOut"; "aTCHourWage"; "aTCExtWage"; "aTCTimeRecs")
// Modified by: Bill James (2017-08-21T00:00:00 - missing specialCharacter to x)
// -- AL_SetHeaders($1; 1; 9; "x"; "Name"; "Activity"; "Cause"; "%"; "S/O"; "OrdLn"; "In"; "Out")
// -- AL_SetHeaders($1; 10; 7; "Lapse"; "Comment"; "DateIn"; "DateOut"; "Wage"; "Ext"; "Recs")
// -- AL_SetWidths($1; 1; 9; 3; 57; 47; 3; 20; 49; 3; 69; 69)
// -- AL_SetWidths($1; 10; 7; 59; 75; 72; 72; 60; 60; 60)
//
// -- AL_SetRowOpts($1; 1; 1; 0; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts($1; 1; 0; 1; 3; 0)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
//// -- AL_SetEntryOpts ($1;0;0;0)
//Name; EntryMode; AllowReturn; DisplaySeconds
// -- AL_SetSortOpts($1; 0; 1; 1; ""; 1)
//Name; SortInDuring; UserSort; AllowSortEditor; Prompt; ShowSortOrder
C_BOOLEAN:C305(<>Quote)
<>Quote:=False:C215
// -- AL_SetCallbacks($1; "Ord_WFALCBEntry"; "TC_ALExit")
//Name; GP at entry; Function true or false if keep changes
// -- AL_SetSort($1; 2; 8; 12)
//    
// -- AL_SetFormat($1; 6; "0000-0000"; 3; 0)
// -- AL_SetFormat($1; 8; "&/5"; 3; 0)  //Time In
// -- AL_SetFormat($1; 9; "&/5"; 3; 0)  ////Time Out
// -- AL_SetFormat($1; 10; "&/2"; 3; 0)  //Lapse
// -- AL_SetFormat($1; 12; "1"; 2; 2)  //date
// -- AL_SetFormat($1; 13; "1"; 2; 2)  //date
//
// -- AL_SetHdrStyle($1; 0; "Geneva"; 9; 0)
// -- AL_SetHdrStyle($1; 14; "Geneva"; 9; 2)
// -- AL_SetStyle($1; 0; "Geneva"; 12; 0)
// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetMiscOpts($1; 0; 1; ""; 0)
//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
// -- AL_SetEntryOpts($1; 6; 1; 1; 1)
//If (Is macOS)
// -- AL_SetEnterable($1; 2; 3; <>aNameID)
// -- AL_SetEnterable($1; 3; 3; <>aActivities)
//// -- AL_SetEnterable ($1;6;3;<>aActiveWOs)

//name; column; mode; array
// -- AL_SetEnterable($1; 8; 3)  //in
// -- AL_SetEnterable($1; 9; 3)  //lapse
// -- AL_SetEnterable($1; 10; 3)  //out
// -- AL_SetEnterable($1; 12; 3)  //date in
// -- AL_SetEnterable($1; 13; 3)  //date out
//End if 