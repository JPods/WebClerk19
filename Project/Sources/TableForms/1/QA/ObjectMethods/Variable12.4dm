If (<>aQATypes>1)
	QUERY:C277([QAQuestion:71]; [QAQuestion:71]questionType:2=<>aQaTypes{<>aQaTypes})
	QA_FillQuestRay(Records in selection:C76([QAQuestion:71]))
	//  --  CHOPPED  AL_UpdateArrays(eQList; -2)
Else 
	<>aQaTypes:=1
End if 