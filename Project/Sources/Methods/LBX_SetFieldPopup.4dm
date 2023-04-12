//%attributes = {}

// Modified by: Bill James (2022-07-23T05:00:00Z)
// Method: LBX_SetFieldPopup
// Description 
// Parameters
// ----------------------------------------------------

// list of all the fields in the table that are not
//  blobs, pictures, objects


C_OBJECT:C1216($1; $table)
$table:=$1

ARRAY TEXT:C222($fieldlist; 0)
APPEND TO ARRAY:C911($fieldlist; "All index fields")
APPEND TO ARRAY:C911($fieldlist; "-")
For each ($field; $table)
	$fieldobject:=$table[$field]
	// storage to avoid relationships  
	//https://vimeo.com/724419680 at minute 50 to run query on server by adding an extention to the dataClass
	If (($fieldobject.kind="storage") | ($fieldobject.kind="calculated") | ($fieldobject.kind="alias"))
		If (($fieldobject.fieldType#Is BLOB:K8:12) & ($fieldobject.fieldType#Is object:K8:27) & ($fieldobject.fieldType#Is picture:K8:10))
			APPEND TO ARRAY:C911($fieldlist; $field)
		End if 
	End if 
End for each 
If ($ptr=Null:C1517)
	
Else 
	$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "fieldlist")
	COPY ARRAY:C226($fieldlist; $ptr->)
	$ptr->:=1
End if 
