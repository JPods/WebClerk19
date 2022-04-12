C_LONGINT:C283($k; $i)
$k:=Size of array:C274(aSdSelectLn)
For ($i; 1; $k)
	aSdMargin{aSdSelectLn{$i}}:=pGross
	aSdDisPrice{aSdSelectLn{$i}}:=Margin2Price(pGross; aSdCost{aSdSelectLn{$i}})
	aSdDiscPC{aSdSelectLn{$i}}:=MarginDiscountPerCent(aSdBase{aSdSelectLn{$i}}; aSdDisPrice{aSdSelectLn{$i}})
End for 
//  --  CHOPPED  AL_UpdateArrays(eItemDis; -2)