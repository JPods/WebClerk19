//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/02/18, 15:56:53
// ----------------------------------------------------
// Method: RP_ReceivedData
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($script)
RP_SyncRecordBasics

SAVE RECORD:C53([SyncRecord:109])
vResponse:="SyncRecordUniqueID="+String:C10([SyncRecord:109]idUnique:1)

$script:=[SyncRelation:103]ScriptSyncRecord:48
If ($script#"")
	ExecuteText(0; $script)
End if 

$0:=vResponse
