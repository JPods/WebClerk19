Case of 
	: (Before:C29)
		C_LONGINT:C283(vilo1)
		vilo1:=0
		QA_FillQuestRay(0)
		QQ_ALDefine(eQList)
		If (<>ptCurTable=(->[Customer:2]))
			READ ONLY:C145([Customer:2])
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=<>CustAcct)
			QUERY:C277([QA:70]; [QA:70]customerID:1=[Customer:2]customerID:1; *)
			QUERY:C277([QA:70];  & [QA:70]tableNum:11=2)
			v1:=[Customer:2]company:2
			v2:=[Customer:2]nameFirst:73
			v3:=[Customer:2]nameLast:23
			srAcct:=[Customer:2]customerID:1
		End if 
		//  CHOPPED QA_FillAnswRay(Records in selection([QA]))
		QA_ALDefine(eAList)
		ARRAY LONGINT:C221(aQaAnswrLns; 0)
		ARRAY TEXT:C222(aAnswers; 0)
		C_LONGINT:C283($i; $k; $w)
		For ($i; 1; $k)
			If (aQaGroup{$i}>vilo1)
				vilo1:=aQaGroup{$i}
			End if 
		End for 
		vilo1:=vilo1+1
		
	: (Outside call:C328)
		Prs_OutsideCall
		
	Else 
		
		Case of 
			: (doSearch=2)  //new answer   
				C_LONGINT:C283($i)
				GOTO SELECTED RECORD:C245([QAAnswer:72]; aAnswers)
				//For ($i;1;Size of array(aQaAnswrLns))
				If ((aAnswers>0) & (Size of array:C274(aQaAnswrLns)>0))
					KeyModifierCurrent
					aQaAnswKey{aQaAnswrLns{1}}:=[QAAnswer:72]idNum:2
					aQaAnswDt{aQaAnswrLns{1}}:=Current date:C33
					aQaAnswr{aQaAnswrLns{1}}:=(aQaAnswr{aQaAnswrLns{1}}*Num:C11(OptKey=1))+[QAAnswer:72]answer:3
					aQaAskedBy{aQaAnswrLns{1}}:=Current user:C182
					GOTO RECORD:C242([QA:70]; aQaAnswrRec{aQaAnswrLns{1}})
					[QA:70]askedBy:7:=Current user:C182
					[QA:70]dateOfAnswer:4:=Current date:C33
					[QA:70]answer:6:=aQaAnswr{aQaAnswrLns{1}}
					[QA:70]idNumQAAnswer:3:=aQaAnswKey{aQaAnswrLns{1}}
					SAVE RECORD:C53([QA:70])
					Case of 
						: (<>ptCurTable=(->[Customer:2]))
							[Customer:2]questionAns:83:=True:C214
							SAVE RECORD:C53([Customer:2])
							
					End case 
				End if 
				//  --  CHOPPED  AL_UpdateArrays(eAList; -2)
				//End for 
			: (doSearch>0)
				//  --  CHOPPED  AL_UpdateArrays(eAList; -2)
				doSearch:=0
				
			: ((doSearch=-3) & (Size of array:C274(aQQLns)>0) & (<>ptCurTable=(->[Customer:2])))
				TRACE:C157
				zFindMe:=1
				QA_AddQuestions
				//  CHOPPED QA_FillAnswRay(-5; 1; 1; Table(<>ptCurTable))
				//  --  CHOPPED  AL_UpdateArrays(eAList; -2)
		End case 
		doSearch:=0
End case 