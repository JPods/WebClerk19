//%attributes = {}

// Modified by: Bill James (2022-05-26T05:00:00Z)
// Method: Edit_FieldNamestoText
// Description 
// Parameters
// ----------------------------------------------------


#DECLARE($data : Collection; $lable : Text; $insertInTo : Text; $lead : Text)->$return : Text

$return:=$insertInTo
var $fieldName; $insert_t : Text
var $row : Object
For each ($row; $data)
	$return:=$lead+$row[$lable]+Storage:C1525.char.cr+$return
End for each 
