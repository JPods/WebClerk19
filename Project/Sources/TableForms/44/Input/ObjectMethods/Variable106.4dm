C_LONGINT:C283($k; $i)
C_REAL:C285(pDscntPrice)
$k:=Size of array:C274(aSdSelectLn)
For ($i; 1; $k)
	aSdDisPrice{aSdSelectLn{$i}}:=pDscntPrice
	aSdMargin{aSdSelectLn{$i}}:=Margin4Price(aSdDisPrice{aSdSelectLn{$i}}; aSdCost{aSdSelectLn{$i}})
	aSdDiscPC{aSdSelectLn{$i}}:=MarginDiscountPerCent(aSdBase{aSdSelectLn{$i}}; aSdDisPrice{aSdSelectLn{$i}})
End for 
//  --  CHOPPED  AL_UpdateArrays(eItemDis; -2)