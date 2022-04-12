//%attributes = {}

// Modified by: Bill James (2021-12-05T06:00:00Z)
// Method: LBX_DraftDialog
// Description 
// Parameters
// ----------------------------------------------------



If (Count parameters:C259=0)
	var $process_o : Object
	$process_o:=New object:C1471("ents"; New object:C1471; \
		"cur"; New object:C1471; \
		"sel"; New object:C1471; \
		"pos"; -1; \
		"tableName"; "Customer"; \
		"tableForm"; ""; \
		"form"; "LBXDraft"; \
		"entsOther"; New object:C1471; \
		"processName"; "Customer "+String:C10(Count tasks:C335))
	$proc_l:=New process:C317("LBX_DraftDialog"; 0; "LBXDraft "+String:C10(Count tasks:C335); $process_o)  // *) checks for duplicate named process
	POST OUTSIDE CALL:C329(<>theProcessList)
Else 
	
	var $1; process_o : Object
	If (Count parameters:C259=1)
		process_o:=$1
	Else 
		process_o:=New object:C1471("ents"; New object:C1471; \
			"cur"; New object:C1471; \
			"sel"; New object:C1471; \
			"pos"; -1; \
			"tableName"; "Customer"; \
			"tableForm"; ""; \
			"form"; "ListBoxDraft"; \
			"entsOther"; New object:C1471("tableName"; New object:C1471); \
			"process"; Current process:C322)
	End if 
	Prs_ListActive
	var $form_t : Text
	var $win_l : Integer
	var $cascade_l : Integer
	var $obWindows : Object
	If (process_o.tableName=Null:C1517)
		process_o.tableName:="Customer"
	End if 
	If (process_o.form=Null:C1517)
		process_o.form:="ListBoxDraft"
	End if 
	tableName:=process_o.tableName
	$form_t:=process_o.form
	$new_o:=New object:C1471("ents"; New object:C1471; "LB_Fields"; New object:C1471; "LB_Tables"; New object:C1471; "LB_Sandbox"; New object:C1471; "process_o"; process_o)
	$obWindows:=WindowCountToShow
	If (process_o.tableForm="")
		$win_l:=Open form window:C675($form_t; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
		process_o.window:=$win_l
		DIALOG:C40($form_t; $new_o)
	Else 
		$win_l:=Open form window:C675(STR_GetTablePointer(process_o.tableName)->; $form_t; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
		process_o.window:=$win_l
		var $fObject : Object
		// QQQents
		$fObject:=New object:C1471("parentProcess"; Current process:C322; \
			"tableName"; "Customer"; \
			"LB_CronJob"; New object:C1471("ents"; New object:C1471; \
			"cur"; New object:C1471; \
			"sel"; New object:C1471; \
			"pos"; 0))
		
		DIALOG:C40($form_t; $fObject)
	End if 
	CLOSE WINDOW:C154($win_l)
	
	POST OUTSIDE CALL:C329(<>theProcessList)
End if 