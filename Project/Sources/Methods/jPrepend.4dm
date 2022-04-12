//%attributes = {"publishedWeb":true}
C_TEXT:C284($1)  //Lead String
C_POINTER:C301($2)  //Ptr to Prepend String
C_TEXT:C284($3)  //Trail String
C_POINTER:C301($4)  //Ptr to Orginal String
If ($3#"")
	$4->:=$1+$2->+$3+$4->
End if 