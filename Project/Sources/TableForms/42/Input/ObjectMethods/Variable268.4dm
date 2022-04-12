C_LONGINT:C283($error; $i; $sizeSelect)
Case of 
	: (ALProEvt=1)
		ARRAY LONGINT:C221(aWoStepLns; 0)
		//  CHOPPED  $error:=AL_GetSelect(ePPWos; aWoStepLns)  //aWoStepLns
		C_REAL:C285($total)
		$sizeSelect:=Size of array:C274(aWoStepLns)
		$total:=0
		For ($i; 1; $sizeSelect)
			$total:=$total+(aWoRate{aWoStepLns{$i}}*aWoDurationPlan{aWoStepLns{$i}})
		End for 
		vOrdWOs:=Round:C94($total; <>tcDecimalUP)
	: (ALProEvt=2)
		//TRACE
		ARRAY LONGINT:C221(aWoStepLns; 0)
		//  CHOPPED  $error:=AL_GetSelect(ePPWos; aWoStepLns)
		vOrdWOs:=Round:C94(aWoRate{aWoStepLns{1}}*aWoDurationPlan{aWoStepLns{1}}; <>tcDecimalUP)
		If (aWoRecNum{aWoStepLns{1}}>-1)
			//  CHOPPED  AL_GetScroll(ePPWos; viVert; viHorz)
			READ WRITE:C146([WorkOrder:66])
			GOTO RECORD:C242([WorkOrder:66]; aWoRecNum{aWoStepLns{1}})
			WO_FillArrays(-4; aWoStepLns{1})
			SAVE RECORD:C53([WorkOrder:66])
			aWoRecNum:=aWoStepLns{1}
			ProcessTableOpen(Table:C252(->[WorkOrder:66])*-1)
			READ ONLY:C145([WorkOrder:66])
			If (False:C215)
				If (Record number:C243([WorkOrder:66])=aWoRecNum{aWoStepLns{1}})
					WO_FillArrays(-6; aWoStepLns{1})
				Else 
					QUERY:C277([WorkOrder:66]; [WorkOrder:66]idNumTask:22=[Order:3]idNumTask:85)
					WO_FillArrays(Records in selection:C76([WorkOrder:66]))
				End if 
				UNLOAD RECORD:C212([WorkOrder:66])
				//  --  CHOPPED  AL_UpdateArrays(ePPWos; -2)  //eItemOrd
				// -- AL_SetSelect(ePPWos; aWoStepLns)
				// -- AL_SetScroll(ePPWos; viVert; viHorz)
				ALProEvt:=0
			End if 
		Else 
			BEEP:C151
			BEEP:C151
		End if 
	: (ALProEvt=-5)  //Line has been dragged
		C_TEXT:C284($codeSeq)
		$codeSeq:=""
		C_TEXT:C284($codeStat)
		C_LONGINT:C283($days)
		TRACE:C157
		$days:=0
		$sizeSelect:=Size of array:C274(aWoSeq)
		For ($i; 1; $sizeSelect)
			aWoSeq{$i}:=$i
			aWoTimeNd{$i}:=aWoTimeNd{($i-1)}+(aWoDurationPlan{$i}*3600)
			If (aWoTimeNd{$i}>86400)
				aWoTimeNd{$i}:=aWoTimeNd{$i}-86400  //24:00:00
				$days:=$days+1
			End if 
			aWoDateNd{$i}:=aWoDateNd{$i}+$days
			If (Length:C16(aWoActivity{$i})>1)  // Modified by: williamjames (111216 checked for <= length protection)
				$codeSeq:=$codeSeq+$codeStat+aWoActivity{$i}[[1]]+aWoActivity{$i}[[2]]+$codeStat+(", "*Num:C11($i#$sizeSelect))
			End if 
		End for 
		READ WRITE:C146([WorkOrder:66])
		TRACE:C157
		For ($i; 1; Size of array:C274(aWoSeq))
			aWoCodeSeq{$i}:=$codeSeq
			GOTO RECORD:C242([WorkOrder:66]; aWoRecNum{$i})
			WO_FillArrays(-4; $i)
			SAVE RECORD:C53([WorkOrder:66])
		End for 
		UNLOAD RECORD:C212([WorkOrder:66])
		READ ONLY:C145([WorkOrder:66])
		//  --  CHOPPED  AL_UpdateArrays(ePPWos; -2)
		vbdWos:=True:C214
		[Order:3]idNum:2:=[Order:3]idNum:2
End case 
ALProEvt:=0