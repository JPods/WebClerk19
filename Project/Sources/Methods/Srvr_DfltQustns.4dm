//%attributes = {"publishedWeb":true}
//Procedure: Srvr_DfltQustns
//Noah Dykoski  July 1, 1998 / 2:29 PM
//Add the default questions to the list of questions.
If (<>vbDefaultQA)
	CONFIRM:C162("There are no questions. Add default questions?")
	If (OK=1)
		QUERY:C277([QAQuestion:71]; [QAQuestion:71]defaultT:6=True:C214)
		ORDER BY:C49([QAQuestion:71]; [QAQuestion:71]questionType:2; [QAQuestion:71]sequence:4)
		QA_FillQuestRay(Records in selection:C76([QAQuestion:71]))
		C_LONGINT:C283($soa)
		$soa:=Size of array:C274(aQQuestKey)
		ARRAY LONGINT:C221(aQQLns; $soa)
		For ($index; 1; $soa)
			aQQLns{$index}:=$index
		End for 
		Srv_AddQuestns
	End if 
End if 


If (False:C215)
	ALL RECORDS:C47([QAQuestion:71])
	ORDER BY:C49([QAQuestion:71]; [QAQuestion:71]questionType:2; [QAQuestion:71]sequence:4)
	FIRST RECORD:C50([QAQuestion:71])
	C_TEXT:C284($vtType)
	Repeat 
		$vtType:=[QAQuestion:71]questionType:2
		$incSeq:=0
		While ($vtType=[QAQuestion:71]questionType:2)
			$incSeq:=$incSeq+1
			[QAQuestion:71]sequence:4:=$incSeq
			[QAQuestion:71]photoTag:12:=Substring:C12([QAQuestion:71]questionType:2; 1; 5)+String:C10([QAQuestion:71]sequence:4)
			SAVE RECORD:C53([QAQuestion:71])
			NEXT RECORD:C51([QAQuestion:71])
		End while 
	Until (End selection:C36([QAQuestion:71]))
End if 