If ([Proposal:42]idNumTask:70=0)
	TaskIDAssign(->[Proposal:42]idNumTask:70)
	acceptPropsl
	C_LONGINT:C283($incRay; $cntRay)
	$cntRay:=Size of array:C274(aQaAnswrRec)
	For ($index; 1; $cntRay)
		GOTO RECORD:C242([QA:70]; aQaAnswrRec{$index})
		[QA:70]idNumTask:12:=[Proposal:42]idNumTask:70
		SAVE RECORD:C53([QA:70])
		aQataskID{$index}:=[Proposal:42]idNumTask:70
	End for 
	If (eAnsListPp>0)
		//  --  CHOPPED  AL_UpdateArrays(eAnsListPp; -2)
	End if 
	// ALERT("Complete")
End if 
