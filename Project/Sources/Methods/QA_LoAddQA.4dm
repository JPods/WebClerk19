//%attributes = {"publishedWeb":true}
//Method: QA_LoAddQA
C_TEXT:C284($acct; $3)  //Acct
C_LONGINT:C283($2; $4; $myTable; $myTask; $docID; $5)  //TableNum;taskID
C_LONGINT:C283($1; $theArea)

<>vbAlwaystaskID:=True:C214

$theArea:=$1
$myTable:=$2
$acct:=$3
$docID:=$4
$myTask:=$5  // not used replaced by viLo3 in the Layout
// ### bj ### 20200129_1933
Case of 
	: ((ptCurTable=(->[Order:3])) & ([Order:3]idNumTask:85=0))
		TaskIDAssign(->[Order:3]idNumTask:85)
		$myTask:=[Order:3]idNumTask:85  //$5
	: ((ptCurTable=(->[Proposal:42])) & ([Proposal:42]idNumTask:70=0))
		TaskIDAssign(->[Proposal:42]idNumTask:70)
		$myTask:=[Proposal:42]idNumTask:70  //$5
	: ((ptCurTable=(->[Invoice:26])) & ([Invoice:26]idNumTask:78=0))
		TaskIDAssign(->[Invoice:26]idNumTask:78)
		$myTask:=[Invoice:26]idNumTask:78  //$5
	: ((ptCurTable=(->[PO:39])) & ([PO:39]idNumTask:69=0))
		TaskIDAssign(->[PO:39]idNumTask:69)
		$myTask:=[PO:39]idNumTask:69  //$5
End case 
myOK:=0
jCenterWindow(576; 429; -724; "QA")
DIALOG:C40([QAQuestion:71]; "diaAddQuestions")
CLOSE WINDOW:C154
C_LONGINT:C283($i; $sizeRay)
If ((myOK>0) & (Size of array:C274(aQQLns)>0))
	myOK:=0
	viLo2:=0
	If ($theArea>0)
		viLo2:=Size of array:C274(aQaAcctKey)
	End if 
	$myTask:=viLo3  //from in the layout
	QA_AddQuestions($myTable; $acct; $docID; $myTask)
	//  CHOPPED QA_LoOnEntry($theArea; $myTable; $acct; $docID; $myTask; viLo2)
	If ($myTask#0)
		Case of 
			: (ptCurTable=(->[PO:39]))
				If ([PO:39]idNumTask:69#$myTask)
					[PO:39]idNumTask:69:=$myTask
					SAVE RECORD:C53(ptCurTable->)
				End if 
			: (ptCurTable=(->[Order:3]))
				If ([Order:3]idNumTask:85#$myTask)
					[Order:3]idNumTask:85:=$myTask
					SAVE RECORD:C53(ptCurTable->)
				End if 
			: (ptCurTable=(->[Invoice:26]))
				If ([Invoice:26]idNumTask:78#$myTask)
					[Invoice:26]idNumTask:78:=$myTask
					SAVE RECORD:C53(ptCurTable->)
				End if 
			: (ptCurTable=(->[Proposal:42]))
				If ([Proposal:42]idNumTask:70#$myTask)
					[Proposal:42]idNumTask:70:=$myTask
					SAVE RECORD:C53(ptCurTable->)
				End if 
		End case 
	End if 
End if 
UNLOAD RECORD:C212([QAQuestion:71])
QA_FillQuestRay(0)
viLo3:=0