//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)
C_POINTER:C301($2)
If ($1=1)
	$2->:=$2->+1
Else 
	$2->:=$2->-1
End if 
Move_SetPvNxBut($2)