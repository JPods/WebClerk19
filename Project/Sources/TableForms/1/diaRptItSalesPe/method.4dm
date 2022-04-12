// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-08-13T00:00:00, 00:19:48
// ----------------------------------------------------
// Method: [Control].diaRptItSalesPe
// Description
// Modified: 08/13/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------



Case of 
	: (Before:C29)
		jsetBefore(->[Control:1])
		SET WINDOW TITLE:C213("Item Period Sales")
		//    Pict_InputLo ([Control];1;4)//get PICT resc 21004
		
		ARRAY TEXT:C222(aPartNum; 0)
		ARRAY TEXT:C222(aPartDesc; 0)
		ARRAY REAL:C219(aCosts; 0)
		ARRAY REAL:C219(aQtySold; 0)
		ARRAY REAL:C219(aQtyOrd; 0)
		ARRAY REAL:C219(aQtyOnPOLns; 0)
		ARRAY REAL:C219(aQtyOnHand; 0)
		ARRAY LONGINT:C221(aLeadTime; 0)
		ARRAY LONGINT:C221(aFactor; 0)
		
		booAccept:=True:C214
		C_LONGINT:C283($error)
		// -- $error:=AL_SetArraysNam(eSaleItList; 1; 9; "aPartNum"; "aPartDesc"; "aCosts"; "aQtySold"; "aQtyOrd"; "aQtyOnPOLns"; "aQtyOnHand"; "aLeadTime"; "aFactor")
		// -- AL_SetHeaders(eSaleItList; 1; 9; "Item Number"; "Description"; "$"; "Ship'd"; "OnSO"; "OnPO"; "O/H"; "Lead"; "Factor")
		// -- AL_SetWidths(eSaleItList; 1; 9; 80; 160; 60; 60; 60; 60; 60; 60; 60)
		// -- AL_SetRowOpts(eSaleItList; 1; 1; 0; 0; 1)
		//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
		// -- AL_SetColOpts(eSaleItList; 1; 0; 1; 0; 0)
		//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
		// -- AL_SetEntryOpts(eSaleItList; 1; 0; 0)
		//Name; EntryMode; AllowReturn; DisplaySeconds
		// -- AL_SetSortOpts(eSaleItList; 0; 1; 1; ""; 1)
		//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
		//// -- AL_SetCallbacks (eSaleItList;"";"")
		//Name; GP at entry; Function true or false if keep changes
		// -- AL_SetSort(eSaleItList; 1)
		// -- AL_SetFormat(eSaleItList; 3; "###,###"; 0; 2)
		// -- AL_SetFormat(eSaleItList; 4; "###,###.###"; 0; 2)
		// -- AL_SetFormat(eSaleItList; 5; "###,###.###"; 0; 2)
		// -- AL_SetFormat(eSaleItList; 6; "###,###.###"; 0; 2)
		// -- AL_SetFormat(eSaleItList; 7; "###,###.###"; 0; 2)
		//
		// -- AL_SetHdrStyle(eSaleItList; 0; "Geneva"; 9; 2)
		// -- AL_SetStyle(eSaleItList; 0; "Geneva"; 12; 0)
		// -- AL_SetDividers(eSaleItList; "Gray"; "Gray"; 0; ""; ""; 0)
		vdDateBeg:=Current date:C33
		vdDateEnd:=Current date:C33
	: (Outside call:C328)
		Prs_OutsideCall
	Else 
		If (doSearch>0)
			//  CHOPPED  AL_GetScroll(eSaleItList; viVert; viHorz)
			//  --  CHOPPED  AL_UpdateArrays(eSaleItList; Size of array(aPartNum))
			$setLine:=aPartNum
			// -- AL_SetLine(eSaleItList; $setLine)
			// -- AL_SetScroll(eSaleItList; viVert; viHorz)
			doSearch:=0
			ARRAY LONGINT:C221(aItemLines; 0)
		End if 
End case 