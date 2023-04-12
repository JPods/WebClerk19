//%attributes = {}

// Modified by: Bill James (2022-01-01T06:00:00Z)
// Method: Form_LBDraft
// Description 
// Parameters
// ----------------------------------------------------


// QQQents

If (Count parameters:C259=0)
	var $process_o : Object
	$process_o:=New object:C1471("ents"; New object:C1471; \
		"cur"; New object:C1471; \
		"sel"; New object:C1471; \
		"pos"; -1; \
		"tableName"; "Customer"; \
		"tableForm"; ""; \
		"form"; "LBXDraftForm"; \
		"entsOther"; New object:C1471("tableName"; New object:C1471); \
		"processName"; "Customer "+String:C10(Count tasks:C335))
	$proc_l:=New process:C317("Form_LBDraft"; 0; "Form_LBDraft "+String:C10(Count tasks:C335); $process_o)  // *) checks for duplicate named process
	POST OUTSIDE CALL:C329(Storage:C1525.process.processList)
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
			"form"; "LBXDraftForm"; \
			"entsOther"; New object:C1471("tableName"; New object:C1471); \
			"process"; Current process:C322)
	End if 
	Process_ListActive
	var $form_t : Text
	var $win_l : Integer
	var $cascade_l : Integer
	var $obWindows : Object
	If (process_o.dataClassName=Null:C1517)
		process_o.dataClassName:="Customer"
	End if 
	If (process_o.form=Null:C1517)
		process_o.form:="LBXDraftForm"
	End if 
	tableName:=process_o.dataClassName
	$form_t:=process_o.form
	$obWindows:=WindowCountToShow
	If (process_o.tableForm="")
		$win_l:=Open form window:C675($form_t; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
		process_o.window:=$win_l
		DIALOG:C40($form_t)
	Else 
		$win_l:=Open form window:C675(STR_GetTablePointer(process_o.dataClassName)->; $form_t; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
		process_o.window:=$win_l
		var $fObject : Object
		
		// QQQents
		
		$fObject:=New object:C1471("parentProcess"; Current process:C322; \
			"tableName"; "Customer"; \
			"LBXDraftForm"; New object:C1471("ents"; New object:C1471; \
			"cur"; New object:C1471; \
			"sel"; New object:C1471; \
			"pos"; 0))
		
		DIALOG:C40($form_t; $fObject)
	End if 
	CLOSE WINDOW:C154($win_l)
	
	POST OUTSIDE CALL:C329(Storage:C1525.process.processList)
End if 