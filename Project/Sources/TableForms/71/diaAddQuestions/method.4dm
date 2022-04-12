If (Before:C29)
	QA_FillQuestRay(0)
	QQ_ALDefine(eQList)
	//: (During)
	<>aQATypes:=1
	Case of 
		: (ptCurTable=(->[PO:39]))
			viLo3:=[PO:39]taskid:69
		: (ptCurTable=(->[Order:3]))
			viLo3:=[Order:3]taskid:85
		: (ptCurTable=(->[Invoice:26]))
			viLo3:=[Invoice:26]taskid:78
		: (ptCurTable=(->[Proposal:42]))
			viLo3:=[Proposal:42]taskid:70
		Else 
			viLo3:=0
	End case 
End if 