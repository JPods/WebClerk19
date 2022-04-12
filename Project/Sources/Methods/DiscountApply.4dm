//%attributes = {"publishedWeb":true}
//Method: DiscountApply  (price;discount;precision)
C_REAL:C285($1; $price; $2; $discount; $0)  //returns the discounted price/cost
$price:=$1
$discount:=$2
If (Count parameters:C259>=3)
	C_LONGINT:C283($3; $precision)  //price, discount, precision
	$precision:=$3
	$0:=Round:C94($price*(1-($discount*0.01)); $precision)
Else 
	$0:=$price*(1-($discount*0.01))
End if 