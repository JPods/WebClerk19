//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/09/06, 22:55:24
// ----------------------------------------------------
// Method: FormEventOnDoubleClicked
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (entryEntity#Null:C1517)
	
	
	
End if 
If (False:C215)
	var $viProcess : Integer
	var $new_o : Object
	var $tableName : Text
	$tableName:=Table name:C256(ptCurTable)
	$new_o:=New object:C1471("ents"; New object:C1471; "tableName"; $tableName; \
		"form"; "Input"; \
		"tableForm"; process_o.tableName+"_Input"; \
		"id"; STR_Get_idPointer($tableName)->; \
		"parentProcess"; Current process:C322)
	$viProcess:=New process:C317("Process_ByID"; 0; $tableName+" - "+String:C10(Count tasks:C335); $new_o)
End if 
