//%attributes = {"publishedWeb":true}
//Method: Txt_UpToDelimiter
C_TEXT:C284($1; $0)
C_TEXT:C284($2)
C_LONGINT:C283($p)
$p:=Position:C15($2; $1)
If ($p>0)
	$0:=Substring:C12($1; 1; $p-1)
Else 
	$0:=$1
End if 