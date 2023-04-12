C_LONGINT:C283($error; $i; $k; $clickRecord)
Case of 
	: ((ALProEvt=1) | (ALProEvt=2))
		KeyModifierCurrent
		If (optKey=1)
			ARRAY LONGINT:C221(aTmpInt1; 0)
			//  CHOPPED  $error:=AL_GetSelect(eTimeList; aTmpInt1)
			$k:=Size of array:C274(aWoStepLns)
			If (($k>0) & (Size of array:C274(aTmpInt1)>0))
				For ($i; 1; $k)
					$clickResult:=aWoStepLns{$i}
					GOTO RECORD:C242([WorkOrder:66]; aWoRecNum{$clickResult})
					aWoTimeNd{$clickResult}:=aTimeSlotBegb{aTmpInt1{1}}
					[WorkOrder:66]dtAction:5:=DateTime_DTTo(aWoDateNd{$clickResult}; aWoTimeNd{$clickResult})
					SAVE RECORD:C53([WorkOrder:66])
				End for 
				//  CHOPPED  AL_GetScroll(eWorkFlow; viVert; viHorz)  //Orders
				//  --  CHOPPED  AL_UpdateArrays(eWorkFlow; -2)
				// -- AL_SetScroll(eWorkFlow; viVert; viHorz)
				// -- AL_SetSelect(eWorkFlow; aWoStepLns)
			End if 
		End if 
		//: ((ALProEvt=-5)|(ALProEvt=-1))//Line has been dragged        
End case 