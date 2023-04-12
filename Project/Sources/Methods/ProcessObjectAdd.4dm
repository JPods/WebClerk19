//%attributes = {}

// Modified by: Bill James (2021-11-20T06:00:00Z)
// Method: ProcessObjectNew
// Description 
// Parameters
// ----------------------------------------------------


var $1; process_o; $selection_o : Object
process_o:=$1
process_o.user:=Storage:C1525.user
var $vtScript; tableName : Text
If (process_o.dataClassName=Null:C1517)
	tableName:=""
Else 
	tableName:=process_o.dataClassName
End if 
If (process_o.task#Null:C1517)
	Case of 
		: (process_o.task="ShowRecord@")
			USE ENTITY SELECTION:C1513(process_o.entitySelection)
		: (process_o.task="Script")
			// $vtScript:=
			var obRec : Object
			$vtEchoedText:=ExecuteScript(process_o.script)
			
	End case 
	//Process_ListActive  // get rid of this
	
	var $obWindows : Object
	$obWindows:=WindowCountToShow
	$form_t:=process_o.form
	var $ptTable : Pointer
	$ptTable:=STR_GetTablePointer(tableName)
	//$win_l:=Open form window($ptTable->; $form_t; Plain form window; $obWindows.leftOffset; 53+$obWindows.topOffset;*)
	//process_o.window:=$win_l
	WindowOpenTaskOffSets
	MESSAGES OFF:C175
	ADD RECORD:C56($ptTable->)
	
End if 