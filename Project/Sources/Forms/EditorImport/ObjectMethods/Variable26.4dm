C_TEXT:C284(vSearchBy)
C_TEXT:C284(vSearchBy2)
KeyModifierCurrent
If (OptKey=0)
	If (Size of array:C274(aFieldLns)>0)
		vSearchBy:=theFields{aFieldLns{1}}
	Else 
		vSearchBy:=""
	End if 
Else 
	If (Size of array:C274(aFieldLns)>0)
		vSearchBy2:=theFields{aFieldLns{1}}
	Else 
		vSearchBy2:=""
	End if 
End if 