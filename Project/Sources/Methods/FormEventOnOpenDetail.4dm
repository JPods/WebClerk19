//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/09/06, 22:41:18
// ----------------------------------------------------
// Method: FormEventOnOpenDetail
// Description
// 
//
// Parameters
// ----------------------------------------------------
// CLASSIC 
If (process_o=Null:C1517)
	process_o:=New object:C1471("ents"; New object:C1471; \
		"cur"; New object:C1471; \
		"sel"; New object:C1471; \
		"pos"; -1; \
		"tableName"; Table name:C256(ptCurTable); \
		"tableForm"; "InputDS"; \
		"entsOther"; New object:C1471("tableName"; New object:C1471); \
		"process"; Current process:C322)
End if 
$ptID:=STR_Get_idPointer(process_o.dataClassName)
process_o.cur:=ds:C1482[process_o.dataClassName].query("id = :1"; $ptID->).first()
process_o.old:=Null:C1517
// should never save from CLASSIC
If (False:C215)
	var entry_o : Object
	var $ptID : Pointer
	var $tableName : Text
	entry_o:=New object:C1471
	Case of 
		: (process_o#Null:C1517)
			$tableName:=process_o.dataClassName
		: (ptCurTable#Null:C1517)
			$tableName:=Table name:C256(ptCurTable)
			ConsoleLog("FormEventOnOpenDetail process_o = null, tableName: "+$tableName)
		Else 
			ConsoleLog("FormEventOnOpenDetail process_o = null and ptCurTable = null")
	End case 
	
	If ($tableName#"")
		$ptID:=STR_Get_idPointer($tableName)
		entry_o:=ds:C1482[$tableName].query("id = :1"; $ptID->).first()
	End if 
	
	If (process_o#Null:C1517)
		process_o.cur:=entry_o
		process_o.old:=Null:C1517
		// NEVER_FROM_CLASSIC Bill James (2022-01-28T06:00:00Z)
		entry_o:=entry_o
	End if 
	var $new_o : Object
	$new_o:=New object:C1471("ents"; New object:C1471; "tableName"; process_o.dataClassName; "form"; "Input"; "tableForm"; process_o.dataClassName+"_Input"; "id"; Form:C1466.cur.id; "parent"; Current process:C322)
	$viProcess:=New process:C317("Process_ByID"; 0; process_o.dataClassName+" - "+String:C10(Count tasks:C335); $new_o)
End if 
