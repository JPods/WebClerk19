//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/09/12, 18:31:36
// ----------------------------------------------------
// Method: WOTransfer_WindowOpen
// Description
// 
//
// Parameters
// ----------------------------------------------------



Process_InitLocal
jCenter4DWindow(990; 720; 8; "WO Transfers"; "CancelCommand")
DIALOG:C40([Control:1]; "WorkOrdersTransfer")
CLOSE WINDOW:C154
POST OUTSIDE CALL:C329(<>theProcessList)