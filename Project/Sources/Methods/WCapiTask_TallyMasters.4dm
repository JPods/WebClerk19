//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/12/21, 22:59:34
// ----------------------------------------------------
// Method: WCapiTask_TallyMasters
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($voTallyMaster)
C_TEXT:C284($vtURL; $tableName)
C_POINTER:C301($ptTable)
C_LONGINT:C283($viTableNum)
vResponse:="Error: No TallyMasters record: "
If (voState.request.pathname.trimmed#Null:C1517)
	$vtURL:=voState.request.pathname.trimmed
	vResponse:=vResponse+$vtURL
	$tableName:=WCapi_GetParameter("tableName")
	$ptTable:=STR_GetTablePointer($tableName)
	If (Not:C34(Is nil pointer:C315($ptTable)))
		vResponse:=vResponse+", tableName: "+$tableName
		$viTableNum:=Table:C252($ptTable)
		$voTallyMaster:=ds:C1482.TallyMaster.query("purpose = :1 AND name = :2 AND tableNum = :3 "; "WCapi"; $vtURL; $viTableNum)
		If ($voTallyMaster.length>0)
			vResponse:=""
			ExecuteText(0; $voTallyMaster[0].script)
		End if 
	End if 
End if 