C_LONGINT:C283($i; $k; $p; $1; $2)
If (Size of array:C274(aItemLines)>0)
	If (aItemLines{1}<=Size of array:C274(aLsItemNum))
		If ((aLsDocType{aItemLines{1}}="") | (aLsDocType{aItemLines{1}}="s@") | (aLsDocType{aItemLines{1}}="@b@"))
			vPartNum:=aLsItemNum{aItemLines{1}}
			cmdKey:=1
			List_Inships(eQuickQuote; ->vPartNum)
		Else 
			BEEP:C151
		End if 
	Else 
		BEEP:C151
	End if 
Else 
	BEEP:C151
End if 