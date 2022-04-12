//%attributes = {}

// Modified by: Bill James (2021-12-05T06:00:00Z)
// Method: LBDialog_Import
// Description 
// Parameters
// ----------------------------------------------------



C_OBJECT:C1216($1; process_o)  // tableName and purpose
If (Count parameters:C259=1)
	process_o:=$1
Else 
	process_o:=New object:C1471("ents"; New object:C1471; \
		"cur"; New object:C1471; \
		"sel"; New object:C1471; \
		"pos"; -1; \
		"tableName"; "Order"; \
		"tableForm"; ""; \
		"form"; "ImportCheck"; \
		"entsOther"; New object:C1471("tableName"; New object:C1471); \
		"process"; Current process:C322)
End if 
Prs_ListActive
C_TEXT:C284($form_t)
C_LONGINT:C283($win_l)
C_LONGINT:C283($cascade_l)
If (process_o.tableName=Null:C1517)
	process_o.tableName:="Order"
End if 
vtTableName:=process_o.tableName
If (process_o.form=Null:C1517)
	process_o.form:="ImportCheck"
End if 
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