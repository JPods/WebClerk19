//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/18/19, 13:48:53
// ----------------------------------------------------
// Method: RP_Project
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_POINTER:C301($1; $ptObect)

If (Count parameters:C259>0)
	$ptObect:=$1
Else 
	// testing
	C_OBJECT:C1216($obTemp)
	$ptObect:=(->$obTemp)
	READ ONLY:C145([Project:24])
	READ ONLY:C145([WorkOrder:66])
	READ ONLY:C145([SyncRelation:103])
	QUERY:C277([Project:24]; [Project:24]projectNum:1>=17)
	QUERY:C277([Project:24];  & ; [Project:24]projectNum:1<=19)
	QUERY:C277([SyncRelation:103]; [SyncRelation:103]name:8="jquerygantt")
End if 

ARRAY OBJECT:C1221($aObBuild; 0)
C_LONGINT:C283($incRec; $cntRec)
$cntRec:=Records in selection:C76([Project:24])
FIRST RECORD:C50([Project:24])
For ($incRec; 1; $cntRec)
	INSERT IN ARRAY:C227($aObBuild; $incRec; 1)
	
	QUERY:C277([WorkOrder:66]; [WorkOrder:66]projectNum:80=[Project:24]projectNum:1)
	
	jsonRecordToObject(->$aObBuild{$incRec}; "Project")  // parameter 2 must be a tableName
	
	ExecuteText(0; [SyncRelation:103]scriptData:28)
	
	jsonSelectionToObject(->$aObBuild{$incRec}; "WorkOrder")  // case sensitive
	// put this into an array of POs to send
	
	NEXT RECORD:C51([Project:24])
End for 

C_OBJECT:C1216($obBody)
OB SET ARRAY:C1227($obBody; "Project"; $aObBuild)  // array of individual Purchase Order and Lines

// add vendor information to the body

C_LONGINT:C283($dataSize)
$dataSize:=Length:C16(JSON Stringify:C1217($obBody))

// create the head and SyncRecord in the head
C_OBJECT:C1216($obPurpose)
jsonCreateHeader(->$obPurpose; "Project"; "Local:Projects,Remote:Projects")
RP_SyncRecordSending($dataSize)  // ;$script)  //just builds the Sync Record


C_OBJECT:C1216($obComplete)  // create the complete object
jsonRecordToObject(->$obComplete; "SyncRecord")  //  send all the fields, sort out later if this is too much

LOAD RECORD:C52([SyncRecord:109])  // incase next record was called in jsonRecordToObject

OB SET:C1220($obComplete; "head"; $obPurpose)  // add the b
OB SET:C1220($obComplete; "body"; $obBody)  // add the body

vWCPayload:=JSON Stringify:C1217($obComplete)  // text to send
[SyncRecord:109]body:34:=vWCPayload
// only if receiving
//  [SyncRecord]ObReceived:=JSON Parse(vWCPayload)
SAVE RECORD:C53([SyncRecord:109])

$ptObect->:=$obComplete



