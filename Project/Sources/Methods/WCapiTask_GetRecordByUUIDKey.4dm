//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/29/20, 17:57:40
// ----------------------------------------------------
// Method: WCapiTask_GetRecordByUUIDKey
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($tableName; $vtUUIDKey)
C_POINTER:C301($ptTable)
C_TEXT:C284($vtUUIDKey)
C_OBJECT:C1216($voRecord; $voSelection; $voField; $voOutput)
$tableName:=WCapi_GetParameter("tableName")
$ptTable:=STR_GetTablePointer($tableName)

If (Is nil pointer:C315($ptTable))
	vResponse:="Error: tableName not valid: "+$tableName
Else 
	$vtUUIDKey:=WCapi_GetParameter("id")
	If (Length:C16($vtUUIDKey)<20)
		vResponse:="Error: id is not provided: "+$vtUUIDKey
	Else 
		
		$voRecord:=New object:C1471
		$voRecord:=ds:C1482[$tableName].query("id = :1"; $vtUUIDKey).first()
		If ($voRecord=Null:C1517)
			vResponse:="Error: No record for tableName: "+$tableName+", id: "+$vtUUIDKey
		Else 
			vResponse:=WCapiTask_RecordToObject($tableName; $voRecord)  // $voSelection[0])  before using .first()
		End if 
	End if 
End if 