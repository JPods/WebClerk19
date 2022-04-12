//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: XMLFindInArray
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_TEXT:C284($1)
C_POINTER:C301($2)
C_LONGINT:C283($w; $0)
$0:=-1
$w:=Find in array:C230($2->; $1)
If ($w>0)
	If ($w<=Size of array:C274($2->))
		$0:=$w
	End if 
End if 