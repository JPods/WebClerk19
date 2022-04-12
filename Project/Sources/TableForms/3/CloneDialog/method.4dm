Case of 
	: (Before:C29)
		aTmpLong1:=0
		$doChoice:=False:C215
		C_TEXT:C284(vDiaCom)
		vDiaCom:=""
		Case of 
			: (ptCurTable=(->[Order:3]))
				COPY ARRAY:C226(<>aCloneOrderStatus; aTmp20Str1)
				COPY ARRAY:C226(<>aCloneOrderID; aTmpLong1)
				COPY ARRAY:C226(<>aCloneOrderComment; aTmpText1)
				$doChoice:=True:C214
			: (ptCurTable=(->[Proposal:42]))
				COPY ARRAY:C226(<>aClonePpStatus; aTmp20Str1)
				COPY ARRAY:C226(<>aClonePpID; aTmpLong1)
				COPY ARRAY:C226(<>aClonePpComment; aTmpText1)
				$doChoice:=True:C214
				//: (ptCurTable=(->[PO]))
				//
				//
				//: (ptCurTable=(->[Invoice]))
				
				
			Else 
				ALERT:C41("Applies only to Orders and Proposals")  //POs,
				CANCEL:C270
		End case 
		If ($doChoice)
			C_LONGINT:C283(eCloneList)  //areaList; entry option
			// -- $error:=AL_SetArraysNam(eCloneList; 1; 3; "aTmp20Str1"; "aTmpText1"; "aTmpLong1")
			// -- AL_SetHeaders(eCloneList; 1; 3; "Clone"; "Comment"; "RecNum:")
			// -- AL_SetWidths(eCloneList; 1; 3; 200; 810; 90)
			//
			// -- AL_SetRowOpts(eCloneList; 0; 1; 1; 0; 1)
			//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
			// -- AL_SetColOpts(eCloneList; 1; 0; 0; 0; 0)
			//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
			// -- AL_SetEntryOpts(eCloneList; 1; 0; 1; 1)
			//Name; EntryMode; AllowReturn; DisplaySeconds;MoveWithArrow;MapEnterKey
			// -- AL_SetSortOpts(eCloneList; 0; 1; 1; ""; 1)
			//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
			//C_POINTER(ptAreaID)
			//ptAreaID:=eCloneList
			//// -- AL_SetCallbacks (eCloneList;"ALGetCurrCell";"")//vlAreaID;
			// -- AL_SetEnterable(eCloneList; 1; 1)
			//Name; GP at entry; Function true or false if keep changes
			//    // -- AL_SetSort (eCloneList;1)
			//    
			//// -- AL_SetFilter (eCloneList;8;"##:##")
			//// -- AL_SetFormat (eCloneList;10;"###,###,###.###";0;2)
			//
			// -- AL_SetHdrStyle(eCloneList; 0; "Geneva"; 9; 2)
			// -- AL_SetStyle(eCloneList; 0; "Geneva"; 12; 0)
			//// -- AL_SetDividers (eCloneList;"Gray";"Gray";0;"";"";0)
			// -- AL_SetMiscOpts(eCloneList; 0; 1; ""; 0)
			//Name; HideHeaders; AreaSelected; PostKey; ShowFooter
			//  --  CHOPPED  AL_UpdateArrays(eCloneList; -2)
		End if 
		//    
	: (Outside call:C328)
		Prs_OutsideCall
		
	Else 
		
End case 