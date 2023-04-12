//%attributes = {}

// Modified by: Bill James (2022-08-04T05:00:00Z)
// Method: LBX_SetListbox
// Description 
// Parameters
// ----------------------------------------------------

//Form:=New object("dataClassName"; "Customer"; "listboxName"; "LB_Selection")

LBX_DataBrowserSetTable(process_o.dataClassName; process_o.listboxName)

LBX_SetFieldPopup(ds:C1482[Form:C1466.dataClassName])

If (False:C215)
	// set Listbox, define values
	// Form.listbox entity selection
	// Form.listboxSelection is listbox to fill
	#DECLARE($listboxSelection : Text)
	var $fieldList : Text
	
	// name of the listbox
	Form:C1466.listboxSelection:=$listboxSelection  //
	
	var $dataClass : Object  // of the data source for the listbox
	$dataClass:=Form:C1466.LB_DataBrowser.source.getDataClass()
	
	var $object : Object
	// set to null for testing
	$object:=New object:C1471("columns"; Null:C1517)
	
	// this should already be set
	Form:C1466.dataClassName:=$dataClass.getInfo().name
	
	var $lbName : Text
	$lbName:=Form:C1466.listboxSelection
	// this is the name of the listbox
	LISTBOX DELETE COLUMN:C830(*; Form:C1466.listboxSelection; 1; 100)
	C_POINTER:C301($nullpointer)
	
	// OPTION 1: fill the listbox with a string of field names coming from Form.fieldlist
	If (Form:C1466.fieldList#Null:C1517)
		If (Form:C1466.fieldList#"")
			// add a role check to this
			var $columnFields : Collection
			$columnFields:=Split string:C1554(Form:C1466.fieldList; ";")
			For each ($property; $columnFields)
				$oneColumn:=LBX_ColumnFromName(Form:C1466.dataClassName; $property)
				If ($oneColumn#Null:C1517)
					$columns_c.push($oneColumn)
				End if 
			End for each 
			$object.columns:=$columns_c
			
			// look at creating an object for editing the structure of the listbox
			//Form.sfSelection:=cs.cEditSubForm
			//Form.sfSelection:=cs.cEditSubForm.new("SF_Selection"; "Customer")
			//Form.sfSelection.setLBFromCollection(Form.LB_Fields.sel.extract("fieldName"))
			//LBX_SelectionIfEmpty(Form.sfSelection.lbName; Form.form_o.dataClassName)
			//Form.sfSelection.setFieldPopUp()
		End if 
	End if 
	
	// OPTION 1: fill the collumns from a FieldCharacteristic record 
	If ($object.columns=Null:C1517)
		var $fc_o; $listbox_o : Object
		$fc_o:=ds:C1482.FC.query("purpose = :1 and tableName = :2"; "DataBrowser"; Form:C1466.dataClassName)
		// store the columns and entire listbox in data
		If (False:C215)
			$fc_o.drop()
			$fc_o:=New object:C1471
		End if 
		If ($fc_o.length>0)  // try to harvest the stored columns
			$rec_o:=$fc_o.first()
			If ($rec_o.data#Null:C1517)
				If ($rec_o.data[Form:C1466.listboxSelection]#Null:C1517)
					If ($rec_o.data[Form:C1466.listboxSelection].columns#Null:C1517)
						$object.columns:=$rec_o.data[Form:C1466.listboxSelection].columns
					End if 
					If ($rec_o.data[Form:C1466.listboxSelection].listbox#Null:C1517)
						$listbox_o:=$rec_o.data.listbox[Form:C1466.listboxSelection].listbox
					End if 
				End if 
			End if 
		End if 
	End if 
	
	// where 4D stores such things
	//$file:=File("/PACKAGE/Databrowser/"+Form.dataClassName+".myPrefs")
	
	If ($object.columns#Null:C1517)
		$counter:=0
		For each ($column_o; $object.columns)
			$counter:=$counter+1
			
			If ($column_o.dataSource=Null:C1517)
				$column_o.dataSource:=$column_o.formula
			End if 
			If ($column_o.fieldType=Null:C1517)
				$column_o.fieldType:=$dataClass[Substring:C12($column_o.dataSource; 6)].fieldType
			End if 
			LBX_ColumnSet(Form:C1466.listboxSelection; $counter; $column_o)
		End for each 
	Else   //($object.columns=Null)
		var $columns_c : Collection
		$columns_c:=New collection:C1472
		$counter:=0
		
		var $column_o : Object
		For each ($field; $dataClass) While ($counter<10)
			$fieldobject:=$dataClass[$field]
			If ($fieldobject.kind="storage")  // only show existing fields, not relations, not alias, not calculated
				If (($fieldobject.fieldType#Is BLOB:K8:12) & ($fieldobject.fieldType#Is object:K8:27))
					$counter:=$counter+1
					$column_o:=LBX_ColumnFromName(Form:C1466.dataClassName; $field)
					If ($column_o#Null:C1517)
						LBX_ColumnSet(Form:C1466.listboxSelection; $counter; $column_o)
					End if 
				End if 
			End if 
		End for each 
	End if 
End if 