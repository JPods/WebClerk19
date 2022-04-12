//%attributes = {"publishedWeb":true}
C_TEXT:C284($1; $0)
C_POINTER:C301($2; $3)
C_LONGINT:C283($w)
$w:=Find in array:C230(<>aTerms; $1)
If ($w#-1)
	$0:=<>aTermDesc{$w}
Else 
	$0:=$1
End if 