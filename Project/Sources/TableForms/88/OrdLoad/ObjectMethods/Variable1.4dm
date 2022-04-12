C_LONGINT:C283($i; $k)
$k:=Size of array:C274(aLiLoadItemSelect)
If ($k>0)
	For ($i; 1; $k)
		aLiTagGroup{aLiLoadItemSelect{$i}}:=vi5
	End for 
	//  CHOPPED  AL_GetScroll(eLoadList; viVert; viHorz)
	//  --  CHOPPED  AL_UpdateArrays(eLoadList; -2)
	viVert:=aLiLoadItemSelect{1}
	// -- AL_SetSelect(eLoadList; aLiLoadItemSelect)
	// -- AL_SetScroll(eLoadList; viVert; viHorz)
	vi5:=vi5+1
End if 