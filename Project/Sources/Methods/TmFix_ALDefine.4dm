//%attributes = {"publishedWeb":true}
//Procedure: TmFix_ALDefine
C_LONGINT:C283($1)
C_LONGINT:C283($error)
C_TEXT:C284($2)
// -- $error:=AL_SetArraysNam($1; 1; 6; "aTimeSlotType"+$2; "aTimeSlotBeg"+$2; "aTimeSlotAction"+$2; "aTimeSlotWhat"+$2; "aTimeSlotEnd"+$2; "aTimeSlotWORec"+$2)
//
// -- AL_SetHeaders($1; 1; 6; "Ty"; "Begin"; "Act"; "Descript"; "End"; "RecID")
// -- AL_SetWidths($1; 1; 6; 22; 62; 62; 65; 50; 20)
// -- AL_SetRowOpts($1; 1; 1; 1; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
//$columnCnt:=Num(Error#0)*8
// -- AL_SetColOpts($1; 1; 0; 1; 2; <>viPixel)  //$columnCnt;0)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
// -- AL_SetEntryOpts($1; 1; 0; 0)
//Name; EntryMode; AllowReturn; DisplaySeconds
// -- AL_SetSortOpts($1; 0; 1; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
// -- AL_SetCallbacks($1; ""; "")
//Name; GP at entry; Function true or false if keep changes
//// -- AL_SetSort ($1;2)//Seq
// -- AL_SetColLock($1; 2)  //Lock after Alt Item Num
// -- AL_SetMiscOpts($1; 0; 1; ""; 0)
//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetStyle($1; 0; "Geneva"; 12; 0)
// -- AL_SetHdrStyle($1; 0; "Geneva"; 9; 0)
//
// -- AL_SetFormat($1; 2; "&/5"; 3; 0)
// -- AL_SetFormat($1; 5; "&/5"; 3; 0)
//// -- AL_SetEnterable ($1;1;1)

// -- AL_SetDrgDst($1; 1; "1"; "2"; "3"; "4"; "5"; "6"; "7"; "8"; "9"; "10")
// -- AL_SetDrgOpts($1; 0; 10; 0; 1)

// -- AL_SetDrgSrc($1; 1; "3")