//%attributes = {}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/29/18, 01:28:38
// ----------------------------------------------------
// Method: RP_SyncRecordSending
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($tableNum)
C_TEXT:C284($tableName; $vtHeader)
C_LONGINT:C283($1; $size)

If (Count parameters:C259>0)
	$size:=$1
End if 


[SyncRelation:103]countUse:22:=[SyncRelation:103]countUse:22+1
SAVE RECORD:C53([SyncRelation:103])
If (Is new record:C668([SyncRelation:103]))
	// record was already created
	// needs to be managed because the in and out behaviors
Else 
	CREATE RECORD:C68([SyncRecord:109])
End if 
[SyncRecord:109]dtCreated:15:=DateTime_DTTo
// ### bj ### 20190113_0913
// should theirs be saved with every exchange
// i do not think so. The fact they worked or did not work is proof they were valid at the time
// the fewer times they are recorded the less likely they are to be compromised
// [SyncRecord]UUIDKeyTheirs:=[SyncRelation]UUIDKeyTheirs

// our needs to be recorded so it can be passed with the message
[SyncRecord:109]idSyncRelation:49:=[SyncRelation:103]id:30

// these should always be passed within an ssl connection
[SyncRecord:109]relationship:41:=[SyncRelation:103]name:8
[SyncRecord:109]syncRelationid:24:=[SyncRelation:103]idNum:1  // this is the key to relating these records

//  Relationship
// [SyncRecord]UserName
// [SyncRecord]Relationship
// [SyncRecord]EmailLocal
// [SyncRecord]EmailRemote

//  Relationship
// not needed
// [SyncRecord]UserName:=[SyncRelation]RemoteUserName
// [SyncRecord]UserName:=[SyncRelation]RemoteUserPassword


// added as parameter to WC_Request for the remote server
// $vtHeader:=$vtHeader+"&id="+[SyncRelation]id
// $vtHeader:=$vtHeader+"&UniqueID="+String([SyncRecord]UniqueID)

[SyncRecord:109]siteIDLocal:13:=Current machine:C483
[SyncRecord:109]direction:29:="Sending"
[SyncRecord:109]approvedBySend:10:=Current user:C182
[SyncRecord:109]date:26:=Current date:C33
[SyncRecord:109]command:23:=vtRPCommand

C_LONGINT:C283(dtSession)
Case of 
	: (dtSession#0)
		[SyncRecord:109]dtCreated:15:=dtSession
	: ([SyncJob:104]dtCreated:5#0)
		[SyncRecord:109]dtCreated:15:=[SyncJob:104]dtCreated:5
	Else 
		[SyncRecord:109]dtCreated:15:=DateTime_DTTo
End case 

[SyncRecord:109]size:38:=$size

// do not store data internally so size is not an issue.
[SyncRecord:109]pathToDocument:18:=Storage:C1525.folder.jitF+"SyncRecord"+Folder separator:K24:12+Date_strYyyymmdd+Folder separator:K24:12
CREATE FOLDER:C475([SyncRecord:109]pathToDocument:18; *)
[SyncRecord:109]pathToDocument:18:=Storage:C1525.folder.jitF+"SyncRecord"+Folder separator:K24:12+Date_strYyyymmdd+Folder separator:K24:12+"SENT"+String:C10([SyncRecord:109]idNum:1)+".txt"
// create this document when blob to send is fully created


SAVE RECORD:C53([SyncRecord:109])



If ([SyncRelation:103]scriptSyncRecord:48#"")  // use the set names or change aspects
	ExecuteText(0; [SyncRelation:103]scriptSyncRecord:48)
End if 


SAVE RECORD:C53([SyncRecord:109])


//end if


// Remote
// [SyncRecord]ActionRemote
// [SyncRecord]ApprovedByRemote
// [SyncRecord]siteIDRemote
// [SyncRecord]StatusRemote
// [SyncRecord]UniqueIDRemote



// Local
// [SyncRecord]ActionLocal
// [SyncRecord]ApprovedByLocal
// [SyncRecord]Date
// [SyncRecord]Direction
// [SyncRecord]DTAction
// [SyncRecord]DTCompleted
// [SyncRecord]DTCreated
// [SyncRecord]dtLastSync
// [SyncRecord]DTLibraryComplete
// [SyncRecord]Duration

// [SyncRecord]PathToDocument
// [SyncRecord]ResolvedBy
// [SyncRecord]siteIDLocal
// [SyncRecord]Size
// [SyncRecord]StatusLocal

// communications
// [SyncRecord]Cookie
// [SyncRecord]eventID


//  Script
// [SyncRecord]Purpose
// [SyncRecord]Profile1
// [SyncRecord]Profile2
// [SyncRecord]Profile3
// [SyncRecord]Profile4
// [SyncRecord]Profile5
// [SyncRecord]Profile6
// [SyncRecord]FieldNum
// [SyncRecord]FieldValue
// [SyncRecord]TableNum
// [SyncRecord]TableName
// [SyncRecord]TextSample
// [SyncRecord]ObjCarrier
// [SyncRecord]ObjReplaced
// [SyncRecord]Body
// [SyncRecord]Comment
// [SyncRecord]PackingNotes


//  Relationship
// [SyncRecord]UserName
// [SyncRecord]Relationship
// [SyncRecord]EmailLocal
// [SyncRecord]EmailRemote
// [SyncRecord]Port


// automatic
// [SyncRecord]UniqueID
// [SyncRecord]id