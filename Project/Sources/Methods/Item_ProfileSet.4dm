//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $2; $3)  //File, sourceFld, destinFld; adders
//$5 - exact, begin @find, end  find@, contains @find@
C_TEXT:C284($4; $5)  //find value; insert value
If (Field:C253($1; $2)->=$4)
	Field:C253($1; $3)->:=$5
End if 