vMod:=calcProposal(vMod)
vR1:=[Proposal:42]amount:26
vR2:=[Proposal:42]totalCost:23
vR5:=[Proposal:42]exchangeRate:54
v20Str1:=[Proposal:42]currency:55
MarginLineRay(Table:C252(->[Proposal:42]); ->aPItemNum; ->aPDescpt; ->aPQtyOrder; ->aPUnitPrice; ->aPDiscnt; ->aPUnitCost)
MarginShow
MarginLineRayUpdate(->aPUnitPrice; ->aPDiscnt; ->aPUnitCost)
For ($index; 1; Size of array:C274(aPUnitPrice))
	PpLnExtend($index)
End for 
//  --  CHOPPED  AL_UpdateArrays(eItemPp; -2)
//  --  CHOPPED  AL_UpdateArrays(ePropList; -2)