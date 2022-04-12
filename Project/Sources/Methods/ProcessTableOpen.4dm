//%attributes = {}
// ProcessTableOpen(Table([Table]->;"script";"Title")

// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/15/11, 19:10:08
// ----------------------------------------------------
// Method: ProcessTableOpen
// Description
// Parameters
// tableNum
// $theScript
// $nameAdder
// ----------------------------------------------------

// MustFixQQQZZZ: Bill James (2021-12-14T06:00:00Z)
// this is a placeholder replace with ProcessObject or similar
// if the script is empty, used the the entity or current selection for the table being passed
var $1 : Variant
var $newProcess; tableNum : Integer
var $2; $theScript : Text
var $3; $nameAdder : Text
var $ptTableToShow : Pointer
var $prcNum; $tableNum : Integer
var $tableName; $script; $tableParent; $idParent; $windowTitleAdder : Text
var $new_o; $current_sel : Object

If (Count parameters:C259=0)
	$ptTableToShow:=ptCurTable
	$tableName:=Table name:C256($ptTableToShow)
Else 
	Case of 
		: (Value type:C1509($1)=Is text:K8:3)
			$ptTableToShow:=STR_GetTablePointer($1)
		: (Value type:C1509($1)=Is longint:K8:6)
			$ptTableToShow:=Table:C252(Abs:C99($1))
		: (Value type:C1509($1)=Is pointer:K8:14)
			$ptTableToShow:=$1
	End case 
	
	$tableName:=Table name:C256($ptTableToShow)
	If (Count parameters:C259>1)
		$theScript:=$2
		If (Count parameters:C259>2)
			$windowTitleAdder:=$3
		End if 
	End if 
End if 
// hold over
If (ptCurTable#Null:C1517)
	If (ptCurTable#(->[Control:1]))
		$tableParent:=Table name:C256(ptCurTable)
		If (vHere>1)
			If (Record number:C243(ptCurTable->)#-1)
				SAVE RECORD:C53(ptCurTable->)  // move all of jAcceptButton into triggers
				var $ptID : Pointer
				$ptID:=STR_Get_idPointer($tableParent)
				process_o.cur:=ds:C1482[$tableParent].get($ptID->)
			End if 
		End if 
	End if 
End if 
var $t : Text
If ($3="ViewOnly")
	$t:="ViewOnly"
End if 
$new_o:=New object:C1471("ents"; New object:C1471; "tableName"; $tableName; \
"task"; script; \
"script"; $2; \
"action"; $t; \
"windowTitleAdder"; $windowTitleAdder; \
"entitySelection"; Null:C1517; \
"entityParent"; Null:C1517; \
"processParent"; Current process:C322)
If ($theScript="")
	$new_o.entitySelection:=Create entity selection:C1512($ptTableToShow->)
End if 
If (process_o.cur#Null:C1517)
	$idParent:=process_o.cur.id
	$new_o.entityParent:=process_o.cur
End if 

//ds.process_o.cur.getInfo().tableName


$newProcess:=New process:C317("ProcessObject"; 0; String:C10(Count user processes:C343)+"-"+$tableName; $new_o)

