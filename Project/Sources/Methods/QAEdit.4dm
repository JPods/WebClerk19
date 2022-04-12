//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/07/21, 01:12:00
// ----------------------------------------------------
// Method: QAEdit
// Description
// 
// Parameters
// ----------------------------------------------------




C_OBJECT:C1216($1; process_o)  // tableName and purpose
If (Count parameters:C259=1)
	process_o:=$1
Else 
	Form_process_o_init
	process_o.form:="QADraft"
End if 
Prs_ListActive
C_TEXT:C284($form_t)
C_LONGINT:C283($win_l)
C_LONGINT:C283($cascade_l)

$form_t:=process_o.form
C_OBJECT:C1216($obWindows)
$obWindows:=WindowCountToShow
If (process_o.tableForm="")
	$win_l:=Open form window:C675($form_t; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
	process_o.window:=$win_l
	DIALOG:C40($form_t)
Else 
	$win_l:=Open form window:C675(STR_GetTablePointer(process_o.tableForm)->; $form_t; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
	process_o.window:=$win_l
	DIALOG:C40($form_t)
End if 

CLOSE WINDOW:C154($win_l)