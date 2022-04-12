//%attributes = {"publishedWeb":true}
//Procedure: Srv_AddQuestns
//Noah Dykoski  July 1, 1998 / 2:34 PM

C_TEXT:C284($acct)
vilo1:=vilo1+1
$doAdd:=False:C215
If (Size of array:C274(aQQLns)>0)
	Case of 
		: ((aServiceTableName{aSrvLines{1}}="S") & ([Customer:2]customerID:1#""))
			$doAdd:=True:C214
			$acct:=[Service:6]customerID:1
			$tableNum:=Table:C252(->[Service:6])
			SAVE RECORD:C53([Customer:2])
		: (aServiceTableName{aSrvLines{1}}="C")
			$doAdd:=True:C214
			$acct:=[Customer:2]customerID:1
			$tableNum:=2
			[Customer:2]questionAns:83:=True:C214
			SAVE RECORD:C53([Customer:2])
		: (aServiceTableName{aSrvLines{1}}="L")
			$doAdd:=True:C214
			$acct:=String:C10([Lead:48]idNum:32)
			$tableNum:=48
			[Lead:48]questionAns:43:=True:C214
			SAVE RECORD:C53([Lead:48])
		: (aServiceTableName{aSrvLines{1}}="i")
			$doAdd:=True:C214
			$acct:=String:C10([Contact:13]idNum:28)
			$tableNum:=13
			[Contact:13]questionAns:40:=True:C214
			SAVE RECORD:C53([Contact:13])
	End case 
End if 
If ($doAdd)
	//QA_LoAddQA (eAnsListService;Table(->[Service]);[Service]customerID;[Service]UniqueID;[Service]taskID)
	QA_AddQuestions($tableNum; $acct; 0; 0)
	//  --  CHOPPED  AL_UpdateArrays(eAList; -2)
Else 
	BEEP:C151
End if 