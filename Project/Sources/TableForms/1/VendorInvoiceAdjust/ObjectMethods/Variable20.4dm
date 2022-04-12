C_LONGINT:C283($i)
If (Size of array:C274(aPoLnSelct)>0)
	For ($i; 1; Size of array:C274(aPoLnSelct))
		aPoDiscnt{aPoLnSelct{$i}}:=pDiscnt
		PoLnExtend(aPoLnSelct{$i})
	End for 
	vLineMod:=True:C214
	vMod:=True:C214
End if 

C_LONGINT:C283($i)
If (Size of array:C274(aPoLnSelct)>0)
	KeyModifierCurrent
	If (OptKey=0)
		For ($i; 1; Size of array:C274(aPoLnSelct))
			aPoDiscnt{aPoLnSelct{$i}}:=pDiscnt
			PoLnExtend(aPoLnSelct{$i})
		End for 
	Else 
		CONFIRM:C162("Decrease(+)/Increase(-) base cost by "+String:C10(pDiscnt; "###.0000")+"%.")
		If (OK=1)
			For ($i; 1; Size of array:C274(aPoLnSelct))
				aPoUnitCost{aPoLnSelct{$i}}:=DiscountApply(aPoUnitCost{aPoLnSelct{$i}}; pDiscnt; <>tcDecimalUC)
				aPoDiscnt{aPoLnSelct{$i}}:=0
				PoLnExtend(aPoLnSelct{$i})
			End for 
			pDiscnt:=0
		End if 
	End if 
	pPricePt:="*"
	vLineMod:=True:C214
	vMod:=True:C214
End if 