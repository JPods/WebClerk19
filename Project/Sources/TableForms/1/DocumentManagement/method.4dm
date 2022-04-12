Case of 
	: ((Before:C29) | (booPreNext))
		If (Is macOS:C1572)
			v8:=Replace string:C233(<>WebFolder; "/"; ":")+":"
		Else 
			v8:=Replace string:C233(<>WebFolder; "/"; "\\")+"\\"
		End if 
		viRecordsInSelection:=0
		ARRAY LONGINT:C221(aRayLines; 0)
		bNewRec:=0
		jsetBefore(->[Control:1])
		SET WINDOW TITLE:C213("Document Editor")
		//  Pict_InputLo (->[Control];1;7)//get PICT resc 21006
		HtPageRay(0)
		iLoText1:=""
		iLoText2:=""
		iLoText3:=""
		iLoText4:=""
		iLoText8:=""
		iLoText10:=""
		iLoText11:="R*ch"
		iLoText12:="txtt"
		iLoText13:=""
		iLoText14:=""
		//
		// -- $error:=AL_SetArraysNam(eHttpEdit; 1; 11; "aHtSelect"; "aHtPage"; "aHtReason"; "aHtBkGraf"; "aHtBkColor"; "aHtLink"; "aHtvLink"; "aHtaLink"; "aHtText"; "aHtBody"; "aHtStyle")
		// -- AL_SetHeaders(eHttpEdit; 1; 11; "t"; "Document"; "Pub"; "Title"; "Description"; "Keywords"; "RecordID"; "HiRes"; "Source"; "Event"; "Copyright")
		// -- AL_SetWidths(eHttpEdit; 1; 11; 10; 112; 12; 54; 54; 54; 54; 54; 54; 200; 400)
		//
		// -- AL_SetRowOpts(eHttpEdit; 1; 1; 0; 0; 1)
		//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
		// -- AL_SetColOpts(eHttpEdit; 1; 0; 1; 0; <>viPixel)
		//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
		// -- AL_SetEntryOpts(eHttpEdit; 6; 0; 0)
		//Name; EntryMode; AllowReturn; DisplaySeconds
		// -- AL_SetSortOpts(eHttpEdit; 0; 1; 1; ""; 0)
		//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
		//// -- AL_SetCallbacks (eHttpEdit;"";"")
		//Name; GP at entry; Function true or false if keep changes
		// -- AL_SetSort(eHttpEdit; 2; 3)
		
		// -- AL_SetHdrStyle(eHttpEdit; 0; "Geneva"; 9; 0)
		// -- AL_SetStyle(eHttpEdit; 0; "Geneva"; 12; 0)
		// -- AL_SetDividers(eHttpEdit; "Gray"; "Gray"; 0; ""; ""; 0)
		// -- AL_SetMiscOpts(eHttpEdit; 0; 1; ""; 0)
		//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
		
		booDuringDo:=True:C214
		
	: (Outside call:C328)
		If (<>vbDoQuit)  //must be first, prevent error with <>vlRecNum
			Quit_Processes
		End if 
	Else 
		If (doSearch>0)
			$k:=Size of array:C274(aRayLines)
			For ($i; 1; $k)
				Case of 
					: (doSearch=50)
						aHtBkGraf{aRayLines{$i}}:=iLoText2  //[ImagePath]Title
						aHtBkColor{aRayLines{$i}}:=iLoText8  //[ImagePath]Description
						aHtLink{aRayLines{$i}}:=iLoText10  //[ImagePath]KeywordText
						//aHtvLink{aRayLines{$i}}:=iLoText2//$aStrRecs{$fia}
						//aHtaLink{aRayLines{$i}}:=iLoText2//[ImagePath]PathHiRes
						aHtText{aRayLines{$i}}:=iLoText3  //[ImagePath]ImageName
						aHtBody{aRayLines{$i}}:=iLoText4  //[ImagePath]Event
						aHtReason{aRayLines{$i}}:=iLoText5  //String([ImagePath]Publish)
					: (doSearch=2)
						aHtBkGraf{aRayLines{$i}}:=iLoText2  //[ImagePath]Title
					: (doSearch=3)
						aHtText{aRayLines{$i}}:=iLoText3  //[ImagePath]ImageName
					: (doSearch=4)
						aHtBody{aRayLines{$i}}:=iLoText4  //[ImagePath]Event
					: (doSearch=5)
						aHtReason{aRayLines{$i}}:=iLoText5  //String([ImagePath]Publish)
					: (doSearch=8)
						aHtBkColor{aRayLines{$i}}:=iLoText8  //[ImagePath]Description
					: (doSearch=10)
						aHtLink{aRayLines{$i}}:=iLoText10  //[ImagePath]KeywordText       
				End case 
			End for 
			//  CHOPPED  AL_GetScroll(eHttpEdit; viVert; viHorz)
			//  --  CHOPPED  AL_UpdateArrays(eHttpEdit; -2)
			// -- AL_SetSelect(eHttpEdit; aRayLines)
			// -- AL_SetScroll(eHttpEdit; viVert; viHorz)
			doSearch:=0
		End if 
		booAccept:=True:C214
End case 