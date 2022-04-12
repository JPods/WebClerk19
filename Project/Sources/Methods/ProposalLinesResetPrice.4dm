//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/19/07, 12:35:39
// ----------------------------------------------------
// Method: Method: ProposalLinesResetPrice
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($tempBase; $i)
C_REAL:C285($price)

If (Size of array:C274(aPPLnSelect)>0)
	$tempBase:=vUseBase
	For ($i; 1; Size of array:C274(aPPLnSelect))
		If (aPPricePt{aPPLnSelect{$i}}#"*")
			
			LN_PricePoint(->pPricePt; ->[Proposal:42]typeSale:20; ->aPItemNum{aPPLnSelect{$i}}; ->[Proposal:42]dateNeeded:4; ->pUnitPrice; ->pDiscnt; ->pQtyOrd; ->vR1; ->vR2; aPPQDIR{aPPLnSelect{$i}})
			aPPricePt{aPPLnSelect{$i}}:=pPricePt
			aPUnitPrice{aPPLnSelect{$i}}:=pUnitPrice
			aPDiscnt{aPPLnSelect{$i}}:=pDiscnt
			// ### bj ### 20181012_1255
			aPRepRate{aPPLnSelect{$i}}:=vR1  // this is hard to read it should show the actual source
			aPSalesRate{aPPLnSelect{$i}}:=vR2
		Else 
			// aPPricePt{aPPLnSelect{$i}}:="*"  // if user has overridden keep their values
			// $price:=$price+aPExtPrice{aPPLnSelect{$i}}
			// aPUnitPrice{aPPLnSelect{$i}}:=0
			// aPDiscnt{aPPLnSelect{$i}}:=0
		End if 
		PpLnExtend(aPPLnSelect{$i})
	End for 
	If (False:C215)  //  (pPricePt="*")  // if user has overridden keep their values
		If (aPQtyOrder{aPPLnSelect{1}}#0)
			aPUnitPrice{aPPLnSelect{1}}:=Round:C94($price/aPQtyOrder{aPPLnSelect{1}}; <>tcDecimalUP)
		Else 
			aPUnitPrice{aPPLnSelect{1}}:=$price
		End if 
		PpLnExtend(aPPLnSelect{1})
	End if 
	If (Size of array:C274(aPPLnSelect)>1)
		Ln_FillVar(aPLineAction; ->aPItemNum; ->aPDescpt; Num:C11(aPUse{aPLineAction}=""); aPQtyOrder{aPLineAction}; 0; aPUnitPrice{aPLineAction}; aPDiscnt{aPLineAction}; aPExtPrice{aPLineAction}; aPPricePt{aPLineAction})
	End if 
	vLineMod:=True:C214
	vR1:=0
	vR2:=0
	vUseBase:=$tempBase
End if 