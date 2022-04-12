TRACE:C157
If (Size of array:C274(aItemLines)>0)
	If (aItemLines{1}<=Size of array:C274(aXRefRec))
		CONFIRM:C162("Delete X-Ref Record?")
		If (OK=1)
			READ WRITE:C146([ItemXRef:22])
			GOTO RECORD:C242([ItemXRef:22]; aXRefRec{aItemLines{1}})
			DELETE RECORD:C58([ItemXRef:22])
			Ray_DeleteElems(aItemLines{1}; 1; ->aXItemNum; ->aXItemDesc; ->aXVendCode; ->aXLead; ->aXCost; ->aXLocation; ->aXQtyLoc; ->aXRefRec)
			ARRAY LONGINT:C221(aItemLines; 0)
			//  --  CHOPPED  AL_UpdateArrays(eXRefList; -2)
		End if 
	End if 
End if 