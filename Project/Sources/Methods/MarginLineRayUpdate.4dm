//%attributes = {"publishedWeb":true}
//Method: MarginLineRayUpdate
//Noah Dykoski 20001001
C_POINTER:C301($1; $aptrUnitPrice)
$aptrUnitPrice:=$1
C_POINTER:C301($2; $aptrDiscount)
$aptrDiscount:=$2
C_POINTER:C301($3; $aptrUnitCost)
$aptrUnitCost:=$3

If (myOK=1)  //user accepted layout
	//put any cost and price mods back in real arrays.
	C_LONGINT:C283($k; $i)
	C_POINTER:C301($1; $2; $3)
	$k:=Size of array:C274($1->)
	For ($i; 1; $k)
		$aptrUnitPrice->{$i}:=aQtyOnHand{$i}/(1-($aptrDiscount->{$i}*0.01))  //Modified Unit Price / orginal discount factor
		//$aptrUnitCost->{$i}:=aCosts{$i}//aOUnitCost//[Orders
		//]LineItems'UnitCost
	End for 
	ARRAY TEXT:C222(aPartNum; $k)
	ARRAY TEXT:C222(aPartDesc; $k)
	ARRAY REAL:C219(aPartQty; $k)  //qty sold
	ARRAY REAL:C219(aQtyOnHand; $k)  //Price
	ARRAY REAL:C219(aCosts; $k)  //cost
	ARRAY REAL:C219(aQtyOrd; $k)  //margin  
	vLineMod:=True:C214
End if 