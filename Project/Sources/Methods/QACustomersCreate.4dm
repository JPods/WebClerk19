//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/07/20, 07:16:20
// ----------------------------------------------------
// Method: QACustomersCreate
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $vtQuestionType)
$vtQuestionType:=$1
QUERY:C277([QAQuestion:71]; [QAQuestion:71]questionType:2=$vtQuestionType)
QA_FillQuestRay(Records in selection:C76([QAQuestion:71]))

$k:=Size of array:C274(aQQuestKey)
If ($k>0)
	C_LONGINT:C283($i; $k)
	
	ARRAY LONGINT:C221(aQQLns; $k)
	For ($i; 1; $k)
		aQQLns{$i}:=$i
	End for 
	myOK:=2
	CANCEL:C270
End if 

QA_AddQuestions($myTable; $acct; $docID; $myTask)

C_LONGINT:C283($i; $k; $dtCreated; $vlGroupID)
$k:=Size of array:C274(aQaAnswrRec)
$dtCreated:=DateTime_Enter
If (Size of array:C274(aQaAcctKey)>0)
	$max_i:=ds:C1482.QA.query("customerID = :1"; aQaAcctKey{1}).max("idGroup")+1
End if 

For ($i; 1; $k)
	If ((aQaAnswDt{$i}=!00-00-00!) & (aQaAnswr{$i}#""))
		aQaAnswDt{$i}:=Current date:C33
	End if 
	CREATE RECORD:C68([QA:70])
	// ### bj ### 20191222_2154
	// needed so different sets of questions can be distinquished from each other
	[QA:70]dtCreated:16:=$dtCreated
	[QA:70]idGroup:8:=$max_i  // create a uniqueBatchID, 
	[QA:70]customerID:1:=aQaAcctKey{$i}
	[QA:70]idNum:13:=aQaQuestKey{$i}
	[QA:70]idNumQAAnswer:3:=aQaAnswKey{$i}
	[QA:70]dateOfAnswer:4:=aQaAnswDt{$i}
	[QA:70]askedBy:7:=aQaAskedBy{$i}
	[QA:70]question:5:=aQaQuest{$i}
	[QA:70]answer:6:=aQaAnswr{$i}
	[QA:70]seq:10:=aQaSeq{$i}
	[QA:70]idNumTask:12:=aQataskID{$i}
	[QA:70]tableNum:11:=aQaTableNum{$i}
	[QA:70]relatedLongid:14:=aQaDocID{$i}
	SAVE RECORD:C53([QA:70])
End for 