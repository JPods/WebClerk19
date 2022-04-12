//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 09/18/18, 16:48:35
// ----------------------------------------------------
// Method: InvoiceLinesResettaxID
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($i)

If (Size of array:C274(aRayLines)>0)
	For ($i; 1; Size of array:C274(aRayLines))
		aiTaxable{aRayLines{$i}}:=[Invoice:26]taxJuris:33
	End for 
End if 