//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/09/21, 23:32:19
// ----------------------------------------------------
// Method: LBPopupJoint
// Description
// 
//
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
		"tableName"; "Popup"; \
		"tableForm"; ""; \
		"form"; "Joint"; \
		"entsOther"; New object:C1471("tableName"; New object:C1471); \
		"process"; Current process:C322)
	
End if 
Prs_ListActive
C_TEXT:C284($form_t)
C_LONGINT:C283($win_l)
C_LONGINT:C283($cascade_l)
If (process_o.tableName=Null:C1517)
	process_o.tableName:="Popup"
End if 
vtTableName:=process_o.tableName
If (process_o.form=Null:C1517)
	process_o.form:="Output"
End if 
$form_t:=process_o.form
C_OBJECT:C1216($obWindows)
$obWindows:=WindowCountToShow

$win_l:=Open form window:C675([PopUp:23]; "Joint"; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)

process_o.window:=$win_l
DIALOG:C40([PopUp:23]; "Joint")
CLOSE WINDOW:C154($win_l)
