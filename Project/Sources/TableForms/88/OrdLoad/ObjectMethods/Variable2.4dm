$k:=Size of array:C274(aLiLoadItemSelect)
If ($k>0)
	C_LONGINT:C283($i; $k)
	C_REAL:C285($wtTotal; $cntTotal; $wtAvg)
	For ($i; 1; $k)
		$cntTotal:=$cntTotal+aLiQty{aLiLoadItemSelect{$i}}
	End for 
	$wtAvg:=Round:C94(vR5/$cntTotal; 2)
	For ($i; 1; $k)
		aLiUnitWt{aLiLoadItemSelect{$i}}:=$wtAvg
	End for 
	//  CHOPPED  AL_GetScroll(eLoadList; viVert; viHorz)
	//  --  CHOPPED  AL_UpdateArrays(eLoadList; -2)
	viVert:=aLiLoadItemSelect{1}
	// -- AL_SetSelect(eLoadList; aLiLoadItemSelect)
	// -- AL_SetScroll(eLoadList; viVert; viHorz)
Else 
	BEEP:C151
	BEEP:C151
End if 