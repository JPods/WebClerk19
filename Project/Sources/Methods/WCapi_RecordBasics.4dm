//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/09/21, 20:57:54
// ----------------------------------------------------
// Method: WCapi_RecordBasics
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301(ptCurTable; $ptTable; $ptField)
C_LONGINT:C283($viTableNum; $viFieldNum)
C_TEXT:C284($tableName; $vtTableNameLC; $vtFieldName; $value; $vtUUIDKey)
vResponse:="Error: Record call not valid."
$tableName:=WCapi_GetParameter("tableName"; "")
If ($tableName="")
	$tableName:=WCapi_GetParameter("table"; "")
End if 
$ptTable:=STR_GetTablePointer($tableName)
If (Is nil pointer:C315($ptTable))
	vResponse:="Error: No valid TableName, "+$tableName
Else 
	$viTableNum:=Table:C252($ptTable)
	$vtTableNameLC:=Lowercase:C14($tableName)
	$vtUUIDKey:=WCapi_GetParameter("id"; "")
	If (Length:C16($vtUUIDKey)<20)
		vResponse:="Error: Invalid id, "+$vtUUIDKey
	Else 
		$ptField:=STR_GetUniqueFieldPointer($tableName)
		
		C_OBJECT:C1216($voSelTable; $voRecord)
		$voSelTable:=ds:C1482[$tableName].query("id = :1"; $vtUUIDKey)
		If ($voSelTable.length=0)
			vResponse:="Error: No such record table "+$tableName+", id, "+$vtUUIDKey
			Case of 
				: (voState.url="/get")
					
				: (voState.url="/save")
					
					
				: (voState.url="/delete")
					
					
				: (voState.url="/clone")
					
					
				: (voState.url="/retire")
					
				: (voState.url="/document")
					
				: (voState.url="/new")
					vResponse:="Error: WCapi/record/new is not yet a feature, "+$tableName
			End case 
		End if 
	End if 
End if 