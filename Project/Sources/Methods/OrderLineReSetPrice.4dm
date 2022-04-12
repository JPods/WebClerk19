//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/19/07, 12:21:13
// ----------------------------------------------------
// Method: Method: OrderLineReSetPrice
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($tempBase; $i)
C_REAL:C285($price)


If (Size of array:C274(aRayLines)>0)
	
	
	
	$tempBase:=vUseBase
	$price:=0
	For ($i; 1; Size of array:C274(aRayLines))
		pPartNum:=aOItemNum{aRayLines{$i}}
		If (aoLineAction{aRayLines{$i}}#-3)  // set line to recalc
			aoLineAction{aRayLines{$i}}:=-3000  // set line to recalc
			// Modified by: William James (2014-08-14T00:00:00 set line to recalc)
		End if 
		
		If (aOPricePt{aRayLines{$i}}#"*")
			LN_PricePoint(->pPricePt; ->[Order:3]typeSale:22; ->pPartNum; ->[Order:3]dateOrdered:4; ->pUnitPrice; ->pDiscnt; ->pQtyOrd; ->vR1; ->vR2; aOPQDIR{aRayLines{$i}})
			aOPricePt{aRayLines{$i}}:=pPricePt
			aOUnitPrice{aRayLines{$i}}:=pUnitPrice
			aODiscnt{aRayLines{$i}}:=pDiscnt
			// ### bj ### 20181012_1255
			aORepRate{aRayLines{$i}}:=vR1  // this is hard to read it should show the actual source
			aOSalesRate{aRayLines{$i}}:=vR2
		Else 
			// aOPricePt{aRayLines{$i}}:="*"
			// $price:=$price+aOExtPrice{aRayLines{$i}}
			// aOUnitPrice{aRayLines{$i}}:=0
			// aODiscnt{aRayLines{$i}}:=0
		End if 
		OrdLnExtend(aRayLines{$i})
	End for 
	If (False:C215)  // (pPricePt="*")   lea
		If (aOQtyOrder{aRayLines{1}}#0)
			aOUnitPrice{aRayLines{1}}:=Round:C94($price/aOQtyOrder{aRayLines{1}}; <>tcDecimalUP)
		Else 
			aOUnitPrice{aRayLines{1}}:=$price
		End if 
		OrdLnExtend(aRayLines{1})
	End if 
	If (Size of array:C274(aRayLines)>1)
		Ln_FillVar(aoLineAction; ->aOItemNum; ->aODescpt; 0; aOQtyOrder{aoLineAction}; aOQtyBL{aoLineAction}; aOUnitPrice{aoLineAction}; aODiscnt{aoLineAction}; aOExtPrice{aoLineAction}; aOPricePt{aoLineAction})
	End if 
	vLineMod:=True:C214
	vR1:=0
	vR2:=0
	vUseBase:=$tempBase
End if 