//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/06/10, 08:24:23
// ----------------------------------------------------
// Method: DB_ShowCurrentSelection
// Description
// Action: testthis
//
// Parameters
//$1  The Table Pointer
//$2  Any script action to be applied to the selection in the child process
//$3 Branch to various actions in the new process
//$4 Name to add in new process
//$5 Mange the current selection in the current process, 1 selection to 0, 2 keep selection but unload current record
// ----------------------------------------------------

//  coming from classic to DS
var $data : Object

var $1 : Variant
var $2; $nameAdder; $tableName; $theScript : Text
var $3; $selectionManage; $setManagement : Integer
var $ptCurrentTable : Pointer
Case of 
	: ((Value type:C1509($1)=Is longint:K8:6) | (Value type:C1509($1)=Is real:K8:4) | (Value type:C1509($1)=Is integer:K8:5))
		$tableName:=Table name:C256($1)
	: ((Value type:C1509($1)=Is text:K8:3) | (Value type:C1509($1)=Is string var:K8:2))
		$tableName:=$1
	: (Value type:C1509($1)=Is object:K8:27)
		$tableName:=$1
	: (Value type:C1509($1)=12)
		$tableName:=$1
	: (Value type:C1509($1)=Is pointer:K8:14)
		$tableName:=Table name:C256($1)
	Else 
		//
End case 
$ptCurrentTable:=STR_GetTablePointer($tableName)
If (Application type:C494#4D Server:K5:6)
	If (Count parameters:C259>1)
		If ($2="")  // is there a script
			$data:=Create entity selection:C1512($ptCurrentTable->)
		Else 
			$data:=ExecuteScript_Object($2)
		End if 
		If (Count parameters:C259>2)  // to manage the selection to display,
			$setManagement:=$3
			If (Count parameters:C259>3)  //add a lable to the opening process
				$nameAdder:=$4
				If (Count parameters:C259>4)  //zero to clear selection, 2 to unload record, 1 to leave as is
					$selectionManage:=$5
				End if 
			End if 
		End if 
	End if 
	
	var $cur_ent; $parent_ent : Object
	
	
	
	
	
	var $isunlocked : Integer
	Case of   // $5 controls this
		: ($selectionManage=1)
			//leave existing record alone
		: ($selectionManage=2)
			UNLOAD RECORD:C212($ptCurrentTable->)
		: ($selectionManage=3)  // unload all records
			UNLOAD RECORD:C212($ptCurrentTable->)
			$isunlocked:=Prs_unlockedRecords($ptCurrentTable)
		Else 
			UNLOAD RECORD:C212($ptCurrentTable->)
			REDUCE SELECTION:C351($ptCurrentTable->; 0)
			$isunlocked:=Prs_unlockedRecords($ptCurrentTable)
	End case 
	
	var $tableParent : Text
	var $oParent : Object
	If (process_o.cur#Null:C1517)
		$tableParent:=process_o.tableName
		$oParent:=process_o.cur
	Else 
		$oParent:=Null:C1517
	End if 
	
	$new_o:=New object:C1471("tableName"; $tableName; \
		"ents"; $data; \
		"cur"; $data.first(); \
		"sel"; New object:C1471; \
		"pos"; -1; \
		"parentRecord"; $oParent; \
		"parentTable"; $tableParent; \
		"tableForm"; ""; \
		"form"; "OutputDS"; \
		"process"; Current process:C322; \
		"entsOther"; New object:C1471("tableName"; New object:C1471))
	$childProcess:=New process:C317("Process_ShowTableDS"; 0; String:C10(Count user processes:C343)+"-"+$tableName; $new_o)
	
	
End if 

