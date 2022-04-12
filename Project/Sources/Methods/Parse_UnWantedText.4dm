//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Parse_UnWantedText
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_TEXT:C284($1; $0)
theText:=$1
theText:=Parse_UnWanted(theText)
$0:=theText
theText:=""