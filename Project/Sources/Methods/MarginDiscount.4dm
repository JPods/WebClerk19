//%attributes = {"publishedWeb":true}
//Method: MarginDiscount
C_REAL:C285($0; $1; $2)  //aSdDiscPC{$row}:=(aSdDisPrice{$row}/aSdBase{$row})
If ($2#0)
	$0:=Round:C94(1-($1/$2); 8)*100
Else 
	$0:=0
End if 