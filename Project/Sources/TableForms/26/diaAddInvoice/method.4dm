Case of 
	: (Before:C29)
		C_LONGINT:C283($k; $error)
		C_LONGINT:C283(vi6)
		vi1:=0
		v6:=""
		vi6:=0
		myOK:=0
		viRecordsInSelection:=0
		Ord_FillArray(0; 0)  //record count; 0 build array,>0 insert element,<0 delete element
		// -- $error:=AL_SetArraysNam(eOpenOrders; 1; 5; "aOpenOrders"; "aNeedDates"; "aComDates"; "aCustCtrl"; "aOrdRecs")
		// -- AL_SetHeaders(eOpenOrders; 1; 4; "Order Number"; "Need Date"; "Status"; "Ship To")
		// -- AL_SetWidths(eOpenOrders; 1; 4; 82; 66; 66; 150)
		//
		// -- AL_SetRowOpts(eOpenOrders; 0; 0; 0; 0; 1)
		//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
		// -- AL_SetColOpts(eOpenOrders; 1; 0; 0; 1; 0)
		//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
		// -- AL_SetEntryOpts(eOpenOrders; 1; 0; 0)
		//Name; EntryMode; AllowReturn; DisplaySeconds
		// -- AL_SetSortOpts(eOpenOrders; 0; 1; 1; ""; 1)
		//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
		// -- AL_SetCallbacks(eOpenOrders; ""; "")
		//Name; GP at entry; Function true or false if keep changes
		// -- AL_SetSort(eOpenOrders; 3)
		//
		// -- AL_SetHdrStyle(eOpenOrders; 0; "Geneva"; 9; 2)
		// -- AL_SetStyle(eOpenOrders; 0; "Geneva"; 12; 0)
		// -- AL_SetDividers(eOpenOrders; "Gray"; "Gray"; 0; ""; ""; 0)
		// -- AL_SetFormat(eOpenOrders; 1; "0000-0000"; 2; 2)
	: (Outside call:C328)
		Prs_OutsideCall
		
	Else 
		If (doSearch=1)
			SELECTION TO ARRAY:C260([Order:3]company:15; aCustCtrl; [Order:3]dateNeeded:5; aNeedDates; [Order:3]dateInvoiceComp:6; aComDates; [Order:3]idNum:2; aOpenOrders)
			ARRAY LONGINT:C221(aOrdRecs; Records in selection:C76([Order:3]))
			For ($i; 1; Records in selection:C76([Order:3]))
				aOrdRecs{$i}:=$i
			End for 
			//  --  CHOPPED  AL_UpdateArrays(eOpenOrders; Size of array(aOrdRecs))
			viRecordsInSelection:=Records in selection:C76([Order:3])
		End if 
		doSearch:=0
		HIGHLIGHT TEXT:C210(vi1; 1; 10)
End case 