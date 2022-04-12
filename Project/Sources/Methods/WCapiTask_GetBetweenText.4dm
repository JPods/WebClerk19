//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/08/21, 21:40:51
// ----------------------------------------------------
// Method: WCapiTask_GetBetweenText
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $tableName; $2; $vtFieldName; $3; $vtValue)
C_TEXT:C284($vtTableNameLC)
C_TEXT:C284($vtFieldNameLC)
C_LONGINT:C283($viTableNum; $viFieldNum)
C_OBJECT:C1216($voSelRecords)
If (($1="") | ($2="") | ($3=""))
	vResponse:="Error: values not provided, tableName: "+$1+", fieldName: "+$2+", value: "+$3
Else 
	$ptTable:=STR_GetTablePointer($1)
	If (Is nil pointer:C315($ptTable))
		vResponse:="Error: Invalid tableName: "+$1
	Else 
		$ptField:=STR_GetFieldPointer($1; $2)
		If (Is nil pointer:C315($ptField))
			vResponse:="Error: Invalid fieldName: "+$2
		Else 
			$tableName:=Table name:C256($ptTable)
			$vtFieldName:=Field name:C257($ptField)
			$vtFieldName:=Substring:C12($vtFieldName; Position:C15("]"; $vtFieldName)+1)
			C_OBJECT:C1216($voSelection)
			$voSelRecords:=ds:C1482[$tableName].query($vtFieldName+" >= :1 AND <= :1 "; $3)
			If ($voSelection.length=0)
				vResponse:="[]"
			Else 
				$vtRole:="Sales"
				$vtPurpose:="list"
				$vtFieldList:=API_GetFieldList($tableName; $vtRole; $vtPurpose)
				vResponse:=API_EntityToText($voSelection; $vtFieldList)
			End if 
		End if 
	End if 
End if 

