//%attributes = {}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 06/23/20, 03:19:04
// ----------------------------------------------------
// Method: FormSizeRestore
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283(viFormLeft; viFormTop; viFormRight; viFormBottom)  // ;viFormWinRef)

If ((viFormLeft#0) & (viFormTop#0) & (viFormRight#0) & (viFormBottom#0))
	SET WINDOW RECT:C444(viFormLeft; viFormTop; viFormRight; viFormBottom)  // ;viFormWinRef) current window
End if 