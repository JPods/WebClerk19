//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-04-04T00:00:00, 15:21:50
// ----------------------------------------------------
// Method: Util_CleanOrders
// Description
// Modified: 04/04/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_BOOLEAN:C305($doChange)
$doChange:=UserInPassWordGroup("ConvertData")
If ($doChange)
	CONFIRM:C162("Clear out the selected Orders?")
	If (OK=1)
		vi2:=Records in selection:C76([Order:3])
		For (vi1; 1; vi2)
			vMod:=True:C214
			OrdLnFillRays
			vi4:=Size of array:C274(aoLineAction)
			For (vi3; 1; vi4)
				If (aOQtyBL{vi3}#0)
					aOLnCmplt{vi3}:="x"
					OrdLnExtend(vi3)
				End if 
			End for 
			booAccept:=True:C214
			acceptOrders
			NEXT RECORD:C51([Order:3])
		End for 
		UNLOAD RECORD:C212([Order:3])
		UNLOAD RECORD:C212([Customer:2])
		UNLOAD RECORD:C212([OrderLine:49])
	End if 
End if 