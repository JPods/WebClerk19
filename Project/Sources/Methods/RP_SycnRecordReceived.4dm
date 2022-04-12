//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/28/18, 14:40:55
// ----------------------------------------------------
// Method: RP_SycnRecordReceived
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
C_OBJECT:C1216($obSyncRecord)
RP_SyncRecordBasics

$obSyncRecord:=$1->

If (False:C215)
	// move the SyncRecord out of the head
	//   jsonRecordToObject (->$obComplete;"SyncRecord") 
	// ### bj ### 20190119_2011  data is in an object, not array object
	C_OBJECT:C1216($objMessage)
	C_OBJECT:C1216(objSyncRecord; objSync)  // process varible for manageing in scripts
	C_OBJECT:C1216(objData)  // process varible for manageing in scripts
	$objMessage:=JSON Parse:C1218($vtjson)
	objSync:=OB Get:C1224($objMessage; "head")
	ARRAY OBJECT:C1221(aSyncFields; 0)
	OB GET ARRAY:C1229(objSync; "SyncRecord"; aSyncFields)
	$obSyncRecord:=aSyncFields{1}  // if it was passed as an array
	objData:=OB Get:C1224($objMessage; "data")
End if 


// get maps
C_TEXT:C284($tableName)
$tableName:="SyncRecord"
ARRAY TEXT:C222($atFieldNames; 0)  // will be rezeroed in jsonMapExtract list here for clarity 
ARRAY TEXT:C222($atMapNames; 0)
ARRAY LONGINT:C221($alFieldNums; 0)
jsonMapExtract($tableName; ->$atFieldNames; ->$atMapNames; ->$alFieldNums)


ARRAY TEXT:C222($atNames; 0)
ARRAY LONGINT:C221($alTypes; 0)
OB GET PROPERTY NAMES:C1232($obSyncRecord; $atNames; $alTypes)
// get array of passed values

C_LONGINT:C283($incRay; $cntRay; $fia; $tableNum)
C_LONGINT:C283($viFieldType)
$tableNum:=Table:C252(->[SyncRecord:109])
C_POINTER:C301($ptField)
$cntRay:=Size of array:C274($atNames)
For ($incRay; 1; $cntRay)
	$fia:=Find in array:C230($atMapNames; $atNames{$incRay})
	If ($fia>0)
		$ptField:=Field:C253($tableNum; $alFieldNums{$fia})
		$viFieldType:=Type:C295($ptField->)
		$ptField->:=OB Get:C1224($obSyncRecord; $atNames{$incRay}; $viFieldType)
	End if 
End for 

If (False:C215)  // delete by 2019-01-22 retained for my testing
	[SyncRecord:109]siteIDRemote:20:=OB Get:C1224($obSyncRecord; "siteIDLocal")
	[SyncRecord:109]ideRemote:27:=OB Get:C1224($obSyncRecord; "idNum")  // from the senders data
	//[SyncRecord]rs1:=OB Get($obSyncRecord; "id")  // from the senders data
	[SyncRecord:109]approvedBySend:10:=OB Get:C1224($obSyncRecord; "ApprovedBySend")
	[SyncRecord:109]siteIDRemote:20:=OB Get:C1224($obSyncRecord; "siteIDLocal")
	
	
	[SyncRecord:109]purpose:40:=OB Get:C1224($obSyncRecord; "Purpose")
	[SyncRecord:109]fieldNum:5:=OB Get:C1224($obSyncRecord; "FieldNum")
	[SyncRecord:109]fieldValue:6:=OB Get:C1224($obSyncRecord; "FieldValue")
	[SyncRecord:109]tableNum:4:=OB Get:C1224($obSyncRecord; "TableNum")
	[SyncRecord:109]tableName:44:=OB Get:C1224($obSyncRecord; "TableName")
	[SyncRecord:109]textSample:11:=OB Get:C1224($obSyncRecord; "TextSample")
	[SyncRecord:109]body:34:=OB Get:C1224($obSyncRecord; "Body")
	//  only if received.
	[SyncRecord:109]obReceived:46:=JSON Parse:C1218([SyncRecord:109]body:34)
	[SyncRecord:109]comment:25:=OB Get:C1224($obSyncRecord; "Comment")
	[SyncRecord:109]packingNotes:14:=OB Get:C1224($obSyncRecord; "PackingNotes")
End if 

SAVE RECORD:C53([SyncRecord:109])


//  [SyncRecord]Relationship
//  [SyncRecord]UniqueIDSyncRelationship
//  [SyncRecord]UUIDSyncRelationships
//  
//  // Local:
//  [SyncRecord]UniqueID
//  [SyncRecord]id
//  [SyncRecord]siteIDLocal
//  
//  
//  // Remote:
//  [SyncRecord]UUIDKeyRemote
//  [SyncRecord]UniqueIDRemote
//  [SyncRecord]siteIDRemote
//  
//  
//  // Actions:
//  [SyncRecord]ActionSend
//  [SyncRecord]StatusSend
//  [SyncRecord]ApprovedBySend
//  
//  [SyncRecord]ApprovedByReceive
//  [SyncRecord]ActionReceive
//  [SyncRecord]StatusReceive
//  
//  
//  
//  // message
//  [SyncRecord]ResolvedBy
//  [SyncRecord]DTAction
//  [SyncRecord]DTCompleted
//  
//  [SyncRecord]Purpose
//  [SyncRecord]TableNum
//  [SyncRecord]TableName
//  [SyncRecord]Cookie
//  [SyncRecord]eventID
//  [SyncRecord]Duration
//  [SyncRecord]FieldNum
//  [SyncRecord]FieldValue
//  [SyncRecord]Body
//  [SyncRecord]Comment
//  [SyncRecord]Date
//  [SyncRecord]Direction
//  [SyncRecord]DTCreated
//  [SyncRecord]dtLastSync
//  [SyncRecord]ObjCarrier
//  [SyncRecord]ObjReplaced
//  [SyncRecord]PackingNotes
//  [SyncRecord]PathToDocument
//  [SyncRecord]Size
//  [SyncRecord]TextSample