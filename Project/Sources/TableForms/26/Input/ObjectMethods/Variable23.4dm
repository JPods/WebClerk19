vMod:=calcInvoice(True:C214)
vR1:=[Invoice:26]amount:14
vR2:=[Invoice:26]totalCost:37
vR5:=[Invoice:26]exchangeRate:61
v20Str1:=[Invoice:26]currency:62
MarginLineRay(Table:C252(->[Invoice:26]); ->aiItemNum; ->aiDescpt; ->aiQtyOrder; ->aiUnitPrice; ->aiDiscnt; ->aiUnitCost)
MarginShow
MarginLineRayUpdate(->aiUnitPrice; ->aiDiscnt; ->aiUnitCost)
For ($index; 1; Size of array:C274(aiUnitPrice))
	IvcLnExtend($index)
End for 
//  --  CHOPPED  AL_UpdateArrays(eItemInv; -2)
//  --  CHOPPED  AL_UpdateArrays(eIvcList; -2)