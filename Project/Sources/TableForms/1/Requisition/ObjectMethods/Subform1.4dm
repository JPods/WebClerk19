C_LONGINT:C283($error; $i; $sizeSelect)
Case of 
	: (ALProEvt=1)
		ARRAY LONGINT:C221(aReqSelLns; 0)
		//  CHOPPED  $error:=AL_GetSelect(eActiveReqs; aReqSelLns)
		
	: (ALProEvt=2)
		ARRAY LONGINT:C221(aReqSelLns; 0)
		//  CHOPPED  $error:=AL_GetSelect(eActiveReqs; aReqSelLns)
		If (Size of array:C274(aReqSelLns)>0)
			//  CHOPPED  AL_GetScroll(eActiveReqs; viVert; viHorz)  //Orders      
			If (aRqRecNum{aReqSelLns{1}}=-3)
				Rq_FillArrays(-4; aReqSelLns{1})
				//  --  CHOPPED  AL_UpdateArrays(eActiveReqs; -2)
			End if 
			GOTO RECORD:C242([Requisition:83]; aRqRecNum{aReqSelLns{1}})
			LOAD RECORD:C52([Requisition:83])
			If (Locked:C147([Requisition:83]))
				MESSAGE:C88("This Req is locked by another user.")
			End if 
			//MODIFY RECORD([Requisition])
			ProcessTableOpen(Table:C252(->[Requisition:83])*-1)
			If (Record number:C243([Requisition:83])=aRqRecNum{aReqSelLns{1}})  //check to see if changed orders
				Rq_FillArrays(-6; aReqSelLns{1})
				//  --  CHOPPED  AL_UpdateArrays(eActiveReqs; -2)
				// -- AL_SetScroll(eActiveReqs; viVert; viHorz)
				// -- AL_SetSelect(eActiveReqs; aReqSelLns)
			End if 
		End if 
		//: ((ALProEvt=-5)|(ALProEvt=-1))//Line has been dragged        
End case 
ALProEvt:=0