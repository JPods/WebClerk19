C_LONGINT:C283($k; $i)
$k:=Size of array:C274(aSdSelectLn)
For ($i; 1; $k)
	aSdDiscPC{aSdSelectLn{$i}}:=pDiscnt
	aSdDisPrice{aSdSelectLn{$i}}:=DiscountApply(aSdBase{aSdSelectLn{$i}}; aSdDiscPC{aSdSelectLn{$i}}; <>tcDecimalUP)
	aSdMargin{aSdSelectLn{$i}}:=Margin4Price(aSdDisPrice{aSdSelectLn{$i}}; aSdCost{aSdSelectLn{$i}})
End for 
//  --  CHOPPED  AL_UpdateArrays(eItemDis; -2)