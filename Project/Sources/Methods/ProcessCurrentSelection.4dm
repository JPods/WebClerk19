//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2021-12-23T06:00:00Z)
// Method: ProcessCurrentSelection
// Description 
// Parameters
// ----------------------------------------------------



var $1 : Variant
var $tableName : Text
var $ptTable : Pointer
$tableName:=""
If (Not:C34(Application type:C494=4D Server:K5:6))
	Case of 
		: (Count parameters:C259=0)
			If (ptCurTable#Null:C1517)
				$tableName:=Table name:C256($1)
			End if 
		: (Value type:C1509($1)=Is text:K8:3)
			$tableName:=$1
		: (Value type:C1509($1)=Is pointer:K8:14)
			$tableName:=Table name:C256($1)
	End case 
	If ($tableName#"")
		$ptTable:=STR_GetTablePointer($tableName)
		var $new_o : Object
		var $entitySelection : Object
		$entitySelection:=Create entity selection:C1512($ptTable->)
		$new_o:=New object:C1471("ents"; New object:C1471; "parentProcess"; Current process:C322; \
			"parentTable"; ""; \
			"tableName"; $tableName; \
			"data"; $entitySelection)
		$process_i:=New process:C317("Process_ShowSelection"; 0; String:C10(Count user processes:C343)+"-"+$tableName; $new_o)
		
	End if 
End if 