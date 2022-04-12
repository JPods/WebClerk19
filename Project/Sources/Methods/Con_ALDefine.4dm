//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)
If (($1>0) & (Before:C29))
	// -- $error:=AL_SetArraysNam($1; 1; 13; "aConFirstName"; "aConLastName"; "aConActionDate"; "aConAction"; "aConZip"; "aConCity"; "aConProfile1"; "aConPhone"; "aConEmail"; "aConLetterList"; "aConPrimeShip"; "aConKeyWords"; "aConRecordNum")
	// -- AL_SetHeaders($1; 1; 13; "First"; "Last"; "ActDate"; "Action"; "Zip"; "City"; "Profile1"; "Phone"; "eMail"; "LetterList"; "PrimeShip"; "Keywords"; "Record")
	// -- AL_SetWidths($1; 1; 13; 58; 58; 54; 54; 54; 54; 54; 70; 70; 12; 12; 120; 90)
	//
	// -- AL_SetRowOpts($1; 1; 1; 0; 0; 1)
	//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
	// -- AL_SetColOpts($1; 1; 0; 1; 0; <>viPixel)
	//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
	// -- AL_SetEntryOpts($1; 1; 0; 0)
	//Name; EntryMode; AllowReturn; DisplaySeconds
	// -- AL_SetSortOpts($1; 0; 1; 1; ""; 0)
	//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
	//// -- AL_SetCallbacks ($1;"";"")
	//Name; GP at entry; Function true or false if keep changes
	//    // -- AL_SetSort ($1;2)
	//// -- AL_SetFormat ($1;2;<>tcFormatTt;3;2)
	//// -- AL_SetFormat ($1;3;<>tcFormatTt;3;2)
	//// -- AL_SetFormat ($1;1;"0000-0000";3;2)
	//// -- AL_SetFormat ($1;7;"0000-0000";3;2)
	// -- AL_SetHdrStyle($1; 0; "Geneva"; 9; 2)
	// -- AL_SetStyle($1; 0; "Geneva"; 12; 0)
	// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
	// -- AL_SetMiscOpts($1; 0; 1; ""; 0)
	//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
End if 