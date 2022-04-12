//%attributes = {"publishedWeb":true}
//Method: QA_Group2Array(GroupNum;->Array)
C_LONGINT:C283($i; $k; $grpNum; $w)
$grpNum:=$1

$k:=Size of array:C274(aQaSeq)
ARRAY TEXT:C222($2->; 3)
ARRAY DATE:C224($aQaAnswDt; 0)
ARRAY TEXT:C222($aQaQuest; 0)
ARRAY TEXT:C222($aQaAnswr; 0)
ARRAY TEXT:C222($aQaAnsweredBy; 0)
ARRAY LONGINT:C221($aQaSeq; 0)
For ($i; 1; $k)
	If (aQaGroup{$i}=$grpNum)
		INSERT IN ARRAY:C227($aQaAnswDt; 1)
		INSERT IN ARRAY:C227($aQaQuest; 1)
		INSERT IN ARRAY:C227($aQaAnswr; 1)
		INSERT IN ARRAY:C227($aQaAnsweredBy; 1)
		INSERT IN ARRAY:C227($aQaSeq; 1)
		$aQaAnswDt{1}:=aQaAnswDt{$i}
		$aQaQuest{1}:=aQaQuest{$i}
		$aQaAnswr{1}:=aQaAnswr{$i}
		$aQaAnsweredBy{1}:=""
		$aQaSeq{1}:=aQaSeq{$i}
	End if 
End for 
$k:=Size of array:C274($aQaSeq)
$2->{1}:=""
$2->{2}:=""
$2->{3}:=""
If ($k>0)
	SORT ARRAY:C229($aQaSeq; $aQaAnsweredBy; $aQaAnswr; $aQaQuest; $aQaAnswDt)
	For ($i; 1; $k)
		$2->{1}:=$2->{1}+$aQaQuest{$i}+": "+$aQaAnswr{$i}+"\r"
		$2->{2}:=$2->{2}+$aQaQuest{$i}+"\r"
		$2->{3}:=$2->{3}+$aQaAnswr{$i}+"\r"
	End for 
End if 