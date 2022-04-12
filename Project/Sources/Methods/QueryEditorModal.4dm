//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/13/19, 18:59:46
// ----------------------------------------------------
// Method: QueryEditorModal
// Description
// 
//
// Parameters
// ----------------------------------------------------
// implemented to keep the windows from locking when not 'Modal form dialog box"
// ### bj ### 20190113_1909
// my machine has trouble editing the values to be searched.  Does not seem to affect others
C_POINTER:C301($1)

If (Count parameters:C259>=1)
	curTableNum:=Table:C252($1)
End if 

curTableNumAlt:=curTableNum
// jCenterWindow (870;590;5;"Query";"Wind_CloseBox")
// DIALOG([Default];"QueryEditor")
//DIALOG([control];"QueryEditor")
$winid:=Open form window:C675([Control:1]; "QueryEditor"; Modal form dialog box:K39:7; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40([Control:1]; "QueryEditor")
CLOSE WINDOW:C154
viRecordsInSelection:=Records in selection:C76(Table:C252(curTableNum)->)