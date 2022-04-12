// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/20/12, 16:00:50
// ----------------------------------------------------
// Method: Object Method: bF12
// Description
// 
//
// Parameters
// ----------------------------------------------------

$errorMessage:=""
If (vbNegScan=0)
	WOBarCodeReceive
	WOTransfers_Sort(iLoText2)
	BEEP:C151
	BEEP:C151
	BEEP:C151
Else 
	
End if 
TallyInventory
