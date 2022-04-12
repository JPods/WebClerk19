//TRACE
C_LONGINT:C283($startState)
//$startState:=viScanByAction
//viScanByAction:=2
//<>pkScaleComment:=""//clear any existing error message
//TRACE

// WHY WAS $startState USED HERE

If (PKNo_ScanPack)
	If (viScanByAction=3)
		If (Size of array:C274(aoLnSelect)>0)
			PKQtyManual  // ### jwm ### 20180312_1036
		Else 
			ALERT:C41("ERROR: No Item Selected to Pack")
		End if 
	Else 
		PKLineIntoBox
	End if 
Else 
	ALERT:C41("Must have PackingManual Privileges.")
End if 
//viScanByAction:=$startState