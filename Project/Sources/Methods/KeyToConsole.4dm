//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/22/21, 11:54:23
// ----------------------------------------------------
// Method: KeyToConsole
// Description
// UUIDKey_ToConsoleMessage
//UUIDKeyToConsoleMessage
// Parameters
// ----------------------------------------------------



C_TEXT:C284($tableName; $vtUUIDKey)
$tableName:=Table name:C256(ptCurTable)
C_POINTER:C301($ptUUIDKey)
$ptUUIDKey:=STR_GetFieldPointer($tableName; "id")
If (Is nil pointer:C315($ptUUIDKey))
	ConsoleMessage("No id for Table: "+$tableName)
Else 
	ConsoleMessage("id record in Table: "+$tableName+": "+$ptUUIDKey->)
End if 