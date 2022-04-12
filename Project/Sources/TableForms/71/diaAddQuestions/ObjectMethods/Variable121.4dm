If (viLo3=0)
	Case of 
		: (ptCurTable=(->[PO:39]))
			viLo3:=[PO:39]idNumTask:69
		: (ptCurTable=(->[Order:3]))
			viLo3:=[Order:3]idNumTask:85
		: (ptCurTable=(->[Invoice:26]))
			viLo3:=[Invoice:26]idNumTask:78
		: (ptCurTable=(->[Proposal:42]))
			viLo3:=[Proposal:42]idNumTask:70
	End case 
	If (viLo3=0)
		TaskIDAssign(->viLo3; "byVariable")
	End if 
Else 
	ALERT:C41("taskID already assigned to this document")
End if 