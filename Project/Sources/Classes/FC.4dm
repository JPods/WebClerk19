Class extends DataClass

Function setInit($dataClassName : Text; $purpose : Text; $ref_o : Object)
	
	This:C1470.tableNum:=$dataClassName
	This:C1470.purpose:=$purpose
	This:C1470.data:=New object:C1471
	
	
Function findPurpose($purpose : Text; $tableName : Text)->$sel : cs:C1710.FieldCharacteristicSelection
	
	$sel:=This:C1470.query("purpose = :1 and tableName = :2"; $purpose; $tableName)
	
	