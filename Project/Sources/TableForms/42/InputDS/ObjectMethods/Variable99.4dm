// srKeywordMethod 
TRACE:C157
If (srKeyword#"")
	If (bSelection=0)
		REDUCE SELECTION:C351([Item:4]; 0)
	End if 
	KeyWordByAlpha(Table:C252(->[Item:4]); srKeyword)
	
	C_TEXT:C284($typeSaleSel)
	$typeSaleSel:=""
	
	Case of 
		: (ptCurTable=(->[Order:3]))
			$salesTypeSel:=[Order:3]typeSale:22
		: (ptCurTable=(->[Invoice:26]))
			$salesTypeSel:=[Invoice:26]typeSale:49
		: (ptCurTable=(->[Proposal:42]))
			$salesTypeSel:=[Proposal:42]typeSale:20
	End case 
	
	viRecordsInSelection:=Records in selection:C76([Item:4])
	// ### jwm ### 20150526_1306 added $salesTypeSel parameter 3
	List_FillOpts(viRecordsInSelection; vUseBase; $salesTypeSel)
	
	If (eItemPp>0)
		//  CHOPPED  AL_GetScroll(eItemPp; viVert; viHorz)
		//  --  CHOPPED  AL_UpdateArrays(eItemPp; -2)
		// -- AL_SetScroll(eItemPp; viVert; viHorz)
		//OrdSetColor($1)  //pass in the areaList
		QQSetColor(eItemPp; ->aLsItemNum)  //###_jwm_### 20101112
	End if 
End if 