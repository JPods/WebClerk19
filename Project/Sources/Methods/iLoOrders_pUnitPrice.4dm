//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-14T00:00:00, 11:52:57
// ----------------------------------------------------
// Method: iLoOrders_pUnitPrice
// Description
// Modified: 08/14/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

If ((Size of array:C274(aOUnitPrice)>0) & (Size of array:C274(aRayLines)>0))
	C_LONGINT:C283($i; $k)
	$k:=Size of array:C274(aRayLines)
	For ($i; 1; $k)
		aOUnitPrice{aRayLines{$i}}:=pUnitPrice
		If (aoLineAction{aRayLines{$i}}#-3)  // set line to recalc
			aoLineAction{aRayLines{$i}}:=-3000  // set line to recalc
			// Modified by: William James (2014-08-14T00:00:00 set line to recalc)
		End if 
		pPricePt:="*"
		aOPricePt{aRayLines{$i}}:="*"
		If (Size of array:C274(aExLnNum)>0)
			Exch_dPriceCost(->[Order:3]exchangeRate:68; ->aOLineNum{aRayLines{$i}})
		End if 
		OrdLnExtend(aRayLines{$i})
	End for 
	vLineMod:=True:C214
End if 