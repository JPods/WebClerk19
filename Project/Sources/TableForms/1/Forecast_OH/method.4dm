
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/05/19, 17:24:23
// ----------------------------------------------------
// Method: [Control].Forecast_OH
// Description
// 
//
// Parameters
// ----------------------------------------------------



Case of 
	: (Outside call:C328)
		If (<>vbDoQuit)  //must be first, prevent error with <>vlRecNum
			Quit_Processes
		End if 
	: ((Before:C29) | (booPreNext))
		//    correct this and make these functional
		//currently crash on retrieve at the AL_UpdateArray in During
		//OBJECT SET ENABLED(b24;FALSE)
		//OBJECT SET ENABLED(b25;FALSE)
		//
		
		iLoMenu:=6
		jsetBefore(->[Control:1])
		SET WINDOW TITLE:C213("Forecasting"+"-"+Current user:C182)
		// Pict_InputLo (->[Control];1;5)//get PICT resc 21005
		//   
		FC_FillRay(0)
		
		// -- $error:=AL_SetArraysNam(eForeCast; 1; 8; "aFCItem"; "aFCDesc"; "aFCActionDt"; "aFCBomCnt"; "aFCRunQty"; "aFCBaseQty"; "aFCTallyYTD"; "aFCTallyLess1Year")
		// -- $error:=AL_SetArraysNam(eForeCast; 9; 8; "aFCTallyLess2Year"; "aFCBomLevel"; "aFCParent"; "aFCTypeTran"; "aFCDocID"; "aFCWho"; "aFCtypeID"; "aFCRecNum")
		
		// -- AL_SetHeaders(eForeCast; 1; 15; "Item Num"; "Description"; "Date"; "Qty Chng"; "Forcast Qty OH"; "Qty OH"; "Tally YTD"; "Tally YTD-1"; "Tally YTD-2"; "Level"; "Doc Item"; "Type"; "Doc ID"; "Who"; "typeID")
		
		C_LONGINT:C283(DateColSize; TallyColSize; QtyOHSize; QtyChangeSize)
		If (<>vbShowTallyInForcast)
			DateColSize:=1
			QtyChangeSize:=1
			TallyColSize:=60
			QtyOHSize:=56
		Else 
			DateColSize:=54
			QtyChangeSize:=56
			TallyColSize:=1
			QtyOHSize:=1
		End if 
		// -- AL_SetWidths(eForeCast; 1; 15; 61; 5; DateColSize; QtyChangeSize; 56; QtyOHSize; TallyColSize; TallyColSize; TallyColSize; 66; 52; 19; 58; 120; 60)
		
		// -- AL_SetHdrStyle(eForeCast; 0; "Geneva"; 9; 2)
		// -- AL_SetStyle(eForeCast; 0; "Geneva"; 12; 0)
		// -- AL_SetDividers(eForeCast; "Gray"; "Gray"; 0; ""; ""; 0)
		// -- AL_SetSort(eForeCast; 1; 3; 8)
		
		
		// -- AL_SetRowOpts(eForeCast; 1; 1; 0; 0; 1)
		//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
		// -- AL_SetColOpts(eForeCast; 1; 0; 1; 1; 0)
		//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
		// -- AL_SetEntryOpts(eForeCast; 1; 0; 0)
		//Name; EntryMode; AllowReturn; DisplaySeconds
		// -- AL_SetSortOpts(eForeCast; 0; 1; 1; ""; 1)
		//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
		// -- AL_SetCallbacks(eForeCast; ""; "")
		//Name; GP at entry; Function true or false if keep changes  
		// -- AL_SetMiscOpts(eForeCast; 0; 1; ""; 0)
		//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
		
		// -- AL_SetFormat(eForeCast; 3; "1"; 0; 0)  //aFCActionDt
		// -- AL_SetFormat(eForeCast; 4; "###,###,###.###")  //aFCBomCnt
		// -- AL_SetFormat(eForeCast; 5; "###,###,###.###")
		// -- AL_SetFormat(eForeCast; 6; "###,###,###.###")  //aFCRunQty
		// -- AL_SetFormat(eForeCast; 7; "###,###,###.###")  //aFCTally
		// -- AL_SetFormat(eForeCast; 8; "###,###,###.###")  //aFCTally
		// -- AL_SetFormat(eForeCast; 9; "###,###,###.###")  //aFCTally
		// -- AL_SetFormat(eForeCast; 10; "0000-0000")
		//    
		vDate1:=Current date:C33
		vTime1:=Current time:C178
		//vCalendarBegin:=Date_ThisMon (Current date;0)
		////   CHOPPED CS_SetRange (eSerCal;vCalendarBegin;!00/00/00!)
		//defaults to the current if Set Range is not called
		////   CHOPPED  CS_Options (eSerCal;1;0;2;1)
		//CalendarActRay (->aFCActionDt;(Size of array(aFCActionDt)))
		////  CHOPPED MM_SetDate (ePopDate;Current date)
		OBJECT SET ENABLED:C1123(b22; False:C215)
		OBJECT SET ENABLED:C1123(b21; False:C215)
		OBJECT SET ENABLED:C1123(b23; False:C215)
		OBJECT SET ENABLED:C1123(b32; False:C215)
		OBJECT SET ENABLED:C1123(b33; False:C215)
		
	Else 
		
		If (ptCurTable#(->[Control:1]))
			
			jsetDuringIncl(->[Control:1])
			SET WINDOW TITLE:C213("Forecasting"+"-"+Current user:C182)
			//    Pict_InputLo (->[Control];1;5)//get PICT resc 21005
			
			//vDate1:=Current date
			//d00Begin:=Date_strYrMmDd (vDate1;0)
			//vTime1:=Current time
		End if 
		Case of 
			: (doSearch=1)
			: (doSearch=8)
				// -- AL_SetHeaders(eForeCast; 1; 15; "Item Num"; "Description"; "Date"; "Qty Chng"; "Forcast Qty OH"; "Qty OH"; "Tally YTD"; "Tally YTD-1"; "Tally YTD-2"; "Level"; "Doc Item"; "Type"; "Doc ID"; "Who"; "typeID")
				If (((Size of array:C274(aFCDesc))#(Size of array:C274(aFCRunQty))) | ((Size of array:C274(aFCDesc))#(Size of array:C274(aFCRecNum))))
					ARRAY TEXT:C222(aFCDesc; Size of array:C274(aFCRecNum))  //Description
					ARRAY REAL:C219(aFCRunQty; Size of array:C274(aFCRecNum))  //          Running quantity on hand        
					//$theString:="["
					//POST KEY(Ascii("[");256)
				End if 
		End case 
		If (doSearch>0)
			C_LONGINT:C283($k; $i)  //
			//  CHOPPED  AL_GetScroll(eForeCast; viVert; viHorz)
			If (Size of array:C274(aFCItem)<=<>alpArrayMax)
				//  --  CHOPPED  AL_UpdateArrays(eForeCast; -2)
			Else 
				doSearch:=0
				ALERT:C41("Arrays are too large to display."+"Run Date Item or Export.")
			End if 
			viRecordsInSelection:=Size of array:C274(aFCItem)
			Case of 
				: (doSearch=6)
					ARRAY LONGINT:C221(aFCSelect; 0)
				: (doSearch=7)  //do nothing when recalling a file        
				: (doSearch=8)
					//// -- AL_SetSort (eForeCast;1;3;8)
					//v1:="["
					//PostEvt (v1;256;error)
					//v1:=""
				Else 
					// -- AL_SetSelect(eForeCast; aRayLines)
					// -- AL_SetScroll(eForeCast; viVert; viHorz)
			End case 
			doSearch:=0
		End if 
		If (Size of array:C274(aFCRecNum)=0)
			OBJECT SET ENABLED:C1123(b22; False:C215)
			OBJECT SET ENABLED:C1123(b21; False:C215)
			OBJECT SET ENABLED:C1123(b23; False:C215)
			OBJECT SET ENABLED:C1123(b32; False:C215)
			OBJECT SET ENABLED:C1123(b33; False:C215)
			
		Else 
			OBJECT SET ENABLED:C1123(b22; True:C214)
			OBJECT SET ENABLED:C1123(b21; True:C214)
			OBJECT SET ENABLED:C1123(b23; True:C214)
			OBJECT SET ENABLED:C1123(b32; True:C214)
			OBJECT SET ENABLED:C1123(b33; True:C214)
			
		End if 
		
End case 