C_LONGINT:C283($i)
If (Size of array:C274(aPPLnSelect)>0)
	//KeyModifierCurrent 
	//If (OptKey=0)
	TRACE:C157
	For ($i; 1; Size of array:C274(aPPLnSelect))
		If (aPQtyOrder{aPPLnSelect{$i}}>0)
			If (aPUnitPrice{aPPLnSelect{$i}}<=0)
				If (pExtPrice>0)
					aPUnitPrice{aPPLnSelect{$i}}:=Round:C94(pExtPrice/aPQtyOrder{aPPLnSelect{$i}}; <>tcDecimalUP+3)
					pUnitPrice:=aPUnitPrice{aPPLnSelect{$i}}
				Else 
					aPUnitPrice{aPPLnSelect{$i}}:=1
					pUnitPrice:=1
				End if 
			End if 
			aPExtPrice{aPPLnSelect{$i}}:=pExtPrice
			aPDscntUP{aPPLnSelect{$i}}:=Round:C94(aPExtPrice{aPPLnSelect{$i}}/aPQtyOrder{aPPLnSelect{$i}}; <>tcDecimalUP+3)
			aPDiscnt{aPPLnSelect{$i}}:=(aPUnitPrice{aPPLnSelect{$i}}-aPDscntUP{aPPLnSelect{$i}})/aPUnitPrice{aPPLnSelect{$i}}*100
			aPExtPrice{aPPLnSelect{$i}}:=Round:C94(aPDscntUP{aPPLnSelect{$i}}*aPQtyOrder{aPPLnSelect{$i}}; <>tcDecimalTt)
			PpLnExtend(aPPLnSelect{$i})
		End if 
	End for 
	//Else 
	//CONFIRM("Decrease(+)/Increase(-) base price by "+String(pDiscnt;
	//"###.0000")+"%.")
	//If (OK=1)
	//For ($i;1;Size of array(aPPLnSelect))
	//aiUnitPrice{aPPLnSelect{$i}}:=DiscountApply 
	//(aiUnitPrice{aPPLnSelect{$i}};pDiscnt;<>tcDecimalUP)
	//aPDiscnt{aPPLnSelect{$i}}:=0
	//aPPricePt{aPPLnSelect{$i}}:="*"
	//PpLnExtend (aPPLnSelect{$i})
	//End for 
	//pDiscnt:=0
	//End if 
	//End if 
	pPricePt:="*"
	vLineMod:=True:C214
End if 