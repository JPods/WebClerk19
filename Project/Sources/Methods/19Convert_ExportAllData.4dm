//%attributes = {}

// Modified by: Bill James (2023-04-12T05:00:00Z)
// Method: 19Convert_ExportAllData
// Description 
// Parameters
// ----------------------------------------------------
#DECLARE($tableName : Text; $path : Text; $output_t : Text)
If (Count parameters:C259=3)
	Case of 
		: ($output_t="xml")
			C_LONGINT:C283($i)
			C_TEXT:C284($ref)
			$ref:=DOM Create XML Ref:C861("settings-import-export")
			var $tableNum_i : Integer
			$tableNum_i:=ds:C1482[$tableName].getInfo().tableNumber
			// Export the table "$1" in '4D' binary format, all the records or only the current selection
			DOM SET XML ATTRIBUTE:C866($ref; "table_no"; $tableNum_i; "format"; "4D"; "all_records"; $3)
			// Definition of fields to export
			For ($i; 1; Get last field number:C255($tableNum_i))
				If (Is field number valid:C1000($tableNum_i; $i))
					$elt:=DOM Create XML element:C865($ref; "field"; "table_no"; $tableNum_i; "field_no"; $i)
				End if 
			End for 
			EXPORT DATA:C666($path; $ref)
			If (Ok=0)
				ALERT:C41("Error during export of table "+$tableName)
			End if 
			DOM CLOSE XML:C722($ref)
		Else 
			var $rec_e; $sel_e : Object
			var $i; $lastField : Integer
			var $c : Collection
			var $export_t : Text
			var $docRef_h : Time
			$sel_e:=ds:C1482[$tableName].all()
			$c:=$sel_e.toCollection()
			$export_t:=JSON Stringify:C1217($c)
			$docRef_h:=Create document:C266($path+".txt")
			CLOSE DOCUMENT:C267($docRef_h)
			TEXT TO DOCUMENT:C1237(Document; $export_t)
	End case 
Else 
	C_TEXT:C284($ExportPath; $tableName)
	C_LONGINT:C283($i)
	$ExportPath:=Select folder:C670("Please select the export folder:")
	If (Ok=1)
		For ($i; 1; Get last table number:C254)
			If (Is table number valid:C999($i))
				$tableName:=Table name:C256($i)
				19Convert_ExportAllData($tableName; $ExportPath+$tableName; "")
			End if 
		End for 
	End if 
End if 