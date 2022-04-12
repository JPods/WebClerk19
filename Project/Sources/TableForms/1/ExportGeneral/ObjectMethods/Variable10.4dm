
KeyModifierCurrent
If (OptKey=1)
	jArchExportRay
	ARRAY LONGINT:C221(aFieldLns; 1)
	aFieldLns{1}:=1
	viVert:=1
	viHorz:=1
	//  --  CHOPPED  AL_UpdateArrays(eMatchList; -2)
	// -- AL_SetSelect(eExportFlds; aFieldLns)
	// -- AL_SetScroll(eExportFlds; viVert; viHorz)
Else 
	MatchAdd(False:C215; Size of array:C274(aMatchType))
End if 