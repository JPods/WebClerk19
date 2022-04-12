KeyModifierCurrent
If (OptKey=0)
	Disc_AddItems
	
	
	//  --  CHOPPED  AL_UpdateArrays(eItemDis; -2)
	
	SORT ARRAY:C229(aSdSelectLn)
	viVert:=aSdSelectLn{1}
	// -- AL_SetScroll(eItemDis; viVert; viHorz)
	// -- AL_SetSelect(eItemDis; aSdSelectLn)
	
	
Else 
	QQ_Push(->aSdItemNum; ->aSdSelectLn)
End if 

