//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 07/07/21, 00:04:16
// ----------------------------------------------------
// Method: Process_AddRecord
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $1 : Variant
If (Value type:C1509($1)=Is text:K8:3)
	var $new_o; $parent_o : Object
	var $id; $tableParent; $endTask : Text
	var $windowParent; $processParent; $processChild : Integer
	$parent_o:=New object:C1471
	If (process_o.cur#Null:C1517)
		$id:=process_o.cur.id
		$tableParent:=process_o.tableName
		$windowParent:=Current form window:C827
		$processParent:=Current process:C322
		$parent_o:=process_o.cur
		$endTask:="reload_"+$tableParent
	End if 
	$new_o:=New object:C1471("ents"; New object:C1471; "tableName"; $1; "task"; "addRecord"; "tableParent"; "Customer"; \
		"idParent"; $id; "tableParent"; $tableParent; "entityParent"; $parent_o; \
		"taskEnd"; $endTask; "myCycle"; 3; "method"; "ProcessObject"; \
		"processParent"; $processParent; "windowParent"; $windowParent)
	$processChild:=New process:C317("Process_AddRecord"; 0; String:C10(Count user processes:C343)+"-"+$1; $new_o)
Else 
	
	Process_InitLocal
	var process_o : Object
	process_o:=$1
	curTableNum:=STR_GetTableNumber(process_o.tableName)
	C_POINTER:C301(ptCurTable)
	ptCurTable:=Table:C252(curTableNum)
	//ADD RECORD(ptCurTable->)
	var $obWindows : Object
	$obWindows:=WindowCountToShow
	$win_l:=Open form window:C675(ptCurTable->; "Input"; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
	CREATE RECORD:C68(ptCurTable->)
	DIALOG:C40(ptCurTable->; "Input")
End if 