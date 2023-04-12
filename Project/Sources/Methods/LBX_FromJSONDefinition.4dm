//%attributes = {}

// Modified by: Bill James (2022-05-27T05:00:00Z)
// Method: LBX_FromJSONDefinition
// Description 
// Parameters
// ----------------------------------------------------


// -----------------------------------------------------------------
// Name: generateListboxFormJSONDef
// Description: Method will create a JSON form definition containing
// a Listbox object specifying the type and data source.
// From: DynamicListBoxFormDemo
// Input Parameters:
// $1 (LONGINT) - Choice of Listbox type
//                1 - Selection based 
//                2 - Array based 
//                3 - Collection based 
//                4 - Entity Selection based 
// $2 (POINTER) - Datasource (Table selection, Array,
//                            Collection, or Entity Selection) 
// $3 (POINTER) - Number of columns or Array of columns 
// Output:
// $0 (OBJECT) - JSON form definition
// ------------------------------------------------------------------
C_LONGINT:C283($1; $choice)
C_POINTER:C301($2; $dataPtr)
C_POINTER:C301($3; $dataCol)
C_LONGINT:C283($nCol; $nFields; $tableName; $fieldName; $width; $height; $i)
C_OBJECT:C1216($0; $page; $form; $obj)
C_OBJECT:C1216($colObj)
C_TEXT:C284($colName; $varName)
ARRAY OBJECT:C1221($arrCol; 0)

If (Count parameters:C259>1)
	
	$choice:=$1
	$dataPtr:=$2
	$dataCol:=$3
	
	Case of 
		: ($choice=1)  // Selection based
			ARRAY TEXT:C222($fldTitles; 0)
			ARRAY LONGINT:C221($fldNum; 0)
			GET FIELD TITLES:C804($dataPtr->; $fldTitles; $fldNum)
			
			$nFields:=Size of array:C274($fldTitles)
			$nCol:=$dataCol->
			
			If ($nCol>$nFields)
				$nCol:=$nFields
			End if 
			
		: ($choice=2)  // Array based 
			$nCol:=Size of array:C274($dataPtr->)
			
		: (($choice=3) | ($choice=4))  // Collection or Entity Based Collection
			$nCol:=Size of array:C274($dataCol->)
	End case 
	
	OBJECT GET COORDINATES:C663((OBJECT Get pointer:C1124(Object named:K67:5; "Subform"))->; $left; $top; $right; $bottom)
	$width:=$right-$left
	$height:=$bottom-$top
	
	// Creating the Listbox column definition
	For ($i; 1; $nCol)
		
		Case of 
			: ($choice=1)
				
				$colObj:=New object:C1471("objectName"; $fldTitles{$i}; "width"; Round:C94(Num:C11($width/$nCol); 0); \
					"dataSource"; "["+Table name:C256($dataPtr)+"]"+$fldTitles{$i}; "header"; \
					New object:C1471("text"; $fldTitles{$i}); "textAlign"; "center")
				
			: ($choice=2)
				$varName:=$dataPtr->{$i}
				
				$colObj:=New object:C1471("objectName"; $varName; "width"; Round:C94(Num:C11($width/$nCol); 0); "dataSource"; $varName; \
					"header"; New object:C1471("text"; $varName); "textAlign"; "center")
				
			: (($choice=3) | ($choice=4))
				$varName:=$dataCol->{$i}
				
				$colObj:=New object:C1471("objectName"; $varName; "width"; Round:C94(Num:C11($width/$nCol); 0); "dataSource"; \
					$varName; "header"; New object:C1471("text"; $varName); "textAlign"; "center")
				
		End case 
		
		APPEND TO ARRAY:C911($arrCol; $colObj)
	End for 
	
	// Creating the Listbox definition
	Case of 
			
		: ($choice=1)
			$obj:=New object:C1471("type"; "listbox"; "listboxType"; "currentSelection"; \
				"table"; Table name:C256($dataPtr); \
				"left"; 0; "top"; 0; "width"; $width+15; "height"; $height)
			
		: ($choice=2)
			$obj:=New object:C1471("type"; "listbox"; "listboxType"; "array"; \
				"left"; 0; "top"; 0; "width"; $width+15; "height"; $height)
			
		: (($choice=3) | ($choice=4))
			RESOLVE POINTER:C394($dataPtr; $colName; $tableName; $fieldName)
			$obj:=New object:C1471("type"; "listbox"; "listboxType"; "collection"; \
				"dataSource"; $colName; "left"; 0; "top"; 0; "width"; $width+15; "height"; $height)
	End case 
	
	OB SET ARRAY:C1227($obj; "columns"; $arrCol)
	$page:=New object:C1471("objects"; New object:C1471("myListBox"; $obj))
	$form:=New object:C1471("pages"; New collection:C1472(Null:C1517; $page))
	
	$0:=$form
End if 