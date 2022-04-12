C_LONGINT:C283($error; $i; $sizeSelect)
Case of 
	: (ALProEvt=1)
		ARRAY LONGINT:C221(aReqsLns; 0)
		//  CHOPPED  $error:=AL_GetSelect(eReqs; aReqsLns)
	: (ALProEvt=2)
		ARRAY LONGINT:C221(aReqsLns; 0)
		//  CHOPPED  $error:=AL_GetSelect(eReqs; aReqsLns)
		If (Size of array:C274(aReqsLns)>0)
			//  CHOPPED  AL_GetScroll(eReqs; viVert; viHorz)  //Orders      
			$clickResult:=aReqsLns{1}
			//GOTO RECORD([Requistion];aReqsRecNum{$clickResult})
			//LOAD RECORD([Requistion])
			//If (Locked([Requistion]))
			//ALERT("This Req is locked by another user.")
			//Else 
			//MODIFY RECORD([Requistion])
			//If (Record number([Requistion])=aReqsRecNum{$clickResult})
			////check to see if changed orders
			//Reqs_FillArrays (-6;$clickResult)
			////  --  CHOPPED  AL_UpdateArrays (eReqs;-2)
			//// -- AL_SetScroll (eReqs;viVert;viHorz)
			//// -- AL_SetSelect (eReqs;aReqsLns)
			//End if 
			//End if 
			//End if 
		End if 
		
		
		//: ((ALProEvt=-5)|(ALProEvt=-1))//Line has been dragged        
End case 
ALProEvt:=0

