//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/09/06, 20:51:11
// ----------------------------------------------------
// Method: FormEventCloseDetail
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	CANCEL:C270  // put here to use as an escape from layout
End if 
FormSizeRestore
UNLOAD RECORD:C212(ptCurTable->)
OLO_HereAndMenu

