//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-12-20T06:00:00Z)
// Method: STR_StructureWrite
// Description 
// Parameters
// ----------------------------------------------------



var $obDataStore; $obTable; $obRec : Object
var $cStructure; $cTableNames : Collection
$cStructure:=New collection:C1472
$obDataStore:=ds:C1482

var $dataClassName; $fieldName : Text
var $ds_o; $f_o; $dc_o; $changes_o : Object
var $ds_t; $f_t; $dc_t; $out_t : Text
var $fields_c : Collection
$ds_o:=New object:C1471

$changes_o:=New object:C1471
$changes_o["AccountPayType"]:=New object:C1471("tableName"; "AccountPayType"; \
"changes"; New object:C1471("exists"; "AccountPayType"; \
"action"; "delete incorporate into GLAccount"; "newName"; ""))
$changes_o["Comment"]:=New object:C1471("tableName"; "Comment"; \
"changes"; New object:C1471("exists"; "Comment"; \
"action"; "delete incorporate into Admin"; "newName"; ""))
$changes_o["Default"]:=New object:C1471("tableName"; "Default"; \
"changes"; New object:C1471("exists"; "Default"; \
"action"; "delete incorporate into Admin"; "newName"; ""))


$changes_o["Default"]:=New object:C1471("tableName"; "Default"; \
"changes"; New object:C1471("exists"; "Default"; \
"action"; "delete incorporate into Admin"; "newName"; ""))


Case of 
	: ($doJson)
		For each ($dataClassName; ds:C1482)
			If ($dataClassName#"zz@")
				$fields_c:=New collection:C1472
				$ds_o[$dataClassName]:=New object:C1471
				For each ($fieldName; ds:C1482[$dataClassName])
					$ds_o[$dataClassName][$fieldName]:=ds:C1482[$dataClassName][$fieldName]
					//$fields_c.push(New object($fieldName; ds[$dataClassName][$fieldName]))
					//For each ($property; ds[$dataClassName][$fieldName])
					//$dc_o[$dataClassName].push(ds[$dataClassName][$fieldName])
					//End for each 
				End for each 
				//$ds_c.push(New object($dataClassName; $fields_c))
			End if 
		End for each 
		$ds_t:=JSON Stringify:C1217($ds_o)
		
		SET TEXT TO PASTEBOARD:C523($ds_t)
		
	Else 
		
		var $obDataStore; $obTable; $obRec : Object
		var $cStructure; $cTableNames : Collection
		$cStructure:=New collection:C1472
		$obDataStore:=ds:C1482
		var $counter_i : Integer
		var $dataClassName; $fieldName : Text
		var $ds_o; $f_o; $dc_o : Object
		var $ds_t; $f_t; $dc_t; $out_t; $fieldsFlat_t : Text
		var $fields_c; $dc_c; $ds_c : Collection
		$ds_o:=New object:C1471
		$ds_c:=New collection:C1472
		//SET TEXT TO PASTEBOARD($obDataStore)
		//SET TEXT TO PASTEBOARD($ds_t)
		For each ($dataClassName; ds:C1482)
			If ($dataClassName#"zz@")
				$out_t:=$out_t+$dataClassName+"\t"
				For each ($property; ds:C1482[$dataClassName].id)
					$out_t:=$out_t+$property+"\t"
				End for each 
				$out_t:=$out_t+"\n"
				$fields_c:=New collection:C1472
				For each ($fieldName; ds:C1482[$dataClassName])
					$out_t:=$out_t+$dataClassName+"\t"
					For each ($property; ds:C1482[$dataClassName][$fieldName])
						$out_t:=$out_t+String:C10(ds:C1482[$dataClassName][$fieldName][$property])+"\t"
						//  GET FIELD PROPERTIES($tableNum; theFldNum{aFieldLns{$i}}; $typeFld; $lenField; $indexed)
					End for each 
					$out_t:=$out_t+"\n"
				End for each 
				$out_t:=$out_t+"\r\r"
			End if 
		End for each 
		
		SET TEXT TO PASTEBOARD:C523($out_t)
		
End case 