// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/18/11, 16:45:23
// ----------------------------------------------------
// Method: Object Method: b1
// Description
// 
//
// Parameters
// ----------------------------------------------------
CONFIRM:C162("Apply Territory, RepID and salesNameID in zip code ranges?")
If (OK=1)
	C_LONGINT:C283($i; $k; $lockedCount)
	FIRST RECORD:C50([Territory:25])
	$k:=Records in selection:C76([Territory:25])
	For ($i; 1; $k)
		TerritoryApplyByZip
	End for 
	UNLOAD RECORD:C212([Territory:25])
End if 