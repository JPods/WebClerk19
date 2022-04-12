//%attributes = {"publishedWeb":true}
//Method: MarginDiscountPerCent  (pUnitPrice;pDscntPrice)
C_REAL:C285($0; $1; $2)
If ($1#0)
	$0:=($1-$2)/$1*100
Else 
	$0:=0
End if 