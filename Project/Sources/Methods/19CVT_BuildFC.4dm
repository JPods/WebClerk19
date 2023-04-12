//%attributes = {}

// Modified by: Bill James (2023-01-07T06:00:00Z)
// Method: 19CVT_BuildFC
// Description 
// Parameters
// ----------------------------------------------------


//If (False)
var $foldersDS_c; $folderTables_c; $folderForms_c; $forms_c; $ind_c; $indForm_c : Collection
var $tableString; $tableName : Text
var $foldersDS_o; $folderTable_o; $folderForm_o; $folderWork_o; $page_o; $output_o : Object
var $index : Integer
var $form_t : Text
var $form_o : Object
var $fieldName_t : Text




var $sel; $rec : Object
$sel:=ds:C1482.FC.all()
//$sel.drop()
For each ($rec; $sel)
	$rec.role:="admin"
	$rec.purpose:="DataBrowser"
	$result:=$rec.save()
End for each 

// HOWTO:Files
// HOWTO:Folders
// KEEP
$output_o:=New object:C1471
ON ERR CALL:C155("jOECNoAction")
//$tableName:=Table name(Num("153"))

$sel:=ds:C1482.FC.all()
$sel.drop()

$path:="/Users/williamjames/Documents/CommerceExpert/00WebClerk19/Project/Sources/TableForms"
$foldersDS_o:=Folder:C1567($path; fk posix path:K87:1)
$foldersDS_c:=$foldersDS_o.folders()
For each ($folderTable_o; $foldersDS_c)
	
	
	
	$tableName:=Table name:C256(Num:C11($folderTable_o.name))
	Case of 
		: ($tableName="")
			
		: ($tableName="zz@")
			
		Else 
			var $usedList_c; $usedEntry_c : Collection
			var $noEdit_c : Collection
			
			$usedList_c:=New collection:C1472
			$usedEntry_c:=New collection:C1472
			var $noEdit_c : Collection
			$noEdit_c:=New collection:C1472
			$noEdit_c:=Split string:C1554("id,idNum,customerID,vendorID"; ";")
			var $fieldNames : Text
			$fieldNames:=STR_GetFieldNames($tableName)
			var $fieldCheck_c : Collection
			$fieldCheck_c:=Split string:C1554($fieldNames; ";")
			
			var $i : Integer
			
			
			$output_o[$tableName]:=New object:C1471("list"; New collection:C1472; "entry"; New collection:C1472)
			$folderForms_c:=$folderTable_o.folders()
			$ind_c:=$folderForms_c.indices("name = Output")
			If ($ind_c.length>0)
				$folderWork_o:=$folderForms_c[$ind_c[0]]
				$forms_c:=$folderWork_o.files()
				$indForm_c:=$forms_c.indices("name = form")
				If ($indForm_c.length>0)
					$form_t:=$forms_c[$indForm_c[0]].getText()
					$form_o:=JSON Parse:C1218($form_t)
					var $fields_c : Collection
					$fields_c:=New collection:C1472
					For each ($page_o; $form_o.pages)
						If ($page_o#Null:C1517)
							For each ($property_t; $page_o.objects)
								//If ($property_t="Field@")
								If ($page_o.objects[$property_t].dataSource#Null:C1517)
									If (Position:C15("["; $page_o.objects[$property_t].dataSource)>0)
										$tempTable:=Substring:C12($page_o.objects[$property_t].dataSource; \
											2; \
											Position:C15(":"; $page_o.objects[$property_t].dataSource)-2)
										If ($tempTable=$tableName)  // see if it is from this table
											$field_t:=Substring:C12($page_o.objects[$property_t].dataSource; \
												Position:C15("]"; $page_o.objects[$property_t].dataSource)+1)
											
											$field_t:=Substring:C12($field_t; 1; Position:C15(":"; $field_t)-1)
											
											$i:=$fieldCheck_c.indexOf($field_t)  // correct for case
											If ($i>-1)
												$field_t:=$fieldCheck_c[$i]
												
												If ($fields_c.indexOf($field_t)=-1)  // avoid duplicates
													$fields_c.push($field_t)
													
													If ($noEdit_c.indexOf($field_t)>-1)  // add to noEdit
														$noEdit_c.push($field_t)
													End if 
												End if 
											End if 
										End if 
									End if 
								End if 
							End for each 
						End if 
					End for each 
				End if 
			End if 
			$output_o[$tableName].list:=$fields_c
			$ind_c:=$folderForms_c.indices("name = Input")
			If ($ind_c.length>0)
				$folderWork_o:=$folderForms_c[$ind_c[0]]
				$forms_c:=$folderWork_o.files()
				$indForm_c:=$forms_c.indices("name = form")
				If ($indForm_c.length>0)
					$form_t:=$forms_c[$indForm_c[0]].getText()
					$form_o:=JSON Parse:C1218($form_t)
					var $fields_c : Collection
					$fields_c:=New collection:C1472
					For each ($page_o; $form_o.pages)
						If ($page_o#Null:C1517)
							
							
							For each ($property_t; $page_o.objects)
								//If ($property_t="Field@")
								If ($page_o.objects[$property_t].dataSource#Null:C1517)
									If (Position:C15("["; $page_o.objects[$property_t].dataSource)>0)
										$tempTable:=Substring:C12($page_o.objects[$property_t].dataSource; \
											2; \
											Position:C15(":"; $page_o.objects[$property_t].dataSource)-2)
										If ($tempTable=$tableName)  // see if it is from this table
											$field_t:=Substring:C12($page_o.objects[$property_t].dataSource; \
												Position:C15("]"; $page_o.objects[$property_t].dataSource)+1)
											
											$field_t:=Substring:C12($field_t; 1; Position:C15(":"; $field_t)-1)
											
											$i:=$fieldCheck_c.indexOf($field_t)  // correct for case
											If ($i>-1)
												$field_t:=$fieldCheck_c[$i]
												
												If ($fields_c.indexOf($field_t)=-1)  // avoid duplicates
													$fields_c.push($field_t)
													
													If ($noEdit_c.indexOf($field_t)>-1)  // add to noEdit
														$noEdit_c.push($field_t)
													End if 
												End if 
											End if 
										End if 
									End if 
								End if 
							End for each 
							
							
							
						End if 
					End for each 
				End if 
			End if 
			$output_o[$tableName].entry:=$fields_c
			
			
			// separate the Form from the listbox from the data entry FC records
			// this is more records but allows for mixing behaviors for multiple listboxes and entry areas
			// purpose is the Form name, role sets field characteristics, name is the subform or listbox
			//zzz
			var $input_o : Object
			$input_o:=New object:C1471
			$input_o.purpose:="DataBrowser"
			$input_o.dataClassName:=$tableName
			$input_o.name:="LB_Databrowser"  // for listbox or listbox subform
			$input_o.view:="default"
			$input_o.role:="admin"
			$input_o.editNo:=$noEdit_c.distinct().orderBy().join(";")
			$input_o.fields:=$output_o[$tableName].list.join(";")
			// for listbox
			$fcRec:=STR_FCGet($input_o; True:C214)
			
			$input_o:=New object:C1471
			$input_o:=New object:C1471
			$input_o.purpose:="DataBrowser"
			$input_o.dataClassName:=$tableName
			$input_o.name:="SF_cur"  // for listbox or listbox subform
			$input_o.role:="admin"
			$input_o.view:="default"
			$input_o.editNo:=$noEdit_c.distinct().orderBy().join(";")
			$input_o.fields:=$output_o[$tableName].entry.join(";")
			$fcRec:=STR_FCGet($input_o; True:C214)
			
	End case 
End for each 

SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($output_o))

ON ERR CALL:C155("")