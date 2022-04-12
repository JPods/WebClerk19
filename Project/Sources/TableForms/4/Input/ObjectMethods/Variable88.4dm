// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/09/08, 10:06:18
// ----------------------------------------------------
// Method: Object Method: b83
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283(b83)
CREATE EMPTY SET:C140([PriceMatrix:105]; "Current")
QUERY:C277([PriceMatrix:105]; [PriceMatrix:105]ItemNum:11=[Item:4]itemNum:1)
SetAddTo(->[PriceMatrix:105]; "Current")
$cntRay:=Size of array:C274(aRptPartNum)
If ($cntRay>0)
	C_LONGINT:C283($incRay; $cntRay; $incRec; $cntRec)
	For ($incRay; 1; $cntRay)
		QUERY:C277([PriceMatrix:105]; [PriceMatrix:105]ItemNum:11=aRptPartNum{$incRay})
		SetAddTo(->[PriceMatrix:105]; "Current")
	End for 
End if 
USE SET:C118("Current")
CLEAR SET:C117("Current")
If (Records in selection:C76([PriceMatrix:105])>0)
	ProcessTableOpen(Table:C252(->[PriceMatrix:105]))
Else 
	ALERT:C41("There are no matching PriceMatrix Records.")
End if 