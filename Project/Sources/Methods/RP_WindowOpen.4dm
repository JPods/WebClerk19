//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/07/11, 01:20:56
// ----------------------------------------------------
// Method: Method: RP_WindowOpen
// Description
// 
//
// Parameters
// ----------------------------------------------------
Process_InitLocal
jCenter4DWindow(953; 612; 8; "Record Passing"; "CancelCommand")
DIALOG:C40([Control:1]; "RP_Editor")
CLOSE WINDOW:C154
POST OUTSIDE CALL:C329(<>theProcessList)