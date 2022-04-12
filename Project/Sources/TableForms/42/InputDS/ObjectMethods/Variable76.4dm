KeyModifierCurrent
C_LONGINT:C283($index; $rayCnt; $1)
If ((OptKey=0) & (CmdKey=0))
	CONFIRM:C162("Relate selected line to the taskID")
	If (OK=1)
		If ([Proposal:42]idNumTask:70=0)
			TaskIDAssign(->[Proposal:42]idNumTask:70)
			SAVE RECORD:C53([Proposal:42])
		End if 
		$rayCnt:=Size of array:C274(aQaAnswrLns)
		For ($index; 1; $rayCnt)
			GOTO RECORD:C242([QA:70]; aQaAnswrRec{aQaAnswrLns{$index}})
			[QA:70]idNumTask:12:=[Proposal:42]idNumTask:70
		End for 
		ALERT:C41("Complete")
	End if 
Else 
	CONFIRM:C162("Relate selected line to the taskID")
	If (OK=1)
		$rayCnt:=Size of array:C274(aQaAnswrLns)
		For ($index; 1; $rayCnt)
			GOTO RECORD:C242([QA:70]; aQaAnswrRec{aQaAnswrLns{$index}})
			[QA:70]idNumTask:12:=0
		End for 
		ALERT:C41("Complete")
	End if 
End if 