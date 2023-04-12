//%attributes = {}

// Modified by: Bill James (2023-01-07T06:00:00Z)
// Method: 19CVT_HarvestForm
// Description 
// Parameters
// ----------------------------------------------------
#DECLARE($dataClassName : Text; $formName : Text)->$fields_c : Collection
var $foldersDS_c; $folderTables_c; $folderForms_c; $forms_c; $ind_c; $indForm_c : Collection
var $tableString; $tableName : Text
var $foldersDS_o; $folderTable_o; $folderForm_o; $folderWork_o; $page_o; $output_o : Object
var $index : Integer
var $form_t : Text
var $form_o : Object

var $f_Resources; $f_TableForms : Object
$f_Resources:=Folder:C1567(fk resources folder:K87:11)
$path_t:=Folder:C1567(fk resources folder:K87:11).platformPath
$path_t:=Substring:C12($path_t; 1; Length:C16($path_t)-1)
var $c : Collection
$c:=Split string:C1554($path_t; Folder separator:K24:12)
$c.remove($c.length-1)
$c.push("Sources")
$c.push("TableForms")
$path_t:=$c.join(Folder separator:K24:12)
$foldersDS_o:=Folder:C1567($path_t; fk platform path:K87:2)
$foldersDS_c:=$foldersDS_o.folders()


// UpdateWithResources by: Bill James (2023-01-07T06:00:00Z)
// loop through to get the correct tablenum text labled folder
// then work it

// using 19CVT_BuildFC to build FC records

For each ($page_o; $form_o.pages)
	For each ($property_t; $page_o.objects)
		If ($property_t="Field@")
			$tempTable:=Substring:C12($page_o.objects[$property_t].dataSource; \
				2; \
				Position:C15(":"; $page_o.objects[$property_t].dataSource)-2)
			If ($tempTable=$tableName)
				$field_t:=Substring:C12($page_o.objects[$property_t].dataSource; \
					Position:C15("]"; $page_o.objects[$property_t].dataSource)+1)
				$fields_c.push(Substring:C12($field_t; 1; Position:C15(":"; $field_t)-1))
			End if 
		End if 
	End for each 
End for each 
