//%attributes = {"publishedWeb":true}
//Method: Service_ALDefine
If (Before:C29)
	// -- $error:=AL_SetArraysNam($1; 1; 14; "atCompleted"; "at_DTActionTime"; "at_DTActionDate"; "atAction"; "atactionName"; "atNameCreatedBy"; "atRepID"; "atAttention"; "atCompany"; "atDescription"; "atTaskID"; "atcontactID"; "atcustomerID"; "aServiceRec")
	//
	// -- AL_SetHeaders($1; 1; 14; "C"; "Time"; "Date"; "Action"; "ActionBy"; "CreatedBy"; "Rep"; "Attn"; "Company"; "Description"; "taskID"; "contactID"; "customerID"; "RecNum")
	// -- AL_SetWidths($1; 1; 14; 8; 54; 54; 56; 56; 15; 15; 64; 68; 163; 54; 54; 54; 54)
	// -- AL_SetRowOpts($1; 1; 0; 0; 0; 1)
	//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
	// -- AL_SetColOpts($1; 1; 0; 1; 1; <>viPixel)
	//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
	// -- AL_SetEntryOpts($1; 1; 0; 0)
	//Name; EntryMode; AllowReturn; DisplaySeconds
	// -- AL_SetSortOpts($1; 0; 1; 1; ""; 1)
	//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
	//// -- AL_SetCallbacks ($1;"";"")
	//Name; GP at entry; Function true or false if keep changes
	// -- AL_SetMiscOpts($1; 0; 1; ""; 0)
	//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
	// -- AL_SetHdrStyle($1; 0; "Geneva"; 9; 2)
	// -- AL_SetStyle($1; 0; "Geneva"; 12; 0)
	//
	// -- AL_SetFormat($1; 3; "1"; 2; 2)  //date
	// -- AL_SetFormat($1; 2; "&/5"; 3; 0)  //time
	// -- AL_SetFormat($1; 1; "X; ")  //Complete
	// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
	// -- AL_SetSort($1; 3; 1)
End if 