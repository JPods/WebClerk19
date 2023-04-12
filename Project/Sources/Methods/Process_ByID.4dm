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
	If (process_o.cur#Null:C1517)
		$obPassable:=New object:C1471("dataClassName"; process_o.dataClassName; \
			"form"; ""; "tableForm"; \
			process_o.dataClassName+"_InputDS"; \
			"id"; process_o.cur.id; \
			"page"; aPages; \
			"parentProcess"; Current process:C322)
		$viProcess:=New process:C317("Process_ByID"; 0; process_o.dataClassName+" - "+String:C10(Count tasks:C335); $obPassable)
		
	End if 
	
Else 
	
	C_OBJECT:C1216($1; $obRec; $obPassable; process_o)
	C_POINTER:C301(ptCurTable; $ptID)
	Process_InitLocal
	Process_ListActive
	var entry_o; $o1; $o2; $o3; process_o : Object
	process_o:=New object:C1471
	process_o:=cs:C1710.TableShow.new($1.dataClassName)
	process_o.ents:=ds:C1482[$1.dataClassName].query("id = :1"; $1.id)
	entry_o:=process_o.selectChanged()
	process_o.pos:=$1.pos
	
	If (process_o.tableForm=Null:C1517)
		process_o.tableForm:=""
	End if 
	
	$form_t:=process_o.form
	$form_t:="InputDS"
	process_o.tableNum:=ds:C1482[process_o.dataClassName].getInfo().tableNumber
	ptCurTable:=STR_GetTablePointer(process_o.dataClassName)
	
	// do this before dialog opens show there is not a data change event
	vActionDate:=Current date:C33
	
	
	
	C_OBJECT:C1216($obWindows)
	$obWindows:=WindowCountToShow
	If (process_o.tableForm#"")
		$win_l:=Open form window:C675($form_t; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
		process_o.window:=$win_l
		DIALOG:C40($form_t; process_o)
	Else 
		$win_l:=Open form window:C675(ptCurTable->; $form_t; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
		process_o.window:=$win_l
		DIALOG:C40(ptCurTable->; $form_t; process_o)
	End if 
	
	process_o.destructor()
	
	CLOSE WINDOW:C154($win_l)
	
	
End if 