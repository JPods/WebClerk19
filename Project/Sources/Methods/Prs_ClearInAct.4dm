//%attributes = {"publishedWeb":true}
//Procedure: Prs_ClearInAct
C_LONGINT:C283($1; $MinTimeOut)  //how long (Minutes) to allow a process to be inactive before clearing it
$MinTimeOut:=$1

C_LONGINT:C283($index)
C_LONGINT:C283($dtTimeOut)

$dtTimeOut:=DateTime_Enter-($MinTimeOut*60)
For ($index; 1; Size of array:C274(<>aPrsDTActiv))
	If (<>aPrsDTActiv{$index}<$dtTimeOut)
		<>vbInActive:=True:C214
		POST OUTSIDE CALL:C329(<>aPrsNum{$index})
	End if 
End for 