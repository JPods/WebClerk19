//%attributes = {"publishedWeb":true}
//function LF_Strip
If (False:C215)
	//Date: 03/14/02
	//Who: Peter Fleming, Arkware
	//Description: Function to strip LF
	VERSION_960
End if 
C_TEXT:C284($0; $1)
$0:=Replace string:C233($1; Char:C90(10); "")