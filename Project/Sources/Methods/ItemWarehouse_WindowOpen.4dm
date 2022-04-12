//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/09/12, 18:30:54
// ----------------------------------------------------
// Method: ItemWarehouse_WindowOpen
// Description
// 
//
// Parameters
// ----------------------------------------------------

Process_InitLocal
jCenter4DWindow(850; 500; 8; "Item Warehouse Editor"; "CancelCommand")
DIALOG:C40([Control:1]; "ItemWarehouse")
CLOSE WINDOW:C154
POST OUTSIDE CALL:C329(<>theProcessList)