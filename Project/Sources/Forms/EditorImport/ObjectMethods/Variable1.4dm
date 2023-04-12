
C_POINTER:C301($1; $ptTable)  //table
C_TEXT:C284($2; $vtPath)  //path of destination file
C_BOOLEAN:C305($3; $bAll)  //export all records

If (Count parameters:C259=3)
	$ptTable:=$1
	$vtPath:=$2
	$bAll:=$3
Else 
	$ptTable:=ptCurTable
	$vtPath:=Storage:C1525.folder.jitF+"zzzTestExport.txt"
	$bAll:=False:C215
End if 


C_LONGINT:C283($i; $cntFields; $viFieldNum)
C_TEXT:C284($ref)
$ref:=DOM Create XML Ref:C861("settings-import-export")
// Export the table "$ptTable" in '4D' binary format, all the records or only the current selection
DOM SET XML ATTRIBUTE:C866($ref; "table_no"; Table:C252($ptTable); "format"; "4D"; "all_records"; $bAll)
// Definition of fields to export
$cntFields:=Size of array:C274(aMatchField)
For ($i; 1; $cntFields)
	$viFieldNum:=aMatchNum{$i}
	If (Is field number valid:C1000($ptTable; aMatchNum{$i}))
		$elt:=DOM Create XML element:C865($ref; "field"; "table_no"; Table:C252($ptTable); "field_no"; aMatchNum{$i})
	End if 
End for 
EXPORT DATA:C666($vtPath; $ref)
If (Ok=0)
	ALERT:C41("Error during export of table "+Table name:C256($ptTable))
End if 
DOM CLOSE XML:C722($ref)