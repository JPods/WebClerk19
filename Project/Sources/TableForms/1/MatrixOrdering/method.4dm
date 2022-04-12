// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/08/10, 09:41:30
// ----------------------------------------------------
// Method: Form Method: MatrixOrdering
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Before:C29)
		viRecordsInSelection:=0
		ARRAY LONGINT:C221(aRayLines; 0)
		bNewRec:=0
		
		jsetBefore(->[Control:1])
		C_BOOLEAN:C305($notGroup)
		$notGroup:=Not:C34(UserInPassWordGroup("Costing"))
		If ($notGroup)
			C_LONGINT:C283($theColor)
			$theColor:=14
			_O_OBJECT SET COLOR:C271([Item:4]costAverage:13; -$theColor+(256*$theColor))
			_O_OBJECT SET COLOR:C271([Item:4]costLastInShip:47; -$theColor+(256*$theColor))
		End if 
		Item_ListBe4(eQuickQuote)
		If (<>vItemNum#"")
			doSearch:=2
			srItem:=<>vItemNum
			<>vItemNum:=""
			doSearch:=ItemSr(doSearch)
			If (doSearch>0)
				viRecordsInSelection:=Records in selection:C76([Item:4])
				List_FillOpts(viRecordsInSelection; vUseBase)
				// -- AL_SetWidths(eQuickQuote; 1; 14; 12; 65; 100; 51; 51; 51; 45; 47; 51; 37; 51; 51; 3; 3)
				REDUCE SELECTION:C351([Item:4]; 0)
				REDUCE SELECTION:C351([ItemSpec:31]; 0)
			End if 
			// -- AL_SetRowColor(eQuickQuote; 0; "Black"; 0; "white"; 0)
			//  --  CHOPPED  AL_UpdateArrays(eQuickQuote; -2)
			$setLine:=aLsItemNum
			// -- AL_SetLine(eQuickQuote; $setLine)
			doSearch:=0
		End if 
		
		OBJECT SET ENABLED:C1123(b21; False:C215)
		OBJECT SET ENABLED:C1123(b22; False:C215)
	: (Outside call:C328)
		Case of 
			: (<>vItemNum#"")
				doSearch:=2
				srItem:=<>vItemNum
				<>vItemNum:=""
				doSearch:=ItemSr(doSearch)
				If (doSearch>0)
					viRecordsInSelection:=Records in selection:C76([Item:4])
					List_FillOpts(viRecordsInSelection; vUseBase)
					// -- AL_SetWidths(eQuickQuote; 1; 14; 12; 65; 100; 51; 51; 51; 45; 47; 51; 37; 51; 51; 3; 3)
					REDUCE SELECTION:C351([Item:4]; 0)
					REDUCE SELECTION:C351([ItemSpec:31]; 0)
				End if 
				// -- AL_SetRowColor(eQuickQuote; 0; "Black"; 0; "white"; 0)
				//  --  CHOPPED  AL_UpdateArrays(eQuickQuote; -2)
				$setLine:=aLsItemNum
				// -- AL_SetLine(eQuickQuote; $setLine)
				doSearch:=0
			: (<>vbDoQuit)  //must be first, prevent error with vlRecNum
				Quit_Processes
		End case 
	Else 
		If (doSearch>0)
			If (Modified record:C314([Item:4]))
				SAVE RECORD:C53([Item:4])
			End if 
			If (Modified record:C314([ItemSpec:31]))
				SAVE RECORD:C53([ItemSpec:31])
			End if 
			CLEAR VARIABLE:C89(vItemPict)
			doSearch:=ItemSr(doSearch)
			If (doSearch>0)
				viRecordsInSelection:=Records in selection:C76([Item:4])
				vUseBase:=SetPricePoint(<>aTypeSale{<>aTypeSale})  // set base for new items
				List_FillOpts(viRecordsInSelection; vUseBase; <>aTypeSale{<>aTypeSale})
				// -- AL_SetWidths(eQuickQuote; 1; 14; 12; 65; 100; 51; 51; 51; 45; 47; 51; 37; 51; 51; 3; 3)
				REDUCE SELECTION:C351([Item:4]; 0)
				REDUCE SELECTION:C351([ItemSpec:31]; 0)
			End if 
			// -- AL_SetRowColor(eQuickQuote; 0; "Black"; 0; "white"; 0)
			//  --  CHOPPED  AL_UpdateArrays(eQuickQuote; -2)
			$setLine:=aLsItemNum
			// -- AL_SetLine(eQuickQuote; $setLine)
			doSearch:=0
		End if 
		If (Size of array:C274(aItemLines)>0)
			OBJECT SET ENABLED:C1123(b21; True:C214)
			OBJECT SET ENABLED:C1123(b22; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(b21; False:C215)
			OBJECT SET ENABLED:C1123(b22; False:C215)
		End if 
		
End case 