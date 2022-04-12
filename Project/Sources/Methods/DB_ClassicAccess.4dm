//%attributes = {}

// Modified by: Bill James (2022-01-21T06:00:00Z)
// Method: DB_ClassicAccess
// Description 
// Parameters
// ----------------------------------------------------
// his is used to access traditional OutPut and Input layouts. No saving. ViewOnly
// technically, you could use a script to save
var $1; $tableName : Text
var $o; $sel_o : Object
$tableName:=$1
Case of 
	: (Count parameters:C259=1)
		$sel_o:=ds:C1482[$tableName].all()
		$o:=New object:C1471("tableName"; $tableName; \
			"saveOK"; "viewOnly"; \
			"sel"; New object:C1471; \
			"cur"; New object:C1471; \
			"ents"; $sel_o; \
			"tableName"; $tableName; \
			"tableForm"; ""; \
			"form"; "OutputDS"; \
			"image"; New object:C1471("item"; New object:C1471("path"; ""; "picture"; Null:C1517); \
			"user"; New object:C1471("path"; ""; "picture"; Null:C1517)); \
			"path"; New object:C1471; \
			"process"; Current process:C322)
		$newProcess:=New process:C317("DB_ClassicAccess"; 0; String:C10(Count user processes:C343)+"-"+$tableName; $tableName; $o)
	: (Count parameters:C259=2)
		Process_InitLocal
		var $1 : Text
		var $2 : Object
		var process_o : Object
		process_o:=$2
		$tableName:=process_o.tableName
		process_o.tableNum:=ds:C1482[$tableName].getInfo().tableNumber
		var ptCurTable : Pointer
		ptCurTable:=Table:C252(process_o.tableNum)
		//var vHere : Integer
		//vMod:=False
		READ ONLY:C145(ptCurTable->)
		If (process_o.ents=Null:C1517)
			process_o.ents:=ds:C1482[$tableName].all()
		End if 
		If (process_o.cur=Null:C1517)
			process_o.cur:=process_o.ents.first()
			process_o.old:=process_o.cur.clone()
		End if 
		USE ENTITY SELECTION:C1513(process_o.ents)
		vHere:=0
		$form_t:="Output"
		var $obWindows : Object
		$obWindows:=WindowCountToShow
		$win_l:=Open form window:C675(ptCurTable->; $form_t; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
		// DIALOG(ptCurTable->; $form_t)   // change to dialog if we change to listboxes, currently tradition Output layout
		MODIFY SELECTION:C204(ptCurTable->)
End case 