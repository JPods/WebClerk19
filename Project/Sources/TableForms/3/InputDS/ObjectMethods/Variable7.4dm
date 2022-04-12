vMod:=calcOrder(True:C214)
vR1:=[Order:3]amount:24
vR2:=[Order:3]totalCost:42
vR5:=[Order:3]exchangeRate:68
v20Str1:=[Order:3]currency:69
MarginLineRay(Table:C252(->[Order:3]); ->aOItemNum; ->aODescpt; ->aOQtyOrder; ->aOUnitPrice; ->aODiscnt; ->aOUnitCost)
MarginShow
MarginLineRayUpdate(->aOUnitPrice; ->aODiscnt; ->aOUnitCost)
For ($index; 1; Size of array:C274(aOUnitPrice))
	OrdLnExtend($index)
End for 
//  --  CHOPPED  AL_UpdateArrays(eItemOrd; -2)
//  --  CHOPPED  AL_UpdateArrays(eOrdList; -2)