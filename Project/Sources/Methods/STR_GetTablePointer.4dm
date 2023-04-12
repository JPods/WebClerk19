//%attributes = {}
// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 09/13/19, 14:30:44
// ----------------------------------------------------
// Method: STR_GetTablePointer
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //
#DECLARE($tableName_t : Text)->$ptTable : Pointer
$ptTable:=Null:C1517

// may want to remove. Good for web
$tableName_t:=STR_FixCaseTableName($tableName_t)

If (ds:C1482[$tableName_t]#Null:C1517)
	$ptTable:=Table:C252(ds:C1482[$tableName_t].getInfo().tableNumber)
End if 
