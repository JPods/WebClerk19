C_LONGINT:C283($i; $k)
C_TEXT:C284($OrdNum)
If (Size of array:C274(aReqSelLns)>0)
	KeyModifierCurrent
	If (OptKey=0)
		<>ptCurTable:=(->[Order:3])
		$k:=Size of array:C274(aRqOrdNum)
		If ($k>0)
			CREATE EMPTY SET:C140([Order:3]; "Current")
			For ($i; 1; $k)
				If (aRqRecNum{$i}>-1)
					If (aRqOrdNum{$i}>0)
						QUERY:C277([Order:3]; [Order:3]idNum:2=aRqOrdNum{$i})
						ADD TO SET:C119([Order:3]; "Current")
					End if 
				End if 
			End for 
			UNLOAD RECORD:C212([Order:3])  //
			USE SET:C118("Current")
			CLEAR SET:C117("Current")
			DB_ShowCurrentSelection(->[Order:3]; ""; 1; "")
		End if 
	Else 
		$OrdNum:=Request:C163("Enter Order Number to Assign?")
		If (OK=1)
			$k:=Size of array:C274(aReqSelLns)
			For ($i; 1; $k)
				aRqOrdNum{aReqSelLns{$i}}:=Num:C11($OrdNum)
				Rq_FillArrays(-4; aReqSelLns{$i}; 1)
				//  --  CHOPPED  AL_UpdateArrays(eActiveReqs; -2)
			End for 
		End if 
	End if 
End if 