//%attributes = {}

// Modified by: Bill James (2022-01-24T06:00:00Z)
// Method: DB_ShowCurrentObject
// Description 
// Parameters
// ----------------------------------------------------
var $1 : Variant
var $2; $info_o : Object
var $tableName : Text
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
$info_o:=$2
var $data; $new_o : Object
var $titleAdder : Text
$data:=$info_o.data
If ($info_o.$titleAdder#Null:C1517)
	$titleAdder:=$info_o.$titleAdder
End if 

//"ents"; New object($tableName; $data); \

$o:=New object:C1471(\
"ents"; $data; \
"cur"; $data.first(); \
"sel"; New object:C1471; \
"pos"; -1; \
"tableName"; $tableName; \
"tableForm"; ""; \
"form"; "OutputDS"; \
"titleAdder"; $titleAdder; \
"processParent"; Current process:C322; \
"entsOther"; New object:C1471("tableName"; New object:C1471))

If (process_o#Null:C1517)
	If (process_o.tableName#Null:C1517)
		$new_o.tableParent:=process_o.tableName
	End if 
	If (process_o.cur#Null:C1517)
		$new_o.idParent:=process_o.cur.id
	End if 
End if 
$childProcess:=New process:C317("Process_ShowTableDS"; 0; String:C10(Count user processes:C343)+"-"+$tableName; $new_o)