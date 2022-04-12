//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 03/05/20, 23:17:51
// ----------------------------------------------------
// Method: CloneQA
// Description
// 
//Run in [QAQuestion] Output Layout
// Parameters
// ----------------------------------------------------
// This is important
// need to add a cleanup for ophaned Answers
CONFIRM:C162("Clone Selected QA?")
If (OK=1)
	vText1:=Request:C163("Enter New QuestionType"; "Job-Setup")
	If (vText1#"")
		
		CREATE EMPTY SET:C140([QAQuestion:71]; "Current")
		SELECTION TO ARRAY:C260([QAQuestion:71]; aLongInt11)
		vi2:=Size of array:C274(aLongInt11)
		UNLOAD RECORD:C212([QAQuestion:71])
		For (vi1; 1; vi2)
			GOTO RECORD:C242([QAQuestion:71]; aLongInt11{vi1})
			vi11:=[QAQuestion:71]idUnique:1
			DUPLICATE RECORD:C225([QAQuestion:71])
			[QAQuestion:71]questionType:2:=vText1
			SAVE RECORD:C53([QAQuestion:71])
			ADD TO SET:C119([QAQuestion:71]; "Current")
			// 
			QUERY:C277([QaAnswer:72]; [QaAnswer:72]questionKey:1=vi11)
			SELECTION TO ARRAY:C260([QaAnswer:72]; aLongInt12)
			vi4:=Size of array:C274(aLongInt12)
			For (vi3; 1; vi4)
				GOTO RECORD:C242([QaAnswer:72]; aLongInt12{vi3})
				DUPLICATE RECORD:C225([QaAnswer:72])
				[QaAnswer:72]questionKey:1:=[QAQuestion:71]idUnique:1
				SAVE RECORD:C53([QaAnswer:72])
			End for 
		End for 
		USE SET:C118("Current")
		CLEAR SET:C117("Current")
	End if 
End if 
