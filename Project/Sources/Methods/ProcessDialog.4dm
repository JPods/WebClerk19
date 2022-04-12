//%attributes = {}

// Modified by: Bill James (2021-12-24T06:00:00Z)
// Method: ProcessDialog
// Description 
// Parameters
// ----------------------------------------------------



// vScript is the name of the text field on the form
C_TEXT:C284($1; vScript)
C_LONGINT:C283($found; $2; $openwindow)
C_POINTER:C301(ptCurTable)

If (Count parameters:C259<2)
	$found:=New process:C317("ConsoleMessage"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-Dialog"; $1; 1)
	POST OUTSIDE CALL:C329(<>theProcessList)
Else 
	Process_InitLocal  // ### jwm ### 20180921_1534 initialize variables in new process
	vi2:=0
	vScript:=$1
	//jCenterWindow (540;380;1)
	$winRef:=Open form window:C675([Control:1]; "diaComments"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
	DIALOG:C40([Control:1]; "diaComments")
	CLOSE WINDOW:C154
	POST OUTSIDE CALL:C329(<>theProcessList)
End if 
