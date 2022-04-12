KeyModifierCurrent
If (optKey=0)
	entryEntity.packedBy:=DE_PopUpArray(Self:C308)
Else 
	jPopUpArray(Self:C308; ->vText1)
	C_LONGINT:C283($i; $k)
	CONFIRM:C162("Set Produced By in selected lines?")
	If (OK=1)
		$k:=Size of array:C274(aRayLines)
		For ($i; 1; $k)
			aiProdBy{aRayLines{$i}}:=vText1
		End for 
	End if 
End if 