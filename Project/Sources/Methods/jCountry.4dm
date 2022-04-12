//%attributes = {"publishedWeb":true}
C_TEXT:C284($1; $2; $0)
If (($2=$1) | ($2=""))
	$0:="\r"
Else 
	$0:="\r"+$2+"\r"
End if 