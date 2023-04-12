//%attributes = {"publishedWeb":true}
//Method: QA_LoPostAnswers

C_LONGINT:C283($1)
If ((aAnswers>0) & (Size of array:C274(aQaAnswrLns)>0))
	C_LONGINT:C283($i)
	KeyModifierCurrent
	//TRACE
	GOTO SELECTED RECORD:C245([QAAnswer:72]; aAnswers)
	iLoQAText1:=[QAAnswer:72]answer:3
	
	aQaAnswKey{aQaAnswrLns{1}}:=[QAAnswer:72]idNum:2
	aQaAnswDt{aQaAnswrLns{1}}:=Current date:C33
	aQaAskedBy{aQaAnswrLns{1}}:=Current user:C182
	If (OptKey=0)
		aQaAnswr{aQaAnswrLns{1}}:=[QAAnswer:72]answer:3
	Else 
		aQaAnswr{aQaAnswrLns{1}}:=aQaAnswr{aQaAnswrLns{1}}+"; "+[QAAnswer:72]answer:3
	End if 
	If (aQaAnswrRec{aQaAnswrLns{1}}>-1)
		GOTO RECORD:C242([QA:70]; aQaAnswrRec{aQaAnswrLns{1}})
		// [QACust]customerID:=aQaAcctKey{aQaAnswrLns{1}}
		[QA:70]answer:6:=aQaAnswr{aQaAnswrLns{1}}
		[QA:70]idNumQAAnswer:3:=aQaAnswKey{aQaAnswrLns{1}}
		[QA:70]dateOfAnswer:4:=Current date:C33
		[QA:70]seq:10:=aQaSeq{aQaAnswrLns{1}}
		Case of 
			: (ptCurTable=(->[Customer:2]))
				[QA:70]customerID:1:=[Customer:2]customerID:1
				[QA:70]tableNum:11:=2
			: (ptCurTable=(->[Contact:13]))
				[QA:70]customerID:1:=String:C10([Contact:13]idNum:28)
				[QA:70]tableNum:11:=Table:C252(->[Contact:13])
		End case 
		SAVE RECORD:C53([QA:70])
		UNLOAD RECORD:C212([QAAnswer:72])
		UNLOAD RECORD:C212([QA:70])
	End if 
	//  --  CHOPPED  AL_UpdateArrays($1; -2)
	// -- AL_SetSelect($1; aQaAnswrLns)
End if 
