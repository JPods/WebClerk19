//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/14/21, 23:06:28
// ----------------------------------------------------
// Method: WCapiTask_GetByUnique
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_OBJECT:C1216($voFieldDefinition)
C_TEXT:C284($tableName; $vtTableNameLC; $vtFieldNameUnique)
C_POINTER:C301($ptTable; $ptUUIDKey)
$tableName:=WCapi_GetParameter("tableName")
If ($tableName="")
	vResponse:="Error: Missing tableName"
Else 
	$ptTable:=STR_GetTablePointer($tableName)
	If (Is nil pointer:C315($ptTable))
		vResponse:="Error: Table not valid: "+$tableName
	Else 
		C_TEXT:C284($vtType; $vtQueryValue)
		C_POINTER:C301($ptTable; $ptField)
		C_OBJECT:C1216($voRecord; $voSelection)
		$vtFieldNameUnique:=STR_GetUniqueFieldName($tableName)
		$vtType:=STR_GetFieldTypeWeb($tableName; $vtFieldNameUnique)
		$voFieldDefinition:=STR_GetFieldDefinition($tableName; $vtFieldNameUnique)
		$ptField:=STR_GetFieldPointer($tableName; $vtFieldNameUnique)
		//
		$vtQueryValue:=WCapi_GetParameter($vtFieldNameUnique; "")  // in value pairs
		If ($voFieldDefinition.type="Longint")
			$voSelection:=ds:C1482[$tableName].query($vtFieldNameUnique+" = :1 "; Num:C11($vtQueryValue))
		Else 
			$voSelection:=ds:C1482[$tableName].query($vtFieldNameUnique+" = :1 "; $vtQueryValue)
		End if 
		If ($voSelection.length=0)
			vResponse:="Error: No record for tableName: "+$tableName+", id: "+$vtUUIDKey
		Else 
			TRACE:C157
			vResponse:=WCapiTask_RecordToObject($tableName; $voSelection.first())
		End if 
	End if 
End if 