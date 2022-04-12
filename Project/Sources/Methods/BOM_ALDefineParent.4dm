//%attributes = {"publishedWeb":true}
//Method: BOM_ALDefineParent
C_LONGINT:C283($1; $2; $error)
If ($1#0)
	////  --  CHOPPED  AL_UpdateArrays ($1;-2)
	If ($2=1)
		//  CHOPPED  AL_RemoveArrays($1; 1; 2)
		//  CHOPPED  $error:=AL_InsArraysNam($1; 1; 2; "aBomMomItem"; "aBomMomRec")
	Else 
		// -- $error:=AL_SetArraysNam($1; 1; 2; "aBomMomItem"; "aBomMomRec")
	End if 
	// -- AL_SetHeaders($1; 1; 2; "Parent"; "Rec")
	// -- AL_SetWidths($1; 1; 2; 110; 30)
	//// -- AL_SetCallbacks ($1;"";"Ord_WFALCBExit")
	//
	// -- AL_SetRowOpts($1; 1; 0; 0; 0; 1)
	//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
	// -- AL_SetColOpts($1; 1; 0; 1; 1; 0)
	//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
	// -- AL_SetSortOpts($1; 0; 1; 1; ""; 1)
	//// -- AL_SetCallbacks ($1;"";"")
	//Name; GP at entry; Function true or false if keep changes
	//// -- AL_SetSort ($1;1)
	// -- AL_SetHdrStyle($1; 0; "Geneva"; 9; 2)
	// -- AL_SetStyle($1; 0; "Geneva"; 12; 0)
	// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
	// -- AL_SetMiscOpts($1; 0; 1; ""; 0)
	//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
End if 