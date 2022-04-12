//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-20T06:00:00Z)
// Method: ShipWindow
// Description 
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($found)
If (Count parameters:C259=1)
	Process_InitLocal
	var process_o; $1 : Object
	process_o:=$1
	//tableName:=process_o.tableName
	tableName:="Control"
	//ptCurTable:=STR_GetTablePointer(tableName)
	ptCurTable:=(->[Control:1])
	//$form_t:=process_o.form
	$form_t:="Packing"
	C_OBJECT:C1216($obWindows)
	$obWindows:=WindowCountToShow
	
	$win_l:=Open form window:C675(ptCurTable->; $form_t; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
	process_o.window:=$win_l
	DIALOG:C40(ptCurTable->; $form_t; process_o)
	
	
Else 
	
	$found:=Prs_CheckRunnin("Packing")
	If ($found>0)
		If (Frontmost process:C327#<>aPrsNum{$found})
			BRING TO FRONT:C326(<>aPrsNum{$found})
		End if 
	Else 
		$tableName:="Control"
		$vtAddTitle:=""
		var $process_o : Object
		process_o:=New object:C1471("ents"; New object:C1471; \
			"cur"; New object:C1471; \
			"sel"; New object:C1471; \
			"pos"; -1; \
			"tableName"; $tableName; \
			"tableForm"; ""; \
			"form"; "FlowMap"; \
			"entsOther"; New object:C1471("tableName"; New object:C1471); \
			"process"; Current process:C322)
		// $process_o:=New object("ents"; New object; "tableName"; $tableName; "tableForm"; "FlowMap"; "process"; Current process)
		<>processAlt:=New process:C317("ShipWindow"; 0; "Packing"; $process_o)
	End if 
End if 