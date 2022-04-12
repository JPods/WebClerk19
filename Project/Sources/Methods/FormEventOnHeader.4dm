//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/09/06, 22:39:47
// ----------------------------------------------------
// Method: FormEventOnHeader
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (vHere=0)
	If (False:C215)
		TCNavigationChange005
	End if 
	jsetInHeader(Current form table:C627)
	OLO_HereAndMenu
End if 