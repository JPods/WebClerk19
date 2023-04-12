//%attributes = {}

// Modified by: Bill James (2022-06-25T05:00:00Z)
// Method: LBX_DemoReworked
// Description 
// Parameters
// ----------------------------------------------------
// -----------------------------------------------------------------
// Name: LBX_DemoDynamic_02
// Description: Method will create a JSON form definition containing
// a Listbox object specifying the type and data source.
//
// Input Parameters:
// $1 (text) - Choice of Listbox type
//                1 - Selection
//                2 - Array
//                3 - Collection
//                4 - Entity
// $2 (collection) - Number of columns or Array of columns 
// Output:
// $0 (OBJECT) - JSON form definition
// ------------------------------------------------------------------
#DECLARE($choice : Text; $collumns : Collection)->$form : Object





C_LONGINT:C283($nCol; $nFields; $tableName; $fieldName; $width; $height; $i)
C_OBJECT:C1216($0; $page; $form; $obj)
C_OBJECT:C1216($colObj)
C_TEXT:C284($colName; $varName)
ARRAY OBJECT:C1221($arrCol; 0)

If (Count parameters:C259>1)
	Case of 
		: ($choice="Selection")  // Selection based
			ARRAY TEXT:C222($fldTitles; 0)
			ARRAY LONGINT:C221($fldNum; 0)
			GET FIELD TITLES:C804($dataPtr->; $fldTitles; $fldNum)
			
			$nFields:=Size of array:C274($fldTitles)
			$nCol:=$dataCol->
			
			If ($nCol>$nFields)
				$nCol:=$nFields
			End if 
			
		: ($choice="Array")  // Array based 
			$nCol:=Size of array:C274($dataPtr->)
			
		: (($choice="Collection") | ($choice="Entity"))  // Collection or Entity Based Collection
			$nCol:=Size of array:C274($dataCol->)
	End case 
	
	// Creating the Listbox column definition
	For ($i; 1; $nCol)
		
		Case of 
			: ($choice="selection")
				
				$colObj:=New object:C1471("objectName"; $fldTitles{$i}; "width"; Round:C94(Num:C11($width/$nCol); 0); \
					"dataSource"; "["+Table name:C256($dataPtr)+"]"+$fldTitles{$i}; "header"; \
					New object:C1471("text"; $fldTitles{$i}); "textAlign"; "center")
				
			: ($choice="array")
				$varName:=$dataPtr->{$i}
				
				$colObj:=New object:C1471("objectName"; $varName; "width"; Round:C94(Num:C11($width/$nCol); 0); "dataSource"; $varName; \
					"header"; New object:C1471("text"; $varName); "textAlign"; "center")
				
			: (($choice="collection") | ($choice="entity"))
				$varName:=$dataCol->{$i}
				
				$colObj:=New object:C1471("objectName"; $varName; "width"; Round:C94(Num:C11($width/$nCol); 0); "dataSource"; \
					$varName; "header"; New object:C1471("text"; $varName); "textAlign"; "center")
				
		End case 
		
		APPEND TO ARRAY:C911($arrCol; $colObj)
	End for 
	
	SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($colObj))
	
	// Creating the Listbox definition
	Case of 
			
		: ($choice="selection")
			$obj:=New object:C1471("type"; "listbox"; "listboxType"; "currentSelection"; \
				"table"; Table name:C256($dataPtr); \
				"left"; 0; "top"; 0; "width"; $width+15; "height"; $height)
			
		: ($choice="array")
			$obj:=New object:C1471("type"; "listbox"; "listboxType"; "array"; \
				"left"; 0; "top"; 0; "width"; $width+15; "height"; $height)
			
		: (($choice="collection") | ($choice="entity"))
			RESOLVE POINTER:C394($dataPtr; $colName; $tableName; $fieldName)
			$obj:=New object:C1471("type"; "listbox"; "listboxType"; "collection"; \
				"dataSource"; $colName; "left"; 0; "top"; 0; "width"; $width+15; "height"; $height)
	End case 
	
	
	
	// replace with writing into the json
	OB SET ARRAY:C1227($obj; "columns"; $arrCol)
	
	//$obj.columns:=New collection
	//$obj.columns
	$page:=New object:C1471("objects"; New object:C1471("LB_"+form_o.dataClassName; $obj))
	$form:=New object:C1471("pages"; New collection:C1472(Null:C1517; $page))
	
End if 
