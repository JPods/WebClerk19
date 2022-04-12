//%attributes = {"publishedWeb":true}
C_BOOLEAN:C305($1; $0)
C_TEXT:C284($2)
If ($1)
	CONFIRM:C162($2)
	$0:=(OK=1)
Else 
	$0:=True:C214
End if 