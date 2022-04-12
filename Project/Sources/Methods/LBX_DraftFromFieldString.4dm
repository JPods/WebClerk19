//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/24/21, 20:34:30
// ----------------------------------------------------
// Method: LBX_DraftFromFieldString
// Description
//
//
// Parameters
// ----------------------------------------------------
var $0; $1; $listboxSetup_o : Object
var $lbName : Text
var $fieldList_t; tableName : Text
var $columnAdder_t : Text
var $columns_o; $listboxSetup_o : Object
If (Count parameters:C259=1)
	$listboxSetup_o:=$1
Else 
	$listboxSetup_o:=New object:C1471("listboxName"; "_LB_OutputDS_"; "tableName"; tableName; "fieldList"; $fieldList_t; "priority"; "FieldCharacteristics")
	$listboxSetup_o:=New object:C1471("listboxName"; $lbName_t; "tableName"; tableName; "fieldList"; ""; "priority"; "harvest"; "role"; ""; "idUser"; ""; "columns"; New object:C1471)
End if 
If ($listboxSetup_o#Null:C1517)
	Case of 
		: ($listboxSetup_o.priority="FieldCharacteristics")
			tableName:=$listboxSetup_o.tableName
			$columnAdder_t:=""
			If ($listboxSetup_o.columnAdder#Null:C1517)
				$columnAdder_t:=$listboxSetup_o.columnAdder
			End if 
			$obRec:=ds:C1482.FieldCharacteristic.query(" tableName = :1 AND purpose = :2 "; tableName; "formDefault").first()
			$fieldList_t:=$listboxSetup_o.fieldList
			Case of 
				: ($obRec#Null:C1517)
					$fieldList_t:=$obRec.data.FormDefault
				: ($listboxSetup_o.fieldList#"")
					$fieldList_t:=$listboxSetup_o.fieldList
				Else 
					$fieldList_t:="id"
			End case 
			$lbName:=$listboxSetup_o.listboxName
			
		: ($listboxSetup_o.priority="fieldList")
			tableName:=$listboxSetup_o.tableName
			$fieldList_t:=$listboxSetup_o.fieldList
			If ($fieldList_t="")
				$obRec:=ds:C1482.FieldCharacteristic.query(" tableName = :1 AND purpose = :2 "; tableName; "formDefault").first()
				If ($obRec=Null:C1517)
					$fieldList_t:="id"
				Else 
					$fieldList_t:=$obRec.data.FormDefault
				End if 
			End if 
			$lbName:=$listboxSetup_o.listboxName
		: ($listboxSetup_o.priority="Selection")
			If ($listboxSetup_o#Null:C1517)
				tableName:=$listboxSetup_o.tableName
				$fieldList_t:=$listboxSetup_o.fieldList
				$lbName:=$listboxSetup_o.listboxName
			End if 
			var $cBuild; $cFilter : Collection
			var $obField : Object
			$cBuild:=New collection:C1472
			For each ($obField; LB_Fields.sel)
				$cBuild.push($obField.fieldName)
			End for each 
			$fieldList_t:=$cBuild.join(",")
			$listboxSetup_o.fieldList:=$fieldList_t
	End case 
Else 
	tableName:="Customer"
	$fieldList_t:="action,actionBy,actionDate,company,nameLast,nameFirst,id"
	$lbName:="LB_Empty"
End if 

$listboxSetup_o:=LBX_FieldListClean($listboxSetup_o)
$0:=$listboxSetup_o





