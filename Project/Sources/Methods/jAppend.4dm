//%attributes = {"publishedWeb":true}
C_POINTER:C301($1)  //Ptr to Orginal String
C_TEXT:C284($2)  //Lead String
C_POINTER:C301($3)  //Ptr to Append String
C_TEXT:C284($4)  //Trail String
If ($3->#"")
	If (Count parameters:C259=4)
		$1->:=$1->+$2+$3->+$4
	Else 
		$1->:=$1->+$2+$3->
	End if 
End if 