//%attributes = {"publishedWeb":true}
//Method: QA_Answer2Form //string;group
//TRACE
C_LONGINT:C283($w; $2; $groupID)
C_TEXT:C284($0; $1; $theQuestion)
If (Count parameters:C259>0)
	$theQuestion:=$1
	$groupID:=0
	If (Count parameters:C259>1)
		$groupID:=$2
	End if 
	$startPoint:=1
	$endEffort:=False:C215
	Repeat 
		$w:=Find in array:C230(aQaQuest; $theQuestion; $startPoint)
		If ($w<1)
			$endEffort:=True:C214
		Else 
			If ((aQaGroup{$w}=$groupID) | ($groupID=0))
				$0:=aQaAnswr{$w}
				$endEffort:=True:C214
			Else 
				$startPoint:=$w+1
			End if 
		End if 
	Until ($endEffort)
Else 
	$0:="No Parameters"
End if 