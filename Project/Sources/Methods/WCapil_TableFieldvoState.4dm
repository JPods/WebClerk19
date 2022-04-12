//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/24/21, 16:56:33
// ----------------------------------------------------
// Method: WCapil_TableFieldvoState
// Description
// 
//
// Parameters
// ----------------------------------------------------
// defineds for testing tableName or fieldName depending
// fieldName is more restrictive
C_TEXT:C284($tableName; $vtFieldName)
ARRAY TEXT:C222($aURL; 0)
TextToArray(voState.url; ->$aURL; "/")
If (Size of array:C274($aURL)#3)
	vResponse:="Error: improper data for GetBy, requires /WCapi/tableName/fieldName: "+voState.url
Else 
	$tableName:=STR_FixCaseTableName($aURL{1})
	C_POINTER:C301($ptTable; $ptField)
	$ptTable:=STR_GetTablePointer($tableName)
	If (Is nil pointer:C315($ptTable))
		vResponse:="Error: tableName invalid in GetBy: "+$aURL{1}
	Else 
		$tableName:=Table name:C256($ptTable)
		$vtFieldName:=STR_FixCaseFieldName($tableName; $aURL{3})
		$ptField:=STR_GetFieldPointer($tableName; $vtFieldName)
		voState.working:=New object:C1471
		voState.working.tableName:=$tableName
		voState.working.tableNum:=Table:C252($ptField)
		If (Is nil pointer:C315($ptField))
			vResponse:="Error: fieldName invalid in GetBy: "+$aURL{3}
		Else 
			voState.working.fieldName:=$vtFieldName
			voState.working.fieldNum:=Field:C253($ptField)
			C_TEXT:C284($vtValue; $vtContains; $vtExact; $vtType)
		End if 
	End if 
End if 