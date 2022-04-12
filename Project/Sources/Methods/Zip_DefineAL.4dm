//%attributes = {"publishedWeb":true}
If (False:C215)
	//Date: 03/20/02
	//Who: Peter Fleming, Arkware
	//Description: Define zipcode AL arrays
	VERSION_960
End if 

C_LONGINT:C283($1)
C_LONGINT:C283($error)

// -- $error:=AL_SetArraysNam($1; 1; 3; "aZipCode"; "aZipCity"; "aZipState")
// -- AL_SetHeaders($1; 1; 3; "Zip Code"; "City"; "State")
// -- AL_SetWidths($1; 1; 3; 50; 160; 20)

// -- AL_SetRowOpts($1; 0; 0; 1; 0; 1)  //Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts($1; 1; 0; 0; 0; 0)  //Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
// -- AL_SetEntryOpts($1; 6; 0; 1; 1)  //Name; EntryMode; AllowReturn; DisplaySeconds;MoveWithArrow;MapEnterKey
// -- AL_SetSortOpts($1; 0; 0; 0; ""; 1)  //Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
// -- AL_SetEnterable($1; 0; 0)  //Name; Column; Enterable
// -- AL_SetHdrStyle($1; 0; "Geneva"; 9; 0)
// -- AL_SetStyle($1; 0; "Geneva"; 12; 0)
// -- AL_SetMiscOpts($1; 0; 1; ""; 0)  //Name; HideHeaders; AreaSelected; PostKey; ShowFooters