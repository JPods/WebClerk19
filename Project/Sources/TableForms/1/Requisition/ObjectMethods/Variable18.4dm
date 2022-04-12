C_LONGINT:C283($i; $k)
C_TEXT:C284($PPNum)
If (Size of array:C274(aReqSelLns)>0)
	KeyModifierCurrent
	If (OptKey=0)
		<>ptCurTable:=(->[Proposal:42])
		$k:=Size of array:C274(aRqPpNum)
		If ($k>0)
			CREATE EMPTY SET:C140([Order:3]; "Current")
			For ($i; 1; $k)
				If (aRqRecNum{$i}>-1)
					If (aRqPpNum{$i}>0)
						QUERY:C277([Proposal:42]; [Proposal:42]idNum:5=aRqPpNum{$i})
						ADD TO SET:C119([Proposal:42]; "Current")
					End if 
				End if 
			End for 
			UNLOAD RECORD:C212([Proposal:42])  //
			USE SET:C118("Current")
			CLEAR SET:C117("Current")
			DB_ShowCurrentSelection(->[Proposal:42]; ""; 1; "")
		End if 
	Else 
		$PPNum:=Request:C163("Enter Order Number to Assign?")
		If (OK=1)
			$k:=Size of array:C274(aReqSelLns)
			For ($i; 1; $k)
				aRqPpNum{aReqSelLns{$i}}:=Num:C11($PPNum)
				Rq_FillArrays(-4; aReqSelLns{$i}; 1)
				//  --  CHOPPED  AL_UpdateArrays(eActiveReqs; -2)
			End for 
		End if 
	End if 
End if 