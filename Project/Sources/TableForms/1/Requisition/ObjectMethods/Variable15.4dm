//
C_TEXT:C284($PONum)
If (Size of array:C274(aReqSelLns)>0)
	KeyModifierCurrent
	If (OptKey=0)
		C_LONGINT:C283($i; $k)
		<>ptCurTable:=(->[Requisition:83])
		$k:=Size of array:C274(aRqRecNum)
		If ($k>0)
			CREATE EMPTY SET:C140([Requisition:83]; "Current")
			For ($i; 1; $k)
				If (aRqRecNum{$i}>-1)
					GOTO RECORD:C242([Requisition:83]; aRqRecNum{$i})
					ADD TO SET:C119([Requisition:83]; "Current")
				End if 
			End for 
			UNLOAD RECORD:C212([Requisition:83])  //
			USE SET:C118("Current")
			CLEAR SET:C117("Current")
			DB_ShowCurrentSelection(->[Requisition:83]; ""; 1; "")
		End if 
	Else 
		$PONum:=Request:C163("Enter Group ID to Assign?")
		If (OK=1)
			viReceiptID:=Num:C11($PONum)
			$k:=Size of array:C274(aReqSelLns)
			For ($i; 1; $k)
				aRqGroupID{aReqSelLns{$i}}:=Num:C11($PONum)
				Rq_FillArrays(-4; aReqSelLns{$i}; 1)
				//  --  CHOPPED  AL_UpdateArrays(eActiveReqs; -2)
			End for 
		End if 
	End if 
End if 