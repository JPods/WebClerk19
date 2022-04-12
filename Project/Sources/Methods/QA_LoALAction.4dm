//%attributes = {"publishedWeb":true}
//Method: QA_LoALAction
C_LONGINT:C283($error; $curLine)
C_LONGINT:C283($1)
Case of 
	: (ALProEvt=1)  //|(ALProEvt=2))
		If (Size of array:C274(aQaAnswrLns)>0)
			C_LONGINT:C283($curLine)
			$curLine:=aQaAnswrLns{1}
		End if 
		ARRAY LONGINT:C221(aQaAnswrLns; 0)
		//  CHOPPED  $error:=AL_GetSelect($1; aQaAnswrLns)
		
		If (aQaAnswrLns{1}#$curLine)
			QUERY:C277([QAAnswer:72]; [QAAnswer:72]idNumQAQuestion:1=aQaQuestKey{aQaAnswrLns{1}})
			SELECTION TO ARRAY:C260([QAAnswer:72]answer:3; aAnswers)
			UNLOAD RECORD:C212([QAAnswer:72])
			aAnswers:=Num:C11(Size of array:C274(aAnswers)>0)
		End if 
		//  --  CHOPPED  AL_UpdateArrays($1; -2)
		
	: (ALProEvt=2)
		ARRAY LONGINT:C221(aQaAnswrLns; 0)
		//  CHOPPED  $error:=AL_GetSelect($1; aQaAnswrLns)
		//  CHOPPED  AL_GetScroll($1; viVert; viHorz)
		If (aQaAnswrLns{1}#$curLine)
			QUERY:C277([QAAnswer:72]; [QAAnswer:72]idNumQAQuestion:1=aQaQuestKey{aQaAnswrLns{1}})
			SELECTION TO ARRAY:C260([QAAnswer:72]answer:3; aAnswers)
			UNLOAD RECORD:C212([QAAnswer:72])
			aAnswers:=Num:C11(Size of array:C274(aAnswers)>0)
		End if 
		GUI_TextEditDia(->aQaAnswr{aQaAnswrLns{1}}; aQaQuest{aQaAnswrLns{1}})
		If (OK=1)
			GOTO RECORD:C242([QA:70]; aQaAnswrRec{aQaAnswrLns{1}})
			[QA:70]answer:6:=aQaAnswr{aQaAnswrLns{1}}
			SAVE RECORD:C53([QA:70])
			UNLOAD RECORD:C212([QA:70])
			//  --  CHOPPED  AL_UpdateArrays($1; -2)
			// -- AL_SetSelect($1; aQaAnswrLns)
			// -- AL_SetScroll($1; viVert; viHorz)
		End if 
	: (ALProEvt=-5)  //Line has been dragged
		For ($i; 1; Size of array:C274(aQaSeq))
			aQaSeq{$i}:=$i
		End for 
		//|(ALProEvt=-1)) not on sort    
End case 
ALProEvt:=0
// //  --  CHOPPED  AL_UpdateArrays(eAnsListCustomers;-2)
