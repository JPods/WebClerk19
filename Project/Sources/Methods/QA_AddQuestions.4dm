//%attributes = {"publishedWeb":true}
//Method: QA_AddQuestions($myTable;$acct;$docID;$myTask)
C_TEXT:C284($2)
C_LONGINT:C283($1; $3; $4)
C_LONGINT:C283($index; $rayCnt)

//  CHOPPED QA_FillAnswRay(0)
$rayCnt:=Size of array:C274(aQQLns)
For ($index; 1; $rayCnt)
	$w:=Size of array:C274(aQaAnswrRec)+1
	//  CHOPPED QA_FillAnswRay(-3; $w; 1)
	aQaAcctKey{$w}:=$2
	aQaQuestKey{$w}:=aQQuestKey{aQQLns{$index}}
	aQaAnswKey{$w}:=-3
	If (aQQDays{aQQLns{$index}}>0)
		aQaAnswDt{$w}:=Current date:C33+aQQDays{aQQLns{$index}}
	Else 
		aQaAnswDt{$w}:=!00-00-00!
	End if 
	aQaQuest{$w}:=aQQuest{aQQLns{$index}}
	aQaAnswr{$w}:=""
	aQaGroup{$w}:=viloText21
	If (vilo1=0)
		// aQaGroup{$w}:=aQQGroup{aQQLns{$index}}
	End if 
	
	aQaAnsweredBy{$w}:=""
	
	aQaSeq{$w}:=$w
	aQaAnswrRec{$w}:=-3
	aQaUniqueID{$w}:=-3
	aQaTableNum{$w}:=$1
	aQataskID{$w}:=$4
	aQaDocID{$w}:=$3
End for 
If (Size of array:C274(aQaAcctKey)>0)
	//  CHOPPED QA_FillAnswRay(-5)  //task ID
Else 
	TRACE:C157  //should not do this  
End if 