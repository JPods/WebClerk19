//%attributes = {"publishedWeb":true}
//Procedure: Srch_ALDefine
C_LONGINT:C283($1; $2)

If ($2=1)
	// -- $error:=AL_SetArraysNam($1; 1; 4; "aQueryBooleans"; "aQueryFieldNames"; "aQueryOperators"; "aTmpText1")  //;"aTmpText2")
	// -- AL_SetHeaders($1; 1; 4; "Combine"; "Field"; "Compare"; "Value")  //;"space")
	
Else 
	//  CHOPPED  $error:=AL_InsArraysNam($1; 1; 4; "aQueryBooleans"; "aQueryFieldNames"; "aQueryOperators"; "aTmpText1")  //;"aTmpText2")
	// -- AL_SetHeaders($1; 1; 4; "Combine"; "Field"; "Compare"; "Value")  //;"space")
End if 
// -- AL_SetWidths($1; 1; 4; 52; 94; 63; 180)  //;30)
//
// -- AL_SetCallbacks($1; "Srch_Enter"; "")  //
//
// -- AL_SetRowOpts($1; 0; 0; 1; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts($1; 1; 0; 1; 0; 0)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
//   // -- AL_SetEnterable ($1;4;3;aQueryBooleans)
//name; column; mode; array

// -- AL_SetEntryOpts($1; 2; 1; 1; 1)
//Name; EntryMode; AllowReturn; DisplaySeconds;MoveWithArrow;MapEnterKey
// // -- AL_SetSortOpts ($1;0;0;0;"";0)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
//// -- AL_SetCallbacks ($1;"";"")
//Name; GP at entry; Function true or false if keep changes
// -- AL_SetSort($1; 1)
// -- AL_SetEnterable($1; 1; 2; aTmp20Str2)
// -- AL_SetEnterable($1; 2; 0)
// -- AL_SetEnterable($1; 3; 2; aTmp20Str4)
// -- AL_SetEnterable($1; 4; 1)

// -- AL_SetHdrStyle($1; 0; "Geneva"; 9; 2)
// -- AL_SetStyle($1; 0; "Geneva"; 12; 0)
// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetMiscOpts($1; 0; 1; ""; 0)
//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
//