//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/13/21, 17:42:35
// ----------------------------------------------------
// Method: STR_GetTableNumber
// Description
// 
//
// Parameters
// ----------------------------------------------------
#DECLARE($tableName_t : Text)->$tableNum_i : Integer
$tableNum_i:=-1
If (ds:C1482[$tableName_t]#Null:C1517)
	$tableNum_i:=ds:C1482[$tableName_t].getInfo().tableNumber
End if 
