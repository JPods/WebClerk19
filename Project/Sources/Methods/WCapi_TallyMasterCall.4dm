//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/10/21, 07:34:19
// ----------------------------------------------------
// Method: WCapi_TallyMasterCall
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($voRec)
$voRec:=ds:C1482.TallyMaster.query("purpose = :1 AND name = :2"; "WCapi"; voState.request.URL.pathNameTrimmed).first()
If ($voRec#Null:C1517)
	ExecuteText(0; $voRec.Script)
End if 