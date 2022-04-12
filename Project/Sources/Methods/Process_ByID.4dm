//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/19/21, 23:33:57
// ----------------------------------------------------
// Method: Process_ByID
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (Count parameters:C259=0)
	var $obPassable : Object
	$ent:=process_o.cur
	$obPassable:=New object:C1471("tableName"; process_o.tableName; \
		"form"; ""; "tableForm"; \
		process_o.tableName+"_InputDS"; \
		"ents"; _LB_OutputDS_.ents; \
		"pos"; _LB_OutputDS_.pos; \
		"cur"; _LB_OutputDS_.cur; \
		"sel"; _LB_OutputDS_.sel; \
		"page"; aPages; \
		"parentProcess"; Current process:C322)
	$viProcess:=New process:C317("Process_ByID"; 0; process_o.tableName+" - "+String:C10(Count tasks:C335); $obPassable)
Else 
	
	C_OBJECT:C1216($1; $obRec; $obPassable; process_o)
	C_POINTER:C301(ptCurTable; $ptID)
	Process_InitLocal
	Prs_ListActive
	var entryEntity; $o1; $o2; $o3 : Object
	
	process_o:=$1
	//process_o.ents:=process_o.ents
	If (process_o.cur=Null:C1517)  // cur does not seem to pass
		//process_o.cur:=process_o.sel[0]  // these are equivalent
		process_o.cur:=process_o.ents[process_o.pos]
		//$o1:=process_o.cur.getSelection()
		$o2:=process_o.ents.slice(0; 0)
		process_o.sel:=process_o.ents.slice(0; 1)
	End if 
	entryEntity:=process_o.cur.toObject()
	$form_t:=process_o.form
	$form_t:="InputDS"
	process_o.tableNum:=ds:C1482[process_o.tableName].getInfo().tableNumber
	ptCurTable:=STR_GetTablePointer(process_o.tableName)
	
	// do this before dialog opens show there is not a data change event
	vActionDateCustomer:=Current date:C33
	
	
	
	C_OBJECT:C1216($obWindows)
	$obWindows:=WindowCountToShow
	If (process_o.tableForm="")
		//$win_l:=Open form window($form_t; Plain form window; $obWindows.leftOffset; 53+$obWindows.topOffset;*)
		//process_o.window:=$win_l
		//DIALOG($form_t;process_o)
	Else 
		$win_l:=Open form window:C675(ptCurTable->; $form_t; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
		process_o.window:=$win_l
		DIALOG:C40(ptCurTable->; $form_t; process_o)
	End if 
	
	CLOSE WINDOW:C154($win_l)
End if 