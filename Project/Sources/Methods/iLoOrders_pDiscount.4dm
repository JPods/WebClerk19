//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-14T00:00:00, 12:05:21
// ----------------------------------------------------
// Method: iLoOrders_pDiscount
// Description
// Modified: 08/14/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($i; $k)
$k:=Size of array:C274(aRayLines)
If ($k>0)
	KeyModifierCurrent
	If (OptKey=0)
		For ($i; 1; $k)
			If (aoLineAction{aRayLines{$i}}#-3)  // set line to recalc
				aoLineAction{aRayLines{$i}}:=-3000  // set line to recalc
			End if 
			aODiscnt{aRayLines{$i}}:=pDiscnt
			aOPricePt{aRayLines{$i}}:="*"
			OrdLnExtend(aRayLines{$i})
		End for 
	Else 
		CONFIRM:C162("Decrease(+)/Increase(-) base price by "+String:C10(pDiscnt; "###.0000")+"%.")
		If (OK=1)
			For ($i; 1; $k)
				If (aoLineAction{aRayLines{$i}}#-3)  // set line to recalc
					aoLineAction{aRayLines{$i}}:=-3000  // set line to recalc
				End if 
				aOUnitPrice{aRayLines{$i}}:=DiscountApply(aOUnitPrice{aRayLines{$i}}; pDiscnt; <>tcDecimalUP)
				aODiscnt{aRayLines{$i}}:=0
				aOPricePt{aRayLines{$i}}:="*"
				OrdLnExtend(aRayLines{$i})
			End for 
			pDiscnt:=0
		End if 
	End if 
	pPricePt:="*"
	vLineMod:=True:C214
End if 
