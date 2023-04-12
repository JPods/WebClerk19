//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/09/06, 22:41:52
// ----------------------------------------------------
// Method: FormEventOnCloseBox
// Description
// 
//
// Parameters
// ----------------------------------------------------

UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
READ WRITE:C146(ptCurTable->)
CANCEL:C270  // ### jwm ### 20181210_1318
Process_ListActive