Case of 
	: ((Before:C29) | (booPreNext))
		C_LONGINT:C283($k; $i; $gotoLine)
		myOK:=0
		viRecordsInSelection:=0
		ARRAY LONGINT:C221(aRayLines; 0)
		
		bNewRec:=0
		jsetBefore(->[Control:1])
		SET WINDOW TITLE:C213("Sales Report")
		// Pict_InputLo (->[Control];1;7)//get PICT resc 21007   
		//
		// -- $error:=AL_SetArraysNam(eRptList; 1; 6; "aBullets"; "aCustSales"; "a20Str1"; "a20Str2"; "a20Str3"; "a20Str4")
		// -- AL_SetHeaders(eRptList; 1; 6; "T"; "Value"; "Period1"; "Period2"; "Diff"; "%Diff")
		// -- AL_SetWidths(eRptList; 1; 6; 3; 100; 100; 100; 100; 100)  //10;100;100;100;100;100)
		//
		// -- AL_SetRowOpts(eRptList; 1; 0; 1; 0; 1)
		//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
		// -- AL_SetColOpts(eRptList; 1; 0; 1; 0; 0)
		//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
		// -- AL_SetEntryOpts(eRptList; 1; 0; 0)
		//Name; EntryMode; AllowReturn; DisplaySeconds
		// -- AL_SetSortOpts(eRptList; 0; 1; 1; ""; 1)
		//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
		// -- AL_SetCallbacks(eRptList; ""; "")
		//Name; GP at entry; Function true or false if keep changes   
		//    
		//    // -- AL_SetFormat (eRptList;4;"";3;2)
		//    // -- AL_SetFormat (eRptList;5;"";3;2)
		//    // -- AL_SetFormat (eRptList;6;"";3;2)
		
		// -- AL_SetHdrStyle(eRptList; 0; "Geneva"; 9; 2)
		// -- AL_SetStyle(eRptList; 0; "Geneva"; 12; 0)
		// -- AL_SetDividers(eRptList; "Gray"; "Gray"; 0; ""; ""; 0)
		// -- AL_SetFormat(eRptList; 0; ""; 3; 2)
		b1:=1
		//
		vDate4:=Date_ThisMon(Current date:C33; 1)
		vDate3:=Date_ThisMon(vDate4; 0)
		vDate2:=vDate3-1
		vDate1:=Date_ThisMon(vDate2; 0)
		
		
	: (Outside call:C328)
		If (<>vbDoQuit)  //must be first, prevent error with <>vlRecNum
			Quit_Processes
		End if 
	Else 
		
		If (doSearch>0)
			//  --  CHOPPED  AL_UpdateArrays(eRptList; -2)
			doSearch:=0
		End if 
End case 