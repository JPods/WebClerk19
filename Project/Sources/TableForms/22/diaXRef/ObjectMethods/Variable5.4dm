If ((vMod) & (Size of array:C274(aItemLines)>0))
	CONFIRM:C162("Save changes to X-Ref?")
	If (OK=1)
		READ WRITE:C146([ItemXRef:22])
		GOTO RECORD:C242([ItemXRef:22]; aXRefRec{aItemLines{1}})
		XRef_Var2Rec
		SAVE RECORD:C53([ItemXRef:22])
		READ ONLY:C145([ItemXRef:22])
		vMod:=False:C215
	End if 
End if 
ACCEPT:C269
myOK:=1