//%attributes = {}
  //The purpose of this method is to prepare the different listboxes used to allow data entry and modification of Object Fields.
  //This is applied only onto the fields used for this specific purpose.
  //The list of these fields has been put into the Form.objectFieldsList collection during the on Load of the form


C_COLLECTION:C1488($collection;$objectsNames)
C_OBJECT:C1216($entity)
C_TEXT:C284($object)

$entity:=$1

$isNew:=Bool:C1537($entity.isNew())
For each ($editor;Form:C1466.objectEditors)
	If ($isNew)
		Form:C1466.data_:=New collection:C1472  //The data source of the listbox is always "data_"
	End if 
	$editor.show()
End for each 

Util_EntityLoad_Specific ($isNew)  //This is where we apply some specific processing depending on the DataClass


