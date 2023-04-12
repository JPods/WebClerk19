//%attributes = {}

// Modified by: Bill James (2022-01-21T06:00:00Z)
// Method: DB_NewEntityDefaults
// Description 
// Parameters
// ----------------------------------------------------
#DECLARE($tableName : Text)->$entry_o : Object
var entry_o; $rec_o; $o : Object
If ($tableName="")
	If (process_o.dataClassName#Null:C1517)
		$tableName:=process_o.dataClassName
	End if 
End if 
