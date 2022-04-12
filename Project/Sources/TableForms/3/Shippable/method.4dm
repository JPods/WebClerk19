Case of 
	: (Before:C29)
		C_LONGINT:C283($error)
		// -- $error:=AL_SetArraysNam(eMarginList; 1; 6; "aPartNum"; "aPartDesc"; "aPartQty"; "aQtyOnHand"; "aCosts"; "aQtyOrd")
		// -- AL_SetHeaders(eMarginList; 1; 6; "Item Number"; "Description"; "BLQ"; "Avail"; "Cost"; "Price")
		// -- AL_SetWidths(eMarginList; 1; 6; 85; 130; 51; 51; 51; 51)
		//
		// -- AL_SetRowOpts(eMarginList; 1; 0; 0; 0; 1)
		//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
		// -- AL_SetColOpts(eMarginList; 1; 0; 1; 0; 0)
		//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
		// -- AL_SetEntryOpts(eMarginList; 1; 0; 0)
		//Name; EntryMode; AllowReturn; DisplaySeconds
		// -- AL_SetSortOpts(eMarginList; 0; 1; 1; ""; 1)
		//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
		// -- AL_SetCallbacks(eMarginList; ""; "")
		//Name; GP at entry; Function true or false if keep changes   
		//
		//// -- AL_SetFormat (eMarginList;3;"###,###.####";3;2)
		//// -- AL_SetFormat (eMarginList;4;"###,###.####";3;2)
		// -- AL_SetFormat(eMarginList; 5; <>tcFormatUP; 3; 2)
		// -- AL_SetFormat(eMarginList; 6; <>tcFormatUP; 3; 2)
		//
		// -- AL_SetHdrStyle(eMarginList; 0; "Geneva"; 9; 2)
		// -- AL_SetStyle(eMarginList; 0; "Geneva"; 12; 0)
		// -- AL_SetDividers(eMarginList; "Gray"; "Gray"; 0; ""; ""; 0)
	Else 
		//
End case 
