//%attributes = {"publishedWeb":true}
//Method: PM:  MarginLineRay
//Noah Dykoski   October 2, 2000 / 8:53 PM
C_LONGINT:C283($1; $TableNum)
$TableNum:=$1
C_POINTER:C301($2; $aptrItemNum)
$aptrItemNum:=$2
C_POINTER:C301($3; $aptrDescription)
$aptrDescription:=$3
C_POINTER:C301($4; $aptrQty)
$aptrQty:=$4
C_POINTER:C301($5; $aptrUnitPrice)
$aptrUnitPrice:=$5
C_POINTER:C301($6; $aptrDiscount)
$aptrDiscount:=$6
C_POINTER:C301($7; $aptrUnitCost)
$aptrUnitCost:=$7

C_LONGINT:C283($k; $i)
$k:=Size of array:C274($aptrItemNum->)
vi1:=$TableNum
ARRAY TEXT:C222(aPartNum; $k)
ARRAY TEXT:C222(aPartDesc; $k)
ARRAY REAL:C219(aPartQty; $k)  //qty sold
ARRAY REAL:C219(aQtyOnHand; $k)  //Price
ARRAY REAL:C219(aCosts; $k)  //cost
ARRAY REAL:C219(aQtyOrd; $k)  //margin

ARRAY LONGINT:C221(aItemLines; 0)  //currently selected lines  
For ($i; 1; $k)
	aPartNum{$i}:=$aptrItemNum->{$i}  //aOItemNum//[Orderline]ItemNum
	aPartDesc{$i}:=$aptrDescription->{$i}  //aODescpt//[Orderline]Description
	aPartQty{$i}:=$aptrQty->{$i}  //aOQtyOrder//[Orderline]QtyOrdered
	//aQtyOnHand{$i}:=DiscountApply ([Orderline]UnitPrice;[Orders
	//]LineItems'Discount;UPPRECIS)
	aQtyOnHand{$i}:=DiscountApply($aptrUnitPrice->{$i}; $aptrDiscount->{$i})  //;<>tcDecimalUP)
	aCosts{$i}:=$aptrUnitCost->{$i}  //aOUnitCost//[Orderline]UnitCost
	aQtyOrd{$i}:=Margin4Price(aQtyOnHand{$i}; aCosts{$i})
End for 
Margin_SumSelectedLines(->vR1; ->vR2; ->vR3; ->vR4)