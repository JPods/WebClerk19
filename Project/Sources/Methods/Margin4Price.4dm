//%attributes = {"publishedWeb":true}
//Method: PM:  Margin4Price
//Noah Dykoski   October 6, 2000 / 4:34 PM
C_REAL:C285($0)  //Margin Percent
C_REAL:C285($1; $rTotalPrice)
$rTotalPrice:=$1
C_REAL:C285($2; $rTotalCost)
$rTotalCost:=$2

If ($rTotalPrice#0)
	$0:=Round:C94(($rTotalPrice-$rTotalCost)/$rTotalPrice*100; <>tcDecimalUP)
Else 
	$0:=0
End if 