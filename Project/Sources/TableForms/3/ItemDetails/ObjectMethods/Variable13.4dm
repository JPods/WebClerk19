If (ptCurTable=(->[Order:3]))
	OR_VarRay(True:C214)
Else 
	IV_VarRay(True:C214)
End if 
Move_RecPvNx(-1; ptLineRec)
If (ptCurTable=(->[Order:3]))
	OR_VarRay(False:C215)
Else 
	IV_VarRay(False:C215)
End if 
pGrossMar:=DiscountApply(pUnitPrice; pDiscnt; <>tcDecimalUP)-pUnitCost
pGross:=RT_NotDevideZer(pUnitPrice; pGrossMar)
vBooMarFlag:=True:C214