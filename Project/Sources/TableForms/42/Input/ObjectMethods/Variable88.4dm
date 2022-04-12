C_LONGINT:C283($index; $rayCnt)
$rayCnt:=Size of array:C274(aWoStepLns)
CONFIRM:C162("Do you seriously want to delete these records:  "+String:C10($rayCnt))
If (OK=1)
	//SORT ARRAY(aWoStepLns;<)//start at the largest element
	For ($index; $rayCnt; 1; -1)
		WO_FillArrays(-1; aWoStepLns{$index}; 1)
	End for 
	//  --  CHOPPED  AL_UpdateArrays(eOrdWos; -2)
	vMod:=True:C214
	vbdWos:=True:C214
End if 