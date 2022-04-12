//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method:  Method: SetAddTo
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//
C_POINTER:C301($1)
C_TEXT:C284($2)
C_LONGINT:C283($i; $k)
$k:=Records in selection:C76($1->)
If ($k>0)
	FIRST RECORD:C50($1->)
	For ($i; 1; $k)
		ADD TO SET:C119($1->; $2)
		NEXT RECORD:C51($1->)
	End for 
End if 
