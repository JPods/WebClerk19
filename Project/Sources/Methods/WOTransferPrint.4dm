//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-10-04T00:00:00, 16:22:28
// ----------------------------------------------------
// Method: WOTransferPrint
// Description
// Modified: 10/04/13
// 
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1)
If (Count parameters:C259=1)
	QUERY:C277([UserReport:46]; [UserReport:46]Name:2=$1)
Else 
	QUERY:C277([UserReport:46]; [UserReport:46]Name:2="WOTransferLabel")
End if 
If (Records in selection:C76([UserReport:46])=1)
	SRE_Print
	UNLOAD RECORD:C212([UserReport:46])
End if 