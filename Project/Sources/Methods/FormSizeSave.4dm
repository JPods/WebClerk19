//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 12/11/18, 13:03:32
// ----------------------------------------------------
// Method: FormSaveSize
// Description
// 
//  general procedure
// Parameters
// ----------------------------------------------------

C_LONGINT:C283(viFormBottom; viFormLeft; viFormRight; viFormTop; viFormWinRef)

viFormWinRef:=Current form window:C827

GET WINDOW RECT:C443(viFormLeft; viFormTop; viFormRight; viFormBottom; viFormWinRef)

