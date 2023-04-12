//%attributes = {"publishedWeb":true}
// ProcessObject
// ### bj ### 20210808_0101
var $1; process_o; $selection_o : Object
//Process_InitLocal
//DELAY PROCESS(Current process; 10)
Process_InitLocal
If (process_o=Null:C1517)
	process_o:=$1
	process_o.user:=Storage:C1525.user
End if 
var $vtScript; tableName : Text
If (process_o.dataClassName=Null:C1517)
	tableName:="Customer"
Else 
	tableName:=process_o.dataClassName
End if 
var $rec_ent : Object
var $ptTable; $ptID : Pointer
$ptTable:=STR_GetTablePointer(tableName)
ptCurTable:=$ptTable
If (process_o.myCycle#Null:C1517)
	myCycle:=process_o.myCycle
End if 

$form_t:="Output"  // baseline show as output

If (process_o.task=Null:C1517)
	If (process_o.entitySelection#Null:C1517)  // if there is an entity selection override script
		USE ENTITY SELECTION:C1513(process_o.entitySelection)  // remove this at some point
	End if 
	If (process_o.script#Null:C1517)  // if there is an entity selection override script
		If (process_o.script#"")
			var obRec : Object
			$vtEchoedText:=ExecuteScript(process_o.script)
			process_o.entitySelection:=Create entity selection:C1512($ptTable->)
		End if 
	End if 
Else 
	Case of 
		: (process_o.task="ShowRecord@")
			USE ENTITY SELECTION:C1513(process_o.entitySelection)
		: (process_o.task="by_id")
			$rec_ent:=ds:C1482[process_o.dataClassName].get(process_o.id)
			USE ENTITY SELECTION:C1513($rec_ent)  // remove this at some point
		: (process_o.task="Script")
			// $vtScript:=
			var obRec : Object
			$vtEchoedText:=ExecuteScript(process_o.script)
			process_o.entitySelection:=Create entity selection:C1512($ptTable->)
		: (process_o.task="Add@")
			$form_t:="Input"  // adding show as input until shift to OutputDS
			CREATE RECORD:C68($ptTable->)
	End case 
End if 

If (process_o.tableParent#Null:C1517)  // get the parent record 
	If (process_o.idParent#Null:C1517)
		If (process_o.idParent#"")
			
			$rec_ent:=ds:C1482[process_o.tableParent].get(process_o.idParent)
			//  create entity selection
			USE ENTITY SELECTION:C1513($rec_ent)  // remove this at some point
			
		End if 
	End if 
End if 

If (process_o.form#Null:C1517)  // override standard forms
	// shift this to OutputDS at some point
	$form_t:=process_o.form
End if 
Process_ListActive
If ($form_t="")
	If (Records in selection:C76($ptTable->)=1)
		$form_t:="Input"
	Else 
		$form_t:="Output"
	End if 
End if 
var $obWindows : Object
$obWindows:=WindowCountToShow
var $tableForm_t : Text
If (process_o.tableForm#Null:C1517)
	$tableForm_t:=process_o.tableForm
End if 

$win_l:=Open form window:C675($ptTable->; $form_t; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
process_o.window:=$win_l
MESSAGES OFF:C175
BRING TO FRONT:C326(Current process:C322)
If (Records in selection:C76($ptTable->)=1)
	DIALOG:C40($ptTable->; $form_t)
Else 
	
	// Modified by: Bill James (2021-12-18T06:00:00Z)
	//. cannot use dialog to open the old type output layouts. Replace the old output with listboxes
	MODIFY SELECTION:C204($ptTable->)
End if 

SelectionToZero


var $idCustomer_t : Text
$idCustomer_t:=[Customer:2]id:127
If (process_o.taskEnd#Null:C1517)
	Case of 
		: (process_o.taskEnd="recall_Customer")
			
			$new_o:=New object:C1471("ents"; New object:C1471; "tableName"; "Customer"; "task"; "by_id"; "id"; $idCustomer_t)  // "Customer"; process_o.Customer)
			$idProcess:=New process:C317("ProcessObject"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-"+process_o.tableParent; $new_o)
			
		: (process_o.taskEnd="recall_Parent")
			$new_o:=New object:C1471("ents"; New object:C1471; "tableName"; process_o.tableParent; "task"; "by_id"; "id"; process_o.idParent; process_o.tableParent; process_o.cur)
			$idProcess:=New process:C317("ProcessObject"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-"+process_o.tableParent; $new_o)
			
			//: (process_o.parent.length>0)
			
			//: (process_o.taskEnd#Null)
			
	End case 
End if 
