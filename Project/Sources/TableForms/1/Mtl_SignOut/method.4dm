//Material Signout
Case of 
	: (Before:C29)
		vtWdStatus:=""
		C_LONGINT:C283(viWdSalesOr)
		C_TEXT:C284(vtWdStatus)
		C_REAL:C285(vrWdQty)
		Case of 
			: (ptCurTable=(->[Order:3]))
				viWdSalesOr:=[Order:3]idNum:2
			: (ptCurTable=(->[Invoice:26]))
				viWdSalesOr:=[Invoice:26]idNumOrder:1
			Else 
				viWdSalesOr:=0
		End case 
		//Ord_OpenRay 
		vNameID:=Current user:C182
		srItem:=""
		srItemDscrp:=""
		srItemMfrItemNum:=""
		srItemType:=""
		srItemsProfile1:=""
		srItemsProfile2:=""
		srItemsProfile3:=""
		srItemsProfile4:=""
		<>aCostCause:=1
		Wd_FillRay(0)
		// -- $error:=AL_SetArraysNam(eItemWd; 1; 11; "aWdItem"; "aWdDscrp"; "aWdReason"; "aWdQty"; "aWdCost"; "aWdDate"; "aWdNameID"; "aWdSo"; "aWdComment"; "aWdVendor"; "aWdItemRec")
		// -- AL_SetHeaders(eItemWd; 1; 11; "Item"; "Description"; "Cause"; "Qty"; "Cost"; "Date"; "Name"; "SO"; "Comment"; "Vend"; "Rec")
		// -- AL_SetWidths(eItemWd; 1; 11; 40; 30; 12; 27; 52; 78; 78; 79; 70; 70; 54)
		//
		// -- AL_SetRowOpts(eItemWd; 1; 1; 1; 0; 1)
		//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
		//$columnCnt:=Num(Error#0)*8
		// -- AL_SetColOpts(eItemWd; 1; 0; 1; 0; 1)  //$columnCnt;0)
		//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
		//
		// // -- AL_SetEntryOpts (eItemWd;6;0;1;1)
		// -- AL_SetEntryOpts(eItemWd; 6; 1; 1; 1)
		//Name; EntryMode; AllowReturn; DisplaySeconds;MoveWithArrow;MapEnterKey
		//
		// -- AL_SetSortOpts(eItemWd; 0; 1; 1; ""; 1)
		//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
		// -- AL_SetCallbacks(eItemWd; ""; "")
		//Name; GP at entry; Function true or false if keep changes
		// -- AL_SetSort(eItemWd; 1)  //Seq
		//// -- AL_SetColLock (eItemWd;2)//Lock after Alt Item Num
		// -- AL_SetMiscOpts(eItemWd; 0; 1; ""; 0)
		//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
		// -- AL_SetDividers(eItemWd; "Gray"; "Gray"; 0; ""; ""; 0)
		// -- AL_SetStyle(eItemWd; 0; "Geneva"; 12; 0)
		// -- AL_SetHdrStyle(eItemWd; 0; "Geneva"; 9; 0)
		//// -- AL_SetEnterable (eItemWd;1;1)    
		// -- AL_SetFormat(eItemWd; 8; "0000-0000"; 3; 0)
		// -- AL_SetFormat(eItemWd; 4; "###,###.###")
		//    
		//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
		
		// -- AL_SetEnterable(eItemWd; 7; 3; <>aNameID)
		// -- AL_SetEnterable(eItemWd; 8; 3; <>aActiveWOs)
		// -- AL_SetEnterable(eItemWd; 6; 3)
		//
		//// -- AL_SetEnterable (eItemWd;7;1)
		//// -- AL_SetEnterable (eItemWd;8;1)
		//// -- AL_SetEnterable (eItemWd;6;1)
		
		//// -- AL_SetEntryOpts ($1;6;1;1;1)
		//// -- AL_SetEnterable ($1;2;3;<>aNameID)
		//// -- AL_SetEnterable ($1;3;3;<>aActivities)
		//// -- AL_SetEnterable ($1;6;3;<>aActiveWOs)
		//name; column; mode; array    
	: (Outside call:C328)
		If (<>vbDoQuit)  //must be first, prevent error with <>vlRecNum
			Quit_Processes
		End if 
	Else 
		If (doSearch>0)
			C_LONGINT:C283($error)
			Case of 
				: (doSearch=18)
					//  CHOPPED  AL_GetScroll(eItemWd; viVert; viHorz)
					//  CHOPPED  $error:=AL_GetSelect(eItemWd; aWDItemLine)
					//  --  CHOPPED  AL_UpdateArrays(eItemWd; -2)
					// -- AL_SetScroll(eItemWd; viVert; viHorz)
					// -- AL_SetSelect(eItemWd; aWDItemLine)
				: (doSearch=55)
					//  CHOPPED  AL_GetScroll(eItemWd; viVert; viHorz)
					//  CHOPPED  $error:=AL_GetSelect(eItemWd; aWDItemLine)
					//  --  CHOPPED  AL_UpdateArrays(eItemWd; -2)
					// -- AL_SetScroll(eItemWd; viVert; viHorz)
					// -- AL_SetSelect(eItemWd; aWDItemLine)
				Else 
					doSearch:=ItemSr(doSearch)
					If (doSearch>1)
						Wd_FillRay(Records in selection:C76([Item:4]))
						//  --  CHOPPED  AL_UpdateArrays(eItemWd; -2)
					End if 
			End case 
			doSearch:=0
		End if 
End case 