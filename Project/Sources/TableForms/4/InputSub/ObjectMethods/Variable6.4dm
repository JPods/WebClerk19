C_LONGINT:C283($cntRay)
$cntRay:=Size of array:C274(aPMtrxUniqueID)+1
PriceMatrix_FillArrays(-3; $cntRay; 1)
aPMtrxItemNum{$cntRay}:=[Item:4]itemNum:1
If ($cntRay>1)
	aPMtrxQtyMin{$cntRay}:=aPMtrxQtyMax{$cntRay-1}+1
	aPMtrxCost{$cntRay}:=aPMtrxCost{$cntRay-1}
	aPMtrxPrice{$cntRay}:=aPMtrxPrice{$cntRay-1}
Else 
	aPMtrxQtyMin{$cntRay}:=1
	aPMtrxCost{$cntRay}:=[Item:4]costLastInShip:47
	aPMtrxPrice{$cntRay}:=3
End if 
aPMtrxQtyMax{$cntRay}:=1000000
aPMtrxRecordNum{$cntRay}:=-3
PriceMatrix_FillArrays(-15; $cntRay; 1)
//PriceMatrix_FillArrays (-7)