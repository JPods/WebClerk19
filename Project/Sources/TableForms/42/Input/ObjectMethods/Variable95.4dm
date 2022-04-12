//C_REAL($allDscnt)
//C_Longint($i)
//If (Size of array(aPPLnSelect)>0)
//For ($i;1;Size of array(aPPLnSelect))
//aPDiscnt{aPPLnSelect{$i}}:=pDiscnt
//aPPricePt{aPPLnSelect{$i}}:="*"
//PpLnExtend (aPPLnSelect{$i})
//End for 
//pPricePt:="*"
//vLineMod:=True
//End if 

C_LONGINT:C283($i)
If (Size of array:C274(aPPLnSelect)>0)
	KeyModifierCurrent
	If (OptKey=0)
		For ($i; 1; Size of array:C274(aPPLnSelect))
			aPDiscnt{aPPLnSelect{$i}}:=pDiscnt
			aPPricePt{aPPLnSelect{$i}}:="*"
			PpLnExtend(aPPLnSelect{$i})
		End for 
	Else 
		CONFIRM:C162("Decrease(+)/Increase(-) base price by "+String:C10(pDiscnt; "###.0000")+"%.")
		If (OK=1)
			For ($i; 1; Size of array:C274(aPPLnSelect))
				aiUnitPrice{aPPLnSelect{$i}}:=DiscountApply(aiUnitPrice{aPPLnSelect{$i}}; pDiscnt; <>tcDecimalUP)
				aPDiscnt{aPPLnSelect{$i}}:=0
				aPPricePt{aPPLnSelect{$i}}:="*"
				PpLnExtend(aPPLnSelect{$i})
			End for 
			pDiscnt:=0
		End if 
	End if 
	pPricePt:="*"
	vLineMod:=True:C214
End if 