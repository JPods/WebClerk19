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
		vNameID:=Current user:C182
		srItem:=""
		srItemDscrp:=""
		srItemMfgItemNum:=""
		srItemType:=""
		srItemsProfile1:=""
		srItemsProfile2:=""
		srItemsProfile3:=""
		srItemsProfile4:=""
		<>aCostCause:=1
		ARRAY TEXT:C222(aWdItem; 0)
		ARRAY TEXT:C222(aWdDscrp; 0)
		ARRAY LONGINT:C221(aWdItemRec; 0)
		// -- $error:=AL_SetArraysNam(eItemWd; 1; 3; "aWdItem"; "aWdDscrp"; "aWdItemRec")
		// -- AL_SetHeaders(eItemWd; 1; 3; "Item"; "Description"; "Rec")
		// -- AL_SetWidths(eItemWd; 1; 3; 126; 218)
		//
		// -- AL_SetRowOpts(eItemWd; 1; 1; 1; 0; 1)
		//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
		//$doChange:=User in group(Current user;"Costing")
		//$columnCnt:=Num(not($doChange))*8
		// -- AL_SetColOpts(eItemWd; 1; 0; 1; 0; 0)  //$columnCnt;0)
		//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
		// -- AL_SetEntryOpts(eItemWd; 1; 0; 0)
		//Name; EntryMode; AllowReturn; DisplaySeconds
		// -- AL_SetSortOpts(eItemWd; 0; 1; 1; ""; 1)
		//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
		// -- AL_SetCallbacks(eItemWd; ""; "")
		//Name; GP at entry; Function true or false if keep changes
		// -- AL_SetSort(eItemWd; 11)  //Seq
		// -- AL_SetColLock(eItemWd; 2)  //Lock after Alt Item Num
		// -- AL_SetMiscOpts(eItemWd; 0; 1; ""; 0)
		//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
		
		// -- AL_SetDividers(eItemWd; "Gray"; "Gray"; 0; ""; ""; 0)
		// -- AL_SetStyle(eItemWd; 0; "Geneva"; 12; 0)
		// -- AL_SetHdrStyle(eItemWd; 0; "Geneva"; 9; 0)
		// -- AL_SetHdrStyle(eItemWd; 1; "Geneva"; 9; 1)  //Item Number
		// -- AL_SetHdrStyle(eItemWd; 10; "Geneva"; 9; 2)  //Ext Price
		//    
		//// -- AL_SetEnterable (eItemWd;1;1)    
	Else 
		If (doSearch>0)
			doSearch:=ItemSr(doSearch)
			If (doSearch>0)
				SELECTION TO ARRAY:C260([Item:4]itemNum:1; aWdItem; [Item:4]description:7; aWdDscrp; [Item:4]; aWdItemRec)
				doSearch:=0
				//  --  CHOPPED  AL_UpdateArrays(eItemWd; -2)
			End if 
		End if 
End case 