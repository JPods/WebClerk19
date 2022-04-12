//%attributes = {"publishedWeb":true}
C_LONGINT:C283($w)
$w:=Find in array:C230(<>aCostCause; aTCCause{aTCSelLns{1}})
If ($w=-1)
	<>aCostCause:=0
Else 
	<>aCostCause:=$w
End if 
$w:=Find in array:C230(<>aActivities; aTCActivity{aTCSelLns{1}})
If ($w=-1)
	<>aActivities:=0
Else 
	<>aActivities:=$w
End if 
$w:=Find in array:C230(<>aNameID; aTCNameID{aTCSelLns{1}})
If ($w=-1)
	<>aNameID:=0
Else 
	<>aNameID:=$w
End if 