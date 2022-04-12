//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 06/19/20, 23:02:07
// ----------------------------------------------------
// Method: KeyWordsMakeAllTables
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($incTables; $cntTables; $i; $k)
C_POINTER:C301($ptTable)
C_TEXT:C284($tableName)
$cntTables:=Get last table number:C254
For ($incTables; 1; $cntTables)
	$ptTable:=Table:C252($incTables)
	$tableName:=Table name:C256($incTables)
	ALL RECORDS:C47($ptTable->)
	FIRST RECORD:C50($ptTable->)
	$k:=Records in selection:C76($ptTable->)
	$ptFieldOb:=STR_GetFieldPointer($tableName; "ObGeneral")
	If (Not:C34(Is nil pointer:C315($ptFieldOb)))
		For ($i; 1; $k)
			KeyWordsMake($ptTable)
			SAVE RECORD:C53($ptTable->)
			NEXT RECORD:C51($ptTable->)
		End for 
		REDUCE SELECTION:C351($ptTable->; 0)
	End if 
End for 
ALERT:C41("Keywords added for all tables")


