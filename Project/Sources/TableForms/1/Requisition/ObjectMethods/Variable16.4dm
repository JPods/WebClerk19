C_LONGINT:C283($i; $k)
C_TEXT:C284($PONum)
If (Size of array:C274(aReqSelLns)>0)
	KeyModifierCurrent
	If (OptKey=0)
		<>ptCurTable:=(->[PO:39])
		$k:=Size of array:C274(aRqRecNum)
		If ($k>0)
			CREATE EMPTY SET:C140([PO:39]; "Current")
			For ($i; 1; $k)
				If (aRqRecNum{$i}>-1)
					If (aRqPONum{$i}>0)
						QUERY:C277([PO:39]; [PO:39]idNum:5=aRqPONum{$i})
						ADD TO SET:C119([PO:39]; "Current")
					End if 
				End if 
			End for 
			UNLOAD RECORD:C212([PO:39])
			USE SET:C118("Current")
			CLEAR SET:C117("Current")
			DB_ShowCurrentSelection(->[PO:39]; ""; 1; "")
		End if 
	Else 
		TRACE:C157
		$PONum:=Request:C163("Enter PO Number to Assign?")
		If (OK=1)
			$k:=Size of array:C274(aReqSelLns)
			For ($i; 1; $k)
				aRqPONum{aReqSelLns{$i}}:=Num:C11($PONum)
				Rq_FillArrays(-4; aReqSelLns{$i}; 1)
				//  --  CHOPPED  AL_UpdateArrays(eActiveReqs; -2)
			End for 
		End if 
	End if 
End if 