//%attributes = {}

// Modified by: Bill James (2023-04-12T05:00:00Z)
// Method: 19Convert_ExportAllData
// Description 
// Parameters
// ----------------------------------------------------

If (Count parameters:C259=3)
	C_TEXT:C284($1)  //tablename
	C_TEXT:C284($2)  //path of destination file
	//C_BOOLEAN($3)  //export all records
	//C_LONGINT($i)
	//C_TEXT($ref)
	//$ref:=DOM Create XML Ref("settings-import-export")
	//// Export the table "$1" in '4D' binary format, all the records or only the current selection
	//DOM SET XML ATTRIBUTE($ref; "table_no"; Table($1); "format"; "4D"; "all_records"; $3)
	//// Definition of fields to export
	//For ($i; 1; Get last field number($1))
	//If (Is field number valid($1; $i))
	//$elt:=DOM Create XML element($ref; "field"; "table_no"; Table($1); "field_no"; $i)
	//End if 
	//End for 
	//EXPORT DATA($2; $ref)
	//If (Ok=0)
	//ALERT("Error during export of table "+Table name($1))
	//End if 
	//DOM CLOSE XML($ref)
	var $rec_e; $sel_e : Object
	var $i; $lastField : Integer
	$sel_e:=ds:C1482[$1].all()
	For each ($rec_e; $sel_e)
		
	Else 
		C_TEXT:C284($ExportPath)
		C_LONGINT:C283($i)
		$ExportPath:=Select folder:C670("Please select the export folder:")
		If (Ok=1)
			For ($i; 1; Get last table number:C254)
				If (Is table number valid:C999($i))
					19Convert_ExportAllData(Table name:C256($i); $ExportPath+Table name:C256($i); True:C214)
				End if 
			End for 
		End if 
	End if 