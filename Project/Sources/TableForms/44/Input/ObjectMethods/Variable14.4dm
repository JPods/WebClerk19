C_LONGINT:C283($k; $i)
$k:=Size of array:C274(aSdItemNum)
For ($i; 1; $k)
	QUERY:C277([Item:4]; [Item:4]itemNum:1=aSdItemNum{$i})
	aSdDescript{$i}:=[Item:4]description:7
	aSdCost{$i}:=[Item:4]costAverage:13
	vi1:=$i
	MarginCalc(->aSdDisPrice{vi1}; ->aSdCost{vi1}; ->pGrossMar; ->aSdMargin{vi1})
End for 
//  --  CHOPPED  AL_UpdateArrays(eItemDis; -2)