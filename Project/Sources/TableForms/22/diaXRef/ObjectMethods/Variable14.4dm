C_LONGINT:C283($error)
Case of 
	: (ALProEvt=0)
	: (ALProEvt=1)
		//  CHOPPED  AL_GetScroll(eXRefList; viVert; viHorz)
		If ((vMod) & (Size of array:C274(aItemLines)>0))
			READ WRITE:C146([ItemXRef:22])
			GOTO RECORD:C242([ItemXRef:22]; aXRefRec{aItemLines{1}})
			XRef_Var2Rec
			SAVE RECORD:C53([ItemXRef:22])
			READ ONLY:C145([ItemXRef:22])
			vMod:=False:C215
		End if 
		ARRAY LONGINT:C221(aItemLines; 0)
		//  CHOPPED  $error:=AL_GetSelect(eXRefList; aItemLines)
		GOTO RECORD:C242([ItemXRef:22]; aXRefRec{aItemLines{1}})
		XRef_Rec2Var
	: (ALProEvt=2)
		If ((vMod) & (Size of array:C274(aItemLines)>0))
			READ WRITE:C146([ItemXRef:22])
			GOTO RECORD:C242([ItemXRef:22]; aXRefRec{aItemLines{1}})
			XRef_Var2Rec
			SAVE RECORD:C53([ItemXRef:22])
			READ ONLY:C145([ItemXRef:22])
			vMod:=False:C215
		End if 
		//  CHOPPED  $error:=AL_GetSelect(eXRefList; aItemLines)
		aXRefRec:=aItemLines{1}
		myOK:=1
		GOTO RECORD:C242([ItemXRef:22]; aXRefRec{aItemLines{1}})
		ProcessTableOpen(Table:C252(->[ItemXRef:22])*-1)
	: (ALProEvt=-1)
	: (ALProEvt=-2)
End case 
ALProEvt:=0