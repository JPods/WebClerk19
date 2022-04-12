//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $2; $0)
If ($2>0)
	$0:=($1\$2)+(Num:C11((($1%$2)>0)))
End if 