If (aPLineAction{aPLineAction}>-1)  //not really needed for POs/Proposals, needed for Orders/Inv
	aPLineAction{aPLineAction}:=-3000
End if 
Pp_VarRay(True:C214)
Move_RecPvNx(-1; ->aPLineAction)
Pp_VarRay(False:C215)
pGrossMar:=DiscountApply(pUnitPrice; pDiscnt; <>tcDecimalUP)-pUnitCost
pGross:=RT_NotDevideZer(pUnitPrice; pGrossMar)
vBooMarFlag:=True:C214