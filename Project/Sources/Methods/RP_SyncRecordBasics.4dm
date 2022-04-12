//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/02/18, 16:24:05
// ----------------------------------------------------
// Method: RP_SyncRecordBasics
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284(vWCPayload)

C_LONGINT:C283(<>viSaveWCPayLoad)
If (<>viSaveWCPayLoad=0)
	<>viSaveWCPayLoad:=1  // save both in [SyncRecord]ObReceived
	// 2 save in [SyncRecord]Body
	// 3 save in both
End if 

If (Record number:C243([SyncRecord:109])#New record:K29:1)
	CREATE RECORD:C68([SyncRecord:109])
End if 
[SyncRecord:109]idSyncRelation:49:=[SyncRelation:103]id:30
[SyncRecord:109]relationship:41:=[SyncRelation:103]name:8
[SyncRecord:109]syncRelationid:24:=[SyncRelation:103]idNum:1
//  need to change eventID to UUID
[SyncRecord:109]cookie:39:=String:C10(vleventID)
[SyncRecord:109]idEventLog:3:=vleventID
[SyncRecord:109]host:45:=vWCRequestHost

[SyncRecord:109]dtAction:2:=0
[SyncRecord:109]dtCreated:15:=DateTime_Enter
[SyncRecord:109]dtComplete:8:=0
[SyncRecord:109]date:26:=Current date:C33

[SyncRecord:109]statusSend:17:="received"
[SyncRecord:109]statusReceive:19:="Pending"
[SyncRecord:109]direction:29:="Receiving"

[SyncRecord:109]siteIDLocal:13:=Current machine:C483
[SyncRecord:109]size:38:=Length:C16(vWCPayload)
[SyncRecord:109]statusSend:17:="Received"
[SyncRecord:109]actionReceive:47:="NoActionTaken"

ON ERR CALL:C155("jOECNoAction")
[SyncRecord:109]pathToDocument:18:=Storage:C1525.folder.jitF+"SyncRecord"+Folder separator:K24:12+Date_strYyyymmdd+Folder separator:K24:12
CREATE FOLDER:C475([SyncRecord:109]pathToDocument:18; *)
[SyncRecord:109]pathToDocument:18:=Storage:C1525.folder.jitF+"SyncRecord"+Folder separator:K24:12+Date_strYyyymmdd+Folder separator:K24:12+"RECD"+String:C10([SyncRecord:109]idNum:1)+".txt"

// ### bj ### 20190126_0826

TEXT TO DOCUMENT:C1237([SyncRecord:109]pathToDocument:18; vWCPayload)
ON ERR CALL:C155("")