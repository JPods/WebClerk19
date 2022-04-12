//%attributes = {"publishedWeb":true}
//Method: Txt_CaseLower
C_POINTER:C301($1)
C_TEXT:C284($0)
$0:=""
If (Count parameters:C259=0)
	ALERT:C41("Pass Pointer to Text.")
Else 
	If (Count parameters:C259>1)
		$0:=Lowercase:C14($1->)
	Else 
		$1->:=Lowercase:C14($1->)
	End if 
End if 