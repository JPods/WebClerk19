//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: QA_PostAdd2Record
	//Date: 01/20/04
	//Who: Bill
	//Description: 
End if 
//Method: QA_EnterByType
$theArea:=$1
$myTable:=$2
$acct:=$3
$docID:=$4
$myTask:=$5
C_TEXT:C284($6; $questionType)
If (Count parameters:C259#6)
	ALERT:C41("Must have 6 parameters:"+"\r"+"AreaNum; TableNum, Account; DocID; taskID; QuestionType")
Else 
	C_LONGINT:C283($theType)
	
	QUERY:C277([QAQuestion:71]; [QAQuestion:71]questionType:2=$6)
	vi2:=Records in selection:C76([QAQuestion:71])
	QA_FillQuestRay(vi2)
	ARRAY LONGINT:C221(aQQLns; vi2)
	For (vi1; 1; vi2)
		aQQLns{vi1}:=vi1
	End for 
	MULTI SORT ARRAY:C718(aQQGroup; >; aQQCol; >; aQQuest; aQQuestKey; aQQDays; aQQRec)
	viLo2:=0
	If ($theArea>0)
		viLo2:=Size of array:C274(aQaAcctKey)
	End if 
	
	QA_LoAddQA($1; $2; $3; $4; $5; viLo2)
	
End if 