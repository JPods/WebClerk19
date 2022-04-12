//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/13/12, 01:12:52
// ----------------------------------------------------
// Method: RP_LoadVariablesRelationship
// Description
// 
//
// Parameters
// ----------------------------------------------------

//HTTP_TestMode:=1 set in test mode
//HTTP_TimeOut:=10//seconds
//HTTP_Protocol:="https"//process as SSL
//HTTP_Method:="Post"  //method of sending
//HTTP_Path:=<>tcCCVerURL//Server command
//HTTP_Host:=<>tcCCVerHost//Server manchine
//HTTP_Port:=<>tcCCVerPort//the Port
//HTTP_BlobSendData  //data to send
//HTTP_BlobReceive   //data received back
// HTTP_APIKey   // Key to access account
// vWCPayload  and vDataReceived are dual // The Return Text


C_TEXT:C284($1; $path)
If (Count parameters:C259=1)
	$path:=$1
Else 
	$path:=""
End if 

vUsername:=[SyncRelation:103]RemoteUserName:3
vPassword:=[SyncRelation:103]RemoteUserPassword:4
HTTP_Protocol:=[SyncRelation:103]Protocol:52
HTTP_Port:=[SyncRelation:103]PortProduction:9
If ([SyncRelation:103]PartnerNumber:14=2)
	HTTP_Host:=[SyncRelation:103]Partner1URL:2
Else 
	HTTP_Host:=[SyncRelation:103]Partner2URL:33
End if 

If ([SyncRelation:103]Command:41="/RP_json@")
	HTTP_Path:="/RP_json"+[SyncRelation:103]id:30
Else 
	HTTP_Path:=[SyncRelation:103]Command:41
End if 

HTTP_TimeOut:=[SyncRelation:103]TimeOut:16
HTTP_APIKey:=[SyncRelation:103]Pin:40
vScript:=[SyncRelation:103]ScriptBefore:7


// when called outside Record Passing, this should already be the same
// depending on which was used to retrieve the record
vUniqueID:=[SyncRelation:103]idUnique:1
vtRPUUIDKey:=[SyncRelation:103]id:30

// vScript:=[SyncRelation]TallyMastersScript
If ($path="")
	RP_BuildHTTPURL
Else 
	RP_BuildHTTPURL($path)
End if 


