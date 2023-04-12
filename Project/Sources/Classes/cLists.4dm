Class constructor($name : Text)
	
	
Function setListToText($data : Object; $lable : Text)->$return : Text
	
	var $fieldName; $insert_t : Text
	var $row : Object
	For each ($row; $data)
		$return:=$row[$lable]+Storage:C1525.char.cr+vTextSummary
	End for each 
	
	
Function setList
	var $fieldName; $insert_t : Text
	var $row : Object
	For each ($row; $data)
		$return:=$row[$lable]+Storage:C1525.char.cr+vTextSummary
	End for each 
	