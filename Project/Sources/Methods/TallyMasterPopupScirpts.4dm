//%attributes = {}

// Modified by: Bill James (2022-01-14T06:00:00Z)
// Method: TallyMasterPopupScirpts
// Description
// Parameters
// ----------------------------------------------------



var $1 : Variant
var $2; $selectionOnly; $tableNum : Integer
var $tableName : Text
var $sel : Object
var $c : Collection



Case of 
	: (Value type:C1509($1)=Is text:K8:3)
		$tableName:=$1
	: (Value type:C1509($1)=Is pointer:K8:14)
		$tableName:=Table name:C256($1)
End case 
If ($tableName#"")
	$tableNum:=ds:C1482[$tableName].getInfo().tableNumber
	If (Count parameters:C259=2)
		$selectionOnly:=$2
	End if 
	// HOWTO:
	//  collections to arrays collectionstoarrays
	//  entityttocollection entity to collection
	ARRAY TEXT:C222(aiLoScript; 0)
	ARRAY TEXT:C222(atTallyScriptInput_name; 0)
	ARRAY TEXT:C222(atTallyScriptInput_id; 0)
	
	$selectionOnly:=-1
	$sel:=ds:C1482.TallyMaster.query("purpose = :1 AND publish > :2 AND publish <= :3 AND tableName = :4"; \
		"iLoScripts"; 0; Storage:C1525.user.securityLevel; $tableName)
	$c:=$sel.toCollection("name,id").orderBy("name asc")
	COLLECTION TO ARRAY:C1562($c; atTallyScriptInput_name; "name"; atTallyScriptInput_id; "id")
	//
	INSERT IN ARRAY:C227(atTallyScriptInput_name; 1; 1)
	INSERT IN ARRAY:C227(atTallyScriptInput_id; 1; 1)
	atTallyScriptInput_name{1}:="Scripts"
	atTallyScriptInput_id{1}:=""
	atTallyScriptInput_name:=1
End if 
