KeyModifierCurrent
C_LONGINT:C283($index; $rayCnt; $1)
If ((OptKey=0) & (CmdKey=0))
	CONFIRM:C162("Relate selected line to the taskID")
	If (OK=1)
		If ([Order:3]idNumTask:85=0)
			TaskIDAssign(->[Order:3]idNumTask:85)
			SAVE RECORD:C53([Order:3])
		End if 
		$rayCnt:=Size of array:C274(aQaAnswrLns)
		For ($index; 1; $rayCnt)
			GOTO RECORD:C242([QA:70]; aQaAnswrRec{aQaAnswrLns{$index}})
			[QA:70]idNumTask:12:=[Order:3]idNumTask:85
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