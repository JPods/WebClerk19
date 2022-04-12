//%attributes = {"publishedWeb":true}
//Method: Txt_CaseUpper
C_POINTER:C301($1)
C_LONGINT:C283($2)
C_TEXT:C284($0)
$0:=""
If (Count parameters:C259=0)
	ALERT:C41("Pass Pointer to Text.")
Else 
	If (Count parameters:C259>1)
		$0:=Uppercase:C13($1->)
	Else 
		$1->:=Uppercase:C13($1->)
	End if 
End if 