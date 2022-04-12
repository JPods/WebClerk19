
// Modified by: Bill James (2021-12-09T06:00:00Z)
// Method: oLoHeader.bAdd1
// Description 
// Parameters
// ----------------------------------------------------
var $1; tableName; $tableName; $id : Text
Case of 
	: (tableName#"")
		$tableName:=tableName
	: (ptCurTable#Null:C1517)
		$tableName:=Table name:C256(ptCurTable)
		If (Record number:C243(ptCurTable->)#-1)
			$id:=STR_Get_idPointer($tableName)->
		End if 
End case 
Process_AddRecord($tableName)
